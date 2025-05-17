Return-Path: <stable+bounces-144674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70743ABAA32
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 15:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175804A4FF5
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6E1E1A3B;
	Sat, 17 May 2025 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1jlG5tr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFD35979
	for <stable@vger.kernel.org>; Sat, 17 May 2025 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487291; cv=none; b=AUAKB2hUAfup1sUCUPtbhI5asjqU+pTsB05kmZvju/Pj4/EJ+/jTwHRTimA/pzoFIHIFGHkC9p4CJkZAtl6+T3Jf3akRORT3Ji7KDxnUzKk194Sn6hr8ePh2EDkBVrkIa0gExmoHx7UDVIIqYKvV6s5dTrwDVgKtSjlROYX/mMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487291; c=relaxed/simple;
	bh=nJJbqerGAmV07F59VEJk7cEQEqbrZle/IWt3RFFMM0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7QJe6Unhlsa+kiADliN+R4CMOo+rFxLcGEIqMhIr8IOPjja3d0cF5CZWre+E81VY32tz5/wvFaCzk3i/NHBJtuAQm2YJYcTHcVvq2za3ZxO6lmoUQlque6QsUetkdT6E2jnpGEmiJSAlPVNPVFts/PuWOElI0QFnZSYkDC+IEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1jlG5tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC95C4CEE9;
	Sat, 17 May 2025 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747487291;
	bh=nJJbqerGAmV07F59VEJk7cEQEqbrZle/IWt3RFFMM0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1jlG5tr9DOB2y4RcuoFqLJH6WwkCC9X4/ry+r56szTucpZ9YewuI00qkKo5K+SIe
	 8bM6P/nrCs9bzdi2Ouw6LO1PolyQhReFZ+1NwxzMboccS08dcJ6aOJoIs/DxLdIetq
	 sNa7yJbqrt5gMFGi9ks5fkciOgJobjmVKWENI9tvH2R5Bfn3aJDKIMgaF9Mvv/kbBw
	 tDkQ1TVb2979oO3HXScewyaa58li43h8EueCiAZ5xNJHL0ZGQGS56o9tVRVRjGP3DD
	 W0p5V1z3z35/AD9b/CMDPJHhiSAQabj0ux1PNrpkBJZrdeoiZAHe8MvP4O20rEHs1U
	 0gO+82kKmX+6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v3 05/16] Documentation: x86/bugs/its: Add ITS documentation
Date: Sat, 17 May 2025 09:08:09 -0400
Message-Id: <20250516213642-88082e344b7c7a1a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250516-its-5-15-v3-5-16fcdaaea544@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 1ac116ce6468670eeda39345a5585df308243dca

Status in newer kernel trees:
6.14.y | Present (different SHA1: 5e32c75352c6)
6.12.y | Present (different SHA1: a35104170df5)
6.6.y | Present (different SHA1: 4c6a960c62ef)
6.1.y | Present (different SHA1: d16fc1930163)

Note: The patch differs from the upstream commit:
---
1:  1ac116ce64686 ! 1:  d920ed9999e58 Documentation: x86/bugs/its: Add ITS documentation
    @@ Metadata
      ## Commit message ##
         Documentation: x86/bugs/its: Add ITS documentation
     
    +    commit 1ac116ce6468670eeda39345a5585df308243dca upstream.
    +
         Add the admin-guide for Indirect Target Selection (ITS).
     
         Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
    @@ Commit message
     
      ## Documentation/admin-guide/hw-vuln/index.rst ##
     @@ Documentation/admin-guide/hw-vuln/index.rst: are configurable at compile, boot or run time.
    -    gather_data_sampling
    +    gather_data_sampling.rst
    +    srso
         reg-file-data-sampling
    -    rsb
     +   indirect-target-selection
     
      ## Documentation/admin-guide/hw-vuln/indirect-target-selection.rst (new) ##
    @@ Documentation/admin-guide/hw-vuln/indirect-target-selection.rst (new)
     +reason, when retpoline is enabled, ITS mitigation only relocates the RETs to
     +safe thunks. Unless user requested the RSB-stuffing mitigation.
     +
    -+RSB Stuffing
    -+~~~~~~~~~~~~
    -+RSB-stuffing via Call Depth Tracking is a mitigation for Retbleed RSB-underflow
    -+attacks. And it also mitigates RETs that are vulnerable to ITS.
    -+
     +Mitigation in guests
     +^^^^^^^^^^^^^^^^^^^^
     +All guests deploy ITS mitigation by default, irrespective of eIBRS enumeration
    @@ Documentation/admin-guide/hw-vuln/indirect-target-selection.rst (new)
     +	    useful when host userspace is not in the threat model, and only
     +	    attacks from guest to host are considered.
     +
    -+   stuff    Deploy RSB-fill mitigation when retpoline is also deployed.
    -+	    Otherwise, deploy the default mitigation. When retpoline mitigation
    -+	    is enabled, RSB-stuffing via Call-Depth-Tracking also mitigates
    -+	    ITS.
    -+
     +   force    Force the ITS bug and deploy the default mitigation.
     +   ======== ===================================================================
     +
    @@ Documentation/admin-guide/hw-vuln/indirect-target-selection.rst (new)
     +   * - Mitigation: Aligned branch/return thunks
     +     - The mitigation is enabled, affected indirect branches and RETs are
     +       relocated to safe thunks.
    -+   * - Mitigation: Retpolines, Stuffing RSB
    -+     - The mitigation is enabled using retpoline and RSB stuffing.
     +
     +References
     +----------
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

