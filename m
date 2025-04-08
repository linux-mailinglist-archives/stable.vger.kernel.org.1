Return-Path: <stable+bounces-131825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72565A8147F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352E8886749
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 18:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218502405E1;
	Tue,  8 Apr 2025 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvFRBEcl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45A23E34D;
	Tue,  8 Apr 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136537; cv=none; b=i6Dd62pqfZFA2P9q5qBvxDtgjl9gJlbN6/gUtDgqCRvVmbDEbEoPuyuOXuEaqggVJz98jsIcqcPntVP82vh81lxkwtkYTde1wvZSJWNiDU4FT5nNf6FWthcrN910EN+3Eem8pg76mRjoOcias1WhylcqZ+fPfhMnpP2O/qeW6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136537; c=relaxed/simple;
	bh=eHdcGx888xtlC48ZA5KqHMbjHiCFTZ5zjevtdOgk8Z4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ub67pslJThZe3Sj38IeFH14fQcvtJrU3Fyy1eUlG39gpjoNQP+0FG2T0sizxQWGl75YdIjhTYyLj4NoOa5v19apd/48ixshlH4H5ymq2QZFop3Fl5aesn3nzLIguDig3v0yDvSgiyaAAznXvCjwx5tkkZLLi/eNmBzaA49N5EZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvFRBEcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BB9C4CEE5;
	Tue,  8 Apr 2025 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744136537;
	bh=eHdcGx888xtlC48ZA5KqHMbjHiCFTZ5zjevtdOgk8Z4=;
	h=From:Subject:Date:To:Cc:From;
	b=BvFRBEcl5OsEQi7f/QftnXa7g9jZZyjRi+h36rRb9nVHmg7uJlE73TTQvQyRn5/lP
	 CCz7CnVOGM7R1mJlPiucwR7aIBuRbyBA8yMv2ufrVMBRmykVP3EQ75eyC3F8NwhDMN
	 LhW3o5eX67JkPQROJPeB7jNVqI0TVFzTFtevv1MLc1UoZiGRFLzeUWB+RSWJA38hsP
	 oRVaxCgcVeA8c+hpq3bF0nDQqobZ8zTP8tsHJSbxOfXAKljc40pccb47pfcwGHJkE+
	 hIqBBtuoDHgcpr2TKjvym4QlMTkjr9TVqr2QOdw8p78oFppsq2kOWzTVxcpWc03L4f
	 MNBYQrymw3lHg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.15 v3 00/11] KVM: arm64: Backport of SVE fixes to v5.15
Date: Tue, 08 Apr 2025 19:09:55 +0100
Message-Id: <20250408-stable-sve-5-15-v3-0-ca9a6b850f55@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHNm9WcC/2XNQQqDMBAF0KvIrBuZTIxKV71H6SLqRENFSyKhR
 bx7Q1YtLv985v0dAnvHAa7FDp6jC25dUlCXAvrJLCMLN6QMhKRRUS3CZrqZRYgstJBadHZodNX
 S0FsD6evl2bp3Fu+gS6nhka6TC9vqP3kmytxlsUI6iVEKFG01IGtrpUS6PdkvPJerHzMW6RdQZ
 4ASoNCo2jStITR/wHEcX6/bJTb2AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2485; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eHdcGx888xtlC48ZA5KqHMbjHiCFTZ5zjevtdOgk8Z4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn9WlLibYUDyzvWj6QR2m2X0cD8FPDQOXDzOCKdBw7
 v4qG836JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/VpSwAKCRAk1otyXVSH0OjfB/
 961xgT1ybYDeYy1GntLMrAWWGvOVY3Q6F5R1f8BgjIVQ+5KfSEriODye3WBRgqL9Cb1g6qC74LsMvn
 Hb+y6f3wRTR+CFM9z3/i2ilTpyi/ffAa+H/9Vwt5vwNUyhldIN9VX1IcIVIk61ZbborgUYBYVBznK/
 YJurG1b7TrVrQE6Ysipc3lmVl8wlGwJzO0UO95YPY4HVAKLFDvSSIYJ/95ClMxQrDGqFtcCM2hUgmu
 ari3U0Mn0VvEcUtH6hSs4tPZB53iSaxYHbRL2GzCZHS3jPpgmUVRzQlBfJvBkILhtnxU/N1mISnDck
 GPDKxyb+jQD7ob2iBuovmj2CMsmScy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series backports some recent fixes for SVE/KVM interactions from
Mark Rutland to v5.15.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Explicitly include "KVM: arm64: Always start with clearing SVE flag on
  load", it was included previously as part of a conflcit resolution.
- Link to v2: https://lore.kernel.org/r/20250403-stable-sve-5-15-v2-0-30a36a78a20a@kernel.org

Changes in v2:
- Resend with Greg and the stable list added.
- Link to v1: https://lore.kernel.org/r/20250402-stable-sve-5-15-v1-0-84d0e5ff1102@kernel.org

---
Fuad Tabba (1):
      KVM: arm64: Calculate cptr_el2 traps on activating traps

Marc Zyngier (2):
      KVM: arm64: Get rid of host SVE tracking/saving
      KVM: arm64: Always start with clearing SVE flag on load

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


