Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C377ECF22
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjKOTqf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjKOTqd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64421A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294B8C433C9;
        Wed, 15 Nov 2023 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077590;
        bh=+kMNfm4ZmMYnwdYqQW2vFdlW2WAPiDDdNRU9w75BEwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGUC02uBS58NTBDnFsrv+Z3m5cb/fe99Mujg30WyMzH9Y0BDIhMd2JyLvK5OZKzLP
         IIt5R1TjLl3CfYwzdvWTzbCV4ydaG+5VJGHbPmATY5v5sFyU7I+t8ufsV0Fi8L/FND
         0O58rQ3aetsvNbIU+YhK4/nfcEEdjPbgnhsog4a4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 375/603] dlm: fix no ack after final message
Date:   Wed, 15 Nov 2023 14:15:20 -0500
Message-ID: <20231115191639.412649169@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 6212e4528b248a4bc9b4fe68e029a84689c67461 ]

In case of an final DLM message we can't should not send an ack out
after the final message. This patch moves the ack message before the
messages will be transmitted. If it's the final message and the
receiving node turns into DLM_CLOSED state another ack messages will
being received and turning the receiving node into DLM_ESTABLISHED
again.

Fixes: 1696c75f1864 ("fs: dlm: add send ack threshold and append acks to msgs")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/midcomms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 6bc8d7f89b2cc..2247ebb61be1e 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -1038,15 +1038,15 @@ struct dlm_mhandle *dlm_midcomms_get_mhandle(int nodeid, int len,
 
 		break;
 	case DLM_VERSION_3_2:
+		/* send ack back if necessary */
+		dlm_send_ack_threshold(node, DLM_SEND_ACK_BACK_MSG_THRESHOLD);
+
 		msg = dlm_midcomms_get_msg_3_2(mh, nodeid, len, allocation,
 					       ppc);
 		if (!msg) {
 			dlm_free_mhandle(mh);
 			goto err;
 		}
-
-		/* send ack back if necessary */
-		dlm_send_ack_threshold(node, DLM_SEND_ACK_BACK_MSG_THRESHOLD);
 		break;
 	default:
 		dlm_free_mhandle(mh);
-- 
2.42.0



