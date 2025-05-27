Return-Path: <stable+bounces-147830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32E7AC595E
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309234C09A0
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CDB27FD4C;
	Tue, 27 May 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AwAb9I/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A652566;
	Tue, 27 May 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368565; cv=none; b=p5Wqvi/tnmedyJneEXAmTy78jaBFxgHfmYPYe58CijNewGlVrzR7D5PpOS818b9nXqqwiriDQ3e0UWsAKIZO0Ax2PNSSoZ7DJEul4PlGS/NStvbhsA0hEfZFGD/b4vavbIVfgQ2B0QsLAjIsiWOMbowGEn3z8kIsyFH3/CnRxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368565; c=relaxed/simple;
	bh=cIP+wmv0GnSGkZNYz6mN4iR01tyfFyLP1dz8Nf1bQ4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ec4HS3yiJF1p1GX95nErRI106cPfHwSRyS526PW8TTC9rrdEUgl0i8FQtpVsQdHsoCD+ZhtMMe2jwzvfh9zFjnZ3sQFUCaLEAoXcgk0dmjdj3DVE1yho4EcaRprjPIx6XkooqdI3hciX2rUurPv/Bcd4+Qhq9J8q7TUAP5fSk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AwAb9I/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D325AC4CEE9;
	Tue, 27 May 2025 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368565;
	bh=cIP+wmv0GnSGkZNYz6mN4iR01tyfFyLP1dz8Nf1bQ4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwAb9I/8w1OlT4sAWtgRViDLJ2QqkWYk1MFcFesyJCQz6ippRPoSeV3zx1J96jmDZ
	 npdbx90GCSlOI8Af6VJWf111MvrngPEfDQJwGUew88bqhczl9e1joq+XmuCsMXoePV
	 HqTTTaH0HEACiYl5NP+CSiXSpm8Ew4u5MJFl1PKk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.14 740/783] pmdomain: renesas: rcar: Remove obsolete nullify checks
Date: Tue, 27 May 2025 18:28:57 +0200
Message-ID: <20250527162543.262376778@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 13a6d4265665201a795a2ff5a3e6e4d183fc9c33 upstream.

All nullify users and helpers were removed, but the R-Car SYSC drivers
still checked for nullified domains.  Remove the obsolete checks.

Fixes: c8d87704444a8ac7 ("pmdomain: renesas: rcar-sysc: Remove rcar_sysc_nullify() helper")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/107f2bf9f13b29f0f623d2959a5347ec151fb089.1745840768.git.geert+renesas@glider.be
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pmdomain/renesas/rcar-gen4-sysc.c |    5 -----
 drivers/pmdomain/renesas/rcar-sysc.c      |    5 -----
 2 files changed, 10 deletions(-)

--- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
@@ -338,11 +338,6 @@ static int __init rcar_gen4_sysc_pd_init
 		struct rcar_gen4_sysc_pd *pd;
 		size_t n;
 
-		if (!area->name) {
-			/* Skip NULLified area */
-			continue;
-		}
-
 		n = strlen(area->name) + 1;
 		pd = kzalloc(sizeof(*pd) + n, GFP_KERNEL);
 		if (!pd) {
--- a/drivers/pmdomain/renesas/rcar-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-sysc.c
@@ -396,11 +396,6 @@ static int __init rcar_sysc_pd_init(void
 		struct rcar_sysc_pd *pd;
 		size_t n;
 
-		if (!area->name) {
-			/* Skip NULLified area */
-			continue;
-		}
-
 		n = strlen(area->name) + 1;
 		pd = kzalloc(sizeof(*pd) + n, GFP_KERNEL);
 		if (!pd) {



