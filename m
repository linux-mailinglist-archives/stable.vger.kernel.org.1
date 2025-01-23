Return-Path: <stable+bounces-110333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23CA1ABA1
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 21:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60FF8161683
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8E21C5D4B;
	Thu, 23 Jan 2025 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4PsH27L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC301C07DC
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737665851; cv=none; b=P+7wvnfRbJm3SPXoB9OxDVHfcJQWhk+DmirvM4rWZVBgb9ODlLhSJsFZzwMjLoJfV4BsoC7TDRSFO5+Y29QV2VCrwe6h8DtnA+37SxxYouXa03hVw+lwrDlqrl1Zqkp6Ag9wFWXYcDOmjzokJcjFf4DFWUQxXkuM8bkNzP8cX6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737665851; c=relaxed/simple;
	bh=C5PT9/PR6OzuqWqlgRaNU/iCDT2YESmtd9yGI6MxEbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZbxQRbmQpCKCi7qktj4X9qQPfPr1r9L4m2YKQqZNU785tnZ8hIzpVqJHDTQ8SMGCwbrFblq3GGJThLS8920c5c7kT2B/sDIzIbg3Tm06/TE4hrYtmYrCqiBkA+mFufbNvcBdQBk5/ANmi72llCXLm58DKfZuTf0XUEYGwZ8Akk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4PsH27L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD9CC4CED3;
	Thu, 23 Jan 2025 20:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737665850;
	bh=C5PT9/PR6OzuqWqlgRaNU/iCDT2YESmtd9yGI6MxEbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u4PsH27L6M0OFxwC/A1XTOb41+c5eqPbhuS4k4bSZW3SJq17vdaqDxOOcZ/zODR6a
	 NYjF1WbeGAlADhwgDAI2jSguPy6qekcifATDpRkbl1MVq8oH2X+V7n4Uvg/C3IvUsq
	 7pTg8MEN+DAqXKNsA/XVhqf496t5vztqJtmEPI/RwMhn1Z/vZzDSNYOEZRTTjPtLCV
	 9muvizcj3QWKUybIKKB3kE7au0w9A/1tE4lXIfXWmJrBGii60CRVBBM7piqnrEM3ly
	 ZXknnUENM0A1UmePKh43s7XKNFH/wGP8R8bnyUrJxw9kyp9rjHI1EbgeAbMRgORhzH
	 D1t0q9bT8sjGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imkanmod Khan <imkanmodkhan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
Date: Thu, 23 Jan 2025 15:57:28 -0500
Message-Id: <20250123153451-55c7ac098ad381c7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250123083551.3400-1-imkanmodkhan@gmail.com>
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

The upstream commit SHA1 provided is correct: 789c17185fb0f39560496c2beab9b57ce1d0cbe7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Imkanmod Khan<imkanmodkhan@gmail.com>
Commit author: Rand Deeb<rand.sec96@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c5dc2d8eb398)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  789c17185fb0f ! 1:  53b764260405d ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
    @@ Metadata
      ## Commit message ##
         ssb: Fix potential NULL pointer dereference in ssb_device_uevent()
     
    +    [ Upstream commit 789c17185fb0f39560496c2beab9b57ce1d0cbe7 ]
    +
         The ssb_device_uevent() function first attempts to convert the 'dev' pointer
         to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
         performing the NULL check, potentially leading to a NULL pointer
    @@ Commit message
         Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
         Signed-off-by: Kalle Valo <kvalo@kernel.org>
         Link: https://msgid.link/20240306123028.164155-1-rand.sec96@gmail.com
    +    Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
     
      ## drivers/ssb/main.c ##
     @@ drivers/ssb/main.c: static int ssb_bus_match(struct device *dev, struct device_driver *drv)
      
    - static int ssb_device_uevent(const struct device *dev, struct kobj_uevent_env *env)
    + static int ssb_device_uevent(struct device *dev, struct kobj_uevent_env *env)
      {
    --	const struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
    -+	const struct ssb_device *ssb_dev;
    +-	struct ssb_device *ssb_dev = dev_to_ssb_dev(dev);
    ++	struct ssb_device *ssb_dev;
      
      	if (!dev)
      		return -ENODEV;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

