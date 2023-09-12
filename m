Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E6279AE24
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351187AbjIKVmt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240666AbjIKOu2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:50:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B931106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70264C433C7;
        Mon, 11 Sep 2023 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443823;
        bh=9FsmH3OMFDHyOI2H+vU7WFrajlwdhhK6afxv/snzS8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcGSxTTavfjz0wDD2G+3hbVLUfFsWPmLW0gDoNw6NmZELUZ4/wTu+ZCtzD6HSDP91
         FLjp7qyFEamzl7SETtkAHGzErOZTYvvAPfobynHQxZdkSwGmtEmHZdsm7jbpgCjlEZ
         LhJDWDzOPug5XqhAs0FtxlAv8XpnMMfxvWJXBhZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Chris Leech <cleech@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 513/737] scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()
Date:   Mon, 11 Sep 2023 15:46:12 +0200
Message-ID: <20230911134704.887414099@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit ce51c817008450ef4188471db31639d42d37a5e1 ]

The functions iscsi_if_set_param() and iscsi_if_set_host_param() convert an
nlattr payload to type char* and then call C string handling functions like
sscanf and kstrdup:

  char *data = (char*)ev + sizeof(*ev);
  ...
  sscanf(data, "%d", &value);

However, since the nlattr is provided by the user-space program and the
nlmsg skb is allocated with GFP_KERNEL instead of GFP_ZERO flag (see
netlink_alloc_large_skb() in netlink_sendmsg()), dirty data on the heap can
lead to an OOB access for those string handling functions.

By investigating how the bug is introduced, we find it is really
interesting as the old version parsing code starting from commit
fd7255f51a13 ("[SCSI] iscsi: add sysfs attrs for uspace sync up") treated
the nlattr as integer bytes instead of string and had length check in
iscsi_copy_param():

  if (ev->u.set_param.len != sizeof(uint32_t))
    BUG();

But, since the commit a54a52caad4b ("[SCSI] iscsi: fixup set/get param
functions"), the code treated the nlattr as C string while forgetting to
add any strlen checks(), opening the possibility of an OOB access.

Fix the potential OOB by adding the strlen() check before accessing the
buf. If the data passes this check, all low-level set_param handlers can
safely treat this buf as legal C string.

Fixes: fd7255f51a13 ("[SCSI] iscsi: add sysfs attrs for uspace sync up")
Fixes: 1d9bf13a9cf9 ("[SCSI] iscsi class: add iscsi host set param event")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Link: https://lore.kernel.org/r/20230723075820.3713119-1-linma@zju.edu.cn
Reviewed-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_transport_iscsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 2680de88f5bbc..49dbcd67579aa 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3029,6 +3029,10 @@ iscsi_if_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev, u
 	if (!conn || !session)
 		return -EINVAL;
 
+	/* data will be regarded as NULL-ended string, do length check */
+	if (strlen(data) > ev->u.set_param.len)
+		return -EINVAL;
+
 	switch (ev->u.set_param.param) {
 	case ISCSI_PARAM_SESS_RECOVERY_TMO:
 		sscanf(data, "%d", &value);
@@ -3202,6 +3206,10 @@ iscsi_set_host_param(struct iscsi_transport *transport,
 		return -ENODEV;
 	}
 
+	/* see similar check in iscsi_if_set_param() */
+	if (strlen(data) > ev->u.set_host_param.len)
+		return -EINVAL;
+
 	err = transport->set_host_param(shost, ev->u.set_host_param.param,
 					data, ev->u.set_host_param.len);
 	scsi_host_put(shost);
-- 
2.40.1



