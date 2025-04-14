Return-Path: <stable+bounces-132672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435D2A88EBE
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 00:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15473A4184
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C101E5208;
	Mon, 14 Apr 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avycfQ4/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA741A0BFA;
	Mon, 14 Apr 2025 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744668078; cv=none; b=ckx2XXB2YWweO4gbwcNf2pvsqmEPyu/76QIFoNuMH0U5SvCTdDnILWqPgDjJBAwDlJT/RlDMGWQggKRXQuMnatIZFHQO9NNbKqdfcWDVpZLNwFngwB3bpzFtpwvdXMrBGyfP6S555wfEwL4MhC8/3+e/yms0ZFM8MUs7dsS+JNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744668078; c=relaxed/simple;
	bh=1l08P30O+lKCvZ5y1d3ISGQUNkb1SwA1W+kwuLxu/6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Be1pYYg7al9sQElxyypCTkVAK6PbWPzq2v5siRPCxOSehq0QPSTNt3W8Ciz4GRaqFn5CmzxAxD8TbsnkxbsRkjXxAvnAOG+kZNlpgOwYAvtqzT3dHhxRtWXIJRJfML3vOjPay7t4zoxHecoH2mSCftTIcEfWknqvdStjzgBcqH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avycfQ4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA36C4CEE5;
	Mon, 14 Apr 2025 22:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744668076;
	bh=1l08P30O+lKCvZ5y1d3ISGQUNkb1SwA1W+kwuLxu/6E=;
	h=From:Date:Subject:To:Cc:From;
	b=avycfQ4/0cG4DMg8yoIOazqlWCLis60DvfwmQwQ1vdOPuF6I2gjyJTxQ3zPOgTiM7
	 cwCXLjU3lalJsXZnZEGzvUpDTmhfoleQf9Pjd8sN4z0VjmyCfEol/pcWG3GJpplFDq
	 XdEwyzLslHTU7l7VVY3mcV+pmm6557XrN78FmvLYPkRy74y8pqUSUHJ3M5OcnZE0hu
	 0NGecSiDdypE1ydyoyvvBCxc2BotJpGJvduTn8Pk3hPt8M39Dth+QVyzS/MBmsWKx4
	 pz9decYhFN4GFA5xTiYXmb8ILHHXYeUeiDTWKYc7d3CUfAuCVrx849/J+a8PkmYLzZ
	 j+z0azCYRu4Mg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 14 Apr 2025 15:00:59 -0700
Subject: [PATCH] lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-drop-default-ubsan-integer-wrap-v1-1-392522551d6b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJqF/WcC/x3NQQrCMBBG4auUWTuQhiroVcRFpvlTByQNk7YKp
 XdvcPlt3tupwhSVHt1Ohk2rzrmhv3Q0vkOewBqbyTt/dUM/cLS5cEQK62fhVWrIrHnBBOOvhcK
 SHOSGJP4u1CrFkPT3Pzxfx3ECt51ZE3EAAAA=
X-Change-ID: 20250414-drop-default-ubsan-integer-wrap-bf0eb6efb29b
To: Kees Cook <kees@kernel.org>
Cc: Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
 Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
 stable@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; i=nathan@kernel.org;
 h=from:subject:message-id; bh=1l08P30O+lKCvZ5y1d3ISGQUNkb1SwA1W+kwuLxu/6E=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOl/W1eWOfmu1DwxweuGvH3/Sf4k3X33El1u672ftf+R6
 henoktLO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBElJgYGeYJHfpSVKezRjLY
 5psHd3usUePBLd6OTZ3hbaoW72cmWDIy7Hz4Penn6vQbBxLDUk+xfPrTVGl7w5jjnt4j/YUhAeq
 tXAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

CONFIG_UBSAN_INTEGER_WRAP is 'default UBSAN', which is problematic for a
couple of reasons.

The first is that this sanitizer is under active development on the
compiler side to come up with a solution that is maintainable on the
compiler side and usable on the kernel side. As a result of this, there
are many warnings when the sanitizer is enabled that have no clear path
to resolution yet but users may see them and report them in the meantime.

The second is that this option was renamed from
CONFIG_UBSAN_SIGNED_WRAP, meaning that if a configuration has
CONFIG_UBSAN=y but CONFIG_UBSAN_SIGNED_WRAP=n and it is upgraded via
olddefconfig (common in non-interactive scenarios such as CI),
CONFIG_UBSAN_INTEGER_WRAP will be silently enabled again.

Remove 'default UBSAN' from CONFIG_UBSAN_INTEGER_WRAP until it is ready
for regular usage and testing from a broader community than the folks
actively working on the feature.

Cc: stable@vger.kernel.org
Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/Kconfig.ubsan | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 4216b3a4ff21..f6ea0c5b5da3 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -118,7 +118,6 @@ config UBSAN_UNREACHABLE
 
 config UBSAN_INTEGER_WRAP
 	bool "Perform checking for integer arithmetic wrap-around"
-	default UBSAN
 	depends on !COMPILE_TEST
 	depends on $(cc-option,-fsanitize-undefined-ignore-overflow-pattern=all)
 	depends on $(cc-option,-fsanitize=signed-integer-overflow)

---
base-commit: 26fe62cc5e8420d5c650d6b86fee061952d348cd
change-id: 20250414-drop-default-ubsan-integer-wrap-bf0eb6efb29b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


