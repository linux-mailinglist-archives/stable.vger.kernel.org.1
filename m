Return-Path: <stable+bounces-125771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E02A6C177
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84609176D64
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BB6224B1C;
	Fri, 21 Mar 2025 17:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyRF+oHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547631BF33F
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578074; cv=none; b=bHdifWOaQZJMIw2rJmoy/OvX4E9gcoLW0LRMV2vpOPEiU6hWc4cyrOfJbiQgIMmTvf3EH3JPQ0QC5+Vn5nyv+Cb3yGReqZq8eaAEmUkn2waaEhTOAk/5fsSs3Cmxhvyu396Bf3pwfEYOFjg6jIzw2jPYXYeIxmCU8yi7GOcRFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578074; c=relaxed/simple;
	bh=WGbeVtPDeMsz3e1XdpcmbJr+SOYxw+n7GA3ziJB6OrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giIPwPlznb+jn9b8SKZyVOp0MglDe3bk+Kh3q7an8beavallp2Ig+iDAW0JPhMaFCzeBjWsOSclzbeQWo4zRoZonJt3HHcD8nibB/Er+CEIbeQd41HNRpDEvIssVkeM2heM0y3pI8lq96xOzd5EOk/uLoFsae9kwvQgjon4c0r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyRF+oHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5A7C4CEE3;
	Fri, 21 Mar 2025 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578073;
	bh=WGbeVtPDeMsz3e1XdpcmbJr+SOYxw+n7GA3ziJB6OrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyRF+oHISk858F3JIYuNe0rPPBqBGy+7dSEZGqdAiOle8hK2+gycHswsag+Oz6lg9
	 ET0NJA+VpQkM2KjZsRqCGyESPgjBHR6mo3xFRf8BKylpZGAiciuVNcY4hYkh+ofCB3
	 As0Oq2yQu8ssvO5CZIIXfJIuw0IvWw5pNIzDwOkm0TszXj9obYbZKGMk6QmsPSecy5
	 sLDoloS8nB4MqJF9jV7qf2AYUwIBlWAJTeBLSIOlfxUZdqkZDPJ06rBDdXBBMX6eg1
	 ChkJKdGnEEPsmUkKhkCOTfg3b4LmkrcqNz1/c34NcoDHUVTn0l2srT/ghZNt7AMaZb
	 aE1yYEzpRwiDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2 7/8] KVM: arm64: Mark some header functions as inline
Date: Fri, 21 Mar 2025 13:27:41 -0400
Message-Id: <20250321112547-2eb0603d49f3cc72@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-12-v2-7-417ca2278d18@kernel.org>
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

The upstream commit SHA1 provided is correct: f9dd00de1e53a47763dfad601635d18542c3836d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 315c35c0aeff)

Note: The patch differs from the upstream commit:
---
1:  f9dd00de1e53a ! 1:  f610626fdd5ac KVM: arm64: Mark some header functions as inline
    @@ Metadata
      ## Commit message ##
         KVM: arm64: Mark some header functions as inline
     
    +    [ Upstream commit f9dd00de1e53a47763dfad601635d18542c3836d ]
    +
         The shared hyp switch header has a number of static functions which
         might not be used by all files that include the header, and when unused
         they will provoke compiler warnings, e.g.
    @@ Commit message
         Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
         Link: https://lore.kernel.org/r/20250210195226.1215254-8-mark.rutland@arm.com
         Signed-off-by: Marc Zyngier <maz@kernel.org>
    +    Signed-off-by: Mark Brown <broonie@kernel.org>
     
      ## arch/arm64/kvm/hyp/include/hyp/switch.h ##
     @@ arch/arm64/kvm/hyp/include/hyp/switch.h: static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

