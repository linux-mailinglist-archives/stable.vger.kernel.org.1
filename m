Return-Path: <stable+bounces-146043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E99AC05DF
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72DE4A03B6
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2FC22256B;
	Thu, 22 May 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo69JIa0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD1221FD1
	for <stable@vger.kernel.org>; Thu, 22 May 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899493; cv=none; b=UiqFHmtKFuJy06tFS9fxDbUQ8a80vyLIm08dBV9+6mMp9rNgvZnodDs0AozAwhTCAXKh11m1BPIJYTDl9mNBPcNkhw/ZtQbScuyxEZ3mLa7pmnozMuv1UjunYI1EdVTK9BcOzEaRu4gBDzn+TQes+Eqb/eKI0Zlb4jzZGYtxUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899493; c=relaxed/simple;
	bh=8RjllJmPHzc6tMcTSseyKYFaObASo2ggehrdt76X3C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrsfbZvV+J8rx27q6Z2q8O1Ydwv/AKUYeAFkwcm4Ge1n6G9dE+YWZKxle9lTEsB0zRhA6MyuzMoZcknXllX45+aw64GR7iNS0xuZqxM4D/SmK7K/GqoAaWi/O3ikQyKzASiBZ+RuK+mKN9z6Oxa5GvM89reMUecsAmt7x9/cJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo69JIa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BB7C4CEE4;
	Thu, 22 May 2025 07:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747899492;
	bh=8RjllJmPHzc6tMcTSseyKYFaObASo2ggehrdt76X3C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qo69JIa0ZezR8ZYtVjBeUkKsDuhdjeBW7nbyKOHZc4NxyEkd624fJR6+QHWt9Sp9e
	 8fHMI1Zuo+MqFydQrnXwntVfwsFdaDjVVNtKXh3D2+YMcSoQmLf8DkIzkhNuEAT3a7
	 dH99DiCmNpEBA+g38s3VsWl+LPYyGqLGZtNDfUUEf7KKdpOqxoiuFjcWFCp5702on+
	 VinmZiUXvqIpf3FVPZTubYy2Nq6OoN3kggTMDyN9BtBfK93veoskucqW+T4nQJdTh5
	 rGnOx5xMpY3AdbjZJZgO7rESEqiWBeumplh9idLFMO/hHWOqKD6Sg1EVW4cHCQel0R
	 C+f1l688ZNtjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Naim <dnaim@cachyos.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/vcn4.0.5: split code along instances
Date: Thu, 22 May 2025 03:38:08 -0400
Message-Id: <20250521233134-20ee4971b373abcb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521165421.293820-1-dnaim@cachyos.org>
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

The upstream commit SHA1 provided is correct: ecc9ab4e924b7eb9e2c4a668162aaa1d9d60d08c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Eric Naim<dnaim@cachyos.org>
Commit author: Alex Deucher<alexander.deucher@amd.com>

Note: The patch differs from the upstream commit:
---
1:  ecc9ab4e924b7 ! 1:  b72c0acf055f5 drm/amdgpu/vcn4.0.5: split code along instances
    @@ Metadata
      ## Commit message ##
         drm/amdgpu/vcn4.0.5: split code along instances
     
    +    commit ecc9ab4e924b7eb9e2c4a668162aaa1d9d60d08c upstream
    +
         Split the code on a per instance basis.  This will allow
         us to use the per instance functions in the future to
         handle more things per instance.
    @@ Commit message
     
         Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>
         Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
    +    Tested-by: Eric Naim <dnaim@cachyos.org>
    +    Signed-off-by: Eric Naim <dnaim@cachyos.org>
     
      ## drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c ##
     @@ drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c: static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

