Return-Path: <stable+bounces-223643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA5eBLvJrmnEIwIAu9opvQ
	(envelope-from <stable+bounces-223643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:23:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1E239ABA
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2292301CCB3
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD83B4E94;
	Mon,  9 Mar 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EedMA1ov"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B113B4EB0
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062584; cv=none; b=X3WKuRz8I+tAUavtCXK44CF2PbfaIhrtKhUImIZCz+Q6OhJdHbhSLrdurtYsTZjmungEqeuCb1jaq/QMnG7Tld8UbXiEoKOXK9V1sqeteBcqruq/HXHS43DYLLwERu1naR16iol3+UVVES756t6NRREOu3qmQ3crp4T7y4CXKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062584; c=relaxed/simple;
	bh=CDMbHzOyiYwCK+NTxgsJNExVm7yzDLO+SyVZe+dSh2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n520KyKWgzI5BPy9zpwNqE0jxgd/NNGE0YkwIfAaWWtn89woGmewS7wPl4fT2Kq7e2F2KA2oh/l0n1vw9x4fB4w/7slAh2pHy9IN9jRcDPjR81BmwLvUsGD7KJyqCEzIm9nluB7pFRSww43ytrNZ3PQyNNtynz055nU1yIKEjCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EedMA1ov; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2aaed195901so53204235ad.0
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773062581; x=1773667381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/8sxaR6Udi4hucwXNgPS4OOBhRNDaLccHenaA3fy0A=;
        b=EedMA1ovGlI+4gxb3Mljx3i/L86Q78RJIb6i2XL23Uox+MIx+ADuCpg23I/Sx8PRhD
         ThIsZAFM8GONI+IxmxVZBNwKwqHWfPNYAdLPIczwfXqnD729MihzyEpEEneMaI3LD0d8
         /2QXSTWCKvFlFJARxGU7udqpYtWCP6lRWryOrcyaRPM+7CKE8lXZA+G1PBMjKoAGqIXy
         +kz4otblpWLx5iT/tuQL5uVQdWW7GZPbnkD1pL2vE6/KIP5zYvrdQGDQijMKmE3YCt+f
         UluS8sTVHthiy1N3WVdZD/CwEvGClJTQk/DNXkSfUvjtU3cNcnExsLlMye9VKVgRK9QF
         5I0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773062581; x=1773667381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/8sxaR6Udi4hucwXNgPS4OOBhRNDaLccHenaA3fy0A=;
        b=WRhXy/QCvcGNJWxi3WpoBfqCIx59xgHjyFYtlMJNX3OIMWNT9EA1jAQnm83dHD+KIA
         800J3W2DZ2fCQZ6nPQ0OTPSuXlPv7DwvSRGoo96Djz++rN8oe+iNRBo5bUsO6/plmqi5
         euk/fnSbC3AO/Rdo//lV3VyROjKLiiV/SojGWM4LmkR+oJbEC8xR9ed2/k4rw1lWKGqs
         X3nMX1vbOhQCJFspilr1bkNchvXrpxRHk1akxRX+WHikjBKgWdLyU/KKs8Hg1brIdAYn
         vzpUJhP+HGqtWa1e5NX4ZWxMh0J6joXl9qlHg5Z3CY9BAU/z86sgvUWZyyjI9HGE86q2
         lxog==
X-Forwarded-Encrypted: i=1; AJvYcCVdpVTPjeTlGyCdaAOddfC8CVBoJG72P3qHPi0SEZ83tBCWJxxbjctMtmpv4LClVVX9YXRFwMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH6JTuFcRnHNqbwWFDX9CDb/8MZvxnVUXLxJjoFRabeFYnSl91
	SKRWMaXSaT0BnaiHMQsJxqFSdbSUcNgK2Pl5GpZ1e3znteJTFqVcwr9+
X-Gm-Gg: ATEYQzza9mDI8YnBANVBcEphUhN+/EFBmvQW8WgyNiN5nMv0oC9X1XUXMYX22iQAZXm
	wwL2zsBKf0gP5zMdzAGGe/BYDtY8ShYeBrQ2fJshE3Cjw/uw8VA7ib33iZZxpv8QGEmRykgO6Cg
	PdARezneJDXJ6fg3hmhSs+zmjP8MruPF6Glgs49/cgqREcBXgOOuXIQUiwIvEdiIs72J+8lmFtB
	AgALS0qV4eV0Xpq/6BegJrqJbPyoBzxFRJz1lmqVfywTe1UoBZn4Sxj/0qVbqzauUqgAEu9O8Va
	fiRXO/mmhZ/QuBaQNZdvmPQN1cm7e41zDYf3OHJyNAEa2q5ggreIqDc829Ak8WXEEjrqi7zsLZV
	H7cIiluTE7jREfCk+3iawqxhEOUvqzYCLES7vH3M4kyHVzW55SCg0F+lBV8P4Rn9ljKU+zzRC4X
	WQGoM1R4Au9Dy4pDMe8hM1Tbu2xuahcRgZZuZiL1AU1XRGB9PVvbtcTojWksk4U4LDLhC6KQ==
X-Received: by 2002:a17:903:2348:b0:2ae:67b7:188a with SMTP id d9443c01a7336-2ae8238ce35mr111041765ad.14.1773062581222;
        Mon, 09 Mar 2026 06:23:01 -0700 (PDT)
Received: from henry-machine.taileee5f2.ts.net ([2408:8606:18c1:c673:8291:e4d6:2556:af63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83eafc64sm156491155ad.40.2026.03.09.06.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 06:23:00 -0700 (PDT)
From: bsdhenrymartin@gmail.com
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Henry <bsdhenrymartin@gmail.com>
Subject: [PATCH] NFS: map TCP_TLS to TCP for mountd transport
Date: Mon,  9 Mar 2026 21:22:53 +0800
Message-ID: <20260309132253.1393804-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A1F1E239ABA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-223643-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bsdhenrymartin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Henry <bsdhenrymartin@gmail.com>

[  202.116047] ------------[ cut here ]------------
[  202.117481] kernel BUG at fs/nfs/client.c:512!
[  202.120419] Oops: invalid opcode: 0000 [#9] SMP KASAN NOPTI
[  202.122038] CPU: 0 UID: 0 PID: 407 Comm: poc Tainted: G      D          N  7.0.0-rc3 #4 PREEMPT(full) 
[  202.125867] Tainted: [D]=DIE, [N]=TEST
[  202.126673] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  202.129634] RIP: 0010:nfs_init_timeout_values+0x235/0x27a
[  202.131128] Code: ff ff 37 00 48 c1 e0 2a 80 3c 02 00 74 09 48 8b 7d d0 e8 a0 e9 bc ff 48 c7 43 08 60 ea 00 00 41 b4 01 eb 08 e8 f1 06 8c ff 90 <0f> 0b e8 e9 06 8c ff 48 8d 7b 1c b8 ff ff 37 00 48 89 fa 48 c1 e0
[  202.136017] RSP: 0018:ffffc90000b1f808 EFLAGS: 00010246
[  202.137484] RAX: 0000000000000000 RBX: ffffc90000b1f8a0 RCX: ffffffff81d77b27
[  202.140499] RDX: 0000000000000000 RSI: ffff88810da88000 RDI: 0000000000000002
[  202.142664] RBP: ffffc90000b1f838 R08: 0000000000000010 R09: 0000000000000001
[  202.145157] R10: ffff88810da1f8af R11: ffffed1021b43f15 R12: ffffffffffffff9c
[  202.147239] R13: 00000000ffffffff R14: 0000000000000000 R15: 00000000ffffffff
[  202.149156] FS:  00007f85976b7740(0000) GS:ffff888270a6b000(0000) knlGS:0000000000000000
[  202.152515] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  202.153976] CR2: 00007fac4e3057e0 CR3: 000000010da6b000 CR4: 0000000000750ef0
[  202.155319] PKRU: 55555554
[  202.155848] Call Trace:
[  202.156321]  <TASK>
[  202.156759]  nfs_mount+0x4bc/0x93f
[  202.157485]  ? __pfx_nfs_mount+0x10/0x10
[  202.158238]  ? __kmalloc_node_track_caller_noprof+0x336/0x37a
[  202.159951]  ? kmemdup_nul+0x3d/0xa1
[  202.161437]  ? nfs_get_tree+0xae3/0x1442
[  202.162622]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.165287]  ? write_comp_data+0x2e/0x8e
[  202.166193]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.167766]  ? write_comp_data+0x2e/0x8e
[  202.169683]  nfs_request_mount.constprop.0+0x575/0x64e
[  202.171319]  ? __pfx_nfs_request_mount.constprop.0+0x10/0x10
[  202.172594]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.173908]  ? write_comp_data+0x2e/0x8e
[  202.174687]  nfs_try_get_tree+0x221/0xad3
[  202.175585]  ? __pfx_nfs_try_get_tree+0x10/0x10
[  202.176927]  ? kasan_save_track+0x18/0x32
[  202.178446]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.179587]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.180655]  ? poison_kmalloc_redzone+0x61/0x6e
[  202.181673]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.182746]  ? __kasan_kmalloc+0x3e/0x4c
[  202.183637]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.184667]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.185713]  ? write_comp_data+0x2e/0x8e
[  202.186842]  nfs_get_tree+0x1415/0x1442
[  202.187734]  vfs_get_tree+0x9a/0x2a1
[  202.188526]  vfs_cmd_create+0xff/0x252
[  202.189345]  __do_sys_fsconfig+0x571/0x8e3
[  202.190226]  ? __pfx___do_sys_fsconfig+0x10/0x10
[  202.191379]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.192436]  ? write_comp_data+0x2e/0x8e
[  202.193428]  ? srso_alias_return_thunk+0x5/0xfbef5
[  202.195304]  ? write_comp_data+0x2e/0x8e
[  202.196426]  __x64_sys_fsconfig+0xdd/0xec
[  202.197673]  x64_sys_call+0x1fa5/0x2105
[  202.198835]  do_syscall_64+0x1b3/0x420
[  202.199946]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  202.201362] RIP: 0033:0x7f859752725d
[  202.202455] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
[  202.207616] RSP: 002b:00007ffc2b1e3bd8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
[  202.209855] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f859752725d
[  202.212372] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
[  202.214434] RBP: 0000000000031491 R08: 0000000000000000 R09: 0000007500000019
[  202.216521] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc2b1e3bec
[  202.218776] R13: 431bde82d7b634db R14: 00005640cbc6ad28 R15: 00007f85976fe000
[  202.220449]  </TASK>
[  202.221106] Modules linked in:
[  202.222234] ---[ end trace 0000000000000000 ]---

xprtsec=tls upgrades nfs_server.protocol to XPRT_TRANSPORT_TCP_TLS.
For NFSv3, nfs_set_mount_transport_protocol() does not handle
XPRT_TRANSPORT_TCP_TLS, and mount_server.protocol can remain invalid.

The mount protocol client passes this value into
nfs_init_timeout_values(), which can hit BUG() on an invalid protocol.

Handle XPRT_TRANSPORT_TCP_TLS like TCP/RDMA and map it to TCP for
mountd transport setup.

Fixes: c8407f2e560c ("NFS: Add an "xprtsec=" NFS mount option")
Cc: stable@vger.kernel.org
Signed-off-by: Henry <bsdhenrymartin@gmail.com>
---
 fs/nfs/fs_context.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index c105882edd16..5fedc5f113f0 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -402,6 +402,7 @@ static void nfs_set_mount_transport_protocol(struct nfs_fs_context *ctx)
 		ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
 		break;
 	case XPRT_TRANSPORT_TCP:
+	case XPRT_TRANSPORT_TCP_TLS:
 	case XPRT_TRANSPORT_RDMA:
 		ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
 	}
-- 
2.43.0

