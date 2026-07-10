Return-Path: <stable+bounces-273134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uq8HJ7JrUGqNygIAu9opvQ
	(envelope-from <stable+bounces-273134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:49:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D87370D3
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 05:49:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=crz1i8AA;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273134-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273134-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B9A03025144
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 03:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFBC303A37;
	Fri, 10 Jul 2026 03:48:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B081A6838;
	Fri, 10 Jul 2026 03:48:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783655337; cv=none; b=lgA59zBDzxQM6vSUI2q3/F0TKp4ZApEt97MPnsH/AwmIORi0MskJOrWNTMhDHNMiiuYpGpTaHct4oNdq+W2uhFNqtsvflaKB9+1ZB5raGHWqLH04267o5UguyXvCoccM1SjQbDB+UPqqCOp2cHd1a8M65TiYDl+74atmgKjK8SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783655337; c=relaxed/simple;
	bh=IC1suyjmt5b8DyR8pK6rxRhMkrtUSvZA/TDabVoUMEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwXyFWGNPC+7ifUXJkWWK3eBjwalrhu2GBcT414+h13h77pd+pfu9w/KDMHlN1TzJVg5lLLtQupavMGU7F6PnZ15leir9g7bPgXmhDd6k0FyreLMYQhPB8+hV0q2fGMxDHtrmFbp+/Nj5OIv06UQFpilQtR4zD3MDWPgAKNeOOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crz1i8AA; arc=none smtp.client-ip=192.198.163.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783655334; x=1815191334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IC1suyjmt5b8DyR8pK6rxRhMkrtUSvZA/TDabVoUMEE=;
  b=crz1i8AA5IqIcmTaoCzx86+CDpCKfq8TVW5SDlyTDn0awZRPIf/pbvyG
   8Y8Sc5sT35TO9sEM0nhx/47oeZ1NtSzbFUkVtnYkHt6vK2ylRhLNjSQ9E
   hQwIcfcAURJuB09yc/6K7Ex/T4DHSS+7OffQSY4FbkYljAK3ToT9m0cSJ
   YEkASujNddx4z+eQjcnbm4DW01xIZtsFTmzMVxOj2Lam3/yEWd9lUkylL
   SX2cEXzeGUqT6LfApKWIKkgs60qhlsSGVOeZ2WqYckj7FLaNXqB2A7HTk
   zzTDFd8zkaLj7jHR8hqRSzbAegq/IkVSbuXdjGVHXxzb6Z7HpfBBNW2yd
   A==;
X-CSE-ConnectionGUID: GH3l/dSyTgCq0IF3nHWT/Q==
X-CSE-MsgGUID: 4uzS+Cn1TnW4sZ0rg6+jlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94956800"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="94956800"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 20:48:53 -0700
X-CSE-ConnectionGUID: haCtSX8mQB+zOM0BN10Btw==
X-CSE-MsgGUID: DbRQTrCUT2Kz1KkMstE/OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255433185"
Received: from litbin-desktop.sh.intel.com ([10.239.159.62])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 20:48:50 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: stable@vger.kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	thorsten.blum@linux.dev,
	binbin.wu@linux.intel.com
Subject: [PATCH v2] KVM: TDX: Reject concurrent change to CPUID entry count
Date: Fri, 10 Jul 2026 11:53:23 +0800
Message-ID: <20260710035324.3170534-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273134-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:kas@kernel.org,m:rick.p.edgecombe@intel.com,m:thorsten.blum@linux.dev,m:binbin.wu@linux.intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[binbin.wu@linux.intel.com,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[binbin.wu@linux.intel.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 120D87370D3

Reject KVM_TDX_INIT_VM if userspace changes cpuid.nent between the
initial read and the subsequent copy of the initialization data.

tdx_td_init() first reads user_data->cpuid.nent to size the flexible
kvm_tdx_init_vm copy.  The copied structure also contains cpuid.nent,
and that field can differ from the value used to size the allocation if
userspace modifies the input concurrently.  setup_tdparams_cpuids() later
passes init_vm->cpuid.nent to kvm_find_cpuid_entry2(), which uses it as
the array bound for the copied entries.

Require the copied count to match the value used to size the allocation
so that CPUID parsing cannot access beyond the entries actually copied.

Fixes: 0bd0a4a1428b ("KVM: TDX: Replace kmalloc + copy_from_user with memdup_user in tdx_td_init()")
Reported-by: Sashiko:gemini-3.1-pro-preview
Cc: <stable@vger.kernel.org>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v2:
- Reject the request if mismatch instead overwriting the value. (Thorsten, Rick)
- Lump the check into the existing sanity check on the cpuid field. (Sean)
- "KVM: x86: TDX:" -> "KVM: TDX:" in the shortlog.

v1:
- https://lore.kernel.org/kvm/20260708022937.2465796-1-binbin.wu@linux.intel.com/
---
 arch/x86/kvm/vmx/tdx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 6ff1469e91cc..d1af0a752e97 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2797,7 +2797,11 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 		goto out;
 	}
 
-	if (init_vm->cpuid.padding) {
+	/*
+	 * Reject the request if userspace changes cpuid.nent between the
+	 * initial read and the subsequent copy.
+	 */
+	if (init_vm->cpuid.padding || init_vm->cpuid.nent != nr_user_entries) {
 		ret = -EINVAL;
 		goto out;
 	}

base-commit: f1e5ada5ab62dbe32350bc161771c9afc6a896de
-- 
2.46.0


