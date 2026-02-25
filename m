Return-Path: <stable+bounces-218595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKwbOeBTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823218FAA0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB75831795B7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C0D26463A;
	Wed, 25 Feb 2026 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jyWFEe/O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB82256C8B;
	Wed, 25 Feb 2026 01:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983439; cv=none; b=DQNemmH8WEKxOcaL/3TkWtsaJysXafD9PtymiB1n+WUSUj0ogz0jy4mjk1Np+iQ5u9DZTh97ZzjuByQt8fq0PupCiep0y+W6FHRdiIDH2Ui+YyQYXTiTjMO0Boi7HmNc+6/q+ZOwuGlh6+Qa7B19ePw2H3bp7Ss7KDVoRy95omE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983439; c=relaxed/simple;
	bh=RPv0st3Drw3tzHvdBWsH40GRQ1sO+FuoANcLyG9cDwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvBe+Yop+3iBUdVCNIZFz3sPr70mc537LN64KL9RrkizPsPOcDso6aORrG491pnQ3Lhsqjz5pFa7Oal1cf2rUQqqT54q+akKtP22qqzgjBv0//+aS6mDhGmJZm6NMPiSoYLS+C8vTt45kObuGvbkgg9SCRfVi7NTSOx35TnYmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jyWFEe/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3391C116D0;
	Wed, 25 Feb 2026 01:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983439;
	bh=RPv0st3Drw3tzHvdBWsH40GRQ1sO+FuoANcLyG9cDwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyWFEe/OwwnIf7kbHtPEeK5FXjvCQGLWreMDzaKRg7UpRtBovX7MS3Bj9H4OVvlK8
	 xFkYn+UbdVr1tgdYG0vbnylEwjPCJnh2L6a1iG98uPxZsWHG/NevHE3H+M2j2j3P0+
	 2N+L4tzIUedQilSySI5bgDgpttlx0d9VNg3rxbHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 530/781] clk: rockchip: Fix error pointer check after rockchip_clk_register_gate_link()
Date: Tue, 24 Feb 2026 17:20:39 -0800
Message-ID: <20260225012412.800035328@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218595-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,sntech.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sntech.de:email]
X-Rspamd-Queue-Id: 5823218FAA0
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit a8d722f03923b1c6166d39482c6df8f017e185d9 ]

Replace NULL check with IS_ERR_OR_NULL() check after calling
rockchip_clk_register_gate_link() since this function
returns error pointers (ERR_PTR).

Fixes: c62fa612cfa6 ("clk: rockchip: implement linked gate clock support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Link: https://patch.msgid.link/20250805030358.3665878-1-linmq006@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/rockchip/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 2601df3b1066b..9ac9d13e87de0 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -693,7 +693,7 @@ void rockchip_clk_register_late_branches(struct device *dev,
 			break;
 		}
 
-		if (!pdev)
+		if (IS_ERR_OR_NULL(pdev))
 			dev_err(dev, "failed to register device for clock %s\n", list->name);
 	}
 }
-- 
2.51.0




