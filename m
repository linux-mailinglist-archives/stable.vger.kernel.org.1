Return-Path: <stable+bounces-240176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHrhCn2F52m+9gEAu9opvQ
	(envelope-from <stable+bounces-240176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:11:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9827543BCC6
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E6633018638
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD293D7D79;
	Tue, 21 Apr 2026 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhcDVgzC"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679D3D6CB8
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780621; cv=none; b=nLHDABbgipbrbeUdwB6Hr9huvYjcXP0gixGMUueW8/Rf+Mf6lUjS/AFskLPZErKIxqMjBoK6Bw/WWr2vsIXZt8ont1hwvNGFIha+W+jj6vtHBfdoMdW9wdD644WUkjpKxMb5q+co9cEZw4uv2jn6RGTCZOrNwbchEG6wTTJlk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780621; c=relaxed/simple;
	bh=kIm5kH85UH7+YNKd5iqnnO1F9CcZhlSMdP4GNhN/Tck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUP74w+X3yTpygz/H1AAI8VNIXGnvzL48ABMR5fqT8UarzHxURYmBxPkuJigDWo+UKR2ArhwTbYrEaXrEmstxX30zpHxJ/R6YzMYHnqxHBibhCONF265dDvllNCFVPQZL64xaknTc9hfD0B68BcGIgcWkuE0EMmrcAMfT6htvcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhcDVgzC; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12d4bed3384so1635189c88.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776780619; x=1777385419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qY87NJeBopBZl+AvWsat0W4p5pkhAeY8QFNi7OA2YE0=;
        b=YhcDVgzCYZ9mHwwA07q2HfXzqGm6Tfld5Hlt+8ux6yxRh2gL/43tYtShuSiZ35XxUG
         jRMV9Go/GF6JmNISgFfq28ZSEzTfZKfMwYcDCOIChpMkl0NlS58bpsX/l/Fq5rbiKrQq
         KLbKlMOpOWizjYaYUHaoBcnBfZMdb32HpN5lq/PHoKeFHC/TaMHZg+Dv3jBjrGKVZW3o
         4n1BZ+bO/4x8+OwJT9nbEDdVK5kDRfyi2EfOIiyMOCCVfVTP2S4/5LnIqPVsute6DimE
         hdfZ7HVGoxDt36h2Zx71+fa23TO8qBD4BSkr/p7bT+E6dyJd3nxuy40CmlgmivYL9G3u
         /zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776780619; x=1777385419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY87NJeBopBZl+AvWsat0W4p5pkhAeY8QFNi7OA2YE0=;
        b=GqgX29jetND9aHBDaHaxE13GnIVF1HcWKfgKyuZdrW0pMACUhT5PADvsW060VvkHXT
         6+EgUrKOPLukjju0EnC+nmfXt0O4RGXkqK5unqLdVrGeFIVEAeLAYpPEKBpPYHnPmkkx
         VklfJoiLZ/UEgfozWR5YG0a7A7nwJ09wbojiM46gn0MVgVDKSO7JP4rZRJv9LPNZkkn1
         fUdBxwoLj83MsdBZ3Lsrtp8cs+u9vhEaOBw0tcZxCRMISaO4OQIPTXYDYYUdLz70GpGa
         qT9gXoVgKZiMSPWYP6aKCyMwj3y0YK/jCs1wW4jSaqyLkguiZq6oMY1QKISFVt2vjksj
         eSkA==
X-Forwarded-Encrypted: i=1; AFNElJ93L0IdG/L0Hsl/lWFJsL4MyfRO074RnJxMdPu2YoHmCu8D4N0jG+17aHDCogbE+qaxjcnYUTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTx1PwnqiisuIlLsUMAgU0sSMMucW5GvLZQX5htclLCb1XxHOV
	TxRyD67SY0R/eeZQnkRNiJ6++SCJ8itFC8TGsodl0m6sp+ckzgZI5EYKAt3KGPRHz0S0mA==
X-Gm-Gg: AeBDievrcihydSYgdcQDAz3komMH4tvm+3NyHaNK/xkFFya8Zb5T7hAaMa8KhDH6uP7
	9FzoCzfNoIxEiu56mx1/ivTLM4tuAqzuSoX9jK4XjZCKtTXVl3h96Xx4b1fJBYXCSPoSBDOusZc
	TlYAkk+4uWf7DdBolQdBhqFxnZlGagXsb4+kacWd8SkE7xzbJAclSXvq5dYG6ChSF43UW+Zo1EV
	ZbNaTbmHyWlIINhVJdM6tOe0PQ783TSGEIDe8yjgD2Qe8v7XwJjCjJ8EDVcnXtdlmS0+nrBW9M1
	z3STsCvWwUoFzRfGHmWIub2EIh6qDZVrU+4zeUyuz/Z3eNDt/5Ayj+Cb0JKSJux0PuXJKrBlJrM
	QMKnZoVz4ISXpCmCfVfIYmB6X94SBct4jj+m1o4/iHDIwrO24mbOrVqkHRkXorjhEaJ8xQuP83h
	rQmE0E4IgvtxnHjJhEX++Ew2DxbY35RuCvHGBdmvferdypnu0TNR9y2IdxwmgcQNnpkEG+UNsyW
	tgmwYcQ
X-Received: by 2002:a05:7022:6988:b0:128:bae0:e03c with SMTP id a92af1059eb24-12c73fac23bmr9805997c88.30.1776780619321;
        Tue, 21 Apr 2026 07:10:19 -0700 (PDT)
Received: from localhost.localdomain ([159.54.180.171])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm17997432c88.8.2026.04.21.07.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:10:18 -0700 (PDT)
From: Bingquan Chen <patzilla007@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org,
	Bingquan Chen <patzilla007@gmail.com>
Subject: [PATCH] usb: gadget: configfs: fix 1-byte OOB read in ext_prop_data_show()
Date: Tue, 21 Apr 2026 22:10:10 +0800
Message-ID: <20260421141010.5607-1-patzilla007@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240176-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patzilla007@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9827543BCC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In ext_prop_data_store(), for unicode property types, the data buffer
is allocated via kmemdup() with size 'len', but data_len is inflated
to len*2+2 to account for the UTF-16 encoding and a 2-byte null
terminator. The null terminator is not actually stored in the data
buffer.

When ext_prop_data_show() reads the data back, it computes the read
length as data_len >> 1 = len+1, then does memcpy(page, data, len+1),
reading 1 byte past the allocated buffer. This is a slab-out-of-bounds
read that leaks 1 byte of adjacent heap data to userspace via configfs.

KASAN report (5.10.252):

  BUG: KASAN: slab-out-of-bounds in ext_prop_data_show+0x4a/0x60
  Read of size 9 at addr ffff888005546008 by task poc/62

  Allocated by task 62:
   kmemdup+0x17/0x40
   ext_prop_data_store+0x52/0x130
   configfs_write_file+0x168/0x200

  The buggy address belongs to the object at ffff888005546008
   which belongs to the cache kmalloc-8 of size 8

Fix by allocating len+1 bytes and null-terminating the buffer, so the
extra byte read in show() returns a known-zero byte instead of
adjacent slab data.

Fixes: 7419485f197c ("usb: gadget: configfs: OS Extended Properties descriptors support")
Cc: stable@vger.kernel.org
Signed-off-by: Bingquan Chen <patzilla007@gmail.com>
---
 drivers/usb/gadget/configfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 183a25f65ac8..a1b2c3d4e5f6 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1352,8 +1352,11 @@ static ssize_t ext_prop_data_store(struct config_item *item,

 	if (page[len - 1] == '\n' || page[len - 1] == '\0')
 		--len;
-	new_data = kmemdup(page, len, GFP_KERNEL);
+	new_data = kmalloc(len + 1, GFP_KERNEL);
 	if (!new_data)
 		return -ENOMEM;
+	memcpy(new_data, page, len);
+	new_data[len] = '\0';

 	if (desc->opts_mutex)
--
2.43.0

