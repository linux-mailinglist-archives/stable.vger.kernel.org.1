Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B417B8963
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244174AbjJDSZZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244188AbjJDSZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:25:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928D4E4;
        Wed,  4 Oct 2023 11:25:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBE1C433C7;
        Wed,  4 Oct 2023 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443919;
        bh=ypzltvnii92eYOu5/ITUMYET7remSkAAxBzLEqHitFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzHdzHVlZqiWDfJRk6uma7NDqd4C1mMitY0CrFYf8cZvXhjZDP4MsmJeVXKUXgdY+
         /EYbaxxZoiqT2ip2/mQ1hIBVW7FEetBi4uVE94gFflweurU5nrVbVDb9IMwqZZcPR0
         7uvDbThEUjxtWWiIPgkVnfpgHfepyUZ3BnxwNCeM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 067/321] scsi: iscsi_tcp: restrict to TCP sockets
Date:   Wed,  4 Oct 2023 19:53:32 +0200
Message-ID: <20231004175232.295425568@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f4f82c52a0ead5ab363d207d06f81b967d09ffb8 ]

Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
pointing to non TCP socket (af_unix for example).

Return -EINVAL if this is attempted, instead of crashing the kernel.

Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator: Initiator code")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Lee Duncan <lduncan@suse.com>
Cc: Chris Leech <cleech@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: open-iscsi@googlegroups.com
Cc: linux-scsi@vger.kernel.org
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/iscsi_tcp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 9ab8555180a3a..8e14cea15f980 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -724,6 +724,10 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
 		return -EEXIST;
 	}
 
+	err = -EINVAL;
+	if (!sk_is_tcp(sock->sk))
+		goto free_socket;
+
 	err = iscsi_conn_bind(cls_session, cls_conn, is_leading);
 	if (err)
 		goto free_socket;
-- 
2.40.1



