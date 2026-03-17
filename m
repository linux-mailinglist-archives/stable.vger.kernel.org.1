Return-Path: <stable+bounces-226542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOAAKHKKuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3A82AEFF6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A39B33088EF7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF213F54D7;
	Tue, 17 Mar 2026 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vz8BCvQe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40EA3F54CC
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767149; cv=none; b=DQnxAislfiad1mHVd0v6vIAJE4UBMwPlUfJtPKmM6dtNScB0QVF258Y59JGLK/7/Egg18SU2JD3juIVum92wif6uepW/pRR6e8oCCF3V/Ricp9jQMN07yVpKb3I2/wZGHOA62ZcAwk8bEbBUxtmZsz9g4wqWYrWCcjex16EqJlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767149; c=relaxed/simple;
	bh=8TdkddL8wUljLckIz/JNaqBa+jbPS/AlwOlRB7Bkmyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hk8ESottcaJzXLyARXK1GjbI5SZunBq0Q3KY48pcVLidDSV7uNkDVSBR8KTsIsZYIdEXyWn3AgSHoKet/D/iRHBdtb2wiJ4LgNjQ0Ztlc1NkiAfguUOz+AugO6filSD0NHNoDFNpmn0iJaXJzDxZvYW4ikL0Gbkpj6GjcfNf7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vz8BCvQe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso37623245e9.2
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767146; x=1774371946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q6gIs1HVH7tv5UkQUPeW9lOIJkrZhUZS9LfXIZmzvE=;
        b=Vz8BCvQeQ/L7GeeeoEer3x5t2MYjj3r5SCvYeGtXaaPe9VAWPKzReRJEK/soMRs9cY
         KYMPgo4Pu+3Nb/A4tN3C+VRPAwvS9hCNVwPF2Y/lNIyEQWRti/hVXUK9VM0y7Z50YrUq
         BPpKvsNj4UfFaJmFXMMDSLQ7SHV5vtY99ztM9OksHxwGVBRJsAdpoWPcoiH1tMqbYRuj
         Zy3YMQH4twCaJ2fSKeO4oro2g+UD0l+DiHw0rBxotwvOVAuu303zeiS9aEGTxB9GOUvQ
         wJPRPeghzb7t0kI73hVHVs15UsSMSaN79w1RpCbcCqvW8tT+wHqYysbmb3E70Fe1ZYWQ
         W+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767146; x=1774371946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q6gIs1HVH7tv5UkQUPeW9lOIJkrZhUZS9LfXIZmzvE=;
        b=Yn8Hb65nK0yQg5jBDzXfmvn/A15hxNmdhLypL4BZf3Atsn1ILfW/upArPvbqDsqQdh
         mHlydfhd1QBIreZsesKMz8T17SMyDFqIA1apoQmgsx36Mfj+n31WogtK6HBCcZCjpRHh
         5mlq2x9qJx7RjZZiABzbfHeQ5bYowQ5YDywMCDzjJqmzXUFaKPYlede/iKoAMuLCJWwy
         0ZJNM5fjz/+fWJ0nXRgKNbw6uIlVzUo8XBY70gkhnNmoT+IL9PNxgQHb7T4eR33Z3kNx
         xEVGxw/y6TymGW+Inx4/cNUKJWse2F8fMa17slrsY27eJaLkbZhivj+r+O58xxaqptGZ
         SZFA==
X-Forwarded-Encrypted: i=1; AJvYcCXGwrlVdNIAaFwoR75RM1jLUuGuAVhwQsurjNL7DSX0BlsSX6QlWJ7gy8HTovFvQq4cBMyBjus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5x0rw3SXVWV78JlIfhckZjU76O0kcIVg68zKvkXYxcQgY+K8C
	zrCvYAHyQngyAZYa0FwTnHQmSA6SkrHuuAWiM6yrdo6owsS26w2VDkOE
X-Gm-Gg: ATEYQzw7Fg0lajYs65WQJzNfkS8K4hA43IVr0t3CgfitOGBwiHaL3xdOyeRdfH6DPaX
	6JEjop99xcSpE0ECjN0yGxTu9N7JMqmqYwdaUjIH6GyjkKX8T9QhpiEu6Yr+qC9qYjyRmKx1J8r
	6/eb8OtDv58Zh1zICpwlR/MWOu8eu8hDU/YDu/g+IZE5SWVqwPpygcvW2M2fY+L0Ze9ZflmYszL
	/kIs8NjKpcUVJUKDUU4dbXbE/dCeCMadof7kXwQHBzACCqHRyzETbwCa9Q1smN7FdP5ajDlSr7U
	lTtgXqVgcnBsWAwusBt4cX27JG22BkIbP5pQhmfbrNlsbaecOUO4lzEtM2zR5WLBencrRtW6w5P
	3LZUGyetPWFYREJYl92DTli2QC6Iwqe8VgXxEPXDh2XOG/4xk5n5xG5TbResR/RrBuNi02IiX+Q
	==
X-Received: by 2002:a05:600c:8b2e:b0:485:4bd1:4c64 with SMTP id 5b1f17b1804b1-486f446d953mr3606525e9.31.1773767145753;
        Tue, 17 Mar 2026 10:05:45 -0700 (PDT)
Received: from kimsufi.. ([2001:41d0:303:6f54::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eae3037sm78866125e9.11.2026.03.17.10.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:05:45 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: "Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+814c351d094f4f1a1b86@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: [PATCH] media: vidtv: fix NULL pointer dereference in vidtv_mux_push_si
Date: Tue, 17 Mar 2026 17:05:44 +0000
Message-ID: <20260317170544.1888757-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FREEMAIL_CC(0.00)[xs4all.nl,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226542-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linuxoid@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,814c351d094f4f1a1b86];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 1D3A82AEFF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reported a general protection fault in
vidtv_psi_ts_psi_write_into [1].

vidtv_mux_get_pid_ctx() can return NULL, but vidtv_mux_push_si() does
not check for this before dereferencing the returned pointer to access
the continuity counter. This leads to a general protection fault when
accessing a near-NULL address.

The root cause is that vidtv_mux_pid_ctx_init() does not check the
return value of vidtv_mux_create_pid_ctx_once() for PMT section PIDs.
If the allocation fails, the PID context is never created, but init
returns success. The subsequent vidtv_mux_push_si() call then gets
NULL from vidtv_mux_get_pid_ctx() and crashes.

Fix both the root cause (add error check in vidtv_mux_pid_ctx_init
for PMT PIDs) and add defensive NULL checks in vidtv_mux_push_si for
all vidtv_mux_get_pid_ctx() calls.

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
Workqueue: events vidtv_mux_tick
RIP: 0010:vidtv_psi_ts_psi_write_into+0x54a/0xbc0 drivers/media/test-drivers/vidtv/vidtv_psi.c:197
Call Trace:
 <TASK>
 vidtv_psi_table_header_write_into drivers/media/test-drivers/vidtv/vidtv_psi.c:799 [inline]
 vidtv_psi_pmt_write_into+0x3b2/0xa70 drivers/media/test-drivers/vidtv/vidtv_psi.c:1231
 vidtv_mux_push_si+0x932/0xe80 drivers/media/test-drivers/vidtv/vidtv_mux.c:196
 vidtv_mux_tick+0xe9b/0x1480 drivers/media/test-drivers/vidtv/vidtv_mux.c:408

Fixes: f90cf6079bf67 ("media: vidtv: add a bridge driver")
Cc: stable@vger.kernel.org
Reported-by: syzbot+814c351d094f4f1a1b86@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=814c351d094f4f1a1b86
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 drivers/media/test-drivers/vidtv/vidtv_mux.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_mux.c b/drivers/media/test-drivers/vidtv/vidtv_mux.c
index 403fbedb86636..bc52f51418f25 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_mux.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_mux.c
@@ -101,7 +101,8 @@ static int vidtv_mux_pid_ctx_init(struct vidtv_mux *m)
 	/* add a ctx for all PMT sections */
 	while (p) {
 		pid = vidtv_psi_get_pat_program_pid(p);
-		vidtv_mux_create_pid_ctx_once(m, pid);
+		if (!vidtv_mux_create_pid_ctx_once(m, pid))
+			goto free;
 		p = p->next;
 	}
 
@@ -170,6 +171,9 @@ static u32 vidtv_mux_push_si(struct vidtv_mux *m)
 	nit_ctx = vidtv_mux_get_pid_ctx(m, VIDTV_NIT_PID);
 	eit_ctx = vidtv_mux_get_pid_ctx(m, VIDTV_EIT_PID);
 
+	if (!pat_ctx || !sdt_ctx || !nit_ctx || !eit_ctx)
+		return 0;
+
 	pat_args.offset             = m->mux_buf_offset;
 	pat_args.continuity_counter = &pat_ctx->cc;
 
@@ -186,6 +190,8 @@ static u32 vidtv_mux_push_si(struct vidtv_mux *m)
 		}
 
 		pmt_ctx = vidtv_mux_get_pid_ctx(m, pmt_pid);
+		if (!pmt_ctx)
+			continue;
 
 		pmt_args.offset             = m->mux_buf_offset;
 		pmt_args.pmt                = m->si.pmt_secs[i];
-- 
2.43.0


