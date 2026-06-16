Return-Path: <stable+bounces-264506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oXk2DMp1MWqFjwUAu9opvQ
	(envelope-from <stable+bounces-264506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:11:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3AE691CA6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:11:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=dvLTZMoo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264506-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264506-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00AE130400CE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E69451052;
	Tue, 16 Jun 2026 16:10:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480D933688F;
	Tue, 16 Jun 2026 16:10:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626252; cv=none; b=WR6q+b3YjaGVRqNZJRnfMGFsG7z6u6GeZeCiotfKGzXiLVyD0pCuqvzp4GZ/0INd6J0te2/BXLqyHgeEcj8AjrkzoPmFXc16xquCOyRRR/zGHiJZeR+oDKzqlHGfdaM9wdhX7rlGp/IWhWEDUKzhstbSTZ9UOV+oIOGXBDv18M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626252; c=relaxed/simple;
	bh=M4fXxsmjdfECFfEELb/GpgMyCwtznCy9j1oV9T8z2Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAeG5xDaQUAq90y9ROYzv1l8GwY1uv+g91H6aovwvj016Q5ZZb4cWGdJz4z8L5V6brZel3bRyQibCAb8xo1u/ckG62YU5iqnLmVLZroMFi2jfRb1K1X5EKMs0uHgm7y2N414bsvow0NM+vyFVW+zE4Q2zezWnVSAwRgEvU+NzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dvLTZMoo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5981F000E9;
	Tue, 16 Jun 2026 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626251;
	bh=uie7/Qtigzc4kFFIs7yHfh1dBEVSOdT4fIv79TVa8K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dvLTZMooHGzhtJ3c9UWUuJjAvgSfB8BmekuqYx624IBBafWOF3vVe4PARgpTcw7S4
	 EQIk7OPASqjAyp6kEhFRlq8CSpH6eEap2cu8A0xOp6EgKZC+o0ZM5x0V+TQ61ydr/3
	 nvrxL4lU1FR6d/RuIs57kwfGLL6VYxiZ19ylVu70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Koenig <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH 6.18 293/325] drm/amdgpu: set noretry=1 as default for GFX 10.1.x (Navi10/12/14)
Date: Tue, 16 Jun 2026 20:31:29 +0530
Message-ID: <20260616145113.412930190@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264506-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:christian.koenig@amd.com,m:alexander.deucher@amd.com,m:felix.kuehling@amd.com,m:vitaly.prosyak@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC3AE691CA6

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

commit e47b0056a08dc70430ffc44bbf62197e7d1ff8ea upstream.

Problem:
While developing the amd_close_race IGT test (which intentionally triggers
execute permission faults by removing VM_PAGE_EXECUTABLE from GPU page table
entries), we discovered that on Navi10 (GFX 10.1.x) these faults produce
zero diagnostic output. The GPU simply hangs silently for ~10s until the
scheduler timeout fires. There is no way to distinguish an execute
permission fault from any other type of GPU hang.

Root cause:
GFX 10.1.x defaults to noretry=0, which sets
RETRY_PERMISSION_OR_INVALID_PAGE_FAULT=1 in the GFXHUB UTCL2 registers
(gfxhub_v2_0.c line 313). With this bit set, permission faults (valid PTE,
wrong R/W/X bits) are handled entirely within the UTCL1/UTCL2 hardware
loop: UTCL2 returns an XNACK to UTCL1, and UTCL1 re-requests the
translation indefinitely, expecting software to eventually fix the
permission bits (as happens in SVM/HMM recovery). No interrupt of any kind
reaches the IH ring.

This is different from invalid-page faults (V=0) which DO generate a retry
fault interrupt that the driver can escalate to a no-retry fault. Permission
faults with valid PTEs loop silently forever in hardware.

GFX 10.3+ already defaults to noretry=1, which makes permission faults
generate immediate L2 protection fault interrupts. GFX 10.1.x was
inadvertently left out of this default.

Fix:
Change the noretry=1 threshold from IP_VERSION(10, 3, 0) to
IP_VERSION(10, 1, 0) in amdgpu_gmc_noretry_set(). This is a one-line
change that aligns GFX 10.1.x behavior with GFX 10.3+ and all newer
generations.

With noretry=1, the existing non-retry fault handler
(gmc_v10_0_process_interrupt) already decodes and prints the full
GCVM_L2_PROTECTION_FAULT_STATUS register including PERMISSION_FAULTS,
faulting address, VMID, PASID, and process name. No additional logging
code is needed — the fix is purely routing permission faults to the
existing, fully-capable non-retry interrupt handler.

v2: Dropped GFX10-specific logging from gmc_v10_0.c and
kfd_int_process_v10.c (Felix Kuehling). v1 added logging in the retry
fault handler, but with noretry=1 permission faults take the non-retry
path — the v1 retry handler code was dead and would never execute.

Tested on Navi10 (GFX 10.1.10):
- Execute permission faults now produce immediate, clear output:
    [gfxhub] page fault (src_id:0 ring:64 vmid:4 pasid:592)
     Process amd_close_race pid 13380 thread amd_close_race pid 13384
      in page at address 0x40001000 from client 0x1b (UTCL2)
    GCVM_L2_PROTECTION_FAULT_STATUS:0x00700881
         PERMISSION_FAULTS: 0x8
- No regressions with properly-mapped GPU workloads

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit eb21edd24c40d81066753f8ac6f23bce15745395)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -953,7 +953,7 @@ void amdgpu_gmc_noretry_set(struct amdgp
 				gc_ver == IP_VERSION(9, 4, 3) ||
 				gc_ver == IP_VERSION(9, 4, 4) ||
 				gc_ver == IP_VERSION(9, 5, 0) ||
-				gc_ver >= IP_VERSION(10, 3, 0));
+				gc_ver >= IP_VERSION(10, 1, 0));
 
 	if (!amdgpu_sriov_xnack_support(adev))
 		gmc->noretry = 1;



