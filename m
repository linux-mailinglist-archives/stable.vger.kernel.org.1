Return-Path: <stable+bounces-94677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D209F9D696E
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1797CB21529
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E83208A9;
	Sat, 23 Nov 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1OnKQWg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1411817BA6
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372233; cv=none; b=IxNmaDF8GbCtjKT9Mm/vuAtP2wYw7TfRguDMj1uYpsa1tLnmNQ/WO/qQb8b5MyooJv6/SaIhGLWMHjnTLuHs4LwWv74lrZoL6wYHupFjKWPsLoeeiT51ljaMqQgnaSwb0vVdQFLgSRzI15m0AM9jGcHhBn9lNCYDmlxg15Xfix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372233; c=relaxed/simple;
	bh=Cvq15I18srqnsRJ46vEgO/Gnx4DV2K/KBKle3QUepp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTftwixAgklf8ESonslgRyFWEPPXUfHocl2Xzzw2UnJIpd3agMUo37R2MspU9U6Ej9NsEWVEd4tJFjRfD6GSFqchXVza438jIxEcjzpAP0pHxi3iTtmZJHOsLtUuUgWhR0VjxCeui7yYEF2M5BT5xPfvw0s73xee2AzR+XIhhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1OnKQWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16963C4CECD;
	Sat, 23 Nov 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372232;
	bh=Cvq15I18srqnsRJ46vEgO/Gnx4DV2K/KBKle3QUepp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1OnKQWgOqqOdXj2DiNN5HERVgNMLwI0sJAY8VNf3p+grfdzq4mAlkFVM5fgYUN+E
	 Him0mxG+1hx7XSfqKUekTp9loLRMk9m7jOkgEflAtcaDzAH0Qw/yDdyUwgZS/mNjpt
	 MIzGSnvYVjCNDv+2hqI45vpD+pfYCPD7Qq6VUPlZeP8PQjZLG7NBtRFf884FEz7cqa
	 zc8z/bjL4UZztBuIge4XpsgCe1XSXkEkuBiAgDTjCDnApSaCbz+UKQsU3b8Zd6XQHS
	 ibRmoTRKyDFFOMn+b6XpV2vptyYKtpyn4TPfBiyFaWpyjqkdrHDj/8Np0HU/2CflvU
	 l6RV8ogzEL9Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 06/31] drm/xe/kunit: Simplify xe_migrate live tests code layout
Date: Sat, 23 Nov 2024 09:30:30 -0500
Message-ID: <20241123092244-92d35e863000d678@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122210719.213373-7-lucas.demarchi@intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 0237368193e897aadeea9801126c101e33047354

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lucas De Marchi <lucas.demarchi@intel.com>
Commit author: Michal Wajdeczko <michal.wajdeczko@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-23 09:14:03.002685686 -0500
+++ /tmp/tmp.D6Q92Tn9Y4	2024-11-23 09:14:02.995375557 -0500
@@ -1,3 +1,5 @@
+commit 0237368193e897aadeea9801126c101e33047354 upstream.
+
 The test case logic is implemented by the functions compiled as
 part of the core Xe driver module and then exported to build and
 register the test suite in the live test module.
@@ -10,6 +12,7 @@
 Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
 Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
 Link: https://patchwork.freedesktop.org/patch/msgid/20240708111210.1154-4-michal.wajdeczko@intel.com
+Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
 ---
  drivers/gpu/drm/xe/tests/Makefile           |  1 -
  drivers/gpu/drm/xe/tests/xe_live_test_mod.c |  2 ++
@@ -127,3 +130,6 @@
 -void xe_migrate_sanity_kunit(struct kunit *test);
 -
 -#endif
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

