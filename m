Return-Path: <stable+bounces-124389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A4A60687
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 01:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE1F3BEB1A
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167E9524C;
	Fri, 14 Mar 2025 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYmhn1lR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4A2E338F;
	Fri, 14 Mar 2025 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741912532; cv=none; b=Qv8txPUsoUABY/Efg9oivaAxRHFHiy77lqiqnkkEg40ziNEqzPCCA/Hm/76pTRA+k75yvWVEy/83FOpo2q9yIVo3l9x8z0oVeIFXNnj13nal1x4RvQrg2/OJc/T8dvVa31pHwhONewJJf2+5kkfnMhSAZUdwkBzgj38X+hMwd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741912532; c=relaxed/simple;
	bh=VyNq+KGq1MvIt8wiPP9z3NWuSyZC8HNFid8j1ag0ziU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eSwFh+wbO3uedB3Js4W7RC85ZjNdPnoQRnda6nCGfyy1qfm+eEQ5ORaMde0WxwvqVxxQy1u+qT3cPgdOyrs/s08LA5dTHpQbPpv7+rJ00DMZsjhiluCspv56WSE/wPT3gBaqvitd4FyaXvFGyq84a7FTl6SpkxFAGPzIG61hmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYmhn1lR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9CCC4CEDD;
	Fri, 14 Mar 2025 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741912532;
	bh=VyNq+KGq1MvIt8wiPP9z3NWuSyZC8HNFid8j1ag0ziU=;
	h=From:Subject:Date:To:Cc:From;
	b=TYmhn1lReFx7HqpHz7FNDUatxOYRkovryGt6eytl6lix7lIv5n6uIpOJmOr+ye0av
	 1gqtfvkezEa65puhBHAxJNsT+IuV2KMwFSTQDuSLTxa1Spx+Z1jlf4+Rc9gWS7U4mF
	 2C/LgGLz4bMeC7ttf79wfv76zaa7UCtGkRGa4f/IHQQ7aiH7jI4r92ajtKgFlISjuB
	 12KtrSgl/2UHfo1hhJx+/nekZJ4ZP6ezlimWaJF52b1lc7PrRgcvRtKCBiH1/nPxZP
	 0UkgqCvf+buMXnw2163qrVZIjqooFH6HuTg9T+uMo6R7Hl/rInvjMEcmENfy+vSmYh
	 eEE/3LgSFuOPA==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 0/8] KVM: arm64: Backport of SVE fixes to v6.12
Date: Fri, 14 Mar 2025 00:35:12 +0000
Message-Id: <20250314-stable-sve-6-12-v1-0-ddc16609d9ba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMB502cC/x2M0QpAQBAAf0X7bOW2HPkVeTjssSV0q0vJvzvmb
 R5mblAOwgptdkPgKCr7lsTkGYyL22ZGmZIDlVSVRDXq6YaVUSOjRUNYfzRuosYPkKojsJfrP3Z
 gC0PQP88LKyV13GcAAAA=
X-Change-ID: 20250227-stable-sve-6-12-777778ad28fb
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Fuad Tabba <tabba@google.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>, 
 Eric Auger <eauger@redhat.com>, Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 Eric Auger <eric.auger@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Jeremy Linton <jeremy.linton@arm.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VyNq+KGq1MvIt8wiPP9z3NWuSyZC8HNFid8j1ag0ziU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn03nI3rQ4drECSXEBo2LN0vtyTJ1f6g66RUTjVnPy
 wNOvBvyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ9N5yAAKCRAk1otyXVSH0NKZB/
 9dOhtBrW+mr33/W9jdpsdEIw5mqmE2blfsMLfBq4tSa5siK11+owL5BRRUIgZZPfsG65cK9chUQh4i
 2IoPq23ynTiVbKG2kfmO6DGHlQss1tvINsdvYfHUSkyJ/awIKBueb+XWdsxG00daKgw7CcQd3A98vN
 zoUXD2XCitYM6znjQGCZSiPZ+5c8e0LKj1bQe6dteUR2h0tk6Ojx8FHeYM8NxW6aX/zLNteZTFIJ1Y
 jJb6Ll/vhUjmD2uZMO39pulqDXwbDwe9i4cqu4r/JRdXPAj4GDrkzQpoyH0UskWThr1tTlSUqGYMpW
 L6Ql7o+bczEt6GNBCXeapnmRtcAaWD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This series backports some recent fixes for SVE/KVM interactions from
Mark Rutland to v6.12.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Fuad Tabba (1):
      KVM: arm64: Calculate cptr_el2 traps on activating traps

Mark Rutland (7):
      KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
      KVM: arm64: Remove host FPSIMD saving for non-protected KVM
      KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
      KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
      KVM: arm64: Refactor exit handlers
      KVM: arm64: Mark some header functions as inline
      KVM: arm64: Eagerly switch ZCR_EL{1,2}

 arch/arm64/include/asm/kvm_host.h       |  25 ++----
 arch/arm64/kernel/fpsimd.c              |  25 ------
 arch/arm64/kvm/arm.c                    |   9 ---
 arch/arm64/kvm/fpsimd.c                 | 100 ++----------------------
 arch/arm64/kvm/hyp/entry.S              |   5 ++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 133 ++++++++++++++++++++++---------
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  15 ++--
 arch/arm64/kvm/hyp/nvhe/pkvm.c          |  29 -------
 arch/arm64/kvm/hyp/nvhe/switch.c        | 134 ++++++++++++++++++--------------
 arch/arm64/kvm/hyp/vhe/switch.c         |  21 ++---
 10 files changed, 204 insertions(+), 292 deletions(-)
---
base-commit: e9cc806c0152fa9993f817cebf42989a3e2530bb
change-id: 20250227-stable-sve-6-12-777778ad28fb

Best regards,
-- 
Mark Brown <broonie@kernel.org>


