Return-Path: <stable+bounces-230683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGsUKcaqxmk4NQUAu9opvQ
	(envelope-from <stable+bounces-230683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:05:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F31B3471F9
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 166AC30C9625
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA1B33F582;
	Fri, 27 Mar 2026 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU4H4Oej"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984133B945
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627325; cv=none; b=gnnQh8qZOrU0BKb19vWZBJUKws/y+hMGF8tF8TAoZZGiTx5nNzppR1rzk2VAhX5nmUOzZVqiQGmc8uCD183UB12i3nTdih+DbGyOkS2VYQeLu24gYFwLKv6awZ7QiRyyvOW63BWT6M8v/q1tKtg8H+1rkdVPMLEhoeU59JbwRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627325; c=relaxed/simple;
	bh=4wA5aA5kvpOysdmKkuQnhxxKdIBhIm6sGNqWgUNHVSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPUOoCx1Y0xP6fw2viVgM7iroJSlIJvEIrVwQKWFQa+9jpskh+uWFaMIorU5coXCo4VubWQ+4dORfmNblnhZTvWRTNIjds9gDFtGIsuntWj2lAygPl9/Iv9o++wjrUC7UtYHWXMCfdIVl5MnJN8fTxyXkwNzkMJFgpuiYBpHCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU4H4Oej; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439bcec8613so1728386f8f.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774627321; x=1775232121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+B9i8tWbv7qCy55iWI/6/ObQDnSt8PQR/1hPCVaYU8=;
        b=XU4H4Oejs4y83xkXHRBIJn5oooxo/RhSWapvAkoEuFIi1Z6CO3K++E172kDH8HItdW
         KshQ9BSWOBhFE9ctT2NnBgQ3A4Z5i+38jomBvsIG295f11uS8OjjdDOb6b190Sck4z0N
         bJr6WhwWCD50TQjpQNKUk7gBEL8f1bcfzy3Qcyc+MXJf0PjJm8yTTBA5Ski1QwW2PFqp
         TKyCtWwJae7OObWhuXJuJD4jbaTygzJ6ManITBjLa8RrLCThDcDdjf4e+KXcEopHbWRt
         dX/EJ/1+QkwHQJqVr1HuOqJrJMdsxbMAd7BBd9vyHw9MxZ2dWwZo/x6amOSKjmgR3/7F
         vGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774627321; x=1775232121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+B9i8tWbv7qCy55iWI/6/ObQDnSt8PQR/1hPCVaYU8=;
        b=L1oiSF2MWf4zBA78MtIqHxzOj7Swqw2OvbY8fIxfVa65IOW0pCCR22ulUNJ8y2XP0C
         Q14sunexIVh7shRAERLzxP51XkZpHuR1XOoiTFiimOYar0CvUj9bPiX3yU1Lxhb9EVwg
         t+fDDQC18Tu6wjaqU+mloxpsv8MMoLsR/u7OB0uJARV7ZjjQl4svgyGqr5lkJNd//0Bc
         Rf3pUnYDhmxjqIKVoXI2klWTIUfAnuxWbQAfSwVUln1f7C+W/evhtInB56mgfVtk3aO0
         R3nieP8A9vZmsSuTLoDEP6aq3HERjLvgbTxfqWegHb9+V1TDoMIcTsovTE/dFw29rj6M
         UjXQ==
X-Gm-Message-State: AOJu0YxXVkOhph1vVjXjgmXQCNVAP/c+A14pYNR5ax5gI324nqla4STE
	NJLFrFKW0zir3W1FLqvxyfIcQWcSXl016dyLJIKlcUq9ntnPDF72NJKe2M2Vl3HV
X-Gm-Gg: ATEYQzwCSj21//2me2/CGEY6ZZsyjrpjZBV7B4sqia0Zljxp6f+H1O+wwJTC41kQiQM
	iLlT5+ugVCwstnc+l7lmEKw3UQOG2CaGqGd7NPT2+K9QWVonxdp0YnNyYrMiEFHTEQ54Gt/jOsd
	VtTGun4hgjUmWAFJJ1kOfOO4SpTKBO/HNVqKsWcSzHa3iPM08xhfOAOUiMuSwmJPAenxnGPSfeL
	PIfBan7WnFaXSUhtuskCvic3ViWS803bwO65tbsxypQuBddNFtWfB8p45nU6qcUAM2a8tbLNhi9
	kxfUvVmes+r5Xur9z1B7gYtSpyCJTmCM/UH96XNptoajJzxsJLpgbD+hAPYRDHNvCP7P3qzidxU
	h6UyoAmkEHmAwKvUFMgoV/3NeTp3orDHezbrgpNRW6RZpcKXPEQ7GYaH38AfEc6aWMnEuwC9nRK
	+OD2/ee+BBD/xwe5ZcaA==
X-Received: by 2002:a5d:64e4:0:b0:43a:16aa:1448 with SMTP id ffacd0b85a97d-43b9e9e8f13mr5334209f8f.22.1774627321076;
        Fri, 27 Mar 2026 09:02:01 -0700 (PDT)
Received: from tux ([2a00:a041:e07d:7c00:1ac0:4dff:feb8:fd3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9192e3e8sm18882191f8f.5.2026.03.27.09.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:02:00 -0700 (PDT)
From: Liav Mordouch <liavmordouch@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	npitre@baylibre.com,
	linux-kernel@vger.kernel.org
Subject: [BUG] csi_J oops on VT write after upgrading to 6.19.10 -- NULL pointer dereference in do_con_write path
Date: Fri, 27 Mar 2026 19:00:50 +0300
Message-ID: <20260327160050.31631-1-liavmordouch@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230683-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[liavmordouch@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F31B3471F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After upgrading from 6.19.9 to 6.19.10, I'm getting a kernel oops in csi_J()
every time something writes a CSI J (clear screen) escape sequence to a VT
console. In my case it's greetd/tuigreet running `clear` on tty1 at login,
but the crash is in the kernel VT code itself, not specific to greetd.

The result is a completely black screen with no keyboard input accepted -- can't
switch VTs, can't do anything besides a hard power off. It happens consistently
on 4 out of 5 boots with 6.19.10. The one boot that didn't crash was when I
manually switched to tty2 before tuigreet had a chance to write to tty1.

Reproducer:
  1. Boot 6.19.10
  2. Have a login manager (or anything, really) send a clear/CSI J sequence to a VT
  3. Kernel oops in csi_J, system is bricked until reboot

I bisected across my boot history using journalctl -- 6.19.9 is fine:

  Kernel          Boots checked   csi_J crashes
  6.19.8          2               0
  6.19.9          24              0
  6.19.10         5               4

The 6.19.10 changelog includes a backport of 5eb608319bb5 ("vt: save/restore
unicode screen buffer for alternate screen"), which is a fix for 23743ba64709
("vt: add support for smput/rmput escape codes"). That commit modifies
vc_uni_lines handling and adds vc_saved_uni_lines for alternate screen
save/restore. I suspect the backport doesn't apply cleanly or has a missing
dependency -- the faulting address (0x0000002000000020 in RDI during a rep stosd
in csi_J) looks like a corrupted vc_uni_lines pointer.

6.19.9 does not contain this commit and works perfectly.

System:
  Gentoo Linux, AMD Ryzen 5 5600X, AMD RX 7800 XT (amdgpu)
  Gigabyte B450M DS3H V2, BIOS F65b
  Boot cmdline: BOOT_IMAGE=/boot/kernel-6.19.10-gentoo-dist root=UUID=... ro zswap.enabled=1 zswap.compressor=lz4 amdgpu.ppfeaturemask=0xffffffff

Oops from boot -1 (journalctl -b -1):

Oops: Oops: 0002 [#1] SMP NOPTI
CPU: 11 UID: 0 PID: 1037 Comm: greetd Tainted: G S                  6.19.10-gentoo-dist #1 PREEMPT(full)
Tainted: [S]=CPU_OUT_OF_SPEC
Hardware name: Gigabyte Technology Co., Ltd. B450M DS3H V2/B450M DS3H V2, BIOS F65b 09/20/2023
RIP: 0010:csi_J+0x133/0x2d0
Code: a4 01 00 00 b8 20 00 00 00 f3 ab 83 fa 01 74 25 48 c1 e2 03 be 08 00 00 00 48 8b 8b 30 03 00 00 48 8b 3c 31 8b 8b a4 01 00 00 <f3> ab 48 83 c6 08 48 39 d6 75 e4 8b 93 a8 01 00 00 0f af 93 a4 01
RSP: 0018:ffffd34941133988 EFLAGS: 00010283
RAX: 0000000000000020 RBX: ffff8b1fc034b800 RCX: 00000000000000f0
RDX: 0000000000000218 RSI: 00000000000000c8 RDI: 0000002000000020
RBP: 0000000000000007 R08: 00000000ffffffff R09: ffff8b1fc034b800
R10: 0000000000000000 R11: ffff8b1ffc17cf7f R12: 000000000000004a
R13: 000000000000004a R14: ffff8b20133c7407 R15: ffff8b1fc034b800
FS:  00007fac7b0e11c0(0000) GS:ffff8b234ce30000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000002000000020 CR3: 0000000108854000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 do_con_write+0x34c/0x5b0
 con_write+0x16/0x50
 process_output_block+0x82/0x1a0
 n_tty_write+0x1ae/0x3f0
 iterate_tty_write+0x116/0x240
 file_tty_write.isra.0+0x86/0xb0
 vfs_write+0x25d/0x480
 ksys_write+0x73/0xf0
 do_syscall_64+0x7e/0x6b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

This then cascades into a second oops during cleanup (NULL pointer deref at
0x2, RIP: 0010:0x2) followed by "Fixing recursive fault but reboot is needed!"
and a "BUG: scheduling while atomic" -- at that point the VT subsystem is
completely dead.

Same crash reproduced on a separate boot (boot -3, different PID):

Oops: Oops: 0002 [#1] SMP NOPTI
CPU: 11 UID: 0 PID: 2485 Comm: greetd Tainted: G S                  6.19.10-gentoo-dist #1 PREEMPT(full)
RIP: 0010:csi_J+0x133/0x2d0
RDI: 0000002000000020  (same bogus pointer)
Call Trace:
 do_con_write+0x34c/0x5b0
 con_write+0x16/0x50
 process_output_block+0x82/0x1a0
 (same stack)

Workaround: boot 6.19.9 instead.

Note: writing of this report was assisted by AI for grammar and flow.

