Return-Path: <stable+bounces-270268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id agB4ID6mRWreDQsAu9opvQ
	(envelope-from <stable+bounces-270268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 01:43:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1986F26E9
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 01:43:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="lerfMJd/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270268-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270268-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2533E305BB5F
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2B3F4DEB;
	Wed,  1 Jul 2026 23:43:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4F3CC300
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 23:43:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949381; cv=none; b=tPn8MmG+gHv3LyGarKlfCxweEiqWMJD+dRU36vqMivPt00w/HIMTw7Qwx4LD28fQHuyzWeYYe4+KZ9fgB4O/vrurFYB+G8BPEkO9wvNt9+D+T4OtFaqP32L3YZpSA+kbJJFhXoGUc4kRk11mXoyrzairY0vaDb5kdU6f5SdtuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949381; c=relaxed/simple;
	bh=WnsrtSFE/x7Xk+CkzGyBv+fIdfu0V4x8ofh2A/QrZmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2nUXhN/zppDFlk0pFimxIrXJzzC6wlU8J1S5r1BTbilJIUs57Y+bIYxVgLhsjJQEe041X2gioKNjH0ivK5yZBWimUVDI7b8FaZPEmsBrPbY53Bf9dqY2zb46Sz1m6fO2AlLszSu0XAtkPxBFisvn2Q2TkbZVA68SyJu7Ii6EZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lerfMJd/; arc=none smtp.client-ip=209.85.208.170
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39af6402933so11938341fa.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782949379; x=1783554179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H89fQeWF4USszu35fjU3+dXnbx3hBALzbUBMMlx2Xyo=;
        b=lerfMJd/h25uX/XEW0yBsPtRT7r2G41b5FkBJLeW0IILN2Id+fMm6WyUts+ov8Pkp6
         vGxHnpr4RDw8cyBYSHBI8FYJ5IqU/MjYa5qGYwkiWOJQOwwb2eSeh6em/eFXRl7Cz0mJ
         MwtSy7mS7U3IKqKPwOUuX9cTHKaygy54GrndVosP42l2NfuVw2NBpYs4e4izqA6gYd8C
         RmvobQejefX3Qb983d5xKE85I89cCNz0Btt9ChiRnZ9DrAy72iUg0B84SCPbDiZEb7Ff
         LUNBG+33KWCWpzVa11Z1GJyt7w21UQq5Eh1275oezPjEl39qfksyOEqI/xYMZLoMAJiA
         jF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782949379; x=1783554179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H89fQeWF4USszu35fjU3+dXnbx3hBALzbUBMMlx2Xyo=;
        b=Z4e067qC8TyiZBy1wK0rqyyE/N+g8e5nkQ6eRwjY/hCEFvW6Q3uTtoX7MlEfxWDDJm
         ABzRdefiBMsAttjWtxhAO1nxRsZDt2YYr5b7dh+pdj9ZyIDVpI4/p5+SChQOfjGQKZZj
         tk04TmV6KT9NnTZvQyxgC1XRNxnhSu5mWO6cVHYxVKeZEGHYPuCrxguoGyyy74HpvfsN
         1MW6202SAh2tujFJ+DT4d+LACAbcZ9b4fqOpQBo7NqClVu5WGwQBq/OtTsOOlbTNntNa
         Fknz6vTyCX0ffYqjUzz+Wj7S4t1gNw9bfr/YmAUbSY1k3NQ4vM/SUbGGPSvgs+kYt8sr
         cEBg==
X-Forwarded-Encrypted: i=1; AHgh+RpTE7sHL1+x8KwXIR7r2UN1PugfM2WPO9aQAFZUA7NZ3+UoQm0uleZlsRfh+wUZs1gkzWsnsBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtTn0uUOUNpeeS67KnvsxE62WWA9TDTze8CgRNdJeDHqO9pKs
	OYTAm/ip/PotJ22Xy+46RB3ErubGxy2gK0sdaU7p+V9QZmyWvsMWus4Z
X-Gm-Gg: AfdE7cmKjniiOP8I8zN7W4c3nGNHVcyWRcsKQex9lLQFn/SO9dRqxtMPOsaTgJ6HhRp
	H5jvIvgL0sosRLkO9gljVK7N/IZZPqQ6+kdFuFV+t2OZONHn06efeh5rUvpExR6XO7vm6nGIBc3
	+09nR09fghI2LnpDXBsyLB+ELgkLATlNc4Yf/KAMdcb2mMSdpnyb1HoFmcsmuATzWRgFwZT7AsH
	mEui+GTLv6hUpezphCBGTj6dgtzH6V8xsp9tUrI1BKxrOM3qNUNZwXoex/Yul+QEtm+1r0jCk9N
	J9bF1M1H+RzLYCUgo+wH2TipLM0hvPn/Nq6ycKxvZZKSZhUdpaveRDyRJHkg+6d6YPUJIFnJFmO
	Ppj2PGvs3UewxBc/aecpYpcBrEpFxbktIy9rWf+upMIJylIT3thqXANfAh6SpAOLRUULp+KqAw5
	WfA3CIaTBXVw7USHduW91p9zamS+z96xk=
X-Received: by 2002:a05:651c:889:b0:399:87c9:459a with SMTP id 38308e7fff4ca-39b36de5658mr6680111fa.9.1782949378486;
        Wed, 01 Jul 2026 16:42:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39b37fda160sm2836261fa.29.2026.07.01.16.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:42:56 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] fbdev: clear fb_info->mode before deleting a videomode
Date: Thu,  2 Jul 2026 01:42:47 +0200
Message-Id: <20260701234248.236023-3-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701231706.234715-1-mlbnkm1@gmail.com>
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-270268-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:deller@gmx.de,m:linux-fbdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:mlbnkm1@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[mlbnkm1@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlbnkm1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C1986F26E9

fb_set_var() can delete a mode from info->modelist when userspace
passes FB_ACTIVATE_INV_MODE through FBIOPUT_VSCREENINFO. The code
checks that the mode being deleted is not the current info->var and
that fbcon is not using it, but it does not check fb_info->mode.

fb_info->mode may still point into the modelist entry being deleted.
If the entry is freed, later mode sysfs reads through show_mode() can
dereference a stale pointer.

Clear fb_info->mode before calling fb_delete_videomode() when it
matches the mode being removed.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/video/fbdev/core/fbmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 2f1c56e5a7..c8aa163b0e 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -246,8 +246,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		ret = fb_mode_is_equal(&mode1, &mode2);
 		if (!ret) {
 			ret = fbcon_mode_deleted(info, &mode1);
-			if (!ret)
+			if (!ret) {
+				if (info->mode && fb_mode_is_equal(info->mode, &mode1))
+					info->mode = NULL;
 				fb_delete_videomode(&mode1, &info->modelist);
+			}
 		}
 
 		return ret ? -EINVAL : 0;
-- 
2.39.5


