Return-Path: <stable+bounces-240264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAmDHtM36GkbHAIAu9opvQ
	(envelope-from <stable+bounces-240264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 04:52:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D04444419F4
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 04:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C05D73077E20
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 02:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF139182A;
	Wed, 22 Apr 2026 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZpQO593"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79539280D
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825578; cv=none; b=irjjOJXZnaHLsjl/j1sILAFiPXcvr1SF/w65E75qlA/l1UNAOul5QhvnzWVxrtuBxY9vw+mvKuZXRrArIuxhqjCARCNTv/U2xO4co1CmMHal3rnTCXiUKX8GWBxLKwgiuwE6ZSDhjGAKAXzqN2pv1cggYHshbHzjjrLPcdUkDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825578; c=relaxed/simple;
	bh=yGfvG2cBrEHidy4K2K9IqvK7y2YzIga4aXzMCqEx6Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ly0RyjcjooGg21OkGUKPR1js16Y3wqg4odMMR7Rs6rmj5fffWbnDPqx0PtOWTd0PEIX59ZTUUrumlIkFBXJm6zwyu4prnCcI2zZ8s8VgpzS3u6Rf5cH8QeMeRpLN97DC1lkPf2IVhHTrYdmHDOvKcfsUdJG7BmugaG/GtDvTCQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZpQO593; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ab46931cf1so41608865ad.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 19:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776825565; x=1777430365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIzrzYUxwj+eWN+y9Ww82vKCDAA7PiDEJITHsFxKlBM=;
        b=ZZpQO593G6+ys2LgqHXSldPqAnbOFvW0Wgd2EFBtXvxi5Oj+5lovD6gBdp+eOe08l6
         bm1W0KBMDntwkD6xtNTzBBYUXUrJcYX2uOQ6j6gLG1NDTHZr5PgteIrpbnpLC0tAfVC7
         a0tq8X05i3Dw9Xk7r3LIiRPNbM2oHmUsglB1uCw/ZXKWKTcFZBf6UQSXNUd67qDA2NX3
         DLAjSPWEYsNvpHR8mJdIlem7rWotgD7OdyJim6oJP6QVB4nQE/KyMvbCFPyv/dG3rwo6
         hKpa3FbYiviMqUgNoqwowaPZl1qYxAL2yKbsRXyRi3dQOD0QSOkoW5chCPh8tVhCIyGv
         iKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776825565; x=1777430365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIzrzYUxwj+eWN+y9Ww82vKCDAA7PiDEJITHsFxKlBM=;
        b=Ij4l5MwIO9KDlpd5BQca7mLIW7W2HpBdd1DR5VmD+rAHEEIh4vi7zcLzjIhILVtnUd
         +UEJpVCD3OEOjdXCFdsA/MN0/ENgYoMGc4KnjC96Ibx4T1vPjOi6cJuWvXiuNdlQY6/W
         qipOKQrdt9L7+s8/Ti1/C/yfZ1jP1lQ3JeIQRqP687C54gNL5MqLQvrdCXKBuEyfyW/c
         3rDJFijlmD7TDoMjO8bnfwsWxtIOVH2Qp6uqO1j+4vF+Gc6sGUYnyzZF4yM9xu2UWFO/
         7+/okE/twlQGzbfxQGeA6TN4SqNZKy08PSAgIA+hsVyTygPZzzgfuX8rQUx2sOAJ5q1x
         eGAA==
X-Forwarded-Encrypted: i=1; AFNElJ8Xfb01MUXw09pzmxU6qm3Myzg3f1TnX7rBUbwHYArmT5LGWC39mO6/C8+SyHmQE0lk4Lt69Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqfJ7Vc8aavYjIqKBOWj2uIT42tDVMghPsl4V6uCiQ60UGBsDM
	KwPkDjwGAz1q+lVQdoVHvbfoQ2gQpZVuJQCv6ZQYF0VFULDLZ4FHCZe+
X-Gm-Gg: AeBDieutVAh4ez6AB8p6wJywTRzJBRyMBdwX0FRl6J0pNErzKQ292sfVvAP2WEWoX/z
	aSbKHChf2129LZdrTEqhbQRXs9LTZiwh+LUwKd/DwdwMb8tI7umXhH3TNpMvK3zXNg+xeFYPz2g
	K7l5mR61fAMSsAtmPfQBT2nx2pYdTfbd0hv7WZrEWkj/UER2g+bslnR5G1Q1aBKJinAXId6XU5z
	EbNeJ6ZoMB4ftFZ2iK4axG0Pc0j3S/ld+rpTBVtOrAWPXHM1XfUGF11ap+BWRs2w1G5aW2sKARK
	yPC/wDx5BV4Vs3VmiZs8LKsu5lhPZAZ7QqLFAsBJTHMb7BjDmMZ/lsh+gScrE/RDaUOSa7WJYzA
	qWJ8Y3ZiYhnJtlluqjVA/vfKpOBzjtmcZHCNLzAZ2XSxdlHlDB3I3FN9Wd2dedr2Skm9537SCC8
	0D/bGqUdscMFjcRjNbYxd4TF2Y8R0NUDk6W7+P+1wV3CmyYj+BekT1xZ1kf5OLyZMWPItffe3eG
	kz3q5iIhA7DaPTA
X-Received: by 2002:a17:902:db11:b0:2b2:5070:8b with SMTP id d9443c01a7336-2b5f9da50b3mr187447215ad.1.1776825565303;
        Tue, 21 Apr 2026 19:39:25 -0700 (PDT)
Received: from localhost.localdomain ([156.59.4.114])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab28e35sm147548145ad.64.2026.04.21.19.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:39:24 -0700 (PDT)
From: Bingquan Chen <patzilla007@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org,
	Bingquan Chen <patzilla007@gmail.com>
Subject: [PATCH v2] usb: gadget: configfs: fix OOB read in ext_prop_data_show()
Date: Wed, 22 Apr 2026 10:39:19 +0800
Message-ID: <20260422023919.37588-1-patzilla007@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240264-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patzilla007@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D04444419F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In ext_prop_data_store(), for unicode property types, the data buffer
is allocated via kmemdup() with size 'len', but data_len is set to
len*2+2 to account for the UTF-16 encoding and a 2-byte null
terminator, as required by the Microsoft OS Extended Properties
Descriptor specification (dwPropertyDataLength must include the
terminator).

However, the null terminator is never actually stored in the data
buffer. When ext_prop_data_show() reads the data back, it computes the
read length as data_len >> 1 = len+1, then does memcpy(page, data,
len+1), reading 1 byte past the allocated buffer. This is a
slab-out-of-bounds read that leaks 1 byte of adjacent heap data to
userspace via configfs.

KASAN report (5.10.252):

  BUG: KASAN: slab-out-of-bounds in ext_prop_data_show+0x4a/0x60
  Read of size 9 at addr ffff888005546008 by task poc/62

  Allocated by task 62:
   kmemdup+0x17/0x40
   ext_prop_data_store+0x52/0x130
   configfs_write_file+0x168/0x200

  The buggy address belongs to the object at ffff888005546008
   which belongs to the cache kmalloc-8 of size 8

Fix by allocating len+2 bytes and explicitly zero-terminating with a
full 2-byte UTF-16 null terminator. This ensures the buffer fully
matches the dwPropertyDataLength semantics (len*2+2) while eliminating
the OOB read.

Fixes: 7419485f197c ("usb: gadget: configfs: OS Extended Properties descriptors support")
Cc: stable@vger.kernel.org
Signed-off-by: Bingquan Chen <patzilla007@gmail.com>
---
 drivers/usb/gadget/configfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 183a25f65ac8..b2c3d4e5f6a7 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1352,8 +1352,12 @@ static ssize_t ext_prop_data_store(struct config_item *item,

 	if (page[len - 1] == '\n' || page[len - 1] == '\0')
 		--len;
-	new_data = kmemdup(page, len, GFP_KERNEL);
+	new_data = kmalloc(len + 2, GFP_KERNEL);
 	if (!new_data)
 		return -ENOMEM;
+	memcpy(new_data, page, len);
+	new_data[len]     = '\0';
+	new_data[len + 1] = '\0';

 	if (desc->opts_mutex)
--
2.43.0

