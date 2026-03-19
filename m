Return-Path: <stable+bounces-227212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEsFONSWu2nwlgIAu9opvQ
	(envelope-from <stable+bounces-227212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:25:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62C2C6BFB
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C2E5301071C
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 06:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8463358D6;
	Thu, 19 Mar 2026 06:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="Ad3EZLF4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF734405C
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 06:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773901518; cv=none; b=qq9th5t/Iq+CFvDcjweNjG0s2V4QpdRmCjrthHHw+h2gbeuA9dg0w4vAh2/DAqR8//kso7TPsqDvdNB3HgtbYEP3sg3uoGu3AfdzTdvO7aL0gB0OwnxTbKCf6bDud+hkIHlKyJY4Nu5gj3h4RYf99Xq05B39YnQ2v8iOlwFZWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773901518; c=relaxed/simple;
	bh=qGqiE3KUBrPkxudnJPpgi7Dxk2L7pvIBgsd4DlVGYN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2+gNIOIqtn+vDgZith5l24ZqU48LzuSlWZ6F0IgQsh/q6nw2iYybp+f1hu1LOQLhu/6geuuC20Lb3T1rDItEQg6244QEf9PBut9KBjVGFs+s9BxWfy3vM2NBjlCTPAGDJ8owbZxd5aR5dfnCdmbP4JLaJybxGx7FRDcnr2Gw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=Ad3EZLF4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82735a41920so289006b3a.2
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 23:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1773901514; x=1774506314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7i2hgB7wzWd0GpL7ZbSfJdBzEQ6VsuZDuvwguDkWp8I=;
        b=Ad3EZLF4lL/KOFXTNOnjmQBHvHOhTYxo92sN9dz0QBiuosv+KgmYzMZ3HuFO2ubGfm
         UP6KoJVbdVxNaRpf4Ix6VqSvBh5PmjyTJKv9Bo2g7ZOGAZ4/XbcJJpDzEPDTFkhSjpax
         oFc1sJBlDBTfTLEiEm1CMp8QWQxRt7NnWfMeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773901514; x=1774506314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i2hgB7wzWd0GpL7ZbSfJdBzEQ6VsuZDuvwguDkWp8I=;
        b=G7tMsiVIhPd9C8qgeXpGtV8wj1xJNr4e7t4UIwC99v8WS1bUxxlfIIriQM/ZSKqPtF
         UGs28efjw/PZWv3cZyvdHgL13fTUnIn1w3nAAE6Bltei5U7mLO3Q0h4cifNjSD/BvakR
         /56XVcRl44/GlJ8tPXvcyHYN7339BmP5caw4bP0zDQ80qasLtfce/pXb1/0EnzwAD4Zz
         4fwmYv4YDwmT3fIjmlWugubto53jao2/BW1rhLE09gFLD+cMnN3iUgodHugnfuIFo0y3
         wH3BT/j8KM6/mpHd8y+UgQIV0JB/ms6O6gcXUsGtdP4HSithKAzDCNC6LVTKnW/tWuHH
         dVAw==
X-Forwarded-Encrypted: i=1; AJvYcCWPJCp8MAIlkBoNg7H2fRvTGzDasf+toCz1HH5TYwdDQoo1ovg/WYJBJtb6J56/tnktxnfURzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrfs0RcWWMck/WJV9qRiz9PCliaIQw9W1UQoO6EkZv3e2nDsUF
	3LkZK/iBj7rOkIFWsNvs0VFmmp80jXYgyVKiFpR727O5ho441Ph1msZBw1RvCWFHzl4=
X-Gm-Gg: ATEYQzwPbj3qAWUX3p+88jsJTztfzZLINSW+OOdKfRLObTisEnBx1cz3GBAtYkw6rES
	Oja+xBJTRnS72oZZ/IDFPCO8KTk4iRH4jWS5dM3ocFIGcrOTca2SwwnDXzgj/d2pfy6XgVUesWJ
	3AIGkHKKepHJNVnTazbLHcC3Q9DqoDtpZoZ/nYR4ZeiDmqwgxleKN5zNODyrjEpfqyHBGDHoVGY
	PYVf5PqRYOEJOPxNyFWC2RWciVNjJI+IpLF8c8Q0ngSh069fwqsbw6+XzPxOb10U0SnWiFQHVa1
	vUtLELXDSVgaNVqwor5kZAW1KHP3Jyf8QMljnXIqXLoDGEBgnarHBy19zywDHkFtE7X0yCkRK1U
	fyR0SasexZ2SLwgwH29f6BdR4wt0PXIDA9tg9xY2cXldgCFtWEHki1iL6O7FHU0DWyzbh+UDYy9
	PeqPkaJseRnGNIEFlx87UqlbVOnb8ZwqoT/S3auGRBkQ20nCBGS+IIrhzqoB3gilam51dXa2/RP
	kTd9SVhricvtUz7lZFgncey6HWolBmch7H6jkWPustjWcWvCQyN11eGJsujatoE21f551uuTTnw
	oo9qHJWpsmJqLjkuWj6WxEeX/jsz20zI7qZmEDg3g/0KjRRFTBHJjlBABXmfT2fk0wf/lcHO7eV
	2YoTFEPM0
X-Received: by 2002:a05:6a00:1793:b0:821:a7b6:10a3 with SMTP id d2e1a72fcca58-82a6aed86ebmr5705451b3a.34.1773901514187;
        Wed, 18 Mar 2026 23:25:14 -0700 (PDT)
Received: from aegis.localdomain ([49.148.247.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb2f34sm4862353b3a.30.2026.03.18.23.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 23:25:13 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] apparmor: Fix string overrun due to missing termination
Date: Thu, 19 Mar 2026 14:24:32 +0800
Message-ID: <20260319062433.17648-1-daniel@quora.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[quora.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[quora.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227212-lists,stable=lfdr.de];
	DMARC_NA(0.00)[quora.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@quora.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,quora.org:dkim,quora.org:email,quora.org:mid]
X-Rspamd-Queue-Id: DF62C2C6BFB
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


