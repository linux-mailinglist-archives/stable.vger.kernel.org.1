Return-Path: <stable+bounces-127453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAD2A798A8
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 01:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7702F3B2DAE
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9F1F3B82;
	Wed,  2 Apr 2025 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go/Ed3Cw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C01E4A4;
	Wed,  2 Apr 2025 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636057; cv=none; b=moIY4Uuvb1PYZFXjPMT14DWttjjmZH8xiysSTfmII8vPfvZgR+AgwWLNMBwEOByoFOdpg1Loc8j+BeQJtIQ0S7/np4pKw5JczZW6lBngTDu/YwaqRqgmbx0mH+KM3bDarUfkLIF9KCDP4UKl/Pq1MUOvTMdGWZ46Y2QOnFBUYO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636057; c=relaxed/simple;
	bh=nX3/gruz24nzISNsLYUs3H9vqQmZwbmWGJB7cUGfVoE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GhfBES/VW7/IMLwIhyeddbVvCuyy0hA9+6APbD337JxR0awkiWjzbdqfoYpwO8AvjRRnjQys/piG76TUsdU8HoLso874yfGbBFvFNlruTMmdtjnus+XCqvANbrZI0/VtSUz6SYVR6N8CHjIiaR40CH1RI6ngedpVEw42D0r/Ki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go/Ed3Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599CBC4CEE9;
	Wed,  2 Apr 2025 23:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743636056;
	bh=nX3/gruz24nzISNsLYUs3H9vqQmZwbmWGJB7cUGfVoE=;
	h=From:Subject:Date:To:Cc:From;
	b=Go/Ed3Cwz/alHDySGecwArKJVHQHZ1FiDwWom+1wYsVT3Usv/pWCphRpdwbkcjCUy
	 qsIIpr7lSAElm2FpzUok2EsykLU1VTbH0CAKJWtJS7MtY0Em8sC6ASdCwMx4UvkGzt
	 +78zmwiSD7ELL37ErjeIV0cz5h5z1/V6skXrO52aS6p5nr5gier26m3B5oiBOj4RDk
	 KkpTdTiwta9c21E/bUj02YLk62/pyFp0bZwB+LaH+UwcQszJOqceUy3aWtukwKRtyD
	 JFiNzkE1rRovBAl86Er2h2hP3DzX0MeR5uQzXGzLz8cm5hLjm7uwDgniSsCUjh6wRm
	 hKBNB7W/f2CLQ==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 v2 00/10] KVM: arm64: Backport of SVE fixes to v5.15
Date: Thu, 03 Apr 2025 00:20:15 +0100
Message-Id: <20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDG7WcC/2WNwQqDMBBEf0X23JVkm22lp/5H8aBmo6GikkhoE
 f+9Idce3wzz5oAowUuER3VAkOSjX5cMdKlgmLplFPQ2M5AiVle6Ydy7fhaMSZBRM/bO3tk0ZAf
 XQV5tQZz/FOMLuNYMbU4nH/c1fMtN0qUrRqPoz5g0KmyMVcLOaa3o+ZawyFyvYYT2PM8fURId9
 bUAAAA=
X-Change-ID: 20250326-stable-sve-5-15-bfd75482dcfa
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Eric Auger <eauger@redhat.com>, Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 Eric Auger <eric.auger@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Fuad Tabba <tabba@google.com>, Jeremy Linton <jeremy.linton@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2164; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nX3/gruz24nzISNsLYUs3H9vqQmZwbmWGJB7cUGfVoE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn7cZLdrB0NO2dtFqvf0MXWLWp0zeFLn8mNybRYe1e
 XZtDk0yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ+3GSwAKCRAk1otyXVSH0EkJB/
 9+jsZvsVXLDPs6gcGZVxpGmfa//H8yI2IrfxewqHudBfTQOgLqbs5oOQpH7gK1HD1HjkcjO9nrBvTV
 ZguofnrYaUcdjZUx2jPX7WQC+16vQDJajTLeLtcMdGuLrwpLUV3hOZwjZZIwp0F9ONX+NnCaPeBdJW
 dJtvP4O0nby/ZzzOpg8VReOitP4c3uRSXhXvr444ulUHfIigt0+8RLKiLGIaWj6cL9p+8nCfz8p0TA
 QyksgcZPw5IisW3/LMfmSpeHwA7sIcPfcZFTGZV8oKSSMah+y2y+x9xInYjcdiMalI4kO9ckHZLHwm
 CqVr1OAguVRimiy+R2aGXkMjUMrEjd
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series backports some recent fixes for SVE/KVM interactions from
Mark Rutland to v5.15.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Resend with Greg and the stable list added.
- Link to v1: https://lore.kernel.org/r/20250402-stable-sve-5-15-v1-0-84d0e5ff1102@kernel.org

---
Fuad Tabba (1):
      KVM: arm64: Calculate cptr_el2 traps on activating traps

Marc Zyngier (1):
      KVM: arm64: Get rid of host SVE tracking/saving

Mark Brown (4):
      KVM: arm64: Discard any SVE state when entering KVM guests
      arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
      arm64/fpsimd: Have KVM explicitly say which FP registers to save
      arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM

Mark Rutland (4):
      KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
      KVM: arm64: Remove host FPSIMD saving for non-protected KVM
      KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
      KVM: arm64: Eagerly switch ZCR_EL{1,2}

 arch/arm64/include/asm/fpsimd.h         |   4 +-
 arch/arm64/include/asm/kvm_host.h       |  17 +++--
 arch/arm64/include/asm/kvm_hyp.h        |   7 ++
 arch/arm64/include/asm/processor.h      |   7 ++
 arch/arm64/kernel/fpsimd.c              | 117 +++++++++++++++++++++++---------
 arch/arm64/kernel/process.c             |   3 +
 arch/arm64/kernel/ptrace.c              |   3 +
 arch/arm64/kernel/signal.c              |   3 +
 arch/arm64/kvm/arm.c                    |   1 -
 arch/arm64/kvm/fpsimd.c                 |  72 +++++++++-----------
 arch/arm64/kvm/hyp/entry.S              |   5 ++
 arch/arm64/kvm/hyp/include/hyp/switch.h |  86 +++++++++++++++--------
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |   9 ++-
 arch/arm64/kvm/hyp/nvhe/switch.c        |  52 +++++++++-----
 arch/arm64/kvm/hyp/vhe/switch.c         |   4 ++
 arch/arm64/kvm/reset.c                  |   3 +
 16 files changed, 266 insertions(+), 127 deletions(-)
---
base-commit: 0c935c049b5c196b83b968c72d348ae6fff83ea2
change-id: 20250326-stable-sve-5-15-bfd75482dcfa

Best regards,
-- 
Mark Brown <broonie@kernel.org>


