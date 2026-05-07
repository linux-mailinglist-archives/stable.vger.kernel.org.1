Return-Path: <stable+bounces-244649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAb/CFsi/WmGYAAAu9opvQ
	(envelope-from <stable+bounces-244649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 01:38:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AA54F0293
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 01:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7743C303C7FA
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 23:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C171C37104A;
	Thu,  7 May 2026 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcGDhBBK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A9340281
	for <stable@vger.kernel.org>; Thu,  7 May 2026 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197076; cv=none; b=BElCEvz4W7iL7Vqd4HFt5B97ODn+ZBm2qPAb0vWa1CF9Bbkd0Cp7ooCGCC17rwUZ7ye+oDfSkhnlNkXgdZJ+0sE73oN4QGMPMnUE3482EJrj777REijfn/0NsPNXloXa4MSEQMHKVbWoRJ/NcSOWtmvJ/v0oUmx0JbtsLRap5Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197076; c=relaxed/simple;
	bh=dymaywSsJ8bL9nKxldKN+amZarY0Rc3i6Hw2CU/N3Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWQ/yYq2lVIVR1H6KMLv2WDLuW5One7l28rt4NDtqx9fF5zFLFBLcTtPpdaVxy1Ar3oO0t4nGyZC+7ltXYlo51zezmj1srW2a23Be4bVdPFP5v8IduFXjvYO0JcFXyov0RSPjAjko7cpd+juedSo0dShJizKG4nAlXr2p1vcIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcGDhBBK; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40eed9b9737so63213fac.3
        for <stable@vger.kernel.org>; Thu, 07 May 2026 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778197074; x=1778801874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=evwJ3WUGDeN11ruEycjl7by7AWSkCxsRcEiQqBCjgN4=;
        b=OcGDhBBKvvC8JXYhHlIolDtuF3pQwUJKAMYyIaBVZHx6WM0yorg+lKAbZ/CiWReDFf
         g93WwYjgxX83uCKiV0PbgXnkskPnatfr0TKfgylOSC5AtIEfnGu4JhNUnza1d9ljtxwy
         nO1CDNp3/wpxVlEljP50kSTiHkIlTpWpa6Ws//CiZlqB3MPNoCGnIFYBlnWW0M/fDeql
         VzSIOi2f/yy2R1uwpjyYcMSqwrFhsV7SDC7tUx/2Nnph9PLsXLuDpf3SrFhiDMQA0BCq
         ALtG6BqTAjObumtLqb4tJWDn/WWgJkC8toBOKyg32Nt8BC2l2UlYWwXiZZVsV7PFy3tE
         B5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778197074; x=1778801874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evwJ3WUGDeN11ruEycjl7by7AWSkCxsRcEiQqBCjgN4=;
        b=l0ZNimWe5xdRbmlFPsbjGOK0sVIIkr7M+i3rMpeDOJrfmrnoD8+lyMTv0STsHmTh1M
         8yvBef9kucRl1dgI49cENla3g+tq2l19qgF1qzEY+0gY8jrk/zRg566PFuUbWEIg4xDo
         QI9KCkpIuR9aqKBz0TpXh2CVcmf6qqg8CrzwguwH5Y8PI/Er8es3dvO13Cf2fNrH85BV
         KZU1DhIL24ycuRrwvxFq//MchJcxMh+wyxnWHQOvVQl7SKPvSq5Qnl3VSpsFTECOBjBO
         QfIMGGg6GCfU4li8+xdvXhZRoepGKJrr7t+Di/zmms93+exBcdzW3/rbu/f4/jj2O2QH
         D9Lg==
X-Forwarded-Encrypted: i=1; AFNElJ8t30zdnmhhxNjEKfmgdPUQ5oOVMKte3OCvSY6a+HQbFs79VrqDXs1W5ljTlnQCs0A5EDgRXYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOtqTHG3fsc48fzDKkTH1hayQGzbJ0f/9iSsxQb87YGROhyAe
	54JSwwXpJlT3CxQCxoIm7LDli32n532T02eQIGyJ8gqZA04aRtOTIuNRYDiI7ckgsYs=
X-Gm-Gg: AeBDietL0/LhAlmmCC7hqNRYv/2Ga2guS6Cm6VBSHg3bAiA8UyiEEkw8BDc4swCTQFq
	oIU2WRvEhpFQGgtk2kMSr/RBX4zBbMUt+aqaVZ2B1UcUtuyY4yHSRxNEHystoZQ8VKXbEaKOaCK
	76vQ+OIQD6BtuJyYRs9OWsTlHVY4zDCMAFrM40cSzEM7SwjxZpsvvWaxJI71K/dkZMrIkgheZCu
	KMCcBAIslWxGENvPMcs8sDxgorxCwvA1BZtgPWbuPfINYRK/4nL07ZId5BnWuNcdAZVS+d6Lf5S
	gmckC4Nq0JUq9xM4balUlaILE86XYtGyfZG/G99OtO0vo75weShFgSF6S9RVjPDIj5Vl8P6QfET
	jm7AoCexgpwZfvlskcbG0+fakm1rpQaXjSUNTIewM1pvXNrriPiCR/sZ/mL4CYTPTusl693Vd62
	2RKFxykjUxxYRddyu77CdFV4IaMifcHVnnb4JoOSFdfd+dOe6sd0P+ni85AZS/ZDcCTRl5KY20/
	qVKvHA0uO4vkqg+b8uqn/2lmBNxTp3mEeQ=
X-Received: by 2002:a05:6830:d1a:b0:7dc:d390:4999 with SMTP id 46e09a7af769-7e1df0d2f3bmr4084450a34.6.1778197074200;
        Thu, 07 May 2026 16:37:54 -0700 (PDT)
Received: from localhost ([136.49.184.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d8fd96sm78980a34.19.2026.05.07.16.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 16:37:53 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH] crypto: acomp - fix dst-folio branch setting src instead of dst in acomp_virt_to_sg
Date: Thu,  7 May 2026 18:37:48 -0500
Message-ID: <20260507233748.327004-1-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4AA54F0293
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244649-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In acomp_virt_to_sg(), the dst_isfolio branch calls
acomp_request_set_src_sg() instead of acomp_request_set_dst_sg(). This
overwrites req->src with the destination folio SG and leaves req->dst
holding a raw struct folio pointer (via the src/dst union). The
algorithm then reads from the wrong buffer and dereferences the stale
folio pointer as a scatterlist.

The bug is reachable from UBIFS decompression on systems with a hardware
compression accelerator (HiSilicon ZIP, Intel IAA, Intel QAT), where
crypto_alloc_acomp() selects the hardware driver over scompress.
Software scompress backends are unaffected because they set
CRYPTO_ALG_REQ_CHAIN and bypass acomp_virt_to_sg() entirely.

Fixes: 8a6771cda3f4 ("crypto: acomp - Add support for folios")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 crypto/acompress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index f7a3fbe54..5a8b0cf3a 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -237,7 +237,7 @@ static void acomp_virt_to_sg(struct acomp_req *req)
 		sg_init_table(&state->dsg, 1);
 		sg_set_page(&state->dsg, folio_page(folio, off / PAGE_SIZE),
 			    dlen, off % PAGE_SIZE);
-		acomp_request_set_src_sg(req, &state->dsg, dlen);
+		acomp_request_set_dst_sg(req, &state->dsg, dlen);
 	}
 }
 
-- 
2.53.0


