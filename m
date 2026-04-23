Return-Path: <stable+bounces-240534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEwpMBty6mkRzgIAu9opvQ
	(envelope-from <stable+bounces-240534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:25:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C28456C2F
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CF1D3024141
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52ED391E49;
	Thu, 23 Apr 2026 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjETA5eY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467548CFC
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972077; cv=none; b=OLPLc7QXQvKtGbYaWseayMNA8RnsDxUoAz2R8wYf+EU8lkDmZynlerASWe+e5/+VXrexaETIOSDCe+m+Xhha+Z8ZyVgSm8Hid/AEFjx8Z2pjQdOY6wv1W+JDv0H4fSjo6SD4uKgs7whTswvGI8wTy148HG3VucHAR3chDmWkdf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972077; c=relaxed/simple;
	bh=V1RO7qmNIESq5JTAu2eT4weLTLz/UDB/my05SY9oDxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJ/GftU/mgn3BmZM5cBQicTY4BqK3RdZfrO/VSc5vamW8OgvX/leEg2OjJ/ZihVkRzfPS/kHZlR/j3ByW0miaeb/QaRAg7vRaWjG+uhlKD4Q73IMWvXahn7E3V7rH9OXULHb4Lh8yPb/xmsPYAKbBxoKAW7KUHPxyMtRGUXfHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjETA5eY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so4739867a91.2
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776972076; x=1777576876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FD+mnSjT2GzzjnT7c/+m0+ys37kefIgr9Jgnl09Emew=;
        b=bjETA5eY/H9UvlkerKEpISoAuKhEGtehAYnqAp0ipMwinwqWBep4tFN9MpwcXL3ir1
         GuWooMaDKReVRl93eBFNPl/ELa0G1232Tby04/Y1hE5HIF7OqfFxSzOqolIHbP9YaLPF
         WjopQser2IKuCUf9o+boXXi1cN4wZs7LFAveW8jNLkbMTiz58WUfFrPtrjsYgOYxmpME
         0+UD/g9LdRzldCuV7xDVUcB9o8JAmKtPYrxA8haFZv/fHZkvtS2dqzAN9yQzgAjQtLIx
         9G4Yg0p19GHreMo68SnOcKOD+Dt4IIZRO539zA62P1Bb9/wH/xgN0K5qpHcsPrwSb6li
         sLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776972076; x=1777576876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD+mnSjT2GzzjnT7c/+m0+ys37kefIgr9Jgnl09Emew=;
        b=e3+nvyrUUeg9fT1BQPJOvYpgQsSvXCl6MaaB2xMcNOprsYuvaKPNa8B/xQCpeyjY+y
         5BPzdepclxehvugvLvRGIIP4UuRHHdVpHEr3icWXW4cnNHw3e/mChYF0tSzfxT6kX+ag
         b4kkKTFxXTjlXMHY76QSTEP3TiCTVBXCNkUsKSJkEvXLjGueLScianYaSSuxVNY2Dmqo
         UrLZ/X2Zy4se1vRufgO5dwYIOoQTSvQE8dPY+auo0TX09OdDGyS+PYCFecoufpTofqVZ
         Lb6PK85ZkNOTGhQCPvVXt5m2zDp74lNuqGhw2jk2FbEfTjZA4AbFmNPNkE3cxoP7c26q
         C+fw==
X-Forwarded-Encrypted: i=1; AFNElJ+L9aC0C8UdJ1E7fUslOsLTRqKt8e+SpCkJ0BQUG149HEExP+Yq7cTmfDD9Qtyumupoms6/o9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVF0FcmAFN9GvjuyU2qvR0SyP57/vvUMXm0xfExVUAQ1gisugN
	8z2DSc5PJ6wFB9RwoEOhpf/A5LZ9RHV9wDg+7lFs0+adzRm26MewW9EmWIeH7OFq
X-Gm-Gg: AeBDietoSLcWqfS2c/kpYfwdkNSD7/FwIL4c7mawyOZBK2ztW/uQdKBcPKSfzxTJMyl
	teaaRpsFgRVDbh2zkY0AUcokQgMpGYI9RKfSEDy9gIZQJ7BYZ5BlO5exyir+78FyHKXVbQ2jSh0
	8cengngKDeHzeV0BcCo3ZSMhp0057uT/j/VLNThmvBYP+FJk4QJN3lyaODsOPPVaZx6+tl0JITH
	hpQUj3FzlAX9qIN3cI0gKu7KPDttoBEY+8+hCPnVKiCePAoQR4Y94OhZtTjZd5ws9KBinKwaCG5
	mCzzRF4pxs62XBlHYxGPVRihjJBfpFZ4dbT7BJK9FiO/Cw5cY0fEQmcenOnlbrNgGKDJXtJoRDJ
	/iTTw5HqOyJHcvch5oSFrm5KLdClE8xY6e9hbzaw9zQTp5cZDjSuDpgD40/LQIIn2q3nAjujOYb
	QQAs72J8FGYFD8Yk36uiYRnzrDGD5agkQyiOc0nsYQrB7bD3BdaT/bv90VBSumD4jZ9E9a4q9Fl
	msj9w==
X-Received: by 2002:a17:90b:2892:b0:35e:5ae3:2993 with SMTP id 98e67ed59e1d1-36140462ae6mr27327818a91.15.1776972075908;
        Thu, 23 Apr 2026 12:21:15 -0700 (PDT)
Received: from LAPTOP-97G9G880.bbrouter ([106.51.151.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141898ebasm21101867a91.7.2026.04.23.12.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 12:21:15 -0700 (PDT)
From: root <karthiproffesional@gmail.com>
X-Google-Original-From: root <root@LAPTOP-97G9G880.localdomain>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: jdelvare@suse.de,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Thu, 23 Apr 2026 19:20:45 +0000
Message-ID: <20260423192045.5729-1-root@LAPTOP-97G9G880.localdomain>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240534-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.de,lists.ozlabs.org,vger.kernel.org,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[karthiproffesional@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,LAPTOP-97G9G880.localdomain:mid]
X-Rspamd-Queue-Id: F3C28456C2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Karthikeyan KS <karthiproffesional@gmail.com>

snoop_file_read() passes the userspace count directly to
kfifo_to_user() without clamping. The kfifo backing buffer is
2048 bytes (SNOOP_FIFO_SIZE), allocated from kmalloc-2k slab.
A read larger than 2048 bytes triggers a BUG under
CONFIG_HARDENED_USERCOPY:

  kernel BUG at mm/usercopy.c:99!

Reproducer:
  hexdump /dev/aspeed-lpc-snoop0

Fix by clamping count to SNOOP_FIFO_SIZE before the copy.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b03310c0830d..5b59e826cc68 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -125,6 +125,7 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
        if (ret == -ERESTARTSYS)
            return -EINTR;
    }
+   count = min(count, (size_t)SNOOP_FIFO_SIZE);
    ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
    if (ret)
        return ret;
-- 
2.34.1




