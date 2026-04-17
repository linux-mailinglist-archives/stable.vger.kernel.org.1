Return-Path: <stable+bounces-238514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGThGg+L4mlq7AAAu9opvQ
	(envelope-from <stable+bounces-238514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 21:33:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996FE41E4CD
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 21:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 904FD300516C
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0431715C;
	Fri, 17 Apr 2026 19:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfwpzdvd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AE2E2EEE
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454405; cv=none; b=LGaTXEyQCSWyXpkHCA/KDzswARVkfrQCzAQNlV3rzCKk2VmO9MaAiYeObBVdE3QYKwVMW0qipgXUQb9Af9LYl8w1141CAn3Wr+H73oo2MjaBJHvTyE+t2NTheEsKx8xXoo+URtBI8iby3KC+3LhiOFPfC7O37Ub++BgVwd2euBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454405; c=relaxed/simple;
	bh=wSouMAxbC4qBTG56Li1QJbGu7+b7Rn1l0WqH5ApVDw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHQDE8fm5qgpW7SSLYeUvH4WD3c3VEQRKM0Vx7sd/IN1UCe8atVDTNOuf7ijOM0r9CQBJ15HT6qrwDSeashBkgrtfkbf9M/Vn40vkAZXih/Wqv62gmc9sW3/SDTegGYOk2qK1LlyRk3FXSoJ7Kj7W2S3oeTinwThX2pQsGATlQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zfwpzdvd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d77f6092eso716611f8f.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776454399; x=1777059199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ0cthg0w4P6S7KugYGvtLaxhgxAoG60Ed2oJXFQlJE=;
        b=Zfwpzdvdgew6YVKkzjQU10DXoYj8onpvnXmHUf9zsPbNCD59dL0gSkbUO1EZA6PnKo
         WiZe864Tz9ApWMdKvIIXx1UniqinnJPZWN/rNWm9jm4CpQB7Tpx+KQvfTNoykE2Bm00H
         1icNTvekACYfOrozraQSvZ6RcBRjQHNFqcbpN1GoklQr05pfG2WE0nmjpRjOJwr/4JJz
         v9Jgr1JK/BlH6jeBxPcpCgy2VOWGlJ31e9vxKxnQbXzG32i8GwJdojA/LOEfQGQZwgTh
         uh8BvvFU4IpFvfP6Dl8f2skhZMF8bess0QIfAu4CVF5PJfoth/zZ9WTBqZ0F8nPS6mkl
         NLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776454399; x=1777059199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kQ0cthg0w4P6S7KugYGvtLaxhgxAoG60Ed2oJXFQlJE=;
        b=UKXHrnWdGslXIr+5UOBWpgde6/WMEoAiNym4h/+AaCphvztQl46VUXtXJM0dQKCNFC
         tsASKcwTezonxirnRjyZQVMYpYA3mcd/m43FXSUrP5DIZJpSGYwww3Ga9o61VxnfSJw8
         vlpkLO+dpb+9hPjQhqxkb9dVppk6hp7cUcM9UcnYL1cI5wVvStNWsVdsIMOgfaMZBVAE
         jcd9ZTN/7nn+99hh1E0okw+BsoNAyWvpo/uPk4GuFvIqiJMRrZBc9/E62jZhz5iCO80C
         /46kzdJlXNyqZOpZg7r9sW1pqoyn9ROc8iWcOQtl54wBq8QRwDeyNW5GRNL3UqPZQnXB
         tnxg==
X-Forwarded-Encrypted: i=1; AFNElJ9VPYPglnE8+qkiKpmypkJsWZ+rJw1fi8vUKlcyuozKddKVQ42ZSdMUEV70OU33IOYtj2a1x4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3oiSJbrK4jrzfzrWZDSWuRz1bX9PIsFzR3/mWem0RnXLAPPOd
	VRFpA0ZFpWNdbBkb7LVlitZgorIfNtBmt6n+A++bJg4AeTqEK4ue/PA=
X-Gm-Gg: AeBDieuoSxb+l7rWz2yasJeL/TcOd2mL4AYWzEaM2WcuUMon0yMqkPzcmsQZz2OlV/u
	F5c1jvICr1xHQ2o7b3Po6Hj+IsmjmWzSYGQ6KZUw3J8QMvdTey7mHYRpFQWRPJqTMCDaFM04hP4
	nnsaQ5dIF6o6BffwFCkrW8vfOmDDswI1ArTqTZXAqUFMvWButfkE1PxxOh4xMBPlkXVlEBy9c6P
	p0QSGRMqh5oknhbn470+bXiI+Oj7NZA7J+noI16rbPRYyaQtAaN/VII7XSdHT2SsjXYnkJaYmgX
	jlF8p77ZzYyExOIw7YIuo98f7sgFbrO1EdYZusCZ11gwowyRoE4UEFlm1Cs/VDWbjjrXwUAMgl/
	Z4uP99BmiQ2o1uZrN02QGTw4s9pu2q1YffyiWszdq0B3G0VWWZy5BYqi7aIKSEjNRHgnRVMBvFZ
	aK+/XFJvYfUms70904
X-Received: by 2002:a05:6000:1446:b0:43d:73d4:b2f with SMTP id ffacd0b85a97d-43fe3e11634mr6425771f8f.39.1776454399246;
        Fri, 17 Apr 2026 12:33:19 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm6341754f8f.33.2026.04.17.12.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:33:18 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2] ksmbd: fix out-of-bounds write in smb2_get_ea() EA alignment
Date: Fri, 17 Apr 2026 19:33:17 +0000
Message-ID: <20260417193317.315698-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417192036.268452-1-tristan@talencesecurity.com>
References: <20260417192036.268452-1-tristan@talencesecurity.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238514-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:mid,talencesecurity.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 996FE41E4CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

smb2_get_ea() applies 4-byte alignment padding via memset() after
writing each EA entry. The bounds check on buf_free_len is performed
before the value memcpy, but the alignment memset fires unconditionally
afterward with no check on remaining space.

When the EA value exactly fills the remaining buffer (buf_free_len == 0
after value subtraction), the alignment memset writes 1-3 NUL bytes
past the buf_free_len boundary. In compound requests where the response
buffer is shared across commands, the first command (e.g., READ) can
consume most of the buffer, leaving a tight remainder for the QUERY_INFO
EA response. The alignment memset then overwrites past the physical
kvmalloc allocation into adjacent kernel heap memory.

Add a bounds check before the alignment memset to ensure buf_free_len
can accommodate the padding bytes.

This is the same bug pattern fixed by commit beef2634f81f ("ksmbd: fix
potencial OOB in get_file_all_info() for compound requests") and
commit fda9522ed6af ("ksmbd: fix OOB write in QUERY_INFO for compound
requests"), both of which added bounds checks before unconditional
writes in QUERY_INFO response handlers.

Cc: stable@vger.kernel.org
Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/smb/server/smb2pdu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ee32e61b6d3c7..407173d2175af 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4821,6 +4821,8 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 		/* align next xattr entry at 4 byte bundary */
 		alignment_bytes = ((next_offset + 3) & ~3) - next_offset;
 		if (alignment_bytes) {
+			if (buf_free_len < alignment_bytes)
+				break;
 			memset(ptr, '\0', alignment_bytes);
 			ptr += alignment_bytes;
 			next_offset += alignment_bytes;
-- 
2.47.3


