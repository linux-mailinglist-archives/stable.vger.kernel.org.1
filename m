Return-Path: <stable+bounces-126646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972CA70E26
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEC3842AA5
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 00:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758CFCA6F;
	Wed, 26 Mar 2025 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cAVjLMd3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881951CA81
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948059; cv=none; b=k+5vpphNA+cJqomq848sh7Jr1ZvvmHJF3kPHC23oY0QUnAfK18+PYoTzph4qWvKm66oq8/SgKt7xf/oxxRcP6pqoyAFEkqUfbUgZ/IdvQL3DmY9LRh8vQ3968RpamfvvmJQmmqwobKkN8Wd9wWAEoV8TRAS9E7uZqS1+u8WR3c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948059; c=relaxed/simple;
	bh=g0dYG+13u3Rs5fuIvKrRbT9x8l7ePHxFiMv96bKZa5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKMXHwFsBdXasIvOSoFY+TzSdRm2TqivRMVas0bMT4rQ8+PnRXyl9j9SWjE8oDSyje6hiDEWwExx5MqMtXBIDnjJG4uvwcA1NrVaLoYYHEZX/6Yyp6h5HAx2UgsLwJtVuRmd0/eoo9ZgDahRsJ6pVbD1zjr5kLfw+05Dy86Rma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=cAVjLMd3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2260c915749so84425395ad.3
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 17:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1742948057; x=1743552857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFDIX+meos0uclaHeE7nSM0sjioNyPG7nrvKisvJDuM=;
        b=cAVjLMd3LLu2H0rXxiPL+moC6pK3We26LOwWMFSBLzah0hMjc+BveudwqYfEmSSr87
         F0jLfK/5kHBm3l7ukJAj/kk0L1GRvJoTatE4h3kCNBTmbq32sElneJwiaLXGtR5UfIZV
         SKmZGSfFGXA4H5zaXt4ObuY6w8iSGodCy6N4z9F7Isd+BL2vGo5EttfPjdaEVFEKxnzq
         UTWkzmWI7OC3qAEQikcAayb9P/9QRaGuXfnldHS3DeHQ7l5GvdYcTXsSEkjT49cS9gKw
         UExkB82X1Sbni/HsA/KpvwQOzG3dYjeE4sCyRcXSW722XwsEFA7xANstwCP8CSEpX2j/
         fteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742948057; x=1743552857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFDIX+meos0uclaHeE7nSM0sjioNyPG7nrvKisvJDuM=;
        b=C2NZMVCrzGu8cLZhJa3hpZsVCqWjAboX0Nv/sSfRhuzo58egqe1rxVc2WFrdotyuB7
         fdCRj+PNnjppayFZmsNOgYMQwlIewVr5VdZqKTx8rbVJ7SSmYmYLQAyaYTRwTUD6OYa5
         hCeKJwvoAuUu6OQL/n5Kgd/WqV3B+aDAXF3o3R54+XJz2TFvAnlEshUk/evcATCPRHY3
         I6ye6M0u7IFHfnPYkD0Vt27Uxpr8NsbwZcCfIMxm15JMbDkWR8bzcESubA47RldzzpMB
         rM9qTj4pvByDeIuFvW+DOzTWKzPbkbAVeGKjV+UsxWAOn4d2J+nYHazqspxWCCBooYzM
         pvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwq+Ise/BbjsPX/t6PdeiXO7nH+EmPX8iaXBSSajvx/CP+YXUQtct7JYKEsm3na4gpxgJPxtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTrsKIzBgGB/mZuaPQBSTPSgxvK44tHFLkmPO1KOc2gO9iUau
	FNDTj4hnt1YTT/WOTWBxPkLD4Q1xip74UaQLJnhWy8auCONp91SMb7vM3lIBKWHqtomZjKRxx3v
	uBA==
X-Gm-Gg: ASbGncscv47CIkXLxEso4E8S3hCJv717Ex4LHmfXS5eY9XRclNoTgM1C6B3BhIc9tE9
	rOqR+PeDbG9NtTdarcx6vsrVrSsK9Bku/B+STFv2ZD1i7NznK32eZqQCW7KltpvYWJL7c6jzOZG
	rAjQUzLnksNXFaOA57kD0O7f74QrfllXzHu3ukTnIChxj2TqI/1QNhGr3g+2OthrCt0IRjd424u
	6HH5EGy7BO3rnykxZV17LU80Ln+CjHWGhfgf3oRIE/IQ+qhEN+q6gzqEf1gY0mYkqHcCAd/Uh34
	r02aK6aNykLmfqvC45sBtR4uVuq0hadOfZp4EjXYYNmrhD0rev1Dc18ZNYfRxMZFetpdCKW0Xua
	M
X-Google-Smtp-Source: AGHT+IHK8sPNE5a8da2vd2P2uilFj9WNnxaFAoXEB1cCtXSAr5mBSWLZSORQW/oGVGD632Z8aRQEGg==
X-Received: by 2002:a17:903:2349:b0:224:1af1:87ed with SMTP id d9443c01a7336-22780d8ab14mr272822845ad.27.1742948056553;
        Tue, 25 Mar 2025 17:14:16 -0700 (PDT)
Received: from s-gupta-ftrace-1.sjc.aristanetworks.com ([74.123.28.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45954sm96992665ad.62.2025.03.25.17.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:14:16 -0700 (PDT)
From: Sahil Gupta <s.gupta@arista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Kevin Mitchell <kevmitch@arista.com>,
	Sahil Gupta <s.gupta@arista.com>
Subject: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64 mcount_loc address parsing when compiling on 32-bit
Date: Tue, 25 Mar 2025 17:06:56 -0700
Message-ID: <20250326001122.421996-2-s.gupta@arista.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ftrace __mcount_loc buildtime sort does not work properly when the host is
32-bit and the target is 64-bit. sorttable parses the start and stop addresses
by calling strtoul on the buffer holding the hexadecimal string. Since the
target is 64-bit but unsigned long on 32-bit machines is 32 bits, strtoul,
and by extension the start and stop addresses, can max out to 2^32 - 1.

This patch adds a new macro, parse_addr, that corresponds to a strtoul
or strtoull call based on whether you are operating on a 32-bit ELF or
a 64-bit ELF. This way, the correct width is guaranteed whether or not
the host is 32-bit. This should cleanly apply on all of the 6.x stable
kernels.

Manually verified that the __mcount_loc section is sorted by parsing the
ELF and verified tests corresponding to CONFIG_FTRACE_SORT_STARTUP_TEST
for kernels built on a 32-bit and a 64-bit host.

Signed-off-by: Sahil Gupta <s.gupta@arista.com>
---
 scripts/sorttable.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/sorttable.h b/scripts/sorttable.h
index 7bd0184380d3..9ed7acca9f30 100644
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -40,6 +40,7 @@
 #undef uint_t
 #undef _r
 #undef _w
+#undef parse_addr
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -65,6 +66,7 @@
 # define uint_t			uint64_t
 # define _r			r8
 # define _w			w8
+# define parse_addr(buf)	strtoull(buf, NULL, 16)
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -89,6 +91,7 @@
 # define uint_t			uint32_t
 # define _r			r
 # define _w			w
+# define parse_addr(buf)	strtoul(buf, NULL, 16)
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -246,13 +249,13 @@ static void get_mcount_loc(uint_t *_start, uint_t *_stop)
 		len = strlen(start_buff);
 		start_buff[len - 1] = '\0';
 	}
-	*_start = strtoul(start_buff, NULL, 16);
+	*_start = parse_addr(start_buff);
 
 	while (fgets(stop_buff, sizeof(stop_buff), file_stop) != NULL) {
 		len = strlen(stop_buff);
 		stop_buff[len - 1] = '\0';
 	}
-	*_stop = strtoul(stop_buff, NULL, 16);
+	*_stop = parse_addr(stop_buff);
 
 	pclose(file_start);
 	pclose(file_stop);
-- 
2.47.0


