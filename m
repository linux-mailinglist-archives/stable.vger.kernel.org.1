Return-Path: <stable+bounces-222915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HR5AQ0bp2m+dgAAu9opvQ
	(envelope-from <stable+bounces-222915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 18:31:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D31F4A57
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 18:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D03023024968
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D8370D61;
	Tue,  3 Mar 2026 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="oKT7TjKz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD2D3D75B4
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559099; cv=none; b=D8hEAMyKQAGKgeIeTYNnpHlLVEL/MI/5baTMaruArx/lzh/FmAFIZIgRInT8Yo5wwr2L//1wQxmbWM1K5T3sjdEejWw44EqMksGAJn8AZXHWW0bd25YYEE63VqKZVW6p3q9XlXr0uydbbvFJ8og8zdX5ujoX4J3ZOnZwglDOxgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559099; c=relaxed/simple;
	bh=bejz2EmLsQXtv+QLfwJ+u089vDtK8QElj6VFXKFmYek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRqHyqNuel/dKs5N+pwtPmD1lgohFcJRNxZFrWWAtu3ErXuIjvB0rI/Yf0t/f95SDOpvbizke0hTWr3JlzVFf96/g5gdN8ckgL32BkEqDqvr3M1/pnJSma4pUcqKC6be/gGC1oFNIoDQ8af2gbEmxCFxoFfWyf+IvNoBcOOv1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=oKT7TjKz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 60EF63F51A
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1772559089;
	bh=GTmAx79RRF37BTsyR8PY3pRwLtekk7ZdSWhLsvUSaA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=oKT7TjKz6asMXt6JMhvlpxgh892eNe18FYqTDH+IQ+81iZS7tYSw/3+LBfUGFpKAy
	 OjPDnJobKl8xI8OT3ItzC4pOSadBg9D8sP3hL69FVjenjPUFm2H5OPSrfrehdo6WdG
	 00bZeoPia5FSTXd1GFV5DCN2uzMI5vzzL0c4nxGOjlymXodiio4RI1p3O0dloiUw1d
	 LkxwAsiO1lXxt0O//tAjRO5TLn5dYH/vz9VDppgF3SePy1hFALf1CLDOXkCgtVdHY3
	 pDb1gtlsxLjKbuGQtYX1AXtHRa56vCvvyMme83jGmVZQObRNuL6aDOYShpwvNbGgRb
	 azWDhQUJhhNCiaIMRKnQ7IVMixdDSuI5PcbSw8wtqbEK/WOtZW6c5lKSG5H6dFUHtj
	 2T4MJV6EBI5GCOmKxA6puttlYEuQnbQcI7sku1MDhBcZZszQZN8oZ92DwnvW6SWhwC
	 RUDjC95/A8V7lHx9jr/Jt8jsFkmPuS8kq58cWW6/qedzK3J8Hd1n0dqsk+g62cIp3k
	 FKa1uaqkBEJ00u33AiRdCvEts+vbW9zvnGlvxgj/Ar4ZViY9xblqesaD2Z/we3WP5t
	 oSnxPqh7UoFCkm9UuJvTNkf1F6YZlLzq2AKvCVtj3An8W7qy7rtN2nHP5unx1Uq/l0
	 klkeN/BtRy6TNJ7apA2zPUmQ=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48069a43217so57053815e9.1
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 09:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559089; x=1773163889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTmAx79RRF37BTsyR8PY3pRwLtekk7ZdSWhLsvUSaA0=;
        b=t9pCQRRDgwDjlEnSyzbWsSUPxbGpBfJfaNGGuMOZw0TwRJQW4va2kGtxhrghgPpwcr
         VWDOCTDX4UIgGu4CLtBKzoI2axcy8rnIYgGfiaiJlKT8IPMbNrC4Fe/vLuxnZpLB/fwf
         9diOZiXDmgPX3RUZt7Ql7mWqRfgYKC+oRvhXrl1KaICHUVlBYUx36U8mriMQKiL6SECT
         XV8Gxm5roNXZ59ynwl9BvKYohAH76LBcRp7Kx9UhFn+Q81myrAUGrtvHfDUPogj6tmGZ
         1rHCx0MZ/Zxw3ZYtdpD4kA+8sK3KWoZdMeKBGUSK+OWZxCeAvc23KE7TB4JjoyiQ5wzj
         q2ag==
X-Gm-Message-State: AOJu0Yz6hN3l0a6qJiy44mOOcdGqPVH5R23pKiVm67QPaAkR0mwpaetj
	W/HrjeopRiHih1s45rk/EAMJh5iK5eYJ+GhX61E+v8AQZdhqNU7YJVGvZqx/4xDflWsNmjfmnOz
	V1hMyqBZYEZgoyvBMYBKIIlC4ciY0qJXRccFomO49/tvdQsb52UQa6fWgrdFKJsdN0SzRYxblVq
	bP26v9Zw==
X-Gm-Gg: ATEYQzxywwYLZvmwkCO0hLdcpc3Ak7RPuDNQq7ZM9XOax4fx5ZsfR2SQLPscNeVXIIu
	ynXD/3XYX9OcWpLc6TcOTeK8k0mKw3BMeWrolzi6h3qcevtTnrD3CeGDB2XHLhwledaSQ0qMSAo
	Bqy4rE74H+wWq6TDG/iMg+KFInTpIkxxfNvARxZGBArn+m7NwmhMCtvFaUuCTzwmJiHkApjsC6e
	rbvNPe7SzfVbYjZpRS4brCLqW9Er4eIVtyrhsq2XJf+KLQm2MwK6Hl8oUMKHQr9LM9nsDENaizB
	jUU7lzyPWFjKPN/7uNjvLFqQMOjaybKjEPHj8TwfMDqjoDSlIdFuNsnDV8WgcT7vszWx23B1emj
	kjMMC+G8hWUskVJBjK+m1HkfaUdMlI2nUINyoEXXKaTUUIm5dyU0H
X-Received: by 2002:a05:600c:4f94:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-483c9bdb6b7mr281326785e9.34.1772559088531;
        Tue, 03 Mar 2026 09:31:28 -0800 (PST)
X-Received: by 2002:a05:600c:4f94:b0:47e:e78a:c834 with SMTP id 5b1f17b1804b1-483c9bdb6b7mr281325945e9.34.1772559087992;
        Tue, 03 Mar 2026 09:31:27 -0800 (PST)
Received: from XPS-17-9720.han-hoki.ts.net ([213.204.117.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485135cfa25sm23391935e9.27.2026.03.03.09.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:31:27 -0800 (PST)
From: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
To: stable@vger.kernel.org
Cc: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Subject: [PATCH 5.15.y] cifs/dfs_cache: Fix NULL pointer dereference on session connection failure
Date: Tue,  3 Mar 2026 19:31:08 +0200
Message-ID: <20260303173108.515913-1-ghadi.rahme@canonical.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 571D31F4A57
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
	TAGGED_FROM(0.00)[bounces-222915-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,canonical.com:dkim,canonical.com:email,canonical.com:mid]
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


