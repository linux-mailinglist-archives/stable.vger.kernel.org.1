Return-Path: <stable+bounces-230644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH2gJjFxxmmkJwUAu9opvQ
	(envelope-from <stable+bounces-230644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:59:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F03A343E5E
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 614CA3057C51
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 11:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD0390C85;
	Fri, 27 Mar 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="RVAEv899"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648243909AD
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612746; cv=none; b=hS0oR7DZDMvmiGTicDOSO6Ap354MatO3aHffP1pvLfPDXvgEeQaVbD5ha+zbdeA4Z1IetvlEBoeUOEoIHlclQuDH0ZlRKgdhsBSQmEAGC6d+HtM3d2OwMwk8az8KuL1VdIRqQDa+zcp+DHVvPPzh0u39M/bEZdRGsePx2fVIQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612746; c=relaxed/simple;
	bh=7ORQZ8ncEf+eZNmfiPVZiLL+FJbeMarPTKIePIuP2V4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T2JXNvRNXETIAIYJMSTku5Zddx4TNxk5ETE8HW6zgJrcfStbreE0sTvEo7TeKKUv6PaU5C+D8BTKctKJ4gNptKXAfOsd+zvfT8Z9SAXnJ4izflrZwzDG05nf8wXzthEWAhePj+kkAqsDMSUEMzHXdUQK8q2XJ8YLAM3Iie5VwzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=RVAEv899; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aecc6b0861so12825985ad.2
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 04:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1774612744; x=1775217544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hug4SpL7ksBzJoom/vOpWbZH8sETbbkswMlMAN0QIos=;
        b=RVAEv899IOSLyFQF+BWm/TRgbmi8aROhNJGgutBZm0gZssMKhdEmafBbRRg/xTFY8B
         lkLvyveGJsAXFcSwBt0pmMeWehZWclVkDXY7y3gyZf1XdPrQttgcEnN0LmR+aq3e8jBK
         nbQot3gb0o51TMOjvjDaIR0kZsMwUOmzpHVTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612744; x=1775217544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hug4SpL7ksBzJoom/vOpWbZH8sETbbkswMlMAN0QIos=;
        b=bygaM/vXFkjuEUcFyR+UsNxxZG44GEdbx4BjvYg9cH/3/66laZaUgWkskG+8KMUvbF
         jlVP7jqbJvpDt8fb/bfWPG55QoQZgPZm5Mu7hoGWt/wFhZnGLvba0JT3deDUp08Q7t+S
         rzW8ch6smXZKNQoekBe7RHyoH2mjAbkbC948IvHV+2UavZc4OJObfopBdxOQ5IHs6tB9
         7gx2r40Xhhxz/qOMmgTcUXl5KBO1qeK3VbtaqWi/4Qs67jFKBNvEClh2OLrzJc9lTVeX
         //P6vR33LhNlVvHTsp8MVsKM/LMcaPZIpxLkotrEJqpESS174esKOJGHLlrOgaYjDQiL
         YHRA==
X-Forwarded-Encrypted: i=1; AJvYcCVgZcOkYgxdc6GsHd4MX8B6FMEdvLL7HPds7M0wPjJpWYUiOXym3HDe1tB6BYvph7H64QsoIzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmjEjTPY0uc9IPL3URW+MNuMK+ZsKKvh6hTM3IDrEJq9lVWu0
	1sI+CPDmIRWb0VL5pUVa+mgrg0mLJ7Dt1VwEwcAY9ljuuD619iBXVtLfdLd4mKuJADE=
X-Gm-Gg: ATEYQzxoQze+kqJW5bsPsWfDiVaJ58FaO9s0X6yIxU9eH6M0liZHuf77RxLjgeTwBEH
	1ps0lucR39EeVqvzyNRAPFD/YGqlY8gyAHgAo5x59O+ydBJi5AXIUZMl/wIeruTzeyb/v2OUBid
	n4wSDx62oPDC9PInRwLMP0t9Gzc2rHjFlUJvRkFhe8M9EgiSiR4P64oarjLyZmv4QPvBmuor8GJ
	pUeqJqspOtwS8dGWk81ooNOQOOJYlAjGi6C85T/DAAXB5RINFA24A8LL7GJddoNbZ+jfil6IqMN
	Rvv3xtQLqVJIR2YQiTIsPMB99QRLyLFFM46LOh//mrVBlYZuXlPSO3VUQxF/HbqOdnCNwUHH5Ey
	AMyf6Cm4R1c7LOabGokv+ig9e6QlZUhj3uoyiAvbqGQXxT4qcLvj9QgQ9Gk5OY95/ZSbHT5jbsO
	cZueGPVxyh7AclBoaaqo87o1wNzmF4BlOX948z9WvdTCD/wWOLUSxjUC2oTIk5XJo57vMsLBoWC
	eI1aOBxoyUykiAVOwHxrFaPM3xHG1KJjC87bGXdIW0FayXppbipDjAZZXXRfslY3tjP3jKFoA36
	XqYrPzacbTD+rmHvQph7jjgQA2x8bh6tRn/cl87/lPN/OOtY4L+DGjqeQQ9ut9VO
X-Received: by 2002:a17:903:8c8:b0:2b0:6945:7dab with SMTP id d9443c01a7336-2b0cdd224a1mr25925275ad.46.1774612743743;
        Fri, 27 Mar 2026 04:59:03 -0700 (PDT)
Received: from aegis ([2001:fd8:4d01:cc02:98a4:1c09:c7c4:e19a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e820sm58443435ad.50.2026.03.27.04.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 04:59:03 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] apparmor: Fix string overrun due to missing termination
Date: Fri, 27 Mar 2026 19:58:32 +0800
Message-ID: <20260327115833.7572-1-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[quora.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[quora.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230644-lists,stable=lfdr.de];
	DMARC_NA(0.00)[quora.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@quora.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quora.org:dkim,quora.org:email,quora.org:mid]
X-Rspamd-Queue-Id: 0F03A343E5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When booting Ubuntu 26.04 with Linux 7.0-rc4 on an ARM64 Qualcomm
Snapdragon X1 we see a string buffer overrun:

BUG: KASAN: slab-out-of-bounds in aa_dfa_match (security/apparmor/match.c:535)
Read of size 1 at addr ffff0008901cc000 by task snap-update-ns/2120

CPU: 5 UID: 60578 PID: 2120 Comm: snap-update-ns Not tainted 7.0.0-rc4+ #22 PREEMPTLAZY
Hardware name: LENOVO 83ED/LNVNB161216, BIOS NHCN60WW 09/11/2025
Call trace:
show_stack (arch/arm64/kernel/stacktrace.c:501) (C)
dump_stack_lvl (lib/dump_stack.c:122)
print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:597)
__asan_report_load1_noabort (mm/kasan/report_generic.c:378)
aa_dfa_match (security/apparmor/match.c:535)
match_mnt_path_str (security/apparmor/mount.c:244 security/apparmor/mount.c:336)
match_mnt (security/apparmor/mount.c:371)
aa_bind_mount (security/apparmor/mount.c:447 (discriminator 4))
apparmor_sb_mount (security/apparmor/lsm.c:719 (discriminator 1))
security_sb_mount (security/security.c:1062 (discriminator 31))
path_mount (fs/namespace.c:4101)
__arm64_sys_mount (fs/namespace.c:4172 fs/namespace.c:4361 fs/namespace.c:4338 fs/namespace.c:4338)
invoke_syscall.constprop.0 (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
el0_svc_common.constprop.0 (./include/linux/thread_info.h:142 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
do_el0_svc (arch/arm64/kernel/syscall.c:152)
el0_svc (arch/arm64/kernel/entry-common.c:80 arch/arm64/kernel/entry-common.c:725)
el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:744)
el0t_64_sync (arch/arm64/kernel/entry.S:596)

Allocated by task 2120:
kasan_save_stack (mm/kasan/common.c:58)
kasan_save_track (./arch/arm64/include/asm/current.h:19 mm/kasan/common.c:70 mm/kasan/common.c:79)
kasan_save_alloc_info (mm/kasan/generic.c:571)
__kasan_kmalloc (mm/kasan/common.c:419)
__kmalloc_noprof (./include/linux/kasan.h:263 mm/slub.c:5260 mm/slub.c:5272)
aa_get_buffer (security/apparmor/lsm.c:2201)
aa_bind_mount (security/apparmor/mount.c:442)
apparmor_sb_mount (security/apparmor/lsm.c:719 (discriminator 1))
security_sb_mount (security/security.c:1062 (discriminator 31))
path_mount (fs/namespace.c:4101)
__arm64_sys_mount (fs/namespace.c:4172 fs/namespace.c:4361 fs/namespace.c:4338 fs/namespace.c:4338)
invoke_syscall.constprop.0 (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
el0_svc_common.constprop.0 (./include/linux/thread_info.h:142 (discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2))
do_el0_svc (arch/arm64/kernel/syscall.c:152)
el0_svc (arch/arm64/kernel/entry-common.c:80 arch/arm64/kernel/entry-common.c:725)
el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:744)
el0t_64_sync (arch/arm64/kernel/entry.S:596)

The buggy address belongs to the object at ffff0008901ca000
which belongs to the cache kmalloc-rnd-06-8k of size 8192
The buggy address is located 0 bytes to the right of
allocated 8192-byte region [ffff0008901ca000, ffff0008901cc000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9101c8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:-1 pincount:0
flags: 0x8000000000000040(head|zone=2)
page_type: f5(slab)
raw: 8000000000000040 ffff000800016c40 fffffdffe2d14e10 ffff000800015c70
raw: 0000000000000000 0000000800010001 00000000f5000000 0000000000000000
head: 8000000000000040 ffff000800016c40 fffffdffe2d14e10 ffff000800015c70
head: 0000000000000000 0000000800010001 00000000f5000000 0000000000000000
head: 8000000000000003 fffffdffe2407201 fffffdffffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff0008901cbf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff0008901cbf80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0008901cc000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
^
ffff0008901cc080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff0008901cc100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

This was introduced by previous incorrect conversion from strcpy(). Fix it
by adding the missing terminator.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
Fixes: 93d4dbdc8da0 ("apparmor: Replace deprecated strcpy in d_namespace_path")
---
 security/apparmor/path.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/path.c b/security/apparmor/path.c
index 65a0ca5cc1bd..2494e8101538 100644
--- a/security/apparmor/path.c
+++ b/security/apparmor/path.c
@@ -164,14 +164,16 @@ static int d_namespace_path(const struct path *path, char *buf, char **name,
 	}
 
 out:
-	/* Append "/" to directory paths, except for root "/" which
-	 * already ends in a slash.
+	/* Append "/" to directory paths and reterminate string, except for
+	 * root "/" which already ends in a slash.
 	 */
 	if (!error && isdir) {
 		bool is_root = (*name)[0] == '/' && (*name)[1] == '\0';
 
-		if (!is_root)
+		if (!is_root) {
 			buf[aa_g_path_max - 2] = '/';
+			buf[aa_g_path_max - 1] = '\0';
+		}
 	}
 
 	return error;
-- 
2.53.0


