Return-Path: <stable+bounces-219364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBR1CmCinmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:18:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60602193320
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BF0F30BB959
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D930BF69;
	Wed, 25 Feb 2026 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aOWf7yIz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9292D6E58;
	Wed, 25 Feb 2026 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002667; cv=none; b=FzfZs+NLlc4aSRVSSeWg7gYiGBjyxiBLknOQRcpsG8T+KGmOWKPzmnRArwS8L46NwY3veXsK1lQNj/3YvBmhMmJJxKvx7vVj+N8VpMovMzBDMQQUpRiR9RUeM5j1gwW8Clod+PlnSsWePsGTxiO8O4kXGFb0/4HAzYEVhwoKXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002667; c=relaxed/simple;
	bh=GdnYzrRD2U5zdS+aE4bQ8fsnu9ctjkpLcRO3gm/m5MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciJo1HIuSfYocLc3BzdK3GoH0K9GVjluWcJDAssEBWyfxBGYH8KS73OfQe7x/TApGUNUR5jDmRbTA0ynnJQPItoTaMnv/BYU7Z1bP/BCJzyArOlNqYzPMsKWNxyoSEtUQpk32Hlxk+3RXbGP6qXAz1DPpYyq94+Gbg9YfNnaNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aOWf7yIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D39C116D0;
	Wed, 25 Feb 2026 06:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002666;
	bh=GdnYzrRD2U5zdS+aE4bQ8fsnu9ctjkpLcRO3gm/m5MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOWf7yIzl40s9a3S3z2IittGsyf06SCaDO6jkJZsvbrd+TImMDVQoxipnnO6SKCdK
	 +siyipd8JhN2fWzwfCYs7gueF1i1e09dAi3yxWgCr6OngBNCR5Dx9IXweJOLsvf9tO
	 Sgq6qYOr/imAYlSNRz/ZVlRoIMHMN8HI4sHD4l0c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miaoqian Lin <linmq006@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 421/641] clk: rockchip: Fix error pointer check after rockchip_clk_register_gate_link()
Date: Tue, 24 Feb 2026 17:22:27 -0800
Message-ID: <20260225012358.753574503@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219364-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,sntech.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sntech.de:email,msgid.link:url]
X-Rspamd-Queue-Id: 60602193320
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 19caf26c991bd..2d30b1e24f013 100644
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




