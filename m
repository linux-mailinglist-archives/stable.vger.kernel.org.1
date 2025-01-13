Return-Path: <stable+bounces-108383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201B5A0B2CC
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72197A060B
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 09:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F47723A57B;
	Mon, 13 Jan 2025 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=arulpandiyan.vadivel@siemens.com header.b="rEHZV9wY"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDF23A56D
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760612; cv=none; b=FM2l/MHo9cmgBWEDhhS4wvQZcUM7OdqEGjyWDDmdiiDuC8ZvgNok5cEMB/yYFtxQPeBKc6aRzxMxNFU5g96mZ1Yn455lfvA7/39/koBlpWkGTnSioVOPsUA8hGlU0+KXP51MA5QWnoAqi4j5jUfu5TOxeWY7O2hLupoikn0O2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760612; c=relaxed/simple;
	bh=1zi8MlsS3J5PlC4lpGeqtVvP1KN7EE+OfpMnnqp770s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltnC+V2ZW06RiZ+81vEUPq06Gnq/TKkMOFwfV2reNuZinRF1gs065pe1oKLzVQChyE4Da508hyam5MnmqpjtVC/Arh13HMQ/iRY/RdE+HKymIELwxZM6LROTvaVouY4Kxj/mX8EqXBa/j/YILKEQiAByFlC1TiqPdBygWo7JzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=arulpandiyan.vadivel@siemens.com header.b=rEHZV9wY; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250113093001fc983925fc2e6fcdac
        for <stable@vger.kernel.org>;
        Mon, 13 Jan 2025 10:30:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=arulpandiyan.vadivel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Ap/B4kbOsbDfWWRsm2B9OFISQzBCwAWhfhE4q/nKKXc=;
 b=rEHZV9wY+yHgsaNPwT/tZHAYQDlACNL1y8eU7pDyHk5psepUq8D+Bx57q7D+meM7pksBT6
 FtFB72T+hbbrEeUnfKPaOqmkNwHizAkUM7EGLrT1ApRT6mQSsqCNwFkCDsevDoJBZIPCyPb2
 0OdeK4CvhsWH53cRlDh+2zwrvYAy6Qist1RbUSvaHWVwL4Rr3sEulVreXE28bVlpCVgjtOHK
 W04wg7xs1ie0BxSQf0/Bs1dnnBYnEov1uEtMD7flKiZJHTrAvnv2fRpxpcHE+rqvJevtXjDW
 +Sv3G3yPFr54OXxqKHQBUvwufwTnUt+KDWe0bikX9KrtfbZdV61LAp6g==;
From: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
To: linux-security-module@vger.kernel.org
Cc: linux-modules@vger.kernel.org,
	stable@vger.kernel.org,
	cedric.hombourger@siemens.com,
	srikanth.krishnakar@siemens.com,
	Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
Subject: [PATCH] loadpin: remove MODULE_COMPRESS_NONE as it is no longer supported
Date: Mon, 13 Jan 2025 15:01:15 +0530
Message-Id: <20250113093115.72619-1-arulpandiyan.vadivel@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328317:519-21489:flowmailer

Commit c7ff693fa2094ba0a9d0a20feb4ab1658eff9c33 ("module: Split
modules_install compression and in-kernel decompression") removed the
MODULE_COMPRESS_NONE, but left it loadpin's Kconfig, and removing it

Signed-off-by: Arulpandiyan Vadivel <arulpandiyan.vadivel@siemens.com>
---
 security/loadpin/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
index 848f8b4a60190..94348e2831db9 100644
--- a/security/loadpin/Kconfig
+++ b/security/loadpin/Kconfig
@@ -16,7 +16,7 @@ config SECURITY_LOADPIN_ENFORCE
 	depends on SECURITY_LOADPIN
 	# Module compression breaks LoadPin unless modules are decompressed in
 	# the kernel.
-	depends on !MODULES || (MODULE_COMPRESS_NONE || MODULE_DECOMPRESS)
+	depends on !MODULES || MODULE_DECOMPRESS
 	help
 	  If selected, LoadPin will enforce pinning at boot. If not
 	  selected, it can be enabled at boot with the kernel parameter
-- 
2.39.5


