Return-Path: <stable+bounces-230225-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAQUEzntwmkdnQQAu9opvQ
	(envelope-from <stable+bounces-230225-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:59:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E96DB31BFCB
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57554303198F
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B431F986;
	Tue, 24 Mar 2026 19:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou+slTsg"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BC30F540
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382388; cv=none; b=SbOixF9MJS5C1NAy7RqOLlUa9Tg1LYcmeICkhhAp6IBwEjGGfzTPmJjfjo+kHtDITamAcma2LCoIhC2tRyBEojMWyqIiPMEKfsiTsBhveP5B8OhkhtdwhgdWxlEt5leuO+2CmyG/hSIuRza2m3YorSpz2j3+LmBaapM+YFQOv2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382388; c=relaxed/simple;
	bh=z7ibkGNm1QW6sR22dPWU1jnwc+ukldoM5ju3j0FWFVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AuMeeCtjXGLXtMCKmFBlt+3I2JVLJRospoXVOoHpyv8SImNKhWi1pb7lzpb5O9LjPjI8Kb4Y8E5HtxsUWa5q9H2s0Q2C0Geq6Pj8YD+8uyJhxO1z1FlaHgUBUGlgMbJzAUdbxzFgYfhDEucayDvPAhb3H7NRBlfqmuMlzJeIZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou+slTsg; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0c482e069so3579439eec.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774382386; x=1774987186; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ua2NTGKaorenmmg2d49ovrLt+QpXF9duRF0O4CKNrgs=;
        b=Ou+slTsgTm6gWd0IHjiE/6N3Yi2JMFWFJWgp3hbMiajsh9RSXNCnMHS6m+5abfp0+r
         C27pRUJw8dMF/PrjKDK9ZUiuLoyQaH6Eq6D6mWqpWcDquPT0h+J5IYhn6fpkWldY7ydh
         47KM2/uuoCZMmiLWW1lPRfh3N3nwNm739wpgzDJQLzVz+BqXhly0+fDlblGFHPyWOHEQ
         pV2l54rSRRgkisMPNV1Yu69QuTwLd18N/FtXkH8TcVPhlolOeRUR5A5iiNjimORYE76O
         K998E+Mt25CoYA902mIThodoqnd2Rtsw2yOKcmQ7tIgzHQqrW5W491tpMybImiOzxpkL
         scWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382386; x=1774987186;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ua2NTGKaorenmmg2d49ovrLt+QpXF9duRF0O4CKNrgs=;
        b=kL4UssCj35FwJ9V8nEWe2e0HWKMtNlKtebm76gOtcSumKq3GPuFk6AMxOxlNF4J9yv
         Vovd3I0dATH6S6Dlbj7C/4UOYETe4ujxTiGcS/hpk5yu2DR31iTeq7yOJr9iV4MHp3oL
         1cGYB2h4RpMDfR9Y5ZXMsDHnqecCtg+3MANGt5iTKAYznhLhfxc7OhkT16X53v2VpCvn
         jfQ55VYNEsv3I5lkpZ8v5Mcb91wR83Xq1G2YKtcFLViSMYKA447MRT0AP4OSTS3K6aho
         1otc3Zt0xeCZWPnXzBQ7Ll7mMOgQSbWSnNwFJcWwZTfsWhKFrrrZ8p8GcIWeo+psozsh
         wr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpBnuuAuvE/MrV1RYQHEt8ZRFtSuD70xYS8A0Cn9Wc0s9zQgO7GT6kD2hCatA1m6AUx8tk/yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7TreU6Vo3MzVZom5bpo7zG/k9WZgA01bD3P/IJyCst//pr2Kj
	wOUVn813TR+BqW3rQrpX1d68ceYHocLb1hzVjMsv9wsMm8jyh9zXrfWg
X-Gm-Gg: ATEYQzywdzB+9n0DBDGmPIIflVsz8J3RCv7dzxTWQonwfJKzAHY5JSBuoFJ5vk7kuP5
	g8wOS08BHX2CVWZPT/9xfIfSy7oMu4MDJAQP5lsukE8heLezsfJoprqwDIVjW58KDMmH+JV7efW
	CamfQwKUHJSsF38B0ZdRb8DbpsI9aR7cFoOOpVJIK9urUqXmEFpuwRN6GdWdUKCmU99Pq/j0S0J
	Py4cYilBY7RzASBnmAKsujpxCYpgjo5X6CgwiDLazVc3VX8lozTnv90xW43wuSbzgvMDi/926h2
	z2/RiBfvdsVHDk2KKX49DMy2X9DdDvFU6cBdQunBpbkLAHkIPjrrzBq/NT9ZmK0TmnR9f5zfrHp
	qaLNjSH1+AEZcoyq49MR2cT2X9cJA+Ubu/5igqdx/1DUvbrpFY7QVuPlrXTCT790tKo/yqUU1bO
	nrM8iIEVSHoiAd9TNOQAWMrw3lfbfxDIYOxdpE0XWVONkbswd77pSgEWaoc65PsuPPESw2f5sva
	GY=
X-Received: by 2002:a05:7300:f191:b0:2bd:b102:a022 with SMTP id 5a478bee46e88-2c15d3c0932mr350819eec.27.1774382385936;
        Tue, 24 Mar 2026 12:59:45 -0700 (PDT)
Received: from [192.168.1.8] (177-4-160-195.user3p.v-tal.net.br. [177.4.160.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b1b8sm16718375eec.8.2026.03.24.12.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:59:45 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 24 Mar 2026 16:59:41 -0300
Subject: [PATCH] ALSA: seq_oss: return full count for successful
 SEQ_FULLSIZE writes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260324-alsa-seq-oss-fullsize-write-return-v1-1-66d448510538@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQ6CMBBG4auQWTtJKeiCqxgXVf7qJE3BGRAi4
 e40LL/NexsZVGDUVRspfmIy5IL6UtHrE/IbLH0xeedvrvEth2SBDV8ezDjOKZn8wYvKBFZMs2Z
 2fe1d84wR7ZVKaFREWc/J/bHvB2y6dDl0AAAA
X-Change-ID: 20260324-alsa-seq-oss-fullsize-write-return-0d1203bffe45
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=z7ibkGNm1QW6sR22dPWU1jnwc+ukldoM5ju3j0FWFVU=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJmH3uq3tWaktFdtXyD+wFk/3zqq50Sz4obAzOxTdiK/V
 cy43V50lLIwiHExyIopsqxOWmS5p+vB1fq4FR4wc1iZQIYwcHEKwESEdRj+yqckb6zPeGHj4xGQ
 sjr1R3CBXLt1scfCC/a1j/2Xav/6wchwTKti8z3Wlay8brXZzDeO5nV9VGqXqD/64JdJpeAHk7m
 MAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230225-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: E96DB31BFCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

snd_seq_oss_write() currently returns the raw load_patch() callback
result for SEQ_FULLSIZE events.

That callback is documented as returning 0 on success and -errno on
failure, but snd_seq_oss_write() is the file write path and should
report the number of user bytes consumed on success. Some in-tree
backends also return backend-specific positive values, which can still
be shorter than the original write size.

Return the full byte count for successful SEQ_FULLSIZE writes.
Preserve negative errors and convert any nonnegative completion to the
original count.

Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/core/seq/oss/seq_oss_rw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss_rw.c b/sound/core/seq/oss/seq_oss_rw.c
index 8a142fd54a19..307ef98c44c7 100644
--- a/sound/core/seq/oss/seq_oss_rw.c
+++ b/sound/core/seq/oss/seq_oss_rw.c
@@ -101,9 +101,9 @@ snd_seq_oss_write(struct seq_oss_devinfo *dp, const char __user *buf, int count,
 				break;
 			}
 			fmt = (*(unsigned short *)rec.c) & 0xffff;
-			/* FIXME the return value isn't correct */
-			return snd_seq_oss_synth_load_patch(dp, rec.s.dev,
-							    fmt, buf, 0, count);
+			err = snd_seq_oss_synth_load_patch(dp, rec.s.dev,
+							   fmt, buf, 0, count);
+			return err < 0 ? err : count;
 		}
 		if (ev_is_long(&rec)) {
 			/* extended code */

---
base-commit: b3c48fa1fb397b490101785ddd87caf2e5513a66
change-id: 20260324-alsa-seq-oss-fullsize-write-return-0d1203bffe45

Best regards,
-- 
Cássio Gabriel <cassiogabrielcontato@gmail.com>


