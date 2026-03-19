Return-Path: <stable+bounces-227386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDi4CT9qvGlQyQIAu9opvQ
	(envelope-from <stable+bounces-227386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:27:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 839362D2A92
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 680143210A1B
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 21:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF773B774D;
	Thu, 19 Mar 2026 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MBaQ9Hgj"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541740242C
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773955399; cv=none; b=Bq61MZtK6clUE1uJiUb1xZNey0r+zAHj4U5kwgTOneX/6WgDa0dMIP29JAOGHYmANikHZkcKto0fh7tFnaiBvT5v287ika0kT34umUwSZAXQBu5bFDXf3d/8TsezMbbAzi13qdaY0PG0y4s4UJAZbKABN75Bd08sTA9x3quEims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773955399; c=relaxed/simple;
	bh=DlmMfWpYDGyGJyY3dvu/TxNqp89onH7c7Yioh6/SV3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm/IRXszhfVWM6sOb8Tsc2CQ0fjV8QS5v59PnrHWztHfcqhGS1aQ2Kub3efgmSMwGT8Io9K3pXyWhdvI/FA0FhHQ6ARVHW9YMAZ/oGklBL2Hm7vfVY39n57DUpq1vYjDH7QRXm5gfUDO49S+P2VcSxtQsb38tpvx0y3ScQB2rLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MBaQ9Hgj; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-467e044082dso18252b6e.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773955397; x=1774560197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCodX196ucy7nu88OLGRgC4cCz00gZWrCN++YGvYx7I=;
        b=MBaQ9Hgj+DS8zZ/sRr5H5cTqyNqzp09mdglzjBpCiTSKV9jrUAdZ59DT5d54lGNH1b
         1EcwyMrHaua4FJqsfEl/vZxRoec3qqz35nvUqsTurSpE7q4zOdmZe8/FdDqfAyET49P4
         KIvyelyVBkGA4ddLTIo7tgpx4e3ZO0hs0qzaGqggE02PrrEck2X9WAz3fyyRps/VDaCp
         fU/evL1OEN8dvvX4GmK/WQcGXBBjEWLsw6G2/sEwPY3Ld5wiT6Pdl4YtcjWVgkVhsgDt
         3KFiphSk/YKOcHyXNK2BudDcT3UbCCIUaMxPxfaoykLTVVemgq0fGccfhHBJyD4LpcPU
         iQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773955397; x=1774560197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SCodX196ucy7nu88OLGRgC4cCz00gZWrCN++YGvYx7I=;
        b=jwGVv3bYnXBlLf/km0/YJM7G7NLHEA1XR9m3CbrhSlzqqVxdIwYEKaMNLScQ5XCeYx
         ml4MGKvWyZbRuw7W1J1MfQnNvPVsFUldRJc29lvxIZDseeLKuOaReyagnK6QNVZqAEee
         M6QI8UqU+yZCaihQxb3/ehs2+VCbiJ337LWlSbBFUTdGSdkdZCOCo7fqwxRe+k17fugm
         +guutTikqbho6RV4QoDv64vX9bEHbm+K62NlQO6uFTja6y6HfxLxxOZ/SLqbsuax19oj
         5NsmqrM76cEJDKaJPmfybLE5AlhN72H+5MOi/RsFFG6ZkldF8pQYUp+L85wNF013PXYr
         5OGA==
X-Forwarded-Encrypted: i=1; AJvYcCWHQ7Jw+6fTYoYMBymYsYvJxLjzN2DTkKdaRbxQmzcvU5yhE9tpAwkzcio97/uFtKh8nyvY3g0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJeOKE+JT+7xLgyxsOJHJJ5H/BkUvIUW2uKgV+K39vKiVIkwMq
	Ygd9jAJhB4AzEFvSvkkQgIR766f31n2mpZpEg2jWFpaNt0R2onIjpS01yTY5pbH4ct1YH9KCE2I
	HZJpPbOU=
X-Gm-Gg: ATEYQzygKrAFP9gM4CZT5kvHSU86xdnD145ZVXtCDsdD5KyVKO4WDrEdxDihn99qY9g
	ioUY+8Scl+X6+mIvauUrTXFv8Q1AruFgS1Zzy+qQBAKunhPxvar2nAJLcm+4EzwfqJ+80kcY7iO
	gbksGCMJz2tCVFFoBXgujWR28iXFCTWjqPcQ0IegbXt9BrZpkPU4MUVTsxgBUoPwuDeeweU+COL
	vc8haVgmLH/yxXwcqqXOK62MCxhefTqhK5uysQXfPeDAYCE7xy5CVW4JHby9G+8XpI108WBpOvX
	D+TjiOLVTP4bvoP4KmQzLb17lARGEqnS6u7DCvX7C23pn4nb3PsE/CY4487tWl5E4csrJ4KVHCo
	TSdSxmVTMsGgzZJf1o9cNtpPZs1V7HeEPPC40Kn4ntb1XrAR1vCW1U8Zd9MaiJSRx2PSkp/Cfxg
	+uzh75OeYnOQgZADSdrCh0ofmTd1ZxpKYq1CaJRgQNUEcNlt0xn1wwhqWCwwxGgf85rQI=
X-Received: by 2002:a05:6808:8919:20b0:45f:2719:32af with SMTP id 5614622812f47-467e5eebfdbmr324290b6e.37.1773955396949;
        Thu, 19 Mar 2026 14:23:16 -0700 (PDT)
Received: from m2max ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c148a5ca4sm186363fac.3.2026.03.19.14.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:23:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: code@mgjm.de,
	Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring/kbuf: fix missing BUF_MORE for incremental buffers at EOF
Date: Thu, 19 Mar 2026 15:21:35 -0600
Message-ID: <20260319212309.284152-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319212309.284152-1-axboe@kernel.dk>
References: <20260319212309.284152-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227386-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,kernel.dk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mgjm.de:email]
X-Rspamd-Queue-Id: 839362D2A92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For a zero length transfer, io_kbuf_inc_commit() is called with !len.
Since we never enter the while loop to consume the buffers,
io_kbuf_inc_commit() ends up returning true, consuming the buffer. But
if no data was consumed, by definition it cannot have consumed the
buffer. Return false for that case.

Reported-by: Martin Michaelis <code@mgjm.de>
Cc: stable@vger.kernel.org
Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
Link: https://github.com/axboe/liburing/issues/1553
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/kbuf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index e7f444953dfb..a4cb6752b7aa 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -34,6 +34,10 @@ struct io_provide_buf {
 
 static bool io_kbuf_inc_commit(struct io_buffer_list *bl, int len)
 {
+	/* No data consumed, return false early to avoid consuming the buffer */
+	if (!len)
+		return false;
+
 	while (len) {
 		struct io_uring_buf *buf;
 		u32 buf_len, this_len;
-- 
2.53.0


