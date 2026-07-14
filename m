Return-Path: <stable+bounces-274226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eZNvNik1VmrH1QAAu9opvQ
	(envelope-from <stable+bounces-274226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:10:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FBA754E22
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:10:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=oXNuM1us;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274226-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274226-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2488631EF319
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BA846AEEF;
	Tue, 14 Jul 2026 13:04:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF384657F5
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 13:03:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034239; cv=none; b=exU4bx6lON96GQSW4dfFJAgI663L2GribP6aFFOMGH7cYVoKC8fHdCeXyxYzJg4mi0PD9ZR7NqPMxDdUfJ6aZM1pFDInuUauIg1hiTmWZlYpowF0663F7zCuOL9sFcMPrA+8Hio7hJiX/q+REeSPhGZc89UP+aDhQ5otTlf8jnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034239; c=relaxed/simple;
	bh=+9LSkEaOqHP5J+gwKCY481xJEYJYJF7buSxUcCGkD+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yep+ErsXzXZCG4mXwDyTG6BUZLDfg8iRE4AKsG9g6tHms1Rezzm39NSQ7+f3BzvWyXy3GlyAH4HRNEH1uLmKZi9WynNyw/MVKe+KDV6khz0tE9Hzo8YdgqbL+ZrAyAPWY8eTsuQbO3qi+T5BOTSIIphkK/FogxoL4Cd9Ttj6uZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=oXNuM1us; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4629051c9d1so620437f8f.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784034232; x=1784639032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QcF0L770TQKMQqDorbzgjGu6vJT+Lw4syVjdxxXe8x0=;
        b=oXNuM1us0X+T1LlQf5qFfxZTFuukMAx5HuDd/w/MKIKoGVq19fqeVU3x57f0cm8Cah
         LIhWDgLE8aH+KyAq2iKrCHVUP8hLN7eG/c9N2/X0qEMEoGTa6oaY3G9kBDghZwaXY0U5
         fshcOKovEIbIjcshNdzTP0yfbO0Oc40zUPcLsasVvjivAQ9V4AX3BVGEEnq7+QAuNEiB
         FNgyo7sjQHVfrgdOKSJrVLBaqjuSgJ6kq1SmD+CqD9XT7BlFIOvp1M3LYbP49chPEjvz
         XFSIwbZmL9aDC5MqfwuleqLiHR783CX9QfW1fnOs/XLsHIiHEwyLnlGqJj9ZkGjeTaDT
         kzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034232; x=1784639032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QcF0L770TQKMQqDorbzgjGu6vJT+Lw4syVjdxxXe8x0=;
        b=oDWJkQeAd3wzVVkHpcbX1odSV+gq3o2ye9jmnSCEFsivJfIXDVOfh9uD5eUucRimAs
         wf1PUVuHZyQ5SxH1qyBBAOdUTwhexM5rtsD67ODtOS/UMimhHFW3TZPm2HTxUbfxrry3
         siP3Ae4kQfqO6xABT7uwjdahARhVWFH0uGQAbWDQvxGtbMm6uaDbliEWWDO8eErXxvJN
         IA+r0XtSx4An4Sb6CVtvy7LUI7OKycgxV9hbpJK91gjOneShnbWp8wpFRakOxK/GjG9M
         mwX2+h3l3KKeQUdxtV7Se+deS4t72mu3uRk7lsIkrJ7T4WhsjnoxwqzHv8p6qEKPkas+
         LaJw==
X-Forwarded-Encrypted: i=1; AHgh+RqonQ6CMRd92nPtnAi3uDLpaWaoj6/0l2xbGKpr6TxiHl7jvxNRXbAwac+4YZ71mqAa6HNSm/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQOawjFe6MBcq+GpRqz/76rmyGohhFa8uDjLNb9Pv2ZKsHaWm
	rEdihMcYyYNaGX5bKrU1D74YRs8JtABCAc4RHtmJnI1akQ9Qw/8biM1LamKcZV5Bw8hi
X-Gm-Gg: AfdE7cmtrj+SCAcK59H8IGywtzNp2WJphB5yTccXw+Jx+ydr0M7kdy2x6fcz9UBqLR9
	fhUOW+S2whO7kCm3Loao2NnAKO9aVeb7rx/t8rgrmyqgiabo14tQ/PvJWBxRKBa0b0HFrwpzk4y
	FkQX+c6i2w7dpyl9JI/qqG7cFuYl1ADSny1mpcziejf6uycZ3ttYujywDaZfdGWa996xsNXv24S
	9usPzGRNWV5qxEiOs/S22i1mpxVpBKP0R4Xm4jyanog8gjC44losnlheVlLApk/M2OigGTwkBPH
	GbgsGQ5hXwSJ9q8YKSzCFqwkgzasI0b5mRglRz2J0fp1Q4Pek71K03n87r9mrRNVHS6pZYvP7zg
	3g3fKgtLmhf2p+Ws0UXAiYBIN8bERSR34oOeFzhddXjIcl6GqMIKWZ/IuW8HFeJrSN0Jq81NoQw
	HMw2vN1te5GlI77wMSKA1rza+R9esAV48zlBuMQ83ylYZEDbS3LOAvx1ZnQBgIQPA7vCHb/Fshc
	cuqn34O6BMSTSFifmXjIrMAsSgUGK/ZVJM=
X-Received: by 2002:a05:600c:e54a:20b0:493:a573:179b with SMTP id 5b1f17b1804b1-493f8829b05mr88159195e9.30.1784034231418;
        Tue, 14 Jul 2026 06:03:51 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm79484005e9.14.2026.07.14.06.03.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 06:03:51 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] mctp: serial: reject zero-length frames to prevent rx buffer overflow
Date: Tue, 14 Jul 2026 15:03:48 +0200
Message-ID: <20260714130348.72716-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[0sec.ai:-];
	TAGGED_FROM(0.00)[bounces-274226-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,stable@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:from_mime,0sec.ai:url,0sec.ai:email,0sec.ai:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74FBA754E22

The MCTP serial receive state machine reads a frame length byte in
mctp_serial_push_header() case 2 and validates it upper-bound-only:

	if (c > MCTP_SERIAL_FRAME_MTU) {
		dev->rxstate = STATE_ERR;
	} else {
		dev->rxlen = c;
		dev->rxpos = 0;
		dev->rxstate = STATE_DATA;
		...
	}

A length of zero passes this check, so rxlen is set to 0 and the state
machine advances to STATE_DATA. In mctp_serial_push() STATE_DATA, the
incoming byte is stored and rxpos incremented before the terminator is
tested:

	dev->rxbuf[dev->rxpos] = c;
	dev->rxpos++;
	dev->rxstate = STATE_DATA;
	if (dev->rxpos == dev->rxlen) {
		dev->rxpos = 0;
		dev->rxstate = STATE_TRAILER;
	}

With rxlen == 0 the "rxpos == rxlen" terminator can never fire (rxpos is
already 1 on the first data byte), so subsequent bytes are written past
the end of the fixed 74-byte rxbuf, which is the last member of the
netdev private area. Every following data byte is an attacker-controlled
1-byte out-of-bounds heap write, and the overflow continues until a
frame (0x7e) or escape byte resets the parser -- effectively unbounded.

Reaching this requires CAP_NET_ADMIN to attach the N_MCTP line
discipline and bring the resulting mctpserialN netdev up, after which
the bytes arrive via the tty receive path.

Reject a zero-length frame in the header parser, matching the existing
upper-bound rejection.

KASAN, on a frame of 0x7e 0x01 0x00 followed by data bytes:

  UBSAN: array-index-out-of-bounds in drivers/net/mctp/mctp-serial.c:370
  index 74 is out of range for type 'u8 [74]'
  BUG: KASAN: slab-out-of-bounds in mctp_serial_tty_receive_buf
  Write of size 1 at addr ... by task kworker/u16:0
   mctp_serial_tty_receive_buf
   tty_ldisc_receive_buf
   flush_to_ldisc
  Allocated by task 152:
   alloc_netdev_mqs
   mctp_serial_open

Found by 0sec (https://0sec.ai).
Fixes: a0c2ccd9b5ad ("mctp: Add MCTP-over-serial transport binding")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/mctp/mctp-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 26c9a33fd636..1e3d285c0500 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -313,7 +313,7 @@ static void mctp_serial_push_header(struct mctp_serial *dev, u8 c)
 		}
 		break;
 	case 2:
-		if (c > MCTP_SERIAL_FRAME_MTU) {
+		if (c == 0 || c > MCTP_SERIAL_FRAME_MTU) {
 			dev->rxstate = STATE_ERR;
 		} else {
 			dev->rxlen = c;
-- 
2.43.0


