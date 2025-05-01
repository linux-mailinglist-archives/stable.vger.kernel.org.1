Return-Path: <stable+bounces-139386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58328AA6395
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FCF4C2EA0
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0F72253E9;
	Thu,  1 May 2025 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOR44YhB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B536224B04
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126721; cv=none; b=nxLRNGgyD+sb3qbtRaRdp6/9kMy48lSvbyuZZlLMGwfosjEb3zZHQ4tO0mjRBm5faYJvE1Zw2kfZHmP8nulUmQ/hW7CzZgrSyhjOPXFuUvAJHZt9daZhAKqIRsQNJ7G9i7+zupRmbVrvn5bDRVqzhNdTWiAP3ytNBFkZnxG4gno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126721; c=relaxed/simple;
	bh=STXguTtlJQ8ThCKox0xKDvkVtcj+uQu5ftlRFBMeaXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZDAEGGYDzBrIaBnJIK/6IQQQhQF3O2lF6qgWwsXv5BL0kfGV/02UaS+2/KPiZUlkgbJxgYZOV1F3fEiwOUShI0YszGdkA1mSjEAWlG84E8oSkKAe1gjIjh8Lw2BjO5UvTG511N2NDEWOCbM4jhQMwyP1t0qHYmL52E9lNOyJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOR44YhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920B5C4CEE3;
	Thu,  1 May 2025 19:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126721;
	bh=STXguTtlJQ8ThCKox0xKDvkVtcj+uQu5ftlRFBMeaXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOR44YhBg7yZ9IAPloU4abdRt5+TTyBQSlpgB0p+iNgvdtCfnqqYWoKywjFJyVHfv
	 RBC/LPpEeRYZYNQNzbuTBXNZEolOUhJYUmz5/96ai2JuWP5uFVb042Y6tllLP7D3K6
	 MlRrJvEbst4n9Enn6H0KOaWakUIo1ycAi8fLVPx10axxufi4cB7NTrvEMm4a4bxdgf
	 dymW2o8F/b4+Kx1ewWv/6BryOQfnDpWeFyn+vnadCYifxKv65EynG9Sb6miBw75tkt
	 07uNnk6cX5q9prktNMl3Zv5Xymxki4MwljZvMcqGkrZXM0XrXRIKGY2aC0wzHfGPjw
	 ZRfG7c/w9tmpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7/7] accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
Date: Thu,  1 May 2025 15:11:56 -0400
Message-Id: <20250501120230-527fda3a0ff9fe91@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430124819.3761263-8-jacek.lawrynowicz@linux.intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: dad945c27a42dfadddff1049cf5ae417209a8996

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  dad945c27a42d < -:  ------------- accel/ivpu: Add handling of VPU_JSM_STATUS_MVNCI_CONTEXT_VIOLATION_HW
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

