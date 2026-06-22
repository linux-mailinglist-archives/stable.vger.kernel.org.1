Return-Path: <stable+bounces-267693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xixsEm0qOWoFnwcAu9opvQ
	(envelope-from <stable+bounces-267693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:28:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 990346AF6F8
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:28:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VkcNBwRI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267693-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267693-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B808A3049962
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97933A782A;
	Mon, 22 Jun 2026 12:26:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E83A75B1
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 12:26:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131208; cv=none; b=HvURhIl9uFK8GaPNAdWV4m0OGcJZrNrmedQ8mNAdDS2F6pdRVujbEPt72W0Mug5Ww1LhPPaVxOO98ENqvreEBKRz+azsM+NWtrqKqyVrKPl0XtfRtIMQx2bNzGNPKPQp0GScJLg5KhP2pw9sIbPkCjiKuAVacqZY8doMcPZd7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131208; c=relaxed/simple;
	bh=TIKUOboVxBUbgvuAaU/tPrbuVSJpeOaGq6YLOTILIcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrjrLuJuOhT8jCRcUiT1lZiC/IOcP7WnoYHTbQMeN7nXLcUJd3vXn9qB8eNRakPW+wtr66Ru5u2GmSMLFeoMkH2q79XL0TNFzgWdAbPOUeXffaXGZdgcT5qiwpScw8xaTyziN6a0Y9+1EFe0NsLfl+Kfs7YuiHFPvOdg+mD8eRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkcNBwRI; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4908b92904fso62822905e9.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 05:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782131205; x=1782736005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEYmqR5PaLPSkckh5kVnG7V4jFZqQSoXCRRC01O6faM=;
        b=VkcNBwRIdrMi5HhQkrUoQSt6CKGumb30rWDeujaM2zTH8MG0ve+fvDW84/fz9FLS+s
         p75gzbF3xoQIDvJTA307aGb9TgW31TtL96oduW2/ZyHNQ63S4VVtKvxHjlJaSX+5Theu
         b2umQ8zorFAfg51S1DnMmGt1cdWEsr4wnR66VAlI9qafdm7gBJH+iVL9f/RgKjnOsvnC
         ebnYfF+uHXAq7ReFwFtrGcYLq+raDgPREBfi1h5IPnczGf9oX1kNspa+8tTr0ziaPKvr
         mV+QRYW1cCs7WIsB5V0HlF3ksKR6p5d4Ktads2nEGPkSGHw4bELcgumSA6EY29aPSpK3
         9xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782131205; x=1782736005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NEYmqR5PaLPSkckh5kVnG7V4jFZqQSoXCRRC01O6faM=;
        b=An+y5z61drw/L0Orammb57td04JA2IwzA00Rd1Va5r/l4jNYqkh6F8BPoDiFfV2J8S
         tMohDfFElKWHkhjVtpDtj4kOwDqhcJZYy+KLN8ULBNva/9XCll3ATsis2n70SXOEFXAl
         vxQBcg4liITKo1Ka45wVTNDuLian8BpKDrmzEfqqvCn9uVISG07BmWq/1LjGkvUdHPwW
         WqyvCnSLj/iyc8qVxZ44hwvRnb/zafBHpu6MGPEXB5YWLMNn2ZQVBMWLNgxPJUXIPuTj
         4jg2jg5qD5baF73m6Pwat39ch+sy/PSR3tOP3oAjlSF73/xBYq78L9qv8zWUYX3s1iTi
         K+iw==
X-Forwarded-Encrypted: i=1; AFNElJ/7BveUKa6pWtRwrn62dR0TyBEKTjJ3VMfQVRMGHgjaV6Jc6213WMS+VglQ7wi1lP7HCNBeIx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziYzs4TyujhAecrMPOGndWuQf+f10ZCpATvXmeky/o0wL8/mCr
	xsYpWfQCB/x2BuanQifcSKtJh70vdk6Z4x6+SQWlQ/Tt0R8ppmg2dqh7
X-Gm-Gg: AfdE7cmXjpeq9FdM87bJzmgLuONP1XY+esIYnB6Azy0p5qpcokHb/rU2fAVd/AR+KLV
	o39ZeKLo3ndFShnNZPbW1xASiiC5iK6tjZzuVD/qyEqxOAjQyVixDJmIviG+SV4RkOvJThoGl8q
	ah5pPcLmhILDBY3Mqrx+PR52FGoFmQvpFB99ED6/PAQc2M5OWo3XE5WZBst+4mArnhgKOzJfo+n
	0D/OyrY9pXUJft7DiZv9dn945gfL38utfAU+MnUVvOxHXoMAGx8wrZFS4I0SU7bgE3KiOXJTDvA
	m4fifpHCLCVT0HtqsM2j70YirsyqbUtyItTRdT/fJzPRiVpemV0wCIMVEFZPKtKliii7OgMMIYr
	TNME7FrJlGiyEYQp92HVKxo8nw4A8Xla1/PMZfZrxBAetW91DK1WRKFdo59sDNS0Idj6ZHdi9SB
	cqgGy9tkQJK1d28kQkI8BsQ0dlqyA=
X-Received: by 2002:a05:600c:b8d:b0:490:9588:bdb6 with SMTP id 5b1f17b1804b1-4924258f73amr192805355e9.33.1782131205319;
        Mon, 22 Jun 2026 05:26:45 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240ee9bc2sm208803975e9.1.2026.06.22.05.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:26:44 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Amit Barzilai <amit.barzilai22@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] drm/ssd130x: fix column and row end address in partial updates in ssd133x
Date: Mon, 22 Jun 2026 15:26:04 +0300
Message-ID: <20260622122604.32500-4-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622122604.32500-1-amit.barzilai22@gmail.com>
References: <20260622122604.32500-1-amit.barzilai22@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267693-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,lists.freedesktop.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[amitbarzilai22@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:javierm@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:jfalempe@redhat.com,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:amit.barzilai22@gmail.com,m:stable@vger.kernel.org,m:amitbarzilai22@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amitbarzilai22@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 990346AF6F8

On partial screen updates, SSD133X controllers expect to get the
rectangle addresses as arguments of the "Set Column Address" and "Set
Row Address" commands. Each command expects the start address and end
address of the row/column in absolute format, however the end
addresses were being sent in a relative format (relative to the start
address).

The relative end addresses work only when the start address is 0. In
those situations, there is no value difference between relative and
absolute addresses.

Fixes: b4299c936d8fd ("drm/ssd130x: Add support for the SSD133x OLED controller family")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index fee35496a324..4e4b879d8b24 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -915,12 +915,12 @@ static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
 	 */
 
 	/* Set column start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD133X_SET_COL_RANGE, x, columns - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD133X_SET_COL_RANGE, x, x + columns - 1);
 	if (ret < 0)
 		return ret;
 
 	/* Set row start and end */
-	ret = ssd130x_write_cmd(ssd130x, 3, SSD133X_SET_ROW_RANGE, y, rows - 1);
+	ret = ssd130x_write_cmd(ssd130x, 3, SSD133X_SET_ROW_RANGE, y, y + rows - 1);
 	if (ret < 0)
 		return ret;
 
-- 
2.54.0


