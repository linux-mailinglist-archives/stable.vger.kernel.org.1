Return-Path: <stable+bounces-228111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ//MblGwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-228111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:57:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC9B2F3797
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67068301C57C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C423AE19E;
	Mon, 23 Mar 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFjIkSLb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8853AD534
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274156; cv=none; b=ADdwwIzIIQ4U+aIhDIMfL/LTig5srSiPN4byWmRiKF9HbXcTvHpUSYfdwrxFyuRKxme8UB93DHjQ/15CPxp+sWNwMyvtcm/k0gxOF6tkPZzlR7jP3/Psqm6NgdqlPMbOpFr0jV46GEma8QCuDGsmjMUJzuUkfQEaaPcHzFN0Ksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274156; c=relaxed/simple;
	bh=ptUbi7coE8TiCTgvjCOJdhXmMm9zZV1RIxnNmpsvNUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eN6/u+zOvgp2kJ4rJCA487tCKRt+aTJ5epMK56/5jMKMbOSU5t8yGwQFTSWnN3cwkusvG2PEvLGfyTEE/772fGxcAWByw1lkce4uJ50zqoqIoe83qCD1z6rEbztCcvznfslTMNGaxUT1FNZMf8ejjn+X/ott8RMb8bGU8tl77ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFjIkSLb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab46931cf1so43817375ad.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774274153; x=1774878953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gX403DU43tnkaleCen3mlLyVekGcaUJRBonPOPbGQtY=;
        b=SFjIkSLb6hCeV6O6C0rMZn9Ic10VRNRaECLQK/c2sn6NWaZgQUEKdAr406SoSmeybA
         4ZrkRBXuiQ68yXXDuqeCt6gYZ3oDHRaZuTr8nWD7xfJxBhEs5cgfXXwvGWnbdUJpBZFi
         Uv3x7AxkMJPm1VB+SlWCjugJVtQNqXphz9NU34oCJ/jFtP4LD1f9a0jt3rfQQ0ryXLhR
         vKAHVsMEMtn6CVqM42/umHMRZQYtU+nKOjoWchw/3RFy5zIQJTkWPsRc0Ya0LKOxueGX
         JzBcQS9q5j5oNnEZbErXiOZulbOrdZ114gyYzpIe0TdEVxtKFOSaJBIYEE1GlnwMzPym
         jAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774274153; x=1774878953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX403DU43tnkaleCen3mlLyVekGcaUJRBonPOPbGQtY=;
        b=BDjgF+8lyUZiXhaDOREX2m7HnEwnV41NCOB0jc7dyVfvP5Ma2nA9GmBGsG/InkMkY5
         bwSbteUtbSxAPJoF48WDvLYVYkBdn9S/7NuM69q6ezDre5ka1KSfuxHWdcSA7u56CXkX
         D+PL5yezmHjG1dTG4sY/mU/VBbObANWEdwJlFSZ+bhE0SKjfD9eYrkt/DsSHw8q0QBWC
         ayizgUwvittleqi6Qel3EEk41zke2yrcf9L/mJrKJmggeIIOv85DiEj5GtLHcGQiW+4O
         uih17ZFwVG9EOLzz9PrIdE64DehbI1qnzfEr1lSpBeB8avJ3yALiw2LSFMLqn42KnOv/
         wvQQ==
X-Gm-Message-State: AOJu0YwFKKWjQhnMqpt3OGQFD3+8lrGx+FTte1dNFDTtR+WicwNMKKOu
	mJhnX6m5JT62FXYEQVuAqV1UX1+wGy/2je0EUTPcRgjoYtVMlN1oEDIV
X-Gm-Gg: ATEYQzz/Bhx0GoY1i2MpbRmuqT5PHsl0tCcLZ6H33yLLK7pk6LU7RMd4iohz1CFvL7x
	WgE6Ezv8b9yXOtO55t4qUeW6tzPv8hQTwbLII+INUx0xwKMAGPvGCorqABVCkUvN1C+aAQ/q8ZV
	R2KZzrZk9DUjsYWhqwu2rG5B4UL7fGTvGVMofcOhGeMt9TqL0Jm0dmtzkZ82nM+6sKcqtVHR6/b
	CZRdq84OOeFL6moKYjSn2vrL3Eqf3bnBg/zzNHfKifQLUfO/3dIqGqRRi3B7IsXVI2z48Yf2jtv
	qD4mL4ErJ+4aAU8TDx1ugVCAWezhrrY6+9sKyOEKOwxsdY3tW2Ikoqfs19eDsmsKuwud5PsH15s
	FftClQS03Wy+DH6HqavEXyJNziviwticQpZS6vi6g1AuSOP2VDpcRsKmVtWp2HUScymVMOWpiws
	50yLwWig8PRMYOsa8Wac0s
X-Received: by 2002:a17:902:db12:b0:2ae:7f85:33d1 with SMTP id d9443c01a7336-2b082636715mr116185785ad.0.1774274153320;
        Mon, 23 Mar 2026 06:55:53 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083527f90sm108967095ad.19.2026.03.23.06.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:55:53 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Adrian McMenamin <adrian@newgolddream.dyndns.info>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] maple: Fix refcount leak in maple_attach_driver() error path
Date: Mon, 23 Mar 2026 21:55:40 +0800
Message-ID: <20260323135540.922928-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-228111-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[users.sourceforge.jp,libc.org,physik.fu-berlin.de,gmail.com,newgolddream.dyndns.info,linux-sh.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BC9B2F3797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As device_register() calls device_initialize() before device_add(), the
failure path in maple_attach_driver() is reached after the embedded
struct device has already been initialized and its lifetime is expected
to be managed through the device core reference counting. However, that
path frees mdev and its associated resources directly via
maple_free_dev(), rather than releasing them through put_device() and
the normal release path. This may leave the reference count of the
embedded struct device unbalanced, resulting in a refcount leak and
potentially leading to a use-after-free.

A possible fix would be to use put_device() in the error path and let
maple_release_device() handle the final cleanup.

Fixes: b3c69e248176 ("maple: more robust device detection.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/sh/maple/maple.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 6dc0549f7900..20b7c2cd852b 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -393,7 +393,7 @@ static void maple_attach_driver(struct maple_device *mdev)
 		dev_warn(&mdev->dev, "could not register device at"
 			" (%d, %d), with error 0x%X\n", mdev->unit,
 			mdev->port, error);
-		maple_free_dev(mdev);
+		put_device(&mdev->dev);
 		mdev = NULL;
 		return;
 	}
-- 
2.43.0


