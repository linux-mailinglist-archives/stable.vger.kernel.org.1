Return-Path: <stable+bounces-142952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D50C5AB07A2
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290FF1C21B62
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A96139D0A;
	Fri,  9 May 2025 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amLEHBxy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8B13B58B
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755566; cv=none; b=G7VAPAnbT0IHNiFsnfAn1BIbziWaYmPaH/5gPimKzAusAS7ilBjUzC8kBICBm1hS4R7/O3unZTM/As55+CGlrylKexAVcbvUBJbcxSXZY6JeseT3kdwGDu6pOHyYHCon57QrVY6KhBCvU9t+Svjh04NcFiCQyYQeFPKh1HxH504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755566; c=relaxed/simple;
	bh=eW1jKJQLUmw6ZNcmkAt5vtbscBfMulOqJPnn+Dj5S/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jesI0RBpP59u0ztJvtsU+ZODM2HpwVJqMvvM4TULhzXwHmx7GLGjnz5CfpUFrfaJ7Ce1yaRZ9V8j603W4procZeOvXRBLVDHEoPjaKGydPxWXn0Y+Z19/Wsi7uXAHZOOfWX1d4o6ht6DQoFBOrdLIwQAUV2jXLpxSvjmpaKLGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amLEHBxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B4FC4CEE7;
	Fri,  9 May 2025 01:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755566;
	bh=eW1jKJQLUmw6ZNcmkAt5vtbscBfMulOqJPnn+Dj5S/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amLEHBxyECxCP33HyKrQiM3WJabVsUnnwv1E/dngoTXriQ3n6PN9ge5P9tm4UBs6P
	 miCT8xMjCke6c8FSSky5keK94+u1yAV8wTOsZETwrTJnH9wbmfxYnvx9MTKXKpzuO/
	 TamNHEQOmPO7ejbWGMPDa/7AjiXEhAG1rIJM+6cfZ9sOg1IC0oVHH0S3YG1vEBU/VY
	 WJZ0mtdkvK5EY55TeCSvAfopKp+tlxTltUvu4AfyuRQgN24IEGQCa9nOjfJr1Bx+e5
	 66p09uTJeg2tpe9qY2+JfZvT1VYInSCy7ZBaA24Ub8JvK7k1cFR8WA03Ao/cuskcRN
	 tEX1IQwRaZNrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	benjamin@sipsolutions.net
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] um: work around sched_yield not yielding in time-travel mode
Date: Thu,  8 May 2025 21:52:42 -0400
Message-Id: <20250508145118-02b51429410292e1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250314130815.226872-1-benjamin@sipsolutions.net>
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

Found matching upstream commit: 887c5c12e80c8424bd471122d2e8b6b462e12874

WARNING: Author mismatch between patch and found commit:
Backport author: Benjamin Berg<benjamin@sipsolutions.net>
Commit author: Benjamin Berg<benjamin.berg@intel.com>

Note: The patch differs from the upstream commit:
---
1:  887c5c12e80c8 < -:  ------------- um: work around sched_yield not yielding in time-travel mode
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

