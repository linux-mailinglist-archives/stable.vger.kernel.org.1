Return-Path: <stable+bounces-132800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2491FA8AA4D
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1C19032FE
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E09257AD1;
	Tue, 15 Apr 2025 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r09MjbLZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EAD253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753441; cv=none; b=oR+at+oa4DERjks3MathEl3t5E+su/4oC+4XDeQJbXbfqz8WUjj0bfdAlhZ1i6saE13pwAmVe7rGCv7qMe1KK6ki0SqcHKspdXOGBhA96Yvn0OemZPgttBdZHZsN2DcjcrDWJjWOjeKhYz8MUhqFpCWRbjLnkTekytoDKfD7p5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753441; c=relaxed/simple;
	bh=Q71FEgd2nFAmxGXoKBCEccIwpPNzMMBeao0qPKUGC0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlViOBqvjnpwWmYZuUV6zbpBJ8ADLn19sngVTu/Vlb3v7oz0QTSOanNZHrYqzFLT6N2cqQSnx/9TxKVRJD4A5BkPulOBbb17dBCUmx0A/PqMOjSWiHLBJzHsGTD0IViZ2pKPsheBM1AXt8x/nqrKeGelaF+dejWKiphgbuF390o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r09MjbLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596AEC4CEE7;
	Tue, 15 Apr 2025 21:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753440;
	bh=Q71FEgd2nFAmxGXoKBCEccIwpPNzMMBeao0qPKUGC0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r09MjbLZmQDu6at+sbYGnMHFfS31tyZW1kTHIPsMIr0WanVuVMOiTlJdjgTfabHHA
	 +ZbeP60oVzQRAeycd9EwCmxLPHwue1gBqgv3+XtY99Ll6G0m7vv1rsdztOHC+cPca2
	 7rOxYJ1tgnH7/oI/ku4OWW2d+Nbg37gI9mkcAc+If47EfBDFx3oqsB0LAkVl2bkAYs
	 K/uFbMN8UIjFdH8v0Z/CRGOGdnOPRtS4m/NWVMrvTsJeBV1ZfzgDT4cUlNtf2M4kO/
	 ezsCPRi2L70vrK1+pbOPDQcevLhy8ITXbTIbe8ZHT3D46m8cXfixaF4syTpT+8zoB7
	 bH3jAU0wYXAnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hgohil@mvista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.4.y] usb: dwc3: core: Do core softreset when switch mode
Date: Tue, 15 Apr 2025 17:43:59 -0400
Message-Id: <20250415105106-49407bc4f96ef856@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415113952.1847695-1-hgohil@mvista.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: f88359e1588b85cf0e8209ab7d6620085f3441d9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hardik Gohil<hgohil@mvista.com>
Commit author: Yu Chen<chenyu56@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (different SHA1: fce7bbcd07d5)

Found fixes commits:
07903626d988 usb: dwc3: core: Do not perform GCTL_CORE_SOFTRESET during bootup
8cfac9a6744f usb: dwc3: core: balance phy init and exit

Note: The patch differs from the upstream commit:
---
1:  f88359e1588b8 < -:  ------------- usb: dwc3: core: Do core softreset when switch mode
-:  ------------- > 1:  1b01d9c341770 Linux 5.4.292
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

