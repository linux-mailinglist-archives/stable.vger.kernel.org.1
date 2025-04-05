Return-Path: <stable+bounces-128383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE3A7C8F8
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1182617305E
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098CE1C28E;
	Sat,  5 Apr 2025 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEGR8EzV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEDE8F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854260; cv=none; b=OFjZ5S323ADM8BuJUrkk/pnUdV2+EkIpIwru/teImh5y3Cy3/UmPHs6zWQW1pcmcegLl9/g3B/KADLJqXguZr/IhUuIy7uE4zlRhUIN20FB0FZA+JR3JpuB5KMCvzERZJLIbT74trAagWhBvo8nyVJcLqE2VZuZmh9kps5p6o4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854260; c=relaxed/simple;
	bh=ocgGPak2O441fnFzqDFClWJn6RVqIJ+FzTzhb5k6gF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2yLxHFiP8O08gluTCT9P+NEY1E416+XVDWWeMGVm6AnZpuMA4Y3+NHoc1Y1ODkQvwoJtz5JEgjiTqqSC04cOL0WdI0bhbrFv7J3FxqFJMNqlCD6vLQqfOb6jHIZ22/8VzHuuhWy9VS4l1M7d9F7HIE2kHDem6U1f9RZ34JfuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEGR8EzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96B8C4CEE4;
	Sat,  5 Apr 2025 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854260;
	bh=ocgGPak2O441fnFzqDFClWJn6RVqIJ+FzTzhb5k6gF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEGR8EzVeLqKA6SqJKI3ZYkCxU4UdEJ5CDOH7lmWXfctHZLnBFPOKjPr9DBghAMdK
	 IYSJYDoi7zBUT61dgZ6lCVP58+o2sqmeffhqAg2X34Sg+j4H6sJDJGcT61iirqg7pZ
	 uvMf5e/AcWDGROJhk0INHTHheASx53FtimgzlBREmTMWaxNfuUtI3JMVvk67dw7jDF
	 jCT6Ww6lvIAS8NkExDjLlsRCkfWF7NiroT6wbhsWVv+Or9aDmL5Yi0CZtcQNIu7+7l
	 W+dPBLqKIOQzvR5wfyCYoGMODq0FBW8gKG1G91nsXfHuYgOZhxrPc+T6TqknkfFqAR
	 TAs7CNdTC7g6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 07/12] KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
Date: Sat,  5 Apr 2025 07:57:38 -0400
Message-Id: <20250405021731-6b86cbdc748ef878@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-7-cd5c9eb52d49@kernel.org>
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

The upstream commit SHA1 provided is correct: 459f059be702056d91537b99a129994aa6ccdd35

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: 3fb8296e7622)
6.12.y | Present (different SHA1: d547b363f16a)
6.6.y | Present (different SHA1: 88adb7a00754)

Note: The patch differs from the upstream commit:
---
1:  459f059be7020 < -:  ------------- KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
-:  ------------- > 1:  8b8b4116df48d KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

