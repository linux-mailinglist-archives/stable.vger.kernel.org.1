Return-Path: <stable+bounces-237737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJudAPrq3WmulAkAu9opvQ
	(envelope-from <stable+bounces-237737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:21:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 129943F68C8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07499302FF84
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48BE370D63;
	Tue, 14 Apr 2026 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltlS0kZT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C83603F7
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150808; cv=none; b=VPsgtyOS10VUHI/TOzy4RE2O3Z48EEyCNP1djkEAtNapshKM+1Z1jSO5TlgQoCrIG3hsCxxD89anhWLWDjl9FYVbQoYesjkxPWAMyOq/h5D2fD7SSvuQaoeIdsbn2zyUnbUtleiA63mtQ2D8taGOzQUciy7XyJv9I6WyEt8Oqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150808; c=relaxed/simple;
	bh=RrspV2M3q1YMPaUF6NAuszBGY+gIKbsLaOiFuToNw3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlglinRq4LunXkAK0GGGC0TWY+RwSK0NIjRyMDMdTtzx2V7p71gFDTxMY+gmyrylMkV8WmY+AfEYFZgpfjDxBATyFc4TMs2RtBEPClsWIc/bGYaLvfyZAPz4Psm1xU6DbFXao4TJ//caNRrrOvY36VlT2FP5vRvp+sA0Pjl7MY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltlS0kZT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82c70e4654eso2285773b3a.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776150805; x=1776755605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZR5ZSEZp74pl3SVnEkbEOwwj/yRKz7BitznZw1sh5s=;
        b=ltlS0kZTR9RXOmax5ag2pon1pcI6NpXbpv58fJCWq26yTqXvNkagRRqZ7VGt7iRnSd
         dGdUzMG/hihbx71ZdHfU65oTnKjRwM5GNOQwHQQXltvpHcbkZEhFkTq+KnH8WCVDf0le
         w9dFLF7QTbvt1js9BSVvsyGQA/LoOliuBwRMzHFmpH3Vv9Ia1HjwOTHEl21ZCUE5ejdw
         RZoZAHAZ4Y/JCg2ZVeNtJ4MAgYocoo/CGijc0AlcMeI7JQegIwI1M/LCGBHYjXVHHPJ5
         BDDpES9RP/1AcBOjv1rkRLvJSP7efo3RNJFnRAlPvtUZhd8qpXSszjZ1vRLMyk6XdGjp
         M6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776150805; x=1776755605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZR5ZSEZp74pl3SVnEkbEOwwj/yRKz7BitznZw1sh5s=;
        b=pPNTj7vGfpj17wjn4D8P51sfjX3xzu3cevdlqFpTu8t9pHHRBYYZ73hmHcQn1vpmQM
         ipjb3Zp0QsYicO3a5ZlI7uLbZU1wzWIy1OfOsxPW7yaEY5aE+PqEo3nFhh49AhoIfyJL
         U83YwgeZqF2AFJ03uFkSVFf2khDG3DrZc8Em8wg5BZiclKqhCJ4E8earoQbcGdrh5tax
         13XsO83kZalCkBBtI/dtWvUO2AUAPnVqDrsI/UA/CbTYGuarhw5Dgg1Nag8m6tSgZBk9
         bujy2+/CnG83PonQ7vLEqs1gMyQnCFqJIPMZy+/Y3iuncYpS+opiXM6xVJnvMPNGiPDS
         AXbA==
X-Forwarded-Encrypted: i=1; AFNElJ90Ngjadt0btSv0BvOMRhcEFiwAXWXKvq0mUCoj87uPC7o8uR4QJn89iELfkEeyFCB2xwqEUrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSjxxpAo/R7pNraSFfyu5f28gA1doDIOuJfYLs4Jc39rP10DA
	b/EQkwUYnXuq90wVQ03XfVFw7h6ht0Hvh6A2YhVw63DRsf5qj+oaHUX4
X-Gm-Gg: AeBDievVP6Z+Xb9Hick1nregnVDGJTCq7NAUPM3EAJHoxTYFK/OjAQ2pY3NwQXU802r
	HISe+lgORaHKU8G39n7Evbwdu8nSwqAz6IeqFcuPjPTVh8UtKc+PXfSSmFXaBGtRCESklcu/1DO
	eV4VPRsEysGl12NXsNbnMbgfbd+u+F/pRO5mMZxUN+fxa7pWK0LhCV+JijhRetWCga4ouI+OFz0
	0D7zALHuY0fXRulXSZDWvcyjTPgwQLBAQxpzBdjAHiV9hDzWxtbX71LUxLMKdjJZtroOFZS/+Hl
	EVIfjFzjPfrv5MyYRDT42OtOPS7zwdwMdwxJLSeTS1SNDVr/8mYLZXlYRYwm2dgIJKCUrnHhb6h
	hshnVHuJEYuLvoUWZSA5LeYuNVTnNhUOWDDXvXoRa7C+0vNLKnzqBh3iUYbK7L1wrRIm+h3dcuO
	QpFQhgG70NernJqA3JiMmhFnoscdrca3GyZ8lzZqaoWzTYNnF6ox5MYoHGmP25SEjHMv6vDAlhK
	nQeFMVImULb4Vbpt/DqN7hznGWyKA==
X-Received: by 2002:a05:6a00:140f:b0:82c:dd31:b844 with SMTP id d2e1a72fcca58-82f0c316a23mr16607277b3a.40.1776150805492;
        Tue, 14 Apr 2026 00:13:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8d02:27d0:15f3:5e9a:ad7d:22d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c506150sm13172519b3a.52.2026.04.14.00.13.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 00:13:25 -0700 (PDT)
From: Gaurav Sharma <sgaurav00719@gmail.com>
X-Google-Original-From: Gaurav Sharma <mgsharm@amazon.com>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gaurav Sharma <mgsharm@amazon.com>
Subject: [PATCH] libperf: fix parallel build race with header install
Date: Tue, 14 Apr 2026 00:12:42 -0700
Message-ID: <20260414071242.95637-1-mgsharm@amazon.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237737-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgaurav00719@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 129943F68C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When perf is built with high parallelism (-j128), there is a race
condition between the install_headers and libperf.a targets in the
libperf sub-build. Both are invoked as targets of a single make
invocation from Makefile.perf:

  $(MAKE) -C $(LIBPERF_DIR) ... $@ install_headers

The perf tool's exported CFLAGS includes -I$(LIBPERF_OUTPUT)/include
which points to the header install destination. The coreutils install
command creates the destination file (truncated) before writing content.
If the compiler runs between file creation and content write, it
includes an empty header, causing incomplete type and missing prototype
errors in the libperf source files.

Fix this by making the libperf compilation target depend on
install_headers, ensuring all headers are fully installed before any
source files are compiled.

Fixes: 91009a3a9913 ("perf build: Install libperf locally when building")
Cc: stable@vger.kernel.org
Signed-off-by: Gaurav Sharma <mgsharm@amazon.com>
---
 tools/lib/perf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
index 32301a1d8f0c..8372cd9919b7 100644
--- a/tools/lib/perf/Makefile
+++ b/tools/lib/perf/Makefile
@@ -99,7 +99,7 @@ $(LIBAPI)-clean:
 	$(call QUIET_CLEAN, libapi)
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) clean >/dev/null
 
-$(LIBPERF_IN): FORCE
+$(LIBPERF_IN): install_headers FORCE
 	$(Q)$(MAKE) $(build)=libperf
 
 $(LIBPERF_A): $(LIBPERF_IN)
-- 
2.50.1 (Apple Git-155)


