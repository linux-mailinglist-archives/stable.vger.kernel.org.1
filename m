Return-Path: <stable+bounces-134682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4775A94331
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1FC17BA94
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB71A254C;
	Sat, 19 Apr 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTfz7CRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBD1C84A8
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063229; cv=none; b=TSPFcw9T07u5KbMJ+WekyllwtYHxDylEg9tuacps2xhDIJX2FyB5uD2jiLaKFSe0clSQQgC6oz1iDtYIW54xU9cs5RIsKVea5gWEbZhgxALozAjsLhOmLF5Eayr89tY5g7aoGjPugFtplLsp5Lg2ErR0W5Te2g0r6AEZVxKx4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063229; c=relaxed/simple;
	bh=L2XTKPiizbf76X/L9CDcRnoVtdH1bN08DkRc0QX1i14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3hkY2HA9VmSodfFR/1zcZZa+KprHN2Do70sPKEECLakoVr0iOH7Q6vRssP4dXS2A2540k400wnlqy7JjohWXIxPUWIeldk0SXBNC6Fai00WNd6FcID1AFsFs+Y/w9jBkpBxhwWm8cAfg8hF7Pb4hVfYgH+7pKI5NXK4kQea5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTfz7CRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CD9C4CEE7;
	Sat, 19 Apr 2025 11:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063228;
	bh=L2XTKPiizbf76X/L9CDcRnoVtdH1bN08DkRc0QX1i14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTfz7CRZC0xiH92CZOyVC8oUp0+4vbll8YWazhqGHqb0iTXCDTVPA/UNP86HwQt45
	 kgwINWAxRX7oJpnECBHgkvD5uGXIrbez9TLGH/3Gvs0qd4GyBYC7OnnatscYpO3AbZ
	 fVme6/dZN1SX25iOc+o4dqIzqxMbMXpuQYnz2chHMZPKpQuebncp5sNXi/7DoxnWHT
	 rWo7+axYfSyhAjArLdaS/+fMLSIJ+DNKYagfRnT92DOG1RXT/bpa/cZO2yY9HowePz
	 0Gn1uj5n28REr+ldu8k8ZFvUCbBRt5GrIOr14we9Qg+J30l/BgAuhC9fi2E3t28Dtw
	 MbZSRTYYh1kcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
Date: Sat, 19 Apr 2025 07:47:06 -0400
Message-Id: <20250418202537-b124a1ff123b2427@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418120504.2019343-1-hayashi.kunihiko@socionext.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: f6cb7828c8e17520d4f5afb416515d3fae1af9a9

Status in newer kernel trees:
6.14.y | Present (different SHA1: 501ef7ee1f76)

Note: The patch differs from the upstream commit:
---
1:  f6cb7828c8e17 < -:  ------------- misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
-:  ------------- > 1:  fc8a461f0de13 misc: pci_endpoint_test: Avoid issue of interrupts remaining after request_irq error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

