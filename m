Return-Path: <stable+bounces-94680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 190BA9D696F
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 15:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF2A281B5A
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AFB208A9;
	Sat, 23 Nov 2024 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLgR1QRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270DF17BA6
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732372239; cv=none; b=RIKnd9W5F7j3idcmKOk7TCO07tjmbScc39F+ELDBvXHghltfXNpeHvzGi/6Q6NmiJZNvL65nPgxsWipwqVTP1tlaHc7lXajali8B0ICUqoU8k9M6Dexc3c1S7VuTGMt1+zz0KxaDv3Oz1MsAQbhdygIPdQcjS5arVUaNzgzGau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732372239; c=relaxed/simple;
	bh=35wvAhgpUMy3iaiCAvfIkqM0E+efridHepnxr43+qEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k82iCfrYTThuJFFBJYyk53wqtirW1TalaTSv3rMYKosagnOvkvnRMfYWa7IK5lm6NTIxTASwzFMKt7ya0kKZpK7ibqbWyEFHygzr2cy9bdwtqAnhZpDuR3Rbp8+jeirOceTJhBTY8B+JwGdnEHUh3M83ue7vihd0YNS3OjFXfIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLgR1QRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3052BC4CECD;
	Sat, 23 Nov 2024 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732372238;
	bh=35wvAhgpUMy3iaiCAvfIkqM0E+efridHepnxr43+qEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CLgR1QRWyebDdr8/IN3AiFdJBj8XVRYe+PzF9Jd2YCAv5Im/g/0wyFBeKC/Qc0xc2
	 igeo0f9TgTTlB1YnhNz+TkwJmL48hpXHyV/9ujROlvwfmdrp5dLbP9Srx7ZoFHV9U9
	 E9S/QGFCtgjLnn2b6Sv07hzOv1cgOKRVIx+XSPYCR+Pbg9OxHiHrcP4xTdjobfbxBn
	 mhURw9IzR5eoega5oopbrhccvySgCIa+M0jMDtfvb8KXcYhLUnyGLqT9+ubOYMW+yn
	 ajpadTFiNIOzts4/Q2CaHKCrhIDlk3CEgtqN7yMKFWRjbEbuuiBd7pZFhFwcldv2yB
	 2Dy/RUx/B+gMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 04/31] drm/xe/kunit: Simplify xe_bo live tests code layout
Date: Sat, 23 Nov 2024 09:30:36 -0500
Message-ID: <20241123090328-27834b4cbe9a115a@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241122210719.213373-5-lucas.demarchi@intel.com>
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

The upstream commit SHA1 provided is correct: d6e850acc716d0fad756f09488d198db2077141e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lucas De Marchi <lucas.demarchi@intel.com>
Commit author: Michal Wajdeczko <michal.wajdeczko@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-23 08:54:18.968301678 -0500
+++ /tmp/tmp.kTGzsMN7DH	2024-11-23 08:54:18.959956694 -0500
@@ -1,3 +1,5 @@
+commit d6e850acc716d0fad756f09488d198db2077141e upstream.
+
 The test case logic is implemented by the functions compiled as
 part of the core Xe driver module and then exported to build and
 register the test suite in the live test module.
@@ -10,6 +12,7 @@
 Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
 Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
 Link: https://patchwork.freedesktop.org/patch/msgid/20240708111210.1154-2-michal.wajdeczko@intel.com
+Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
 ---
  drivers/gpu/drm/xe/tests/Makefile           |  1 -
  drivers/gpu/drm/xe/tests/xe_bo.c            | 20 +++++++++++++++-----
@@ -143,3 +146,6 @@
  
  MODULE_AUTHOR("Intel Corporation");
  MODULE_LICENSE("GPL");
+-- 
+2.47.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

