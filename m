Return-Path: <stable+bounces-144439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F032FAB769A
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220097AE6F9
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAAD296157;
	Wed, 14 May 2025 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHwOfG7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D1295519
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253672; cv=none; b=suzzobTwcYRcuSjKOH3H7rfsL8OZzOmmJK8kgyUcvxWfuFHIA1wrSnz+IHIH7aF+djYU4G+y/sTsIe7SdiCwu6lag8p6sfS7g87PSn6Yw+6/YQg6Y0E/5v/UghVlbnUpmO0kaXTGaNd/NlosT0NRX3BBKNJtgMXI4kRHVlx1T9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253672; c=relaxed/simple;
	bh=jo6KSM38vpQll23VbKfJbn067ZPlZUI9XpysMtyCtr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTEfGGooooQNdo0lbn7WlYmswrByi0qiEMoYVDByrPYpoozBQ3xg5RXQFOGbtA7bEMoG/0j4QooBZPWyaLf1/0P293ldWKESAtlpTh8abgu8k9JHgpvazrdP1zG1/Ne5P4BAk25TK7p7z66tZ/ue564fsF/64oqL2+CdHVbhPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHwOfG7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE80C4CEE3;
	Wed, 14 May 2025 20:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253672;
	bh=jo6KSM38vpQll23VbKfJbn067ZPlZUI9XpysMtyCtr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHwOfG7e9D63crUAvSS8lAJmkJuDVs0w39fIco38ozeUO6w/uIppyBci9526ZF+ov
	 55mJmZf1eVR4pNi+cvWszhbeOjrJR28vnmFiRcS7etN8N1qzMVcSM9HmFvco6Ji7vF
	 B4p///NqvNHUl70uucESHZYvOALDL+ydolmhCZztvkaImuAVsm1JALNzKohgrfbdvC
	 eK2vz1ljEavy1NbRzAwiXktMa9fuje+q0uZkJVPaQxIPBL6yIgSRdhiZ6VANtudF9D
	 baDD3GjM946jl7Q9I2/ElIor7YaBGFenF8IkbodO9y7xF0xjn6rDhe8fK4oRvP9cHV
	 FaPSHgK1vUf7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 05/14] Documentation: x86/bugs/its: Add ITS documentation
Date: Wed, 14 May 2025 16:14:29 -0400
Message-Id: <20250514110833-0cc48f41e2f17b28@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-5-90690efdc7e0@linux.intel.com>
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
1:  1ac116ce64686 ! 1:  5fef22b8da7cf Documentation: x86/bugs/its: Add ITS documentation
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

