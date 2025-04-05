Return-Path: <stable+bounces-128390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C7AA7C8FF
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB2B7A2DE9
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34E1C28E;
	Sat,  5 Apr 2025 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coEMbBbd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80E8F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854275; cv=none; b=d3Z+HViYtt1V6lhLrRnxicEZb2DUW1TS8yknmym473a4ycCzaqVueWZrf+8aoLTKTJ/XSYcaN1JZflsQ1BL0BU0jCR6YlbASVGOrTvWJUjGbqa8K//dHUrLZK8ie/dXlZm77S/XGPiMSdtleAssrwBmP2Px+zV8ri6bAEA+W47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854275; c=relaxed/simple;
	bh=SMvkjAY+FsxA0qMa96PsdGj2cS6isY2jdgIxUKQHo3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzNegvKbEqV/QzNwCs3JqtrOwWT0zd7b7+Hg0foNGudMvvyEsf2T6HQuMpWSqeIAzFGc+7t5KoG2zg7uSCxRLzNMIqtQvT3NxoFCUs3bqzsi8ouCfhdz/va93rr2h3zTHMLDv8Em4EHjLefb9pmVl26qAUP5JvlLyU9nwiK1kts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coEMbBbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65843C4CEE4;
	Sat,  5 Apr 2025 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854273;
	bh=SMvkjAY+FsxA0qMa96PsdGj2cS6isY2jdgIxUKQHo3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coEMbBbdyXnV41534ha+typvgEig9IQxMKU+7I6KAjshb2qYByBso7yPEqvJmC7s1
	 rathndCza0s35+aJCY7dIC9e+nhIVVabV0TLMgeyJ5/pA1c0HGVThrtYicDAriqYiO
	 yDPHbBkIlMErJ6ZKepsE7022sVxt3o9RktvLpspe43e520Tab6jyrYMjYMQFtpNsdn
	 +aE8mNXITqcJJ52NMwMu3cfAxjGqRtFvTSTzoon8suelmOHnGy2XYNsYXQCo9nemt1
	 GtAAmOnCf4gymu1MymCeBWVbPVtXcFlJNZRuOE9cCCqUSM2ew4b7uivatsiB4/KfsD
	 4KKJzmHeNzhDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 12/12] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Date: Sat,  5 Apr 2025 07:57:52 -0400
Message-Id: <20250405031122-2bda7c53ebfe10d4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-12-cd5c9eb52d49@kernel.org>
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

The upstream commit SHA1 provided is correct: 59419f10045bc955d2229819c7cf7a8b0b9c5b59

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: 8c90d431c166)
6.12.y | Present (different SHA1: c7762348038b)
6.6.y | Present (different SHA1: 7d5669629422)

Note: The patch differs from the upstream commit:
---
1:  59419f10045bc < -:  ------------- KVM: arm64: Eagerly switch ZCR_EL{1,2}
-:  ------------- > 1:  db70f4a960366 KVM: arm64: Eagerly switch ZCR_EL{1,2}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

