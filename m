Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE77CA31F
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjJPJBZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjJPJBD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:01:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB04DFD
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:00:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D6AC433C9;
        Mon, 16 Oct 2023 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446857;
        bh=3+tcf1VHEyV9h75f4EkPAI97MVylMXczmHbSdbW4ahk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvWVJ2/7SEXsURyVM+uYF5302/hefPzM/JV5Qr6t5nY3a3NBCqO8f744ZIwg29hKF
         oT040v6ezgvozbDXEKaBw2dTfsB/W8bwHanpySPBK0HiCm4dzPq1fN/Wce31BNIGSY
         CRB40Ko7B5k/hsf6jNYNxfa2qsNpJgwliX7URci8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeremy Cline <jeremy@jcline.org>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Subject: [PATCH 6.1 065/131] nfc: nci: assert requested protocol is valid
Date:   Mon, 16 Oct 2023 10:40:48 +0200
Message-ID: <20231016084001.681074298@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
References: <20231016084000.050926073@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Cline <jeremy@jcline.org>

[ Upstream commit 354a6e707e29cb0c007176ee5b8db8be7bd2dee0 ]

The protocol is used in a bit mask to determine if the protocol is
supported. Assert the provided protocol is less than the maximum
defined so it doesn't potentially perform a shift-out-of-bounds and
provide a clearer error for undefined protocols vs unsupported ones.

Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
Reported-and-tested-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0839b78e119aae1fec78
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20231009200054.82557-1-jeremy@jcline.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/nci/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 4ffdf2f45c444..7535afd1537e9 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -908,6 +908,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
 		return -EINVAL;
 	}
 
+	if (protocol >= NFC_PROTO_MAX) {
+		pr_err("the requested nfc protocol is invalid\n");
+		return -EINVAL;
+	}
+
 	if (!(nci_target->supported_protocols & (1 << protocol))) {
 		pr_err("target does not support the requested protocol 0x%x\n",
 		       protocol);
-- 
2.40.1



