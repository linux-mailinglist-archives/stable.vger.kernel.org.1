Return-Path: <stable+bounces-132783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68457A8AA3C
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4EE3BA86B
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292792580C2;
	Tue, 15 Apr 2025 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp18C+i8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD55253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753390; cv=none; b=FsePltdbOO7I+IEcIwmLWCyz6kwUJhXMTwQJGlUZ94K1I4XKsJPbkX8V101wr7hgwuxjFOvLUzIuX6l9mJgjsdBIH+NuyKoCc+yq9A8XH5Id0IYpjG1E7LYdwS9rRGaFcPjAe34RKrxCyNjDfsM++kJENv1m9l895M9bhS8dgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753390; c=relaxed/simple;
	bh=/3bzc3ixfwzm/L6mLYb//GnnzjM/yBdgMgzq2p7qILY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kus1fmveLXMb4Ii+SOIVMSLGO7CbVG1cnz0ldy2YAE98S4+cSP3R57EJ82HyOQe/wVuUbidbZqtj4wB07DnattTwNAaIKiA3KYzxT1Eg6MXVYeUuj5kGjveEMx+rqu0+YGJyQu8JkxZI2IirHETinpJj+ntd0YZxc6MD18FA7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp18C+i8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA2EC4CEE7;
	Tue, 15 Apr 2025 21:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753389;
	bh=/3bzc3ixfwzm/L6mLYb//GnnzjM/yBdgMgzq2p7qILY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vp18C+i81Aw6tO7ryBXmPOeW0cq8qWKwrQF47/9SUPwUisvdRRYu0gM+i6oBXV3r8
	 j5rSkBJjoTHEckV5+8WOQLh4pJrDA0EDL0ZCKz0mGaH9hxOoNDMjG5uM7KRmBNPIwi
	 sl17ejCwx6DQ7uT/EzoFaB3rdxa3q+9Rv7CT//2oHGJTRNij6dhX+K5mf++iAoX+vG
	 /EbFkTUEMqY4qzbsnOZrkBUgcD59B/fcro0P8SAJMmt+Dw1QDuXJmw6yA0vImWkpaM
	 naLMTdmdvqTRtJGwyGyLnJe16TfdQlpGH8URtQkIZCHG/eAXKsblgVsmlwADzIyGRE
	 HgpQNgUySb7Rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] smb: client: fix potential UAF in is_valid_oplock_break()
Date: Tue, 15 Apr 2025 17:43:07 -0400
Message-Id: <20250415112449-0d403bda217b21ea@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415020212.320762-1-donghua.liu@windriver.com>
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

The upstream commit SHA1 provided is correct: 69ccf040acddf33a3a85ec0f6b45ef84b0f7ec29

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0a15ba88a32f)
6.1.y | Present (different SHA1: 494c91e1e941)

Note: The patch differs from the upstream commit:
---
1:  69ccf040acddf < -:  ------------- smb: client: fix potential UAF in is_valid_oplock_break()
-:  ------------- > 1:  9bdb460b7ab1a smb: client: fix potential UAF in is_valid_oplock_break()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

