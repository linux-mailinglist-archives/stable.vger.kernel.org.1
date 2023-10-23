Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4D7D34D5
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjJWLnK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjJWLnA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:43:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0541C171D
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:42:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEB3C433C8;
        Mon, 23 Oct 2023 11:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061373;
        bh=hjZF+6A59ezV4EVHYl8SITLagO4gBnT6Dzaq90KleMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MP1ysXufWMT8fdD3gH9viHozciZAXk4Nu0uEcmXzrAIuQt0eYCkLp8jY54fcDtcrR
         ujH6g+EwZAIATET5gj40hJrMpU93UNdgl2KVIlKHXQTo+NvurvawSQqYOtCNQ6uBAf
         gxhTW+gpdlVA7SvrdmMIkR8XVpnaOnsBhbWQOOzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeremy Cline <jeremy@jcline.org>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
Subject: [PATCH 5.10 025/202] nfc: nci: assert requested protocol is valid
Date:   Mon, 23 Oct 2023 12:55:32 +0200
Message-ID: <20231023104827.343736801@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index ed9019d807c78..4c931bd1c1743 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -894,6 +894,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
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



