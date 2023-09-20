Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707407A7CDB
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjITMFY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjITMEl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:04:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FA5AD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:04:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B70C433C8;
        Wed, 20 Sep 2023 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211474;
        bh=HEOuq2dSQENrD+f4dqApkv1l/2Ov4aWC6nDnQWsJ46c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg9JdSaB+77FEl/YvfhVmo2JF+KX1UxW17sS2RmN+vE9RXMSGTR7P73+YAqfxnape
         UqagDl+++LEAACTxBl1/cfrIlnrSzfhe0yqJveU7TWZXmfgpgH5vVwSpWXdW9zcPtG
         8KspZYIKXS+q1RVUwiwxpIiLX+CVNEkSUWhDYgD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Chris Leech <cleech@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 081/186] scsi: qla4xxx: Add length check when parsing nlattrs
Date:   Wed, 20 Sep 2023 13:29:44 +0200
Message-ID: <20230920112839.800413175@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 47cd3770e31df942e2bb925a9a855c79ed0662eb ]

There are three places that qla4xxx parses nlattrs:

 - qla4xxx_set_chap_entry()

 - qla4xxx_iface_set_param()

 - qla4xxx_sysfs_ddb_set_param()

and each of them directly converts the nlattr to specific pointer of
structure without length checking. This could be dangerous as those
attributes are not validated and a malformed nlattr (e.g., length 0) could
result in an OOB read that leaks heap dirty data.

Add the nla_len check before accessing the nlattr data and return EINVAL if
the length check fails.

Fixes: 26ffd7b45fe9 ("[SCSI] qla4xxx: Add support to set CHAP entries")
Fixes: 1e9e2be3ee03 ("[SCSI] qla4xxx: Add flash node mgmt support")
Fixes: 00c31889f751 ("[SCSI] qla4xxx: fix data alignment and use nl helpers")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Link: https://lore.kernel.org/r/20230723080053.3714534-1-linma@zju.edu.cn
Reviewed-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla4xxx/ql4_os.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 62022a66e9ee2..d6e9717cb0fb5 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -942,6 +942,11 @@ static int qla4xxx_set_chap_entry(struct Scsi_Host *shost, void *data, int len)
 	memset(&chap_rec, 0, sizeof(chap_rec));
 
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*param_info)) {
+			rc = -EINVAL;
+			goto exit_set_chap;
+		}
+
 		param_info = nla_data(attr);
 
 		switch (param_info->param) {
@@ -2727,6 +2732,11 @@ qla4xxx_iface_set_param(struct Scsi_Host *shost, void *data, uint32_t len)
 	}
 
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*iface_param)) {
+			rval = -EINVAL;
+			goto exit_init_fw_cb;
+		}
+
 		iface_param = nla_data(attr);
 
 		if (iface_param->param_type == ISCSI_NET_PARAM) {
@@ -8102,6 +8112,11 @@ qla4xxx_sysfs_ddb_set_param(struct iscsi_bus_flash_session *fnode_sess,
 
 	memset((void *)&chap_tbl, 0, sizeof(chap_tbl));
 	nla_for_each_attr(attr, data, len, rem) {
+		if (nla_len(attr) < sizeof(*fnode_param)) {
+			rc = -EINVAL;
+			goto exit_set_param;
+		}
+
 		fnode_param = nla_data(attr);
 
 		switch (fnode_param->param) {
-- 
2.40.1



