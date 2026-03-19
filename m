Return-Path: <stable+bounces-227315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDFZKLANvGkirwIAu9opvQ
	(envelope-from <stable+bounces-227315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:52:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 978AE2CD367
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC2B13047E9B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FA73C457C;
	Thu, 19 Mar 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZOhJF22r"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF63D75D1
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931458; cv=none; b=coTEUOdTJjDEaGA13EBXaShI/SDKoPpbdNdhJLb0CCQlzsyNvtEuKT3ihnN7iGSId/VfV/K9uT0zicuBzxIe5GC+R+dEYwgU16t+MG/0UeLBcSG+96Ez3ZOMB04p0qBshOrclj7NCOvzyWEI6RFCTB1s6kf7BJArepqmKSULqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931458; c=relaxed/simple;
	bh=ug5Q1tYhOutC+6/+4KjesizCcJe7ky5sajhME7gBIqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UE+qD3Xm4SMSRSHpb71piXUzP9ybRT4jvVVdZgQSZrpwYWm4DOxtBGghvlToAzBITifY35kpAupovDizFJreFe9PaIxpKVsiMChoNjWPmnmN2Pp8Gacnz3xRioS/csFveTMBVJkOhD2oT7KOuvv+9+4khjLIxKCgALKdYFA+Qx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZOhJF22r; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E169C3F665
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773931453;
	bh=vMKxtJKboCvg52mgxUFzChSrhCEwBJ/YbGYkS+qHCUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ZOhJF22rISfmiGB7coSGcsKNqVEb1kTDzFwfaGUDiwNRF8sv6xYKRgmYMnfJe84PG
	 VmtkLz9zIb1Wmfcvk3tb8JYjYdOSQTbsb9bDxfZLtbiDXvJ5d7P9nOv2bNFf0k+y0P
	 VBu09wzk21oXNqQ8IcpP6luve3Q6x8Pg32ieqmWidk9jlWt/7WEqE3x08fG9OZDbT4
	 h9rVPf/l3iIS/Wh2CAxoMWhEYXPvLRbXxW2EANJe3QXMRcvFgdec+HV4h1qAqhhNLD
	 dscyO3iThi2YzIT+81R2bQM9Dy1k/LI5BGpE+auBuR9gDz6qrQ/vZVAH/qmJ+e65vd
	 1ie+gcMW8YWKj7A0hEvr6NlR2hfJEc4y/QVp4+5fJAiImmjQVu2CDVTPd3z+GLYfS6
	 bm0ep6kR40EsGipHNtMHN40CIJ2anC1d5nPljPoh/CYjDMi/krRmFsqNIBDcRs3LRf
	 Ye7RkbL5BrZCbD4TBLy9RNzlfXNHjVgJzdRroMISQmdXgOjiRkOsHexrwANWDw11BF
	 LYP/HfPsl2DfoHm0yPwKrHGH6mLflyInNKKjYpNlUK6GmzVHfTuTkLBs2oaNp6d9ch
	 OamvVY8eyxypvwLdbEHSlaHH+ojRgxPdDUmalMbD7qIfLSbbF7cTqkSdGYbFqOQXMn
	 gW0067220MtqitN8F3z3B/J4=
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439af7ba802so1355930f8f.2
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 07:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931453; x=1774536253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMKxtJKboCvg52mgxUFzChSrhCEwBJ/YbGYkS+qHCUI=;
        b=HtojTT8QqpP0CPmyhmUeZNS1w2+4rZdTa4/uc4kxd5jm6IDeCKUwcELqdku8sWkpab
         vkXAsNTE/fBDQBtOXa4RivCRnK9dxiCZaQj2irnYY3sPTXwmQ5cu5O/sAnxjIeM8RqOB
         jkTxCVWYf+R4Ue2x3NVclm6gIiA0b32YjWlFh6dykPX/I2dplwDmvmLS2XyDzLT4blKq
         ylRO/TEVYZS4j3ndF6i1xb/DWWjwpkkiThU4kW0XjwpWFgDEL5VziEEZN2NEq/Npm1gV
         7xs9Z9jtrhvbLz3114SrsFAOy2fwxKZcv2Z8SQMUyDrswi7VwmAwk/bi6q548JEbUvXV
         tAPg==
X-Gm-Message-State: AOJu0Yx7MJjcYHqPeZNSeY9sfSgvFNhBJg1XwpuwDeXepvGj8NXR2+yE
	utOfWMMqZo8jL4kT5wTrUc8JGAsNNL2bHBww5e31HcAGdI2q90lfKyrHnp4a+Xy/5+/0j9eUQb+
	iRkLxcXbWj+2nPWxCVZC0LVpT/gjraxy5taH8Di5kEh2H7OORmd8zwcLzi3lNyoGxie8/Lzwoik
	w6qiIF753zX9I=
X-Gm-Gg: ATEYQzxvqqxhBUgCl1sds1Zqx9NTBD2hKmKnUbY4+V9UjELOcqH5QqMB39rMR7kchyE
	H3Qb+g5wzu38wVuqOJyyKdo6EclS7OyEm2TrAGc00GcdsvaP0QQv3YsCH6zGZKvZdBWg3HAwzZo
	Y5hQ1lEVLjizZEs+55zROIntaU4ffoFYs0xoOwSUrbfWedU6hWXOuKV/LYzPn2vUXzm6bTLlRwl
	CF5ohQ/gNmLXIE3VTsQ+p+z2FnsldAJHecc1pR5wdOEndzPHI9zhiM4bI51tmq8x43yYZal+OGJ
	PQZruMe4cShwVgJRrOrw4LYDFug33DvwhKCQQEJfRM9CcBGPsfKT9J+4djbV9gWTILpdn6iWlMe
	94nTJmAXE4XKEY0rKn/aWJM522ETMxAkz3gxkoHlRWW7H/G5XeqJ4
X-Received: by 2002:a5d:64c3:0:b0:43b:47bc:c147 with SMTP id ffacd0b85a97d-43b527cc553mr13236697f8f.45.1773931452957;
        Thu, 19 Mar 2026 07:44:12 -0700 (PDT)
X-Received: by 2002:a5d:64c3:0:b0:43b:47bc:c147 with SMTP id ffacd0b85a97d-43b527cc553mr13236647f8f.45.1773931452421;
        Thu, 19 Mar 2026 07:44:12 -0700 (PDT)
Received: from XPS-17-9720.han-hoki.ts.net ([213.204.117.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852097sm16579827f8f.9.2026.03.19.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:44:12 -0700 (PDT)
From: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
To: stable@vger.kernel.org
Cc: Ghadi Elie Rahme <ghadi.rahme@canonical.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@cjr.nz>,
	Aurelien Aptel <aaptel@suse.com>,
	samba-technical@lists.samba.org
Subject: [PATCH v2 5.15.y] cifs/dfs_cache: Fix NULL pointer dereference on session connection failure
Date: Thu, 19 Mar 2026 16:43:25 +0200
Message-ID: <20260319144325.438788-1-ghadi.rahme@canonical.com>
X-Mailer: git-send-email 2.51.0
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
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227315-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghadi.rahme@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.993];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 978AE2CD367
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 6916881f443f67f6893b504fa2171468c8aed915 ]

It is possible for find_ipc_from_server_path to run while the tcon is NULL,
resulting in a NULL pointer dereference crash when calling strcasecmp().
This happens when the ipc connection fails freeing the tcon and setting it
to NULL while the dfs cache worker thread was already executing.
This issue was fixed upstream indirectly by a rewrite that removed this
function. Although with this fix the issue can still occur, the window of
the race is now much narrower.
A fix that would completely fix it using mutexes was tested and
worked fine. However the regression potential would be much higher and so
would be the deviation from upstream.
This is a good balance of safety while minimizing upstream deviation.

Stack trace:

 BUG: kernel NULL pointer dereference, address: 0000000000000050
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 1013dc64067 P4D 10125f65067 PUD 10125f64067 PMD 0
 Oops: 0000 [#1] SMP NOPTI
 CPU: 80 PID: 3913754 Comm: kworker/u256:1 Kdump: loaded Not tainted 5.15.0-143-generic #153-Ubuntu
 Hardware name: Dell Inc. PowerEdge R760/09XV41, BIOS 2.3.5 09/10/2024
 Workqueue: cifs-dfscache refresh_cache_worker [cifs]
 RIP: 0010:strcasecmp+0x19/0x50
 Code: 01 84 c9 75 f1 c3 cc cc cc cc 0f 1f 80 00 00 00 00 49 89 f9 31 ff 41 0f b6 04 39 0f b6 c8 89 c2 83 c2 20 f6 81 e0 39 89 85  01 <0f> b6 0c 3e 0f b6 d2 0f 45 c2 89 ca 44 0f b6 c1 83 c2 20 41 f6 80
 RSP: 0018:ff4043e68aadb900 EFLAGS: 00010246
 RAX: 000000000000005c RBX: ff4043e68aadbc68 RCX: 000000000000005c
 RDX: 000000000000007c RSI: 0000000000000050 RDI: 0000000000000000
 RBP: ff4043e68aadb990 R08: 0000000000000064 R09: ff4043e68aadb91f
 R10: 0000000000000012 R11: 0000000000000000 R12: ff210c171f193c00
 R13: 0000000000000009 R14: 0000000000000008 R15: ff210d1d3f19a7c0
 FS:  0000000000000000(0000) GS:ff210d127fc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000050 CR3: 0000011f2cc38005 CR4: 0000000000771ee0
 PKRU: 55555554
 Call Trace:
 <TASK>
 ? find_ipc_from_server_path+0xd9/0x110 [cifs]
 refresh_cache+0xf1/0x470 [cifs]
 ? in4_pton+0x7a/0x160
 ? kfree+0x1f7/0x250
 ? target_share_equal+0x198/0x210 [cifs]
 ? __refresh_tcon.isra.0+0x242/0x670 [cifs]
 ? kfree+0x1f7/0x250
 ? __refresh_tcon.isra.0+0x242/0x670 [cifs]
 ? cifs_put_tcon.part.0+0x39/0x220 [cifs]
 ? cifs_put_tcon+0x1c/0x30 [cifs]
 ? refresh_mounts+0x147/0x210 [cifs]
 refresh_cache_worker+0x1ac/0x300 [cifs]
 ? lock_timer_base+0x3b/0xd0
 process_one_work+0x228/0x3d0
 worker_thread+0x53/0x420
 ? process_one_work+0x3d0/0x3d0
 kthread+0x127/0x150
 ? set_kthread_struct+0x50/0x50
 ret_from_fork+0x1f/0x30
 </TASK>

Fixes: c870a8e70e68 ("cifs: handle different charsets in dfs cache")
Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@cjr.nz>
Cc: Aurelien Aptel <aaptel@suse.com>
Cc: samba-technical@lists.samba.org
Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
---
Changes in v2:
- Added maintainers to CC.

v2: https://lore.kernel.org/stable/20260303173108.515913-1-ghadi.rahme@canonical.com/T/#u

 fs/cifs/dfs_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 1864bdadf3dd..92be7fe7c725 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -98,7 +98,7 @@ static struct cifs_ses *find_ipc_from_server_path(struct cifs_ses **ses, const c
 
 	get_ipc_unc(path, unc, sizeof(unc));
 	for (; *ses; ses++) {
-		if (!strcasecmp(unc, (*ses)->tcon_ipc->treeName))
+		if ((*ses)->tcon_ipc && !strcasecmp(unc, (*ses)->tcon_ipc->treeName))
 			return *ses;
 	}
 	return ERR_PTR(-ENOENT);
-- 
2.51.0


