Return-Path: <stable+bounces-240750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEJIAs9y62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:40:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537645F5CC
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3A14303D32C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC53D75A9;
	Fri, 24 Apr 2026 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uD6Ifqtd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131553D5241;
	Fri, 24 Apr 2026 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037744; cv=none; b=LS4eREC0F6FXZ1rfqYTxj/vdYdk5sqsJ0wwKivynRBfpenEgfNikHlavKdkcSGtifoL0e7P9tzheI43xZRrBXl4noOTnZszv8zJ5rD7tA3Y1FXoj5vi/UwaBXNmQFUFfkCns1LCc2pZoOdkQvKKJ7SRrh3lsIAhmbW3DVGb5cDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037744; c=relaxed/simple;
	bh=G0eMZ+zS7t230uFuiqRB007VQzlGU9CmMjGNENfrJx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UL1XrXkWce7Emit1IU6VC5FYd+jvNQnbML6dyQXYha4XJf1Ou9AcGNLkdOVjVEW+5Urh797YrGvjsX/dcK60PmvgWbOgxZZVIdb0SI0DH6w4cjjogPboM1th1kpbiUBjC59tuRRg2K36Ff0bOxNbLtnwAbxDerSJyu0LstBhXFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uD6Ifqtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976ADC19425;
	Fri, 24 Apr 2026 13:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037743;
	bh=G0eMZ+zS7t230uFuiqRB007VQzlGU9CmMjGNENfrJx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uD6IfqtdnTZNAX27GgE/gsEjGNH3Ize8odgfmCJ+yPcr8HItF18Ubi1nccrVkvzXO
	 vwx5HtmpMn6c0CUiHYRgZ8mLJHHOM2XHhYQUFMX9NjkBHSZs9zVJoayS4dcJfv+eT+
	 Cr026swtdtzYI1yOP3Vg0jbrQr5kP0H+OBVw0F+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/166] pinctrl: intel: Fix the revision for new features (1kOhm PD, HW debouncer)
Date: Fri, 24 Apr 2026 15:28:53 +0200
Message-ID: <20260424132536.793193187@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6537645F5CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240750-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit a4337a24d13e9e3b98a113e71d6b80dc5ed5f8c4 ]

The 1kOhm pull down and hardware debouncer are features of the revision 0.92
of the Chassis specification. Fix that in the code accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 9775f6be1c1e6..b1ce3daae8e85 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1581,7 +1581,7 @@ static int intel_pinctrl_probe(struct platform_device *pdev,
 		value = readl(regs + REVID);
 		if (value == ~0u)
 			return -ENODEV;
-		if (((value & REVID_MASK) >> REVID_SHIFT) >= 0x94) {
+		if (((value & REVID_MASK) >> REVID_SHIFT) >= 0x92) {
 			community->features |= PINCTRL_FEATURE_DEBOUNCE;
 			community->features |= PINCTRL_FEATURE_1K_PD;
 		}
-- 
2.53.0




