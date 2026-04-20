Return-Path: <stable+bounces-239402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL9NMhRk5mkuvwEAu9opvQ
	(envelope-from <stable+bounces-239402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:36:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E585431926
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69C16320590E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0A2D77E5;
	Mon, 20 Apr 2026 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yzAWjqr1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F585332919;
	Mon, 20 Apr 2026 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700155; cv=none; b=GEYso22tdLXR20Yjn/TRR4qaWJtyDF0TZh4JWWOaVvycJgrTg75NWxetyOt2a+qhNsKuE/1fnljQVB0aF92v0A7XUnwGp9wCvRYYA0zxOqaznwET4W9Sg0ieXhvd04bAN0KhzEH7r+6AR1Ccu9DaeD6DROjRfHIPAKntQSfI+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700155; c=relaxed/simple;
	bh=kD46m8Yua7ucd6KzIYJSYRvwHIqm8BetGF+yO5ylFdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzN5qEjFhhPTkfAIehqEpxDztQT2fq1WxT6O8O3XI1cvJTVby9hoxJ3MdP8HkJq7IIITc+QCyP0HMzf/Rvvi1AiBXm/+od9zNLoMxEhSwQIO2P6xUabeof+3ZLDO3p4507mcdHw2P8crXlpJ7n+yO7oaTo0giQxfuZYBeNneJRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yzAWjqr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4982C19425;
	Mon, 20 Apr 2026 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700155;
	bh=kD46m8Yua7ucd6KzIYJSYRvwHIqm8BetGF+yO5ylFdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yzAWjqr1OPZsnNISLCIOMLXHpnaCGNSINFc0hnaeZu0CBdDBvCKvxTALYI/kbLHsu
	 n/cPoR5BPP8/yR4kiOInSOFdZoF1nEjEf786hj/wIKnuAfK9CWNXNUcnPHdE+OioYy
	 PstiX9YXh5bIQ6s+uoG4o2jLQIBNsgVgGDelYBaw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 036/220] pinctrl: intel: Fix the revision for new features (1kOhm PD, HW debouncer)
Date: Mon, 20 Apr 2026 17:39:37 +0200
Message-ID: <20260420153935.335433827@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-239402-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1E585431926
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
index cf9db8ac0f42e..106835b5ee5a5 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1610,7 +1610,7 @@ int intel_pinctrl_probe(struct platform_device *pdev,
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




