Return-Path: <stable+bounces-268925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rDjuMyeDPmpfHQkAu9opvQ
	(envelope-from <stable+bounces-268925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:48:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7566CDB20
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 15:48:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=St5dZ1N0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268925-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268925-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35AEE303B5A5
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A313F7A84;
	Fri, 26 Jun 2026 13:48:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0463F7AAA
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:48:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481691; cv=none; b=qQmJR24yo+t/VEPzrF/CLhobwVPi2rwdN2RyrdzHVooamC1haCJrFlHOdQcJZ+MnzsDD/zvt09uqHWzdVhSs6aBatPczgNHyCS9Hmst3HgVsy0aQOB+Lk0KLTHG6ZAhZNt1SpzErJShyq3xlkmYF1xPtnrr6fE7VoHtjOrWDlB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481691; c=relaxed/simple;
	bh=Fmj0UvlNYeh0M8dAvXiFurkpaGJ1mwBSxgmJkJxwKCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A3t9kFw3drTxTqvWZ+Q+fkx74CUO/PlI1pb9NxWulGKFt2oK8MzqBsd33BIR3Iu/X6E/5Nl36XW43ZmudWk7+rk9cbC3nPeF/Gn/v6+amHB59VO/SjSxiBGjLqS3etUuroTAL55nk+ztn+sc8sD3QnDDMZzVoWKgaLSp+MrjrEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St5dZ1N0; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ac357c55so8995695e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481689; x=1783086489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rgr46SxhdjeIkGhYXOPemxka+uic54Qm3KOgU974BkA=;
        b=St5dZ1N0s9pWnukJMebi/jN3EBVBszJnXAt4geCudKc3Bj6ab5CnNyaOvv7dkeAnha
         U9tHUWsRXIU8MJPt0cTdCn1NI1k0rn3YRuAXtdus05lIpEw5zj+TKgbVlwrfOVOf41Zu
         S3xnrmJxPH8g/NOIuKRNlHHDSfGp0w9Po4xGRNG7nReeCyVTtEAwG1qK/9m9Q8vu708j
         7K6/ehU4qaI70dRz6Dgnei01OGeNZKP0+ZZiHtzwFqVECbECqK84CCHyIicGdSrTevda
         t4XsLXlCGDmkHRkgO/Riy3FWogi68gsXKZtOjIgcGekRnEomW7R92uK2irgrh3M3KGDf
         4tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481689; x=1783086489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rgr46SxhdjeIkGhYXOPemxka+uic54Qm3KOgU974BkA=;
        b=PmNW/eD/Q1tgoulSfmMjUogCRFFV3jp7+cRLiaKtJfEo0ZiPwSVGGeeuWxtrSiBsW6
         7CYIKWZ3yzqJlN9ZoNGAMrGgxIqN6A4HqZABpCMqJSseqdZO5z3HzO0pBUIxxKLrvdDo
         64x45IqQqw/be+a7NMll8grxfm28qL0GaZ0Hy5ZAVZGtv1OFCsWUxejDvwducZ+vt+ml
         qpExFz1AcGkQlOZ6e4QtYOhXWsBG7+tkDV/b8OZy/ZNHwDHHHzruWcj9LkojUmts9tXO
         o5LySQaOECtBC6gYzybX2nfsNy2xzbnxnIztxhj16Yz3wCmcv+IcKoGYS1HkXGJbc3wg
         hl4g==
X-Forwarded-Encrypted: i=1; AFNElJ9ScCQkwkTadDJ2+BVyzfdpYsWUOmU8zF6wk0HwLY70yHt/Ek7rmGBgzHoQ2fPvjMiRvTRU12w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkaVhqAJ7BFB8zGR9II43jPGKy4RU1QuX5B6O1LflW/Od3mFjb
	VuKn5o0v82Xap3DyD7+Y+TH4XT00mNx4uIoHB6ay6Jq05CqtVvZRX02z
X-Gm-Gg: AfdE7cnG09dAjQdcppKauGYDawGDnSOb1CV1TcXEVvkJNym2QHFSX1uM64gn8E2K7aL
	uhhJYoEI5V7ZZ3qdZkHxQN3lqdNFtkpy0pabC8OzOsWdEOnz0/RO/tDhGH2x16aGL0JWSi2Xh12
	TcWsDNJpwrDZ8inyBkJrmhOHtPfKMG5bd/sqGf7BRTPHIgyLFSfsxXefex07Z/tCGfo3Jm3sZPx
	CFQKKT/dmfmDgHvReiK/Aks/eqZNoOz7XbsYmWZADVVzBATh3PDhKNiu8IaNwzXpNV+RJ/YYhIk
	hVwn3aEFE+02HW8gX6LB1FGJQMTzBE56G3sFxmSZMmlTlbfZnrljRmNlMsuroasLzDQ/WMn5TA3
	Eg8zRn0Y9CpuA2wLxlw0CRw8giTy6OQNdHNLtnSELxhXKGmBmlA0rzMbd5S/a6EiKanVuza28OQ
	Sq5PnujvLPWeWyKnJXSC41D8U8fOi/KDi2AKhHCtiya9g9rLCOiY3JFQ==
X-Received: by 2002:a05:600c:a086:b0:492:6954:1036 with SMTP id 5b1f17b1804b1-49269541111mr57411275e9.14.1782481688782;
        Fri, 26 Jun 2026 06:48:08 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il. [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:08 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 6/6] ALSA: rawmidi: propagate resize_runtime_buffer() error in input_params
Date: Fri, 26 Jun 2026 16:47:09 +0300
Message-Id: <20260626134709.27883-7-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[alsa-project.org,kernel.org,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268925-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tiwai@suse.de,m:broonie@kernel.org,m:alsa-devel@alsa-project.org,m:security@kernel.org,m:nevergfx1@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[nevergfx1@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nevergfx1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E7566CDB20

snd_rawmidi_input_params() calls resize_runtime_buffer() but ignores
its return value, unconditionally returning 0.  This silently swallows
-ENOMEM (allocation failure), -EINVAL (invalid parameters), and -EBUSY
(buffer in use).

When resize fails, the framing and clock_type parameters are still
applied to the substream, but the buffer remains at its old size.
This leaves the stream in an inconsistent state where the configured
framing mode does not match the buffer layout.

Return the error from resize_runtime_buffer().

Fixes: 08fdced60ca0 ("ALSA: rawmidi: Add framing mode")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/rawmidi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index XXXXXXXXXXXX..XXXXXXXXXXXX 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -784,7 +784,7 @@ int snd_rawmidi_input_params(struct snd_rawmidi_substream *substream,
 		substream->framing = framing;
 		substream->clock_type = clock_type;
 	}
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(snd_rawmidi_input_params);
--
2.43.0

