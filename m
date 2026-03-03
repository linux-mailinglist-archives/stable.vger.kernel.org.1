Return-Path: <stable+bounces-222916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKQ2Dlcbp2m+dgAAu9opvQ
	(envelope-from <stable+bounces-222916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 18:33:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC581F4A84
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 18:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB84030A5722
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0793E5EE9;
	Tue,  3 Mar 2026 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="RhPLBTls"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78A63E5562
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559117; cv=none; b=iAXPas9sVh04DmeO5KIk/ryyx57zbpu1IzCvcYbP7wIaYHlKPokunBkV7Mv4/1ee1cEVo8GfVA6k1LODfvrMKc95W0Tv00MkC1p6l5bJm0frImCq0t8SKvhBRDcYC/ekMViXA6V3iGkMdm2ezBkBlNLuJnNeHSVsWZyZv0BqyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559117; c=relaxed/simple;
	bh=P8LbE17hdz3CRorHbSrGxepUcNNuUq4aHR8Ri8SA8ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g37QEmWXbb93bpfBRQUbfZON9JG98hnobm8UV94x51WHSCJjcIhhIz7z2oCKRp4tDP+lWSsIg7x/DSGYSLVowV3UqsVujt87dH9uCUmBFwR0UCg0C025Qi9V+Hkhoq/qWmmUmDtb6eelINzs8ZjhlFvY9I+pEqTuJcL71wVO0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=RhPLBTls; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6EB4B3F520
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 17:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1772559113;
	bh=EDqogQ9vdpkUGgl1TT2407NR+T7P9avJNaxknb9LMUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=RhPLBTlsz6Lhrmwn2ci/kRrJurZiDw2AB4I5zbD+47SwEqCMJ6hu+FjEnlfwcSkfD
	 r4GKAfntH54BRCF+j5LzvoDriSRp9tNoY4mDOrQGwVgv0B8imqz2CGox05XPIFZRBW
	 T4ekCuvyrOTGzHfGl/pj30uMGsQTl0sS1Ue78E6qGhHQs4sGAPSaD3M9YCE5wzjw6h
	 R3uQxacqZQymL7ymgIreHD/iFpbJ11IvbnXtPppjaTpplNPnH+GbnpycK1/pDpNG1T
	 MhmV+s6cf9F8/KR79/mJPINj6XxNqo+hFPIfDee56LqNQLDzuSG++AnzRE+QQN2PoS
	 SmipsvedWCCIHLF7R/9ojpEi19JsPtjcYprIaqC0e88mtAob7KSzY27Rd6uy/OLfb4
	 204R3395pXR1FixnaS6y4Y8N39nFX/OYAzmig5GoAI683qoumu1hYRgVF8pNyND5AM
	 Lc+iK6yKoIR+9/Jb34ijld+3CGSMgY2vnuTF61HmlSAMwHINUxmGsYCdrDOnaTqLr9
	 MH56yWG0L3UlCT40ZJTzCwzx75nZSujIUgSN8etbcgxZAkY4qF8Ahw1QT9vJI+uBbO
	 ohFjATwHaSmTabFtYnWqb1ATX4+2ttZKyRjzZT63T032oIIv1Xg5SeiDOIaVBWiAMw
	 qnChM4xQQ9PwbZsyPNWiNPuo=
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836cf00787so62665545e9.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 09:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559113; x=1773163913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDqogQ9vdpkUGgl1TT2407NR+T7P9avJNaxknb9LMUo=;
        b=bMf+10Ps7JJGP8nr4A0IHqT2v53dNeVCY+oGD7PPwCcCjQDLmcHCH2KDxwwoa4p2KC
         D8UgvAINO3OVRqj9TNXppH4oQkvVSHP4v2R/HrqCQhlog6Pk8vLC601CFtjBrmky2v7y
         vjb/15ORbIlnhuz/UcMZhqGZLNgpUX1H/wLRLgAWGI41hHd0MfHf+D9DNlwiq+ZsGfTf
         Ex0zx3BkOITPzNgfztidleLWY2OBsdfXWtNbr2nkB7UgvjNwaUWCWPCFGbloCcfeymmk
         icGaR+Ei61ftBl85UYkJogNpXvPxir/6jsWJiWmb7wH4xke81GyhfnmBy+xiSP01WPrJ
         dTlw==
X-Gm-Message-State: AOJu0Ywzv3EWGPRX5QARbpMMzebnbTs2oMWPleiWLnV9W2saH89xyPGn
	zPI+38xyTuCDv96pX6U14zM+XExtcgbTg1D2qAVxwFMS9HkFw7DK5YViZOqcb1Zdrj0lCNJeDFU
	5jj0bZDL+Xl/i59AIequicUHjL4JkgpQgZ/ImLKLlz1N8eTztmjBvXRs7xKqpKhMtGvbvNatTg+
	b15dClQA==
X-Gm-Gg: ATEYQzxDun9NP7UJTsbdcn7OoX/pVVb8L/nUkOYFZ4BSiLjXeCkRZABatcMSzDymfyh
	scaJYkYvBgNlsgMxxDs7+2NhE9ExW2qQa//1mTHE8Rh/s19Wc9fCd5M3EMIzdu6j6J1oqCNZjcI
	MxoTyqGLMFnI4aF5ISsxURGMvO5aQy2M+v31QtaFunJJOJyP8N//CXW7e9Ttg8noifBUAE+nziI
	EUz70pM9v2tasTrpTGJ0WMMRhnwdx+Al1ONOfQyJV+pLINR3KKScsE95PiKF5gkPzT7nKdzn4Wr
	HDXSCHCjOmhG1k3kliIQRxOGAtibBMr4cHKf1jL+Ir6rUiNRWCzcO55DT5SX9bJG9zOvST7aOPC
	WNqbfP+4VHoDYoInpoJ7wfBBk21u2Gp4cIPBQpQzBb5eU2vd6hB/P
X-Received: by 2002:a05:600c:35c3:b0:47e:e2b8:66e6 with SMTP id 5b1f17b1804b1-48513c752cbmr57526625e9.14.1772559112562;
        Tue, 03 Mar 2026 09:31:52 -0800 (PST)
X-Received: by 2002:a05:600c:35c3:b0:47e:e2b8:66e6 with SMTP id 5b1f17b1804b1-48513c752cbmr57526005e9.14.1772559112121;
        Tue, 03 Mar 2026 09:31:52 -0800 (PST)
Received: from XPS-17-9720.han-hoki.ts.net ([213.204.117.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485135cf050sm18993035e9.26.2026.03.03.09.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:31:51 -0800 (PST)
From: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
To: stable@vger.kernel.org
Cc: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Subject: [PATCH 6.1.y] smb/dfs_cache: Fix NULL pointer dereference on session connection failure
Date: Tue,  3 Mar 2026 19:31:39 +0200
Message-ID: <20260303173139.517020-1-ghadi.rahme@canonical.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DC581F4A84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222916-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ghadi.rahme@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
---
 fs/smb/client/dfs_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index 3bc1d3494be3..af2177b96f2f 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -98,7 +98,7 @@ static struct cifs_ses *find_ipc_from_server_path(struct cifs_ses **ses, const c

 	get_ipc_unc(path, unc, sizeof(unc));
 	for (; *ses; ses++) {
-		if (!strcasecmp(unc, (*ses)->tcon_ipc->tree_name))
+		if ((*ses)->tcon_ipc && !strcasecmp(unc, (*ses)->tcon_ipc->tree_name))
 			return *ses;
 	}
 	return ERR_PTR(-ENOENT);
--
2.51.0


