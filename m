Return-Path: <stable+bounces-255669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFQsO0OkGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 995415F8886
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 369FD3088CB7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88592D1303;
	Thu, 28 May 2026 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K9C2ESXN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC2282F17;
	Thu, 28 May 2026 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999561; cv=none; b=Ps9W3kElKhBcecTC41DKvpo/arzAxEF5u+LMw1Sf1+KnXygaiJsVThlzBjQMr+wH+ypE3NzMZqKVVu9/iffSjfAspbkIq6m65R+1Hqd8spdqBWDiSH/9Qo+t75RkpWEPh0xEQ+vtIuKlEW5xL15zEVeXqY0p/RdTaLqzQwdGCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999561; c=relaxed/simple;
	bh=JHlUR2f8xCUXF50JEVUro16HRKhG+/r4IqL1r1ZO3a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riBDVtZyzIRCR5tNm3o4AzyVrEdRy8x6lITgy2GHJWlIBK7mRVeMFzp3U+bTM1KXElkNzL+q5zPx/Ij8KO6yEYwfyB09IF/+3NuH7Me05ctqfdPpEaXfD2eEY/cJzGKXMbI2M46vBDFh/8jGs2Yu2HD3LFupzD3qRQBJ/Jeyyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K9C2ESXN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD181F000E9;
	Thu, 28 May 2026 20:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999560;
	bh=pGeyE1tzf95ttkB4Cd0hC8uo+AkCgbr6Zgz3gs1A0c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9C2ESXN8AMcMptMHZnA2mXx7GR/GwWeH14jFZppdnxwzWVZ+dDMMtXrk3aFWxvZG
	 Mpu2x2fqJkyzGQGeZvJ3KAmshL/pikK6ZOjwxCb0cUbs+knX+1I+pwYizJ65h7FbHn
	 +tJuVXzIBVTE2rrVjox3J6nbJ21zE203RO2AoDZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH 6.18 109/377] KVM: SVM: Disable AVIC IPI virtualization on Hygon Family 18h (erratum #1235)
Date: Thu, 28 May 2026 21:45:47 +0200
Message-ID: <20260528194641.494661257@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255669-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 995415F8886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tina Zhang <zhang_wei@open-hieco.net>

commit 9a12fa5213cfc391e0eed63902d3be98f0913765 upstream.

Hygon Family 18h CPUs are derived from AMD Family 17h (Zen1) silicon and
share the same erratum #1235: hardware may read a stale IsRunning=1 bit
during ICR write emulation and silently fail to generate an
AVIC_IPI_FAILURE_TARGET_NOT_RUNNING VM-Exit on the sending vCPU.

The absence of the VM-Exit causes KVM to miss the required wakeup of
blocking target vCPUs, leading to hung vCPUs and unbounded delays in
guest execution.

Extend the existing AMD Family 17h erratum #1235 workaround to also cover
Hygon Family 18h.  With IPI virtualization disabled, KVM never sets
IsRunning=1 in the Physical ID table, so every non-self IPI generates a
VM-Exit and is correctly emulated.

Fixes: 8de4a1c8164e ("KVM: SVM: Disable (x2)AVIC IPI virtualization if CPU has erratum #1235")
Cc: <stable@vger.kernel.org>
Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Message-ID: <20260522040014.3380201-1-zhang_wei@open-hieco.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/avic.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1252,12 +1252,14 @@ bool __init avic_hardware_setup(void)
 		svm_x86_ops.allow_apicv_in_x2apic_without_x2apic_virtualization = true;
 
 	/*
-	 * Disable IPI virtualization for AMD Family 17h CPUs (Zen1 and Zen2)
-	 * due to erratum 1235, which results in missed VM-Exits on the sender
-	 * and thus missed wake events for blocking vCPUs due to the CPU
-	 * failing to see a software update to clear IsRunning.
+	 * Disable IPI virtualization for AMD Family 17h (Zen1 and Zen2) and
+	 * Hygon Family 18h (derived from AMD Zen1) CPUs due to erratum 1235,
+	 * which results in missed VM-Exits on the sender and thus missed wake
+	 * events for blocking vCPUs due to the CPU failing to see a software
+	 * update to clear IsRunning.
 	 */
-	enable_ipiv = enable_ipiv && boot_cpu_data.x86 != 0x17;
+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18)
+		enable_ipiv = false;
 
 	amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
 



