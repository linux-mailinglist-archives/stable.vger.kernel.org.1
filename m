Return-Path: <stable+bounces-154764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1B9AE0142
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72073AAFF0
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205E728315F;
	Thu, 19 Jun 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4zQ/Fsr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1928314D
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323795; cv=none; b=OQ+pHEwnFCWeZdC8Pgkf3rG4lEPneHv8Vh1mu0kG2V6Aemeg8oNJDiIfn24pWr0g4XAiXho/dCNFPiemMgKfaHCwdSuBajrcDM63Sc8b7o0m6vBsvwgvvo8Wii3GDRaA7yaHfMRl30Tj6X/3kJ7J1yS77LcWhWss0u90VpT9yW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323795; c=relaxed/simple;
	bh=XoyWytngJoOSTZmnubq8wvGC4SxzU1Yq2U2S/p6WztI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1S9G7ZD62MZ2Y2vkPtO/ACcMnStBwVC08t2PgnyHR3jsWDhuSNX1ei2zkA0BvK21qJ2eO5GJfrusOck9BgA9f/zpjYWgUTKFrtoA+vp/Hs7rXP3dMhJnby+gkO/O+DLgrF6WmNaHa2rEcU9f5TKc2aRQnuiqI7k8e+vwTQIruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4zQ/Fsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472C9C4CEED;
	Thu, 19 Jun 2025 09:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323795;
	bh=XoyWytngJoOSTZmnubq8wvGC4SxzU1Yq2U2S/p6WztI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q4zQ/Fsrfu9MfrKE06uG2gFcLo9TJI5n9S9Em+t0cNWsn7pX3TlqFJYdtiFkZye4C
	 BaPEoK22+B2ocI7aTg6sxct7TFM773/o+09r7Wy31TSgx4eKKcO+9PqStWWjuw9ttI
	 BJ/A86Yj/JvjSBiWbZ6lPiu+gv5RsA/6hfl4bOdpVHv8/zZG5uLoWI42F1avIX1cnD
	 D3Or71j/SgeMJmTCPiBOfQkkxFw4oTnVvRi7yPKO7QbIgZ8S+jiIGNGFHkUE1r52kA
	 6l1MrUa+n7snCeZOB65vDmco9paXsY829kA4PsMqtv3i/VTV263DyPpq5wKWWGJha9
	 jU6Pt0ibKZ7tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 01/16] Documentation: x86/bugs/its: Add ITS documentation
Date: Thu, 19 Jun 2025 05:03:14 -0400
Message-Id: <20250618164838-2a579fef32195669@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-1-3e925a1512a1@linux.intel.com>
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
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 76f847655bcb)
6.6.y | Present (different SHA1: c6c1319d19fc)
6.1.y | Present (different SHA1: ed2e894a7645)
5.15.y | Present (different SHA1: da8db23e3c8d)

Note: The patch differs from the upstream commit:
---
1:  1ac116ce64686 ! 1:  2a07a25354435 Documentation: x86/bugs/its: Add ITS documentation
    @@ Metadata
      ## Commit message ##
         Documentation: x86/bugs/its: Add ITS documentation
     
    +    commit 1ac116ce6468670eeda39345a5585df308243dca upstream.
    +
         Add the admin-guide for Indirect Target Selection (ITS).
     
    -    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
         Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
         Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>
         Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
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
| stable/linux-5.10.y       |  Success    |  Success   |

