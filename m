Return-Path: <stable+bounces-215893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAECHsEojWl8zgAAu9opvQ
	(envelope-from <stable+bounces-215893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 02:11:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CEF128D23
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 02:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A50830DEE3B
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 01:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61A81E5B88;
	Thu, 12 Feb 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ7rtkod"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7734C6FC5;
	Thu, 12 Feb 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858606; cv=none; b=dFWuX4mhBhnqRKrS/L5sZ5vp8RDRXlnQq4oUhSEJZXyPFfZ1rUgTt2YO85HtzQTOZRK8/QdR2PZlZCg0iArufx+RsOELAUo/VHtWmnCd3pm04oOjnV0ERzYhWiH2+dnXXkXFsesD0+G/ykVuKflMP/3WHemo/78qTS91s+GnvcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858606; c=relaxed/simple;
	bh=QLT6RgMv62ZraNUSIuAaLzoSfVVBylat0rii7v3ZbAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiDpH3i2kS7NeT9MLxT/9Gu2I9ZsIQqK22sZ1vgb7Mmp/tKunVITYGEaQ4xvlBZG+cvaCegdQ68ppQ1yFM0TzTr/a/khtE2H7jYb1iUrADxNx/0PUCy1uKBPsjYLfvjidVlNT0H8HkU6VP8hYhrPUhDoKn6eGU3Ab7dmMJ48cOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ7rtkod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C630BC16AAE;
	Thu, 12 Feb 2026 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770858606;
	bh=QLT6RgMv62ZraNUSIuAaLzoSfVVBylat0rii7v3ZbAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZ7rtkodGRuelBOiMFjH2YiuMDMUpbumFMKltfirFnp1gtKEq6IdISruIBCDh3mk4
	 AzRL2ldqrVxZCcmKyR9x8EhRVyAQC1npn4/kC6DWuCBEgTb9/v0PvESXyAAmtIx8cb
	 Ji7fc6HNIRiR69Vk9bP6QqxQtlYUyy/jMZNP1Q5dKBYcQT4JULRxm2YCq0m20yNJqa
	 8DMeWS3neHMmnVRjHvpRMbEZdoHRnCliPgVTO8pc8yUJMugUXNKwySOrlbGbsyZQRr
	 tTg3ziZhibPIKoi1X8jkzZeylLtX9IjAljTpfDYNtgpg7dI/C1W0bvbJyKS+T936HV
	 ZPGnQ3zbDGecQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Martin Schiller <ms@dev.tdt.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] perf/x86/msr: Add Airmont NP
Date: Wed, 11 Feb 2026 20:09:28 -0500
Message-ID: <20260212010955.3480391-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260212010955.3480391-1-sashal@kernel.org>
References: <20260212010955.3480391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215893-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tdt.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,infradead.org:email,intel.com:email]
X-Rspamd-Queue-Id: C9CEF128D23
X-Rspamd-Action: no action

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit 63dbadcafc1f4d1da796a8e2c0aea1e561f79ece ]

Like Airmont, the Airmont NP (aka Intel / MaxLinear Lightning Mountain)
supports SMI_COUNT MSR.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251124074846.9653-2-ms@dev.tdt.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Here is my complete analysis:

---

## Analysis: perf/x86/msr: Add Airmont NP

### 1. Commit Message Analysis

The commit adds support for the Intel Airmont NP (aka Lightning Mountain
/ MaxLinear Lightning Mountain) CPU to the MSR perf driver. The commit
message explicitly states that "Like Airmont, the Airmont NP supports
SMI_COUNT MSR." This is a simple CPU model ID addition to an existing
driver/feature.

The commit was:
- Authored by Martin Schiller (ms@dev.tdt.de), who maintains patches for
  the Lightning Mountain SoC
- Signed off by Peter Zijlstra (Intel), the perf subsystem maintainer
- Reviewed by Dapeng Mi (Intel), an x86 perf developer

### 2. Code Change Analysis

The change is exactly **1 line** in a single file
(`arch/x86/events/msr.c`). It adds:

```c
case INTEL_ATOM_AIRMONT_NP:
```

right after the existing `case INTEL_ATOM_AIRMONT:` line in the
`test_intel()` function. This is a switch-case fall-through that enables
the `PERF_MSR_SMI` counter (which reads `MSR_SMI_COUNT`) for the Airmont
NP CPU model.

Without this patch, on Airmont NP systems:
- `test_intel()` returns `false` for `PERF_MSR_SMI`
- `perf_msr_probe()` skips the SMI counter
- The SMI perf counter is unavailable even though the hardware supports
  it
- Users cannot monitor SMI (System Management Interrupt) counts via perf
  on this CPU

### 3. Classification: CPU Model ID Addition

This falls squarely into the **"NEW DEVICE IDs"** exception category for
stable backports:
- It adds a CPU model ID to an **existing driver** (the MSR perf PMU)
- The driver already exists in all stable trees
- Only the CPU ID is new in the context of this driver
- The `INTEL_ATOM_AIRMONT_NP` / `INTEL_FAM6_ATOM_AIRMONT_NP` define has
  existed since kernel v5.4 (added September 2019 in commit
  `855fa1f362ca`)
- The CPU is already recognized in numerous other kernel subsystems
  (`common.c`, `intel.c`, `tsc_msr.c`, `intel_tcc.c`)

### 4. Scope and Risk Assessment

- **Lines changed**: 1 (absolute minimum)
- **Files touched**: 1
- **Complexity**: Trivially simple - adding a case label to an existing
  switch fall-through group
- **Risk of regression**: Essentially zero. The change only affects
  systems running on the Airmont NP CPU (model 0x75). For all other
  CPUs, behavior is completely unchanged. The added case falls through
  to the same `if (idx == PERF_MSR_SMI) return true;` that all other
  Atom variants in that group use.
- **Subsystem maturity**: The perf MSR driver is mature and stable; this
  same pattern of adding CPU model IDs has been repeated over a dozen
  times in the file's history.

### 5. User Impact

The Intel Airmont NP (Lightning Mountain) is a real SoC used in embedded
networking equipment (routers, CPE devices). Martin Schiller works for
TDT, which produces networking hardware using this SoC. Without this
patch, users of Lightning Mountain-based systems cannot use `perf` to
monitor SMI counts, which is useful for diagnosing system latency and
firmware issues.

The impact is:
- **Who**: Users of Intel Lightning Mountain / Airmont NP embedded
  systems
- **Severity**: Functionality gap - a hardware capability is not exposed
- **Real-world**: The patch author works with the hardware and submitted
  this based on actual need

### 6. Backport Feasibility

- **v6.12 and later**: Patch applies cleanly as-is (uses
  `INTEL_ATOM_AIRMONT_NP` and `x86_vfm`)
- **v6.6, v6.1, v5.15**: Requires trivial name adaptation
  (`INTEL_FAM6_ATOM_AIRMONT_NP` instead of `INTEL_ATOM_AIRMONT_NP`, and
  `x86_model` switch). The `INTEL_FAM6_ATOM_AIRMONT_NP` define exists in
  all these trees.
- **Dependencies**: None. This is a completely standalone one-line
  addition.

### 7. Precedent

The `arch/x86/events/msr.c` file has a long history of similar CPU model
ID additions (Tremont, Tiger Lake, Ice Lake, Comet Lake, Rocket Lake,
Alder Lake, Raptor Lake, Sapphire Rapids, Emerald Rapids, Meteor Lake,
Granite Rapids), all following the exact same pattern. These additions
are the textbook example of the "device ID addition" exception to stable
kernel rules.

### Conclusion

This is a textbook example of a CPU model ID addition to an existing
driver - one of the explicitly allowed exception categories for stable
backports. The change is:
- 1 line, 1 file
- Zero risk of regression to any other hardware
- Enables existing functionality on real hardware that real users depend
  on
- Completely standalone with no dependencies
- The required CPU ID defines exist in all active stable trees
- Following an established pattern seen many times in this exact file

**YES**

 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 7f5007a4752a1..8052596b85036 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -78,6 +78,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_ATOM_SILVERMONT:
 	case INTEL_ATOM_SILVERMONT_D:
 	case INTEL_ATOM_AIRMONT:
+	case INTEL_ATOM_AIRMONT_NP:
 
 	case INTEL_ATOM_GOLDMONT:
 	case INTEL_ATOM_GOLDMONT_D:
-- 
2.51.0


