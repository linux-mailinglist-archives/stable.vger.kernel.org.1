Return-Path: <stable+bounces-165179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7CB1579D
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 04:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBAB4E6547
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 02:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720B31C5F06;
	Wed, 30 Jul 2025 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXmu8Rks"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3069B15A8
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 02:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753843377; cv=none; b=IiukkCMRdRqp4VNf17He4XxrTKVjdrQ4hs6XkfkClYdOanH4h5yGrwQQxas4ORxERGlaaIYAhmkSHnPkE1tIgf/py6tjqXIuQhmjDalWTBLyh3TOMrnzoJaDgRza5NNdAN96IgStgu1UKlOEuNSViOI4OsdwzlQSfhjboLSGfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753843377; c=relaxed/simple;
	bh=s6XOK4D54weGFsdd2XJyljYYgWw5nPNufajxGeJTffE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKwvG9foBK5ikKp/m4fBa2brhIQa4LwlvFKIMfwzigOFVI1mt8m6ChnxjBsih4SUV6bluiOh8lYFFQr8Nf+L6Q+TM+NFGBRMC7P3L2gV/VtB2iMg9h/bRRxKB/C66Eg6Qju5j/m4IfpNoYSdMuFL+5oDp2I/eGY8qf+M8ICwTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXmu8Rks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC1EC4CEEF;
	Wed, 30 Jul 2025 02:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753843376;
	bh=s6XOK4D54weGFsdd2XJyljYYgWw5nPNufajxGeJTffE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXmu8Rksb7nUlFhA4Jz0sn97WxOstQOEEQjmgSJUHLme9xi0oGVtPHA2bHmX1FI0e
	 /wwHMbZ+huyKYem1vHly73LJpS5VmdiKCYveMtZD6Qfwx3NuWoJSKrglnVKAiVDZVX
	 fdFSHk7iiCSijJ0ru50A8UcacfqgrnR9pptPkX21cfL/soKrKlUizV9kqyM7QIjmNz
	 aBcgYh8BHGCtMzf3vjtNnPRJeovqF8sSClNNjHmB7p3ar7Q+Xp0yY/7rnRH2Mg5Qt3
	 esjTkIop8Vop3x80WmM71VlBkv2ZaByRCBDxlxptZbGJS4SPLcX+TIsGk9PhjIMZhw
	 gFDNEt91GFz3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sumanth.gavini@yahoo.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] HID: mcp2221: Set driver data before I2C adapter add
Date: Tue, 29 Jul 2025 22:42:54 -0400
Message-Id: <20250716200658-fbf1063f2e8bf820@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250716195316.176786-1-sumanth.gavini@yahoo.com>
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

Found matching upstream commit: f2d4a5834638bbc967371b9168c0b481519f7c5e

WARNING: Author mismatch between patch and found commit:
Backport author: Sumanth Gavini<sumanth.gavini@yahoo.com>
Commit author: Hamish Martin<hamish.martin@alliedtelesis.co.nz>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 2afe67cfe8f1)

Note: The patch differs from the upstream commit:
---
1:  f2d4a5834638b < -:  ------------- HID: mcp2221: Set driver data before I2C adapter add
-:  ------------- > 1:  f2198ea7eb3e7 Linux 6.1.145
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

