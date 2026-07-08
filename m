Return-Path: <stable+bounces-272536-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e9L6BVS1TWpG9QEAu9opvQ
	(envelope-from <stable+bounces-272536-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 04:26:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBAD721242
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 04:26:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="k/f4QDQC";
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272536-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272536-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83BEC3031C28
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DD93B71D0;
	Wed,  8 Jul 2026 02:25:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62A3B71DC;
	Wed,  8 Jul 2026 02:25:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477506; cv=none; b=R6to6p6BNRKLhjs33bgvjUMAU51EVN6SibubSWXzNarbsrDg8/lGspGkjCj+jwtnJl6YMK/ZDNYUuuzXL/TLJlYHKeI5NNpW2eam425DhqH+FnCLRCY3ruFLYSxSNPuSWH6SlY1Qm5/qt4BYGCWEktZYcMooE5dlEC4lijjqpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477506; c=relaxed/simple;
	bh=uMRcGUfcSxGy3KJX0xa0rRYeXeX5tZKuWgpF+l22Qbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W2XWad1izIzvwXMxyMSDh3m8g8yRFi/lkH1LnBemyQmoQqGszSl/N/7jg3NBTfPIqB4yxW3ELHWbDM8BytGG7awiU6iljw0gr8Mo1T+yP2X9ObQLKr3+T7ubGiRMKMvVjl4ueOsMAM/L525cgZE//IGiMrU8FdSn354uIHsLyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/f4QDQC; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783477505; x=1815013505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uMRcGUfcSxGy3KJX0xa0rRYeXeX5tZKuWgpF+l22Qbk=;
  b=k/f4QDQCGiThPbAXPIw2/myy+3ogrXxUCigtXWq1ZS+0IkYiLdKN7wqj
   suPLTv00Xyl+22aI/fRlpW7bCCv4Ig2c27jWgIphTSfa1ErO8D8c3LUAe
   lwIoSQ5Qi2R8kakKnNQSS/fUBhYaDJ9N8lmdu0N/v+X/NZr8H8jO+4fcg
   HCzSWyzIu98NxS0fBCq0HdEPpfTEcemxgRdlhWPe5pLykCjri8xdiPVBT
   wCmPf19PSzyA9FgGmZoSqLjFuvlLTaCElJ4z90Tl8BHOG4O/HIxsRQH7D
   d3MxHNK2A1PrVXO/WsDr7TFrqkAwHWpOt7Z8nnMq7Gz0QBn1RhG/gesnu
   Q==;
X-CSE-ConnectionGUID: k7e9PSE4SKugjfRbS0TvVQ==
X-CSE-MsgGUID: rKy2b+KFTIiWio1aGrffQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84230079"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84230079"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:25:04 -0700
X-CSE-ConnectionGUID: C4jOcgdnTqqbeQRAetsxgw==
X-CSE-MsgGUID: 82wwJbsvSNCX+SII30ajQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="252414965"
Received: from litbin-desktop.sh.intel.com ([10.239.159.62])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:25:02 -0700
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
Subject: [PATCH] KVM: x86: TDX: Use validated CPUID entry count for TD init
Date: Wed,  8 Jul 2026 10:29:37 +0800
Message-ID: <20260708022937.2465796-1-binbin.wu@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-272536-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CBAD721242

Use the validated CPUID entry count when parsing CPUID data for
KVM_TDX_INIT_VM.

tdx_td_init() first reads user_data->cpuid.nent to size the flexible
kvm_tdx_init_vm copy.  The copied structure also contains cpuid.nent, and
that field can differ from the value used to size the allocation if
userspace modifies the input concurrently.  setup_tdparams_cpuids() later
passes init_vm->cpuid.nent to kvm_find_cpuid_entry2(), which uses it as
the array bound for the copied entries.

Overwrite the copied nent with the validated count so CPUID parsing is
bounded by the number of entries actually copied.

Fixes: 0bd0a4a1428b ("KVM: TDX: Replace kmalloc + copy_from_user with memdup_user in tdx_td_init()")
Reported-by: Sashiko:gemini-3.1-pro-preview
Cc: <stable@vger.kernel.org>
Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ffe9d0db58c5..b658b03e7750 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2802,6 +2802,12 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 	if (IS_ERR(init_vm))
 		return PTR_ERR(init_vm);
 
+	/*
+	 * Use the validated entry count, as user_data->cpuid.nent may have
+	 * changed.
+	 */
+	init_vm->cpuid.nent = nr_user_entries;
+
 	if (memchr_inv(init_vm->reserved, 0, sizeof(init_vm->reserved))) {
 		ret = -EINVAL;
 		goto out;

base-commit: 50406d35f5635e1cc523e61409d57e851b5f5df8
-- 
2.46.0


