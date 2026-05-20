Return-Path: <stable+bounces-250726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG6qDLkTDmot6AUAu9opvQ
	(envelope-from <stable+bounces-250726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95039599124
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F62E33EAAF0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEF83F1ADC;
	Wed, 20 May 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w/Z0aRDB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458803D7D7B;
	Wed, 20 May 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296156; cv=none; b=lKSRt5Qe5umuv+EByVE81y9xEFgQ55k2AXf2z9z97QEfQ7d3D/KdYeFFcH10mSs+qkuj+kf8kf5cteTh20LxTs2WPt7AeWDQWKMU9Lb1iM/vSPotMyvXpGWNiXm5ckSo3IhrKwhvDamg3cSAnUuIdntHP7qgDlQWNZkG4pz68N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296156; c=relaxed/simple;
	bh=iNEQpT+XjaBnsYhAvKLZd9wHC4KiwTRCbnEh7JHimFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqOsN9XfeYKE9aTtK80e8z8wyI2QCp/C9DB7OkpAj1GN8I7kVmP0yftcJ59vkHxMygB4Yl3V7TPiP2yVg58LyhcOQ6tktVSt+dEVNSPxRB0p7aDcQubtz7kKsHXYF6Pi9Q7KrEWKzIZ5Ebs+oHmmZ66XThBVz0mR001vJh1jiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w/Z0aRDB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEEA1F000E9;
	Wed, 20 May 2026 16:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296155;
	bh=PtyM9RCE45XQZDgKuo6oZaddY0lyNwG6/5Itm1whGXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w/Z0aRDB6vN4LS1/ki1352+rj/lgy1T0n4j5ludZ1665vGTAWPYFQhXA5Si1bnbHL
	 HxZ/DbIpG4q9mJiadEdCPjOA+3ylIVYE723HLrqJ4nTM5uuRc8h3IhCPDv+JjIbOBO
	 msKVaUZRny2KSmr4vzMRT5oazzgBwo3xzk//Ssro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0652/1146] pinctrl: sophgo: pinctrl-sg2044: Fix wrong module description
Date: Wed, 20 May 2026 18:15:02 +0200
Message-ID: <20260520162202.940542580@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250726-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 95039599124
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Inochi Amaoto <inochiama@gmail.com>

[ Upstream commit 7648112358a4207916d3e38bfee49f85552fe95f ]

Fix the SoC model in module description string, it should be
sg2044 instead of sg2002.

Fixes: 614a54cb5ac3 ("pinctrl: sophgo: add support for SG2044 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sophgo/pinctrl-sg2044.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sophgo/pinctrl-sg2044.c b/drivers/pinctrl/sophgo/pinctrl-sg2044.c
index b0c46d8954ca1..cf0b674c038f0 100644
--- a/drivers/pinctrl/sophgo/pinctrl-sg2044.c
+++ b/drivers/pinctrl/sophgo/pinctrl-sg2044.c
@@ -714,5 +714,5 @@ static struct platform_driver sg2044_pinctrl_driver = {
 };
 module_platform_driver(sg2044_pinctrl_driver);
 
-MODULE_DESCRIPTION("Pinctrl driver for the SG2002 series SoC");
+MODULE_DESCRIPTION("Pinctrl driver for the SG2044 series SoC");
 MODULE_LICENSE("GPL");
-- 
2.53.0




