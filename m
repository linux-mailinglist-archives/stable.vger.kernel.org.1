Return-Path: <stable+bounces-124056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC81AA5CBE3
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 192B41752B7
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BEC2620C4;
	Tue, 11 Mar 2025 17:17:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFDA1925AF;
	Tue, 11 Mar 2025 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713459; cv=none; b=jAUhohSt2dPCAWEK5MNudfiBjwrwmVcwdl/N7Mqps5k3hRWUDH8+2hbCZbJD29QHQm+vaaEGDc+2tcTp3UrSMqYaYau/i3aMlnqGEVvrvmpxPQvXii3GWPUlzCXGjykwogMKw2pkmf2tcPRg8eTVaqyaVwp3WYEAfgVnf24Fz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713459; c=relaxed/simple;
	bh=d2MUZCjy8ry37cjCWkBKe3JtYOwSxUPPNJthsOU6ecc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmPWsZR4ZGKnjt4qbtDlG7NdTt7J0wE2ESe6epQmmKGRzstwJZSKbNTpADrk3Kibixu0AIsnvzZvcnibXIbohU2pmyKAqbcbQwsAWP6ghFASDKqVW0QofdIaDz9rEDPIVbzjM7EPMUW/QvzWOXKIrqFfgU/93lMq7BgEU31p/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55EBC4CEE9;
	Tue, 11 Mar 2025 17:17:36 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	mark.rutland@arm.com,
	robh@kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH V3] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
Date: Tue, 11 Mar 2025 17:17:34 +0000
Message-Id: <174171335999.3659520.16613654046629962007.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227035119.2025171-1-anshuman.khandual@arm.com>
References: <20250227035119.2025171-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Feb 2025 09:21:19 +0530, Anshuman Khandual wrote:
> FEAT_PMUv3p9 registers such as PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1
> access from EL1 requires appropriate EL2 fine grained trap configuration
> via FEAT_FGT2 based trap control registers HDFGRTR2_EL2 and HDFGWTR2_EL2.
> Otherwise such register accesses will result in traps into EL2.
> 
> Add a new helper __init_el2_fgt2() which initializes FEAT_FGT2 based fine
> grained trap control registers HDFGRTR2_EL2 and HDFGWTR2_EL2 (setting the
> bits nPMICNTR_EL0, nPMICFILTR_EL0 and nPMUACR_EL1) to enable access into
> PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1 registers.
> 
> [...]

Applied to arm64 (for-next/el2-enable-feat-pmuv3p9), thanks!

[1/1] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
      https://git.kernel.org/arm64/c/858c7bfcb35e

I removed Cc: stable since, if it gets backported automatically, it will
miss the sysreg updates and break the build. Please send it to stable
directly once it lands upstream, together with the dependencies.

-- 
Catalin


