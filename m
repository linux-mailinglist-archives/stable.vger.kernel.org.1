Return-Path: <stable+bounces-259847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x7BMGQ7/Hmp/cgAAu9opvQ
	(envelope-from <stable+bounces-259847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 18:04:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB36300E2
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 18:04:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CYwZ5782;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259847-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-259847-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 633B8300D4F0
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584623EC2E6;
	Tue,  2 Jun 2026 16:04:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898F3F1AB2
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 16:04:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780416268; cv=none; b=EPbHuMdnuQk3GoFZZShsm4W+0x3FdoY7B98W3S+IH7beBLy5vlht5dNepm+DE4tk4mFSBHK3ajNg7FH8vN0wY+nyTXb2PTmbePQ0D7TQ5LKe0gstctz3A2iRFkU3poLKPcIImS205qKAy9JXdxBLLxZCbQbJ7+z7Hj9RxHNNyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780416268; c=relaxed/simple;
	bh=CgUR528ltaPd7rr9XGuU8qxQxZkouETPRzdIsLLIalI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G2ei2EBv6xIND9lVC6hkx8KDienlfgZaHydBwBnozDmidrePrCkg+Zfkd8LETl2LhR4+c/2RmnxamuvkSbamf44OTkGbvEaEl2rPdMQnikee3Bi+o9te1XpZ8FdSnpwaEOvim7swDwCDy0IGlg/WxuimtY+A4/GtzjOvK/eV1Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYwZ5782; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf02708e8fso41229505ad.2
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780416265; x=1781021065; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPM66VcrINL92Jo5ORupc7PN6tPDPcidTQjTGXaIkdE=;
        b=CYwZ5782lx3sJHEUp6vyF1fuIaPOlVjOYynaRkzZJ9bC6AgU7txDIvoaJHohR5PS8G
         Q1esYI57WdVBHXino1XHWZ1gFr3bV+kO0mDtUVHTSWHwA9OQ6qaGAkNMDETOYkZ2rhDH
         OGfAcWMfnMTZItArvLSQ0Mlhd9g9DRy8UEtIuk3HHOEjofx87Lq/S/raL6osy80XIi2o
         Ye+rIQlWvwvKllPFl0QW/tHQxSL4Ld2FBwj1qTDHBlxtMVatAHf4/b6TmQm37tifzdsh
         2Q0pxJ25D9ef5ASHtAJ6Ze9vJ7yRrOYSnN1HSPQQA4p25nDe1rnw86/PKfBlU3uuHFrZ
         M5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780416265; x=1781021065;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPM66VcrINL92Jo5ORupc7PN6tPDPcidTQjTGXaIkdE=;
        b=lrhb+jsOC0ujnuAoZC6ChGnR1kZwOf0h+jRIlmeINEejsEXdhWx5amLwF5FxV9php/
         gIOCT0z7rWaJKDqetd4djCqRy8fo29whDEYInt5/J4aJk2+w6i3md7vAMHBGd32VmP4R
         xJ+IBzam/EbKN/TiCy9Kv4r+2H4Zx+Tx4KflClW7ycRFWas7ITGdawvVh2OBUKjLG15q
         ue6lGyNMvwe2cfJKLChq3XFkimD2ZtFfnG8l3rG8O0QMjyPDyGHm+5lpeGVMbHvHot9r
         qwK5rTZXLs5fwIXgnrT6Asp3q88zSncT1RzJrYMtWkZiM5aXph3/p45p5onltDQg5FGs
         o3SQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+15srvjNS8yxDwZ2DgOhVrEJh+TCBiBw4MgCwwGgqPqVi92YnjAA8gGqcNyie06OYhU+t0nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxydiQMg4S+ggf9yfgnnhhkdjpNaEwZiheRjAVftb+MRR7aNJEa
	aoWQ9laBOOvIUqksgQB1wFCwv9fQO0Ma3F1mQaOb+OvSe9EirrzOLkn7
X-Gm-Gg: Acq92OEdGlXF8UHmFlLs4aXt5A01SHhmpNe2Jm4tW6xgdU7+8exUL45HSQ5QHxrhENk
	8hFaR+3r0NoDWI8OnGsAeZUpSGPgNKmOfmF9zdUaNdyCLp86zrtdjaUwAmkK8jrbH0zDrcAYQN5
	YROw4TWmuYI1x0BBGqWSdjyk/v9KwmWPJ9eeRfmHW8sR18LhYaMhMzdPxxMw5/q5jvP9zfCA0L/
	U17T1Z6DVsXbJPl1RMSh2TVT0q2DKHg909gaGRUVNRzTXrILp2L6CCxNM/YC3m3fQKQON6xx6VX
	J9BSD9KKi2hUm8P7YWZTAlB7zUCZSGKMc2funAY3L+TWcU7IT3ncTZ48i+AKvMgKLM0TFO41bX5
	2LFlvd3NrX7kmvqV0zQBmuDSws5Bf1vx0adSHnx6GxNXBmLNHNayxqObUo8572FvCuaD/vlrShY
	xwEithX+sntejBrEG2K6+1BswJqZ3iboPkYlnniddUQC3TZeXaFkziGA==
X-Received: by 2002:a17:903:4b07:b0:2c0:b6c7:2273 with SMTP id d9443c01a7336-2c0b6c7267emr145511365ad.3.1780416265235;
        Tue, 02 Jun 2026 09:04:25 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c2381bsm140818235ad.62.2026.06.02.09.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 09:04:24 -0700 (PDT)
Date: Wed, 3 Jun 2026 01:04:20 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH] KVM: arm64: Take the SRCU lock for page table walks in fault
 injection and AT emulation
Message-ID: <ah7_BAAzHggzdZeI@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259847-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:maz@kernel.org,m:oupton@kernel.org,m:joey.gouly@arm.com,m:seiden@linux.ibm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:stable@vger.kernel.org,m:imv4bel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01FB36300E2

inject_abt64() rewalks the guest stage-1 page tables via
__kvm_find_s1_desc_level() when injecting an abort for a failed S1PTW, and
__kvm_at_s12() calls kvm_walk_nested_s2() to perform the stage-2
translation. Both walks reference kvm->memslots through kvm_read_guest(),
which reads the descriptors, and __kvm_at_swap_desc(), which updates the
access flag, so they must run while holding the kvm->srcu read lock.
__kvm_at_swap_desc() asserts srcu_read_lock_held() on entry, and the other
callers of these walks, handle_at_slow(), kvm_translate_vncr() and
kvm_handle_guest_abort(), take the lock before calling them.

inject_abt64() is reached from the SEA and size fault injection paths,
which run before kvm_handle_guest_abort() takes the lock, and
__kvm_at_s12() does not hold the lock across the stage-2 walk. Take the
kvm->srcu read lock with guard(srcu) in both places so that it is held for
the duration of the walk.

Cc: stable@vger.kernel.org
Fixes: 50f77dc87f13 ("KVM: arm64: Populate level on S1PTW SEA injection")
Fixes: be04cebf3e78 ("KVM: arm64: nv: Add emulation of AT S12E{0,1}{R,W}")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 arch/arm64/kvm/at.c           | 3 +++
 arch/arm64/kvm/inject_fault.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/at.c b/arch/arm64/kvm/at.c
index 9f8f0ae8e86e..eb334a1c2672 100644
--- a/arch/arm64/kvm/at.c
+++ b/arch/arm64/kvm/at.c
@@ -1569,6 +1569,9 @@ int __kvm_at_s12(struct kvm_vcpu *vcpu, u32 op, u64 vaddr)
 	/* Do the stage-2 translation */
 	ipa = (par & GENMASK_ULL(47, 12)) | (vaddr & GENMASK_ULL(11, 0));
 	out.esr = 0;
+
+	guard(srcu)(&vcpu->kvm->srcu);
+
 	ret = kvm_walk_nested_s2(vcpu, ipa, &out);
 	if (ret < 0)
 		return ret;
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index 89982bd3345f..868895ed0930 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -121,6 +121,8 @@ static void inject_abt64(struct kvm_vcpu *vcpu, bool is_iabt, unsigned long addr
 		if (hpfar == INVALID_GPA)
 			return;
 
+		guard(srcu)(&vcpu->kvm->srcu);
+
 		ret = __kvm_find_s1_desc_level(vcpu, addr, hpfar, &level);
 		if (ret)
 			return;
-- 
2.43.0


