Return-Path: <stable+bounces-219147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGLEDcVknmlCVAQAu9opvQ
	(envelope-from <stable+bounces-219147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A58F71910F6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BADC7308107E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43894299924;
	Wed, 25 Feb 2026 02:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b399ZxA+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D8D296BD1
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988132; cv=none; b=DpbYqRva+UkA4f2PPe9uoOXbBn4OhGTku++V+W+EgMqZMwWE6wuqjwGDsSuVsw9DvfKoCjXWJ2jJptGUyLHTvJrDzavL1tbZVeVemFX8oIMxMVvgUXCvE4/7Q4DIGtmPlIT4IwYIzLP68E9nVqtBTl9SDYGWkNxabSAzIMjtn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988132; c=relaxed/simple;
	bh=fMHHKFEdjQdBy9uMS2UJfVIHJ5UwGKOb/jxB6aSzfOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgNSHenXPvkXr72R9aa5gu8EYFO3qoQaN67uqhcWhgA7JK1dDXUi60O3pqncb8qTMHwvgYQ5+NVP/haGCYN+YW3ZELr87i8/63hBoZBPPfm2UHt2G7ouCBFqlpD6kX5DjjmEWf45v+de8kapfrIXW55bjJjjWDfLUaTZbtPVrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b399ZxA+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso53590435e9.3
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771988129; x=1772592929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXhgb2zQPpqqc0jn/TaFjFQNrp/xJUmN4JUSCw7TpjI=;
        b=b399ZxA+p403JgtTa2sMFnPKSvjU3tIOn9lsooAIT9/u+shDDPW/sJzJAIf2pGWBry
         dD1iPEa4sxfAReXPr+X0YA2AA+Pr3FIKObVVeFBOenvwqXZR6ar2x3FHC5RzbF4EUF8E
         PgDvknduim1IsrHO4anbcXSo6A4RDXwTwoEdOLP3gyBbFi/uyu2jv0FFyd9biIVurqb7
         1yRAHmzavElb7sQkfFosxHDYji9RfKxeY3KgkgbBveIDQlfCd8by19/we/Sfur/2jddy
         ml5Z/whoobopJp5bERIjvraaxPIaw9JEzWxRnBWHcvshU2VMvCqHGxS/r9KXQuYFgu02
         3xlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771988129; x=1772592929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FXhgb2zQPpqqc0jn/TaFjFQNrp/xJUmN4JUSCw7TpjI=;
        b=mAiN+RzTLRpso9jbUxdlUJjm0AwhC0GrX9LeHTSdYkBRWX1KLcddqT09fvBMaEyK8Q
         tYstNyHQ1K1VsmC8QxXLAYYehEIm8M1UDISwVbBz4dcgLQB0wbRM0jAmuB2a6En3+Vxr
         2rBoTfx7zWqsMSo2KaDTk6BXNGFBkYjaeXhiEyK/01Ko5fj0kwNQ6GgxRC4C8/deGN4a
         LUZte0BUTZq0+FvkDJgp/OyIK+XPR0lz34ZVzTFsvcNRYK/TQ3UPmzJanhcoObAiGlfd
         ejjbm53pdrIajXX9MdHBtOhaP1lgUpeHOdkYuHWDTehiWUZ5JPwPJbGfyGmNXYjnIhGs
         H9zA==
X-Gm-Message-State: AOJu0YzfuK9VSFi6ddOASLQUYVy8QTSjseSDCm4R/choVjT0nmw0H52H
	gaF/q6AqCBExQmynBJG7z8wDxpsIxzlL0P904/R50oVUeDFTPefMMFqc8MnlIxxSgNfiFtHdfoM
	z3RrP
X-Gm-Gg: ATEYQzxfsVe9JTPpwMzJCds2TYkmUyGhQI91Ek+vDm1RGe88Zdnk516J2w9QMSEpj0w
	pUYgcc5GatvpKprTFyc+tCrcXVo0dVCWeiRW/xWOQUx1pWL5E1CaRNYZnuI4GbhzNMJBMeWLg2e
	q/BPA0UttVkBFt31yUcm9iY44DC/JOF8Nw/6FoQQ3tYIqLz0YfiEE9BY+EaGLISqEsnuvs6/GIJ
	CoDvBSy0Crm8J7uhda5WXbOkfwSlJpP0vE9ASOfgHBWPYauoyxa9RPnbCaj5SBh9I1ujnl9NRk5
	hJcGBbtkNqsnsZV/Ut9Wq9t1Vc3FZ2khxLXI8U2wPqicXWD1oZfEvVo1qkHxlRA3HMmPsA/nYpg
	xgvwMR12STqXww1Pc4JI1UnzN9S0hKJZukjlju1dYif64WsFK3Nt0Q9UlzfGWJbKb+UzV0J/n8P
	O20xYZUagBisNQhVhkeTWoJL0UBQ==
X-Received: by 2002:a05:600c:8b88:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-483a963d64bmr208607145e9.30.1771988128952;
        Tue, 24 Feb 2026 18:55:28 -0800 (PST)
Received: from localhost ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ee179sm11578436b3a.61.2026.02.24.18.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:55:28 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH stable 6.6 07/11] selftests/bpf: use simply-expanded variables for libpcap flags
Date: Wed, 25 Feb 2026 10:54:45 +0800
Message-ID: <20260225025454.17398-8-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225025454.17398-1-shung-hsi.yu@suse.com>
References: <20260225025454.17398-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-219147-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A58F71910F6
X-Rspamd-Action: no action

From: Eduard Zingerman <eddyz87@gmail.com>

commit 5772c3458bb8d17d763e0f411e1bae1bf4eda88d upstream.

Save pkg-config output for libpcap as simply-expanded variables.
For an obscure reason 'shell' call in LDLIBS/CFLAGS recursively
expanded variables makes *.test.o files compilation non-parallel
when make is executed with -j option.

While at it, reuse 'pkg-config --cflags' call to define
-DTRAFFIC_MONITOR=1 option, it's exit status is the same as for
'pkg-config --exists'.

Fixes: f52403b6bfea ("selftests/bpf: Add traffic monitor functions.")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20240823194409.774815-1-eddyz87@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 2eeb51b13249..9d652cd3f494 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -33,9 +33,10 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)	\
 LDFLAGS += $(SAN_LDFLAGS)
 LDLIBS += -lelf -lz -lrt -lpthread
 
-LDLIBS += $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
-CFLAGS += $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null)
-CFLAGS += $(shell $(PKG_CONFIG) --exists libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
+PCAP_CFLAGS	:= $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null && echo "-DTRAFFIC_MONITOR=1")
+PCAP_LIBS	:= $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
+LDLIBS += $(PCAP_LIBS)
+CFLAGS += $(PCAP_CFLAGS)
 
 ifneq ($(LLVM),)
 # Silence some warnings when compiled with clang
-- 
2.53.0


