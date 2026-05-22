Return-Path: <stable+bounces-253716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLGaHMYaEGqlTgYAu9opvQ
	(envelope-from <stable+bounces-253716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:58:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EFB5B0CBC
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0C6302C5C4
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF58F3AFAE2;
	Fri, 22 May 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad//hpu+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE13AE707
	for <stable@vger.kernel.org>; Fri, 22 May 2026 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440218; cv=none; b=PHuVomfZb6vL3xiGlRaZbgz8t/iTndIul5qMXEQhBb35iMY3FJuYirZwKPpVwNdV88zJyimRV6IHupNOkTB2KLyTEPeIvUFOlu/irvh0wFGSUmpCYO8tqE7mTbZxZm5yXuqmXGeO7CoTrnEifCkDF7DJeoxYFuwtTEMw0wLUu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440218; c=relaxed/simple;
	bh=gOmun+zN7RztrvQYSyqFVJChn6F0LABtiPDXJNCLz18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O70VHUphUgVaq72yWBJA8HT9VDE9O2vU7PlXUG7XRuAUOmD3Uanb9weUqIdURAJaXptoReO+M9uVIKC/wLHViShMTrlQdGppl9zW72tnrG/Xm6zA8x4pdXLrXhNByoMCGaM0n2tz0ImPq0Gd0CQKjWVccXN0FtegX2omK8+ef8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad//hpu+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so921070f8f.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 01:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779440213; x=1780045013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIcMGzBSx7pwGWEOrLxy1VclzIMHdDoOsNUMGRX9Xl8=;
        b=Ad//hpu+vnPvZgHRwr9Slih+w99gk16GDDLD6eG88h9cWfwt9VizzZzUHWv4Qc3uIB
         OWYjDzhfd/7pXferr0yJHGPDZrZfnA+0hDj2hTDYE2SEu7nXQ8m0aG7EGgKvfq92vuAl
         Jah6vAkGc5b5UQTmkGEWy+XzNKPk8u/urmPId4uQ648wAh6TvNX8AxQh3ZtLCPnbEh72
         KUUqgQ/fYydq6DXKHVBZSUUy86zautqL+xnTr5ccW0trbpsQftLHcCOTnem7NMj0ll5R
         8JogpP+D+6DF3jSmjuwmVtJT207aIEaXlZmUh4Xl5aVbpeZ+QI0PMdRG+leAV6zzDHIB
         XkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779440213; x=1780045013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIcMGzBSx7pwGWEOrLxy1VclzIMHdDoOsNUMGRX9Xl8=;
        b=N9FfFLzZqJtRtSQJz1msR0e0jZ072rvF42pDmqwatLHo0xDEQVSZnZqxv2i69ALYFE
         gJjTirSoD1CR9EXrPudReppGcvV3+uxdSwRiCfCGVa2aDMAr8KU4CH4hzdodV+r59bZ5
         YjazIJVLJn5SnEwK5wGssK8ptOjD5LPxJeoN3+sQ0S5mD0JUmQbxXwhuLhsqu6vgcuQX
         sJCE3iqzEF1bv+rlW5Rwfbw/n55MGWpl0eDTjReLVI8M2W+qkuxDdV4Gm3IRgEG9eubW
         lxcS8LbpG92lC80Fmu7QnbSPSmo+x89S18bt1BVPg7qs1ImECpflfHuH/WUsgHdcYVi1
         ORfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2JvSbkIb5o2eXXBzpXo9Q2smOTZHXQvUNfRRQFwxRRT0H32SRBjq9VCbRILQRNUsfp/J8rGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/afFX04SoN2uUUlx9JNBeZD7vHyhhkLFm9L1m42ex4on2HVeN
	SjQgQCob7ljSr2akRxtFukR2GGUhJb2E7bFpyAO2kBM0YovbDO2yXmdt
X-Gm-Gg: Acq92OEW5dLmtB/9cjSW4YdzFfvTVKLB0WYUWmeoDQyca8rpT4UEGEYq1eym2HwX9Xa
	FnFUUATUu7UAjweKFqmw1R7lA0FX9qCARcT/1k54HEOG7KkVDjfqRnji3qKb/uPaJhNSRo6Bcf0
	FnimkzGitJy6RhDrhMYQXP8Jcpvuy0jdiIvMNMuEoF2KFTk1GbTIuhpmeFGiKLdRP/wxOJPmrnl
	Y5fZmwAxhWSZzbpKM4vrRNW9O2oghKkBIP11KMCpOh/53a56kQWSJm+G/QAhEugscG5pMn5B3Km
	ORsq4Ersg36eabnrLIEO+qanZ2Ib1jUdwT31iDUCchaxq29cl/A+iCtuTcDR13vrOlFJC00bevO
	zRnilPf3nbTFTcF6OfIk18E8dW0zRmXd+o7FOiQVrEKYc+EKpNcVk5v3X3dxLMzKxY+TgAsMsvt
	VMzT7DyZux507jIuSVH9IPmuE0hhpw7ZpOBdvboIg+9/7j7mRDGxRa1oE2DESaSboY0/bc/tp/b
	A==
X-Received: by 2002:a05:600c:8b77:b0:48f:c8d4:487a with SMTP id 5b1f17b1804b1-49042adef79mr16696695e9.8.1779440213032;
        Fri, 22 May 2026 01:56:53 -0700 (PDT)
Received: from thomas-precision3591.wifi.univ-lorraine.fr ([2001:660:4503:4242:16c2:6758:c5ad:949e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4904174a145sm18607125e9.0.2026.05.22.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:56:52 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	Sanghoon Choi <csh0052@gmail.com>,
	Kees Cook <kees@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ims-pcu - fix usb_free_coherent() size in ims_pcu_buffers_alloc()
Date: Fri, 22 May 2026 10:54:04 +0200
Message-ID: <20260522085412.45430-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253716-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 14EFB5B0CBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The input buffer size is pcu->max_in_size, but pcu->max_out_size is
passed to usb_free_coherent().

Change size to match the allocation size.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 4c022a36dbe8..7a1cb9333f53 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1624,7 +1624,7 @@ static void ims_pcu_buffers_free(struct ims_pcu *pcu)
 	usb_kill_urb(pcu->urb_in);
 	usb_free_urb(pcu->urb_in);
 
-	usb_free_coherent(pcu->udev, pcu->max_out_size,
+	usb_free_coherent(pcu->udev, pcu->max_in_size,
 			  pcu->urb_in_buf, pcu->read_dma);
 
 	kfree(pcu->urb_out_buf);
-- 
2.43.0


