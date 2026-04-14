Return-Path: <stable+bounces-237872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DCSJnxA3mlvpwkAu9opvQ
	(envelope-from <stable+bounces-237872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:26:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A83CE3FA782
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A0B6301F692
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1777D3E6DD4;
	Tue, 14 Apr 2026 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7i/1LEs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87163E6DF5
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173106; cv=none; b=sp4jW2B13fLbngeFyPABuExDxv751Uq6ioKFED57s2vrvTVHunM5cvIixIaoSZIAtC4VJNe4wvxveXjQZByj+xibt4W93d/lkCkAuEfZO1aigqdXIRnF8rsy3Q0Dwn6WpszSlYE/429I7qqfqFuDUhZDdgE5eyxgfVi7cMzkz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173106; c=relaxed/simple;
	bh=RWMWWhBREYWNutiyCoxu5SfAs+bK2NNa7S06nm39YoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9zJiR1jm23cVtwIScvcsgZBXUodvYe9jMU4IjxuOjHTwSct58BD68PIcqqdItPSZtO2qSi+rgd44sjBQ2TxinUEgekUVJxiMQ28SIn/zklIAfJL66LJk52rXIOQq6AkcGtI8t77V7pLGAqXkghi91TA/ftfQVgJRFObkZAbKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7i/1LEs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35e4617924eso545931a91.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 06:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776173105; x=1776777905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=opcylBd2GGN1SyilCKpA4V3rg0BLKqf3938q77JOvpk=;
        b=I7i/1LEsXQRh8w5EskKQtbUKMblrLhFkHtWNI8cNF5hbtFbFMJUbJkjwGvnW8LR+wI
         P1T8iIVU4Tq1tbuA2A11hPgUDbGM6I1YDgWpCq5rVazjkGlgg8/lyxl8Ca8sjw2Ci2+0
         hbTro6RrpmJXu0Fl4E7GRGhUqA57tPe/dKKirJHIFo18m3MsE6z/tsIKp3qNkfbRx7Pw
         jcU6Wet5FKnarbf0x435bbBcQ3t1eqRkEugXEbbEr74rxEPphefyqmDwd9VnV1SDdSr3
         oz2yfTTAujhWtwaz8A+Rs9rALIx1k8nR/VAsjodFc5y14vi9opjShTImOXoX8MzdNpaF
         Kd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776173105; x=1776777905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opcylBd2GGN1SyilCKpA4V3rg0BLKqf3938q77JOvpk=;
        b=cBLlvcKg+npuEHt4Ur7WivHgdSv5K970XuFgjGO5Ta2XcAehJD0ayxYB66vEQSHOch
         sA+8FtPMV73zEspFNDwdvKmJ2Rys0PjxVe+9azBvNnjQfjW58MBRNHX1D4nKO6zLW9KB
         UQEcRQjPSYDSX1gv6wdWuyZ/TjWnNuxhgQEbXI5f83R7TyxCArPDmMEkrPoTwYxoL47l
         O/MCJoI2A/BCBZqGKutOMHABQDbG60oWu9ltGYes4iMWlF0RYQV6qVwovTQDKiTtN/zF
         vTcIgQgQH30MY8xfDFbnZIVlgLyHWMqJ6+lSKoO42lmyF6FfxH/3pU3A8YeZ6gSGOyKQ
         KI4w==
X-Forwarded-Encrypted: i=1; AFNElJ9ZM+R7Ab5YkD8wXYDYp6Ci7isIpzpLMV4JMQbjN7xcx0GSjhdcu1gVKs7sruF4naImyrm9HMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvmYPVXDC/cGfG5BGwZJ/fVuRZgfaqyzJZnTykCnjVxkVQuD5
	KYKijQEJaQLwuLyhSCYmRJr4mSqgRM//dEIMcMAuzIZ7YJCFC3eo6AMX
X-Gm-Gg: AeBDietaKmLlJaMZoRNiogRCwfmTFBrQNjDFa14DmA1vylT5GXZwYCHQays5ZSHM5h+
	aM1ra9AUIIWV6t/xFAtp4VpUR58zoXjvZFBMLleahq9uolL0DLgtKrUw7+OqMvT5crjVkNSnr0/
	gDIQk5gIQKGjR9l7TPzqVL6cDaLQD5HRFAlitWdbb/HBTn+MOyGfqoLUgzhrKM9mfU19MMEvPQI
	XS6aAClPcksZNNGvG6H2MwtJSILHQPwjQw7HmE8PY2aceJgm225fvDHeurPaGxOwCF8lH+xYChz
	AqBCyMFj7QBaQ8UXge4N2WfnLC/N3taKVk/4Tk/x6H8ry4mZOmBnF6K7mlklSmCelU8US85iBbo
	lrpvE5DNSAZ8hT5RRiooNfkq2Kyq7PrqtNhdlPMprlviHgs/Jwe4QlSCvZEnNXSWL0bAZ+FqPg+
	X8gQ1unZi1vSxBm1tG/WTbK7ya1Lwi9ceyUw/hjSzTIx7tesVAzxwedd+uoaKB
X-Received: by 2002:a17:90b:35cf:b0:35e:576c:7c1e with SMTP id 98e67ed59e1d1-35e576c7d9cmr6196495a91.4.1776173104648;
        Tue, 14 Apr 2026 06:25:04 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC ([43.224.245.229])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a12adasm12526545a12.26.2026.04.14.06.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 06:25:02 -0700 (PDT)
From: Ziqing Chen <chzq96@gmail.com>
X-Google-Original-From: Ziqing Chen <chenziqing@xiaomi.com>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ziqing Chen <chenziqing@xiaomi.com>
Subject: [PATCH v2] ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
Date: Tue, 14 Apr 2026 21:24:37 +0800
Message-ID: <20260414132437.261304-1-chenziqing@xiaomi.com>
X-Mailer: git-send-email 2.50.1
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-237872-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chzq96@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xiaomi.com:email,xiaomi.com:mid]
X-Rspamd-Queue-Id: A83CE3FA782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

snd_ctl_elem_init_enum_names() advances pointer p through the names
buffer while decrementing buf_len. If buf_len reaches zero but items
remain, the next iteration calls strnlen(p, 0).

While strnlen(p, 0) returns 0 and would hit the existing name_len == 0
error path, CONFIG_FORTIFY_SOURCE's fortified strnlen() first checks
maxlen against __builtin_dynamic_object_size(). When Clang loses track
of p's object size inside the loop, this triggers a BRK exception panic
before the return value is examined.

Add a buf_len == 0 guard at the loop entry to prevent calling fortified
strnlen() on an exhausted buffer.

Found by kernel fuzz testing through Xiaomi Smartphone.

Fixes: 8d448162bda5 ("ALSA: control: add support for ENUMERATED user space controls")
Cc: stable@vger.kernel.org
Signed-off-by: Ziqing Chen <chenziqing@xiaomi.com>
---
 sound/core/control.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/control.c b/sound/core/control.c
index 0ddade871b52..6ceb5f977fcd 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1574,6 +1574,10 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
 	/* check that there are enough valid names */
 	p = names;
 	for (i = 0; i < ue->info.value.enumerated.items; ++i) {
+		if (buf_len == 0) {
+			kvfree(names);
+			return -EINVAL;
+		}
 		name_len = strnlen(p, buf_len);
 		if (name_len == 0 || name_len >= 64 || name_len == buf_len) {
 			kvfree(names);
--
2.52.0


