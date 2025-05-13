Return-Path: <stable+bounces-144258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35856AB5CD2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B8919E88B7
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29272BEC3F;
	Tue, 13 May 2025 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvezKesS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BD749620
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162263; cv=none; b=qLZf3YRXFCWbE0dNSNLVmx+stGfiK0HELnFxRPO/rhkLYp/FTW4n1kKw3H98/qKEGOfTQJsCRPLm5TacHYqmmD8M9w1dtfcAydFUYsL5KULxOIsgC0CqJpNXR5Vt0fUU1PIC0bBOsHOszdlGTAfINk0CXxQj/49rYh8RpL0N3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162263; c=relaxed/simple;
	bh=8DbNL8z2IR4uARbny5LvkFv5bpR6er9wjEDiWxX5GQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lix7s/igh+d1AVv4UaBWjnrOkfw7qsaAbl7uMhMS59aC2HyYfvniUuogyZGcLIq4wYFLbgbVtJVscGWTqMNWdaUfqv0zTGBnVkluPVPJ5En7vuAXbFQlxPnyZPMBQ52r9doJ4yku/acqYif1qGmI9hVuTkr5Ya7d5kVpVcZZMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvezKesS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F48C4CEE4;
	Tue, 13 May 2025 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162263;
	bh=8DbNL8z2IR4uARbny5LvkFv5bpR6er9wjEDiWxX5GQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvezKesSEOh0KTX2Q4bUJXXs/XQ2eFQiSagKkoJfqlCLqRS4aRHm3eMH0F7OqQYOX
	 8lwgpLokqVQYTgsasbQsz+JyrU6NvLiDxVM0bQ5xP0O1tl/3H8o/FJORQBNg4ciZDD
	 CJlEgmzZC+jrHXdJ/SBXNV0d9C3jO9hB1Amx/6aLgosanoyVx/bi4/mAiYblX6uHqJ
	 ieeSzWBeVYfm6anyyx80pvWTNBWS4AkGXNL76I0oI3UY8exwwXvoTV4oRpChLlkh72
	 S5BvcjZ7VA5Tr7PqrOpNfU8GBZMgNfqfdiLMStcvS1G3JMhmz2dyyXqWL+NwyVxRI0
	 l6nY3dKIKRk7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 05/14] Documentation: x86/bugs/its: Add ITS documentation
Date: Tue, 13 May 2025 14:50:59 -0400
Message-Id: <20250513130600-014c550d40c215dc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512-its-5-15-v1-5-6a536223434d@linux.intel.com>
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
6.14.y | Present (different SHA1: d94999d36def)
6.12.y | Present (different SHA1: 13a7b7b4c7a7)
6.6.y | Present (different SHA1: aef0566edca8)
6.1.y | Present (different SHA1: 145182f52b93)

Note: The patch differs from the upstream commit:
---
1:  1ac116ce64686 ! 1:  e24360a0c5e89 Documentation: x86/bugs/its: Add ITS documentation
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

