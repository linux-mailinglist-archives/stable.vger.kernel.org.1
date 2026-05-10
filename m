Return-Path: <stable+bounces-245019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMVuBq+IAGrcJwEAu9opvQ
	(envelope-from <stable+bounces-245019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:31:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 569865044A1
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD6AC300B452
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B8F1F78E6;
	Sun, 10 May 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/tkso08"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA61919E968
	for <stable@vger.kernel.org>; Sun, 10 May 2026 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778419882; cv=none; b=NXpdJR6ti1HxY+L8ITaJAaq+b7QZ0qU6XudDdjTfzpTW3aMaXKFE4ov7YEiy1i0Ah/Nu6WQGYXWG6upBGfm0P32PCpfvpAq8LLRXPGuDgZewqQLoQuRUfYerxHwIE0SDL1OEWoztnFzlwTz8yrJaLdeyPZptyVqHVGxgorRb4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778419882; c=relaxed/simple;
	bh=vzxqpeGShuFLVgwXzMwXRO8RABUajaDsTIGUjrNanw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiN64CAOLtb0wxCe89EfMrj4hunWELRtb/U/Q7AosR4mntDESLE5bJjdRI728KeOZjAMmaIHEB/KmjA86NE33mBtFm07Yc64FlQkhYNtvROIDaDfotqdBejOlzEmVi9JeFP03go1nhbafjJjyguKXtw5/qI+EesGJPzv8UOTTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/tkso08; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83659d38e38so1505485b3a.1
        for <stable@vger.kernel.org>; Sun, 10 May 2026 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778419881; x=1779024681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=decq6IraHBV6QMzg3T3l4JImkV/E2OwWUQR9LGmt3/k=;
        b=P/tkso08aJZb+hhf3aFoFDuBSzDw+cpR+bH0oFWEqPFve6M7gqbFchSBgzivNnLTrZ
         UU6qdGT3kk2VmWxuKuu4dmZSIlm7QU3PfP162VDMKdoy21Yk1GHjM1ASGVQyoPvsZfit
         H2eQrht7RxZ7LUZvvU2WCcqtkRnmYF2OoiNIupczVsWD0D9/Dm/oAKFjdFWhTg8HN/sN
         iokeqiU//rHG9j19LCAt4iOHf9yMT/MVNP8Vt74zGfgqBtmdWFvm+tbpFT13P+Po7lDz
         yef+z5KWQSP0QyvnGWVzUuHQt2F0lLHKtt7c16Qm9QK45YFSYQXpXCZTN+/RtPjSBgxb
         qBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778419881; x=1779024681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=decq6IraHBV6QMzg3T3l4JImkV/E2OwWUQR9LGmt3/k=;
        b=aBq7Od6FzecF17Ab1RuDPndkEQgI9tADe8jlvQNstsUffmWTYfrT2U+hbGSB99eVSc
         HLp4g1g13jy75NCTM6WdexHEvCQVqfpzYaPzQX0LS3Fv41X9br/Y2l8I9eeK0yN3gcVc
         OgNVinZYAGCOyb6S88IvUT07hqfrb0ka/Ef10Ac7H84Pg9IjcH3/3MjM9DI6LUoVIYgB
         Q4Djb9YSZYjawPX5atBinuLd6WRaYI5Q5GGKfARa9o3A+RWncK/E/LEO0US8S3t93Ljp
         UQwaCiQ+oILgpqaKjJ7UBI3NxVWvJFiXTpDOv0W2krY412LL8jXU35TPB3lTfBdfWdH8
         DaEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GQ4krGnKotdKeOl1Dr+aqmfWcpUFfqFWp0x+2930IG1S+R3cgJ2r3retvZFl4NrMn2jWdMWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgE8gbwRewCCCDBImwN2u3qVjUCvMggqE+ePKfQssG6Gz+WZaG
	Sv3b90+ZreRjIL5B+1/vhRAtKsSWLKjID2nA7+O04UbfIT3vb5UU1ay9
X-Gm-Gg: Acq92OEEOioUzLmYJSoDJrhrFkddxJJNJ8vzfTThJWHyIJvOlDq9bqHRs8mJ6Ysyr87
	IGPSQrO3yfLis2EiSMpk+g61z5KR1m30XHVZHgJXhXiH10ItvqGGdrZYIYk+5AEgu0lF6mr7lot
	lIIlyjJGW5e2e7xNsLbacplgYp/C9i0XqjDgV0YNXLf8yHhtGB6vT5AVbj2rPAk4dZfGa14hISD
	JXeXyej4s4y/RRUab0ikSr8Nm8V1tGB/6ULKdjLhBBQ/5bGhjpUvOnK6LTuxM3tyRHqSU8cDGrt
	4jvv0tzOGmHxxbru2gKlp87wS/P0wtDFX8pQ6KG5Dz/lKl48f+w+AbG4r3qxp9M1+NScGPue0HO
	hIHMCQHhr8dr59XDZFTuAQSklEyFjTZf5yqwP/IHAbOgLXsSdUlj3g+M7eR4BgLo0PCimP5DRNJ
	2S9awUzPYbkXkdOVpMt/66lNintx6u8BRlsdrPJO1PY1jETu2kHLDLB8hP8AQ=
X-Received: by 2002:a05:6a20:c707:b0:3ab:e30:ee9a with SMTP id adf61e73a8af0-3ab0e30ef75mr51972637.20.1778419880864;
        Sun, 10 May 2026 06:31:20 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267711513sm6513703a12.16.2026.05.10.06.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 06:31:20 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: security@kernel.org
Cc: lains@riseup.net,
	hadess@hadess.net,
	jikos@kernel.org,
	bentiss@kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: logitech-hidpp: fix slab-out-of-bounds write in HIDPP_FF_DESTROY_EFFECT
Date: Sun, 10 May 2026 22:31:18 +0900
Message-ID: <20260510133118.337026-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510132917.335796-1-jinmo44.yang@gmail.com>
References: <20260510132917.335796-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 569865044A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245019-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[riseup.net,hadess.net,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a missing bounds check in hidpp_ff_work_handler() for the
HIDPP_FF_DESTROY_EFFECT case.

When erasing a force-feedback effect that was never uploaded,
hidpp_ff_find_effect() returns 0 and this value is stored in
wd->params[0].  The handler then computes effect_ids[params[0] - 1],
i.e. effect_ids[-1], which is a slab-out-of-bounds write of -1.

The symmetric HIDPP_FF_DOWNLOAD_EFFECT case already guards the access
with `slot > 0 && slot <= data->num_effects`.  Apply the same bounds
check to HIDPP_FF_DESTROY_EFFECT.

KASAN report (on 7.0.5 with raw-gadget G920 emulation):

  BUG: KASAN: slab-out-of-bounds in hidpp_ff_work_handler+0x980/0x9d0
  Write of size 4 at addr ffff888003013afc by task kworker/u8:0/12

  The buggy address belongs to the object at ffff888003013ae0
   which belongs to the cache kmalloc-16 of size 16
  The buggy address is located 12 bytes to the right of
   allocated 16-byte region [ffff888003013ae0, ffff888003013af0)

Fixes: ff21a635dd1a ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2525,12 +2525,14 @@
 		}
 		break;
 	case HIDPP_FF_DESTROY_EFFECT:
-		if (wd->effect_id >= 0)
-			/* regular effect destroyed */
-			data->effect_ids[wd->params[0]-1] = -1;
-		else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
-			/* autocenter spring destoyed */
+		if (wd->effect_id >= 0) {
+			u8 slot = wd->params[0];
+
+			if (slot > 0 && slot <= data->num_effects)
+				data->effect_ids[slot - 1] = -1;
+		} else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER) {
 			data->slot_autocenter = 0;
+		}
 		break;
 	case HIDPP_FF_SET_GLOBAL_GAINS:
 		data->gain = (wd->params[0] << 8) + wd->params[1];
--
2.39.2

