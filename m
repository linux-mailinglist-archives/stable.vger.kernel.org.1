Return-Path: <stable+bounces-164776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC29AB1274C
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948F13AA467
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5B25F976;
	Fri, 25 Jul 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec8GaZH2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBD41A8F
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485853; cv=none; b=ittmZ9LMJjCkjljLL84/jDWSlTWJEY4AJBrP0YwKeemrj9J0pn9oXT8VTWGw8Uz6CUOrHze90rfSxJYZ2VYeAVDbwn858dRZIiC7Raily7y05ndH/JkE4AB8VzgcAoNjqjMANHX8w9h0U3JpOXRmVPW/R9ZRHKq9Fstf1MvQpWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485853; c=relaxed/simple;
	bh=dYYwaSAKY5WNdY24B16Wn2EjUwxoJc8jSdrJgmnVzAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3VcokOM9T8bdkTGA4BDHksrQ7WfSmW+Y4mLsVSO2Uhq8D2ibtBeqjc/8LJlfUy4p0Vg+sT0wEM5qU7AMjJhu00XmOvrfqZHzhp0nlWJszwdRx8pUClyUiGv4GBVjYQfpnf0NXI5E/l/Awez8cJwUKJnxSCW6HARSGf/uMEsXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec8GaZH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E141C4CEE7;
	Fri, 25 Jul 2025 23:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485852;
	bh=dYYwaSAKY5WNdY24B16Wn2EjUwxoJc8jSdrJgmnVzAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ec8GaZH2AUAko+grSUyfKJ+KHYj2ppXgKCl1xu2bOMIVrFNp6y+p+v/BeF96BWlXx
	 JH2ahpI2k+Tvz6op/TgN8OkhoDMNdHcqKZyQ38dGHbC88SINqKts19XV7L7Md5Hmcc
	 SLFXYxQjXRgiGM6uLwTASBapSfTBBRFxTp/CkNtN4j6TP+18c7si/6u6fY8UJ4EJPS
	 6UTd2EtFdOVWZvRNZEuDNfx2wU4biZ79a0QYXCl/1JLtagliXoVgEzkwxHthA06cx0
	 qUWGQ5fE/+umCzvXKssCbuSOYeEXfpP46I1Mj/Oc/WuxWFhKOpOFzXCsWnzdqS5rUy
	 IGCvpKQ8i6wug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	abbotti@mev.co.uk
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: Fix initialization of data for instructions that write to subdevice
Date: Fri, 25 Jul 2025 19:24:10 -0400
Message-Id: <1753468023-5d115273@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724182218.292203-8-abbotti@mev.co.uk>
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
❌ Patch application failures detected

The upstream commit SHA1 provided is correct: 46d8c744136ce2454aa4c35c138cc06817f92b8e

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.4.y        | Failed      | N/A        |

