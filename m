Return-Path: <stable+bounces-222859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFxICOjIpmkaTwAAu9opvQ
	(envelope-from <stable+bounces-222859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:41:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8751EE3A7
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1400B30E11C6
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E9C480978;
	Tue,  3 Mar 2026 11:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e89h1Ted"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86574611C4
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537281; cv=none; b=c603HnjMjCeDUInMy3so/rpuyK1wP/lFO2XLeEx2XUkr2C2KZ1LIF180NtJnDQM3vmkc1wlTv1LgHsf+KmohwXA+IUzfhRhprGUY3o9mNMLb88ho0f3D6fp0GYoatcCstM9Ra9bi3g0DVBRMBu2ZW/e7mg5zuyJvPYdD5z/Nu2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537281; c=relaxed/simple;
	bh=Z7wo6V9kU8iNoyeWICZnYBGx6CgJO1IAkVLA1EldMnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH0QTRtlpNTI3+l1ah4QWYjpU3jTe++qG7nfUyiduVOn7FJl05dqR2r/BiBJUA8wwzdFiwNvXufzjTqwF+RjJ7Ae2jjR5aj+VBpBEm2dbgpjC+ezb1SyCGN/vwCCiYr8gHglg3FZ+R/AkTu90Aaj64diYvnp+0tvNxWOSbItj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e89h1Ted; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4833115090dso57296325e9.3
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 03:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772537276; x=1773142076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bnm1A86ZE9NwpPvFAzmesLCd98LCt5htyJUYGbVOzOI=;
        b=e89h1TedqS01u/CqV2thI9o7b9xBjDmf3lPODZR4UlLAJoNWdC0q6Rokbz3vdHygL1
         eZz+Akn+Pg1O2ffzRkL0vvZKr0Y0mPObzLUZBJG1SqxsseeC5TF/Vi0jcaMsrGxg3/Ct
         fhtph88fIQyRGq/LwM4UO2lb3vwIRxQ11G8+Ky+ksC3CHuuIIOyiro29MUgWqUAFYUxo
         4xh3K9rXcjyxA/kU5yvxLuxAVuuzYhTQGk1HqfHpyj0zL+OFi3wPwn3/W0guxvoL27v/
         2MAzzvwLzKS/Ef8B8UGvYaGAxnoGmshWt2lfWecUbn8RSv3Pl4e0NXRqWi+6+ZE0kjfz
         DH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772537276; x=1773142076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bnm1A86ZE9NwpPvFAzmesLCd98LCt5htyJUYGbVOzOI=;
        b=dgcjK/ppNp7HMPFt/UwO9Qcx2eoD5y3XzxyP0fzH7MTbJBPL+ROy9RqBbiiRsEn3l5
         lPRI1lGIi1XULyxJf1Jsi+BEiMMkWunQD3XKIdbXan20VceiDnEBQgkz5yOm5DxvJ9NH
         NAip0U3rkPTgic9GYslBU9E3Dw7Vm5DGTpgZn2JMSnLBoec4DgLICoM0irOOI0c/yO8e
         08sEyZZlr4hANsuJYumafc4IXhpfhLhvyjMRR1e0W6vpTk9VU70NWa74J6C5MsRqaDDI
         bcaD/Ht+4d3SECt8268eoav2yj03Nkho/CxNdRnP6QhZ+fEK60RMTUcJEhxKABOPcJuk
         Pdsg==
X-Forwarded-Encrypted: i=1; AJvYcCVAxzBazuFFWJvbWZnobqLyVpPAluc1hce5S/zaxVqgLseftXGeP3cUpUtZXr1Yj4R7XDm6iTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXoorjM6egMirWJ1A6ofhCYLm6n8zj4Ii//L+rHuceENJuv7yO
	nL1sZ4i8qcFBv0QcB/FHU1hRQGVKltGT9OjTMzVlAWtzBUY0TdJFdKv5
X-Gm-Gg: ATEYQzxr/F/U9P1DbE3z6atCMm3AFA9nKgCAdmJ1B3caFQqBvcqG1dVkaKJmz8rLD+R
	Gmjd0sD/R1HJAD5NllLX6JM4VaQUeg5q3DCIP1bKgaI8gfSeHs7/Z4ZP3+UAoCpR6vAEKRFgNZV
	q6RiQ7WYAGb8Ri8aREgPhWH3Cq64D8fPxkaKRu9NFmaqTZDUPpUoqCgrTvk/87pfYHvnuuvvTuR
	W7nDGzzv5uLi5ShPYsV4Tzvd7v3rrtQ8RkCh0jY9RWY9VONBWLaLHo0bLt7PfgptM+BzMBptTka
	42zr9fQOYdeMjAJjwM+fWbqquzpAnI3/f7b2QrUym2hY+GZI8Vjd1LY3XKXUIFXeCkIprNx3XzG
	SvHXpxj590BDSSOXniwHCU1s8yrXVD2JXp91a0cS7D5RzhIFtO6JPpLhOUKxq8/9ETPaJ11k6/Q
	==
X-Received: by 2002:a05:600c:8b12:b0:483:71f7:2794 with SMTP id 5b1f17b1804b1-483c9bbbe39mr288394345e9.15.1772537275524;
        Tue, 03 Mar 2026 03:27:55 -0800 (PST)
Received: from kimsufi.. ([2001:41d0:303:6f54::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851262ee4asm22629685e9.1.2026.03.03.03.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 03:27:54 -0800 (PST)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: syzbot+1f5bcc7c919ec578777a@syzkaller.appspotmail.com,
	"Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: [PATCH] media: vidtv: fix NULL pointer dereference in vidtv_channel_pmt_match_sections
Date: Tue,  3 Mar 2026 11:27:54 +0000
Message-ID: <20260303112754.340155-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69539037.050a0220.329c0f.052f.GAE@google.com>
References: <69539037.050a0220.329c0f.052f.GAE@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D8751EE3A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,gmail.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222859-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linuxoid@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,1f5bcc7c919ec578777a];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Action: no action

syzbot reported a general protection fault in vidtv_psi_desc_assign [1].

vidtv_psi_pmt_stream_init() can return NULL on memory allocation
failure, but vidtv_channel_pmt_match_sections() does not check for
this. When tail is NULL, the subsequent call to
vidtv_psi_desc_assign(&tail->descriptor, desc) dereferences a NULL
pointer offset, causing a general protection fault.

Add a NULL check after vidtv_psi_pmt_stream_init(). On failure, clean
up the already-allocated stream chain and return.

[1]
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
RIP: 0010:vidtv_psi_desc_assign+0x24/0x90 drivers/media/test-drivers/vidtv/vidtv_psi.c:629
Call Trace:
 <TASK>
 vidtv_channel_pmt_match_sections drivers/media/test-drivers/vidtv/vidtv_channel.c:349 [inline]
 vidtv_channel_si_init+0x1445/0x1a50 drivers/media/test-drivers/vidtv/vidtv_channel.c:479
 vidtv_mux_init+0x526/0xbe0 drivers/media/test-drivers/vidtv/vidtv_mux.c:519
 vidtv_start_streaming drivers/media/test-drivers/vidtv/vidtv_bridge.c:194 [inline]
 vidtv_start_feed+0x33e/0x4d0 drivers/media/test-drivers/vidtv/vidtv_bridge.c:239

Fixes: f90cf6079bf67 ("media: vidtv: add a bridge driver")
Cc: stable@vger.kernel.org
Reported-by: syzbot+1f5bcc7c919ec578777a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1f5bcc7c919ec578777a
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 drivers/media/test-drivers/vidtv/vidtv_channel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_channel.c b/drivers/media/test-drivers/vidtv/vidtv_channel.c
index da20657adc747..5f8c3af871711 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_channel.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_channel.c
@@ -341,6 +341,10 @@ vidtv_channel_pmt_match_sections(struct vidtv_channel *channels,
 					tail = vidtv_psi_pmt_stream_init(tail,
 									 s->type,
 									 e_pid);
+					if (!tail) {
+						vidtv_psi_pmt_stream_destroy(head);
+						return;
+					}
 
 					if (!head)
 						head = tail;
-- 
2.43.0


