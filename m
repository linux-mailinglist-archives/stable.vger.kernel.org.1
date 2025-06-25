Return-Path: <stable+bounces-158577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EA3AE85AD
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0651889CA3
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A462264A74;
	Wed, 25 Jun 2025 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX//0Zbs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6125EFB5
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860446; cv=none; b=CU+WWAcEBnbNpUJo+FeOBlb85PxVgGsXc/pXAlwshbPJfAr9752vTAHtmNFBx24mLFKyK9OFfv2iLES9myb/7Hf51VtD2fIpdZJS/nafyvd3IF1xrx5/tHofAb+hPp/KZY4edpvy5SsyQ9JImsoXsQWF7TFpO7bFvwFsXiOQ9rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860446; c=relaxed/simple;
	bh=spPmfeus4FZDybOnqXE3buPmBKFrdmZ+LxBaSZlYmwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axgY2JtIitlRNxHJ7GIBRls03ipJgBEscNeHm08UVGnrdB58b7CrkpHk1IdGu78X5VsIMpuQoKzxOf43V1kAJHZE9spH7YEpYS7iTLzKv1IMTOjFx4+DSKNss+FJJTwtlcxxs0YVmwMdLOaCTRAq15Uw+QVvmKSpUEoEHrCkr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX//0Zbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C89CC4CEEA;
	Wed, 25 Jun 2025 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860445;
	bh=spPmfeus4FZDybOnqXE3buPmBKFrdmZ+LxBaSZlYmwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jX//0ZbsgX8IiZCPKzaF0ce/7lKIwiv+VUHzse7UCSzHnl7/xDuIyLX1A9nPjwrUs
	 9WE+EApzPRIvGJn8mY91XN/HhgQIjCyVsgw1mdV4GWMYHhtsfOSv8658/kWldk29iC
	 F7ZnWp3t/2ynL+S8632D2oQn10hbOAoQ2cYjU8OW+8M1jH7pYCwlE4mUyVhZ1c9NLP
	 7OCF8VuJS75vop8pMPJGPXF0TRdBOIlCNxIhihPk+L2Ch7hQqSH5u2d+uuQglnHhPD
	 nQ79wZf5Qa2so1yq6eEpdD+f76weIDwpMa08BRmtFR6KWmTormK3rb2XFu+tpul/b0
	 2re8ouMltQxhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] s390/entry: Fix last breaking event handling in case of stack corruption
Date: Wed, 25 Jun 2025 10:07:24 -0400
Message-Id: <20250624192315-41acd160ac7a473d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623130823.733595-1-hca@linux.ibm.com>
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

The upstream commit SHA1 provided is correct: ae952eea6f4a7e2193f8721a5366049946e012e7

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 5c3b8f05756b)

Note: The patch differs from the upstream commit:
---
1:  ae952eea6f4a7 < -:  ------------- s390/entry: Fix last breaking event handling in case of stack corruption
-:  ------------- > 1:  5d8199e6ab3c2 s390/entry: Fix last breaking event handling in case of stack corruption
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

