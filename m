Return-Path: <stable+bounces-94673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACFD9D680A
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 08:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50711161273
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0F917332C;
	Sat, 23 Nov 2024 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cure/U5c"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8CF16EBE9
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732346489; cv=none; b=sVhWA0mcNLKtduWY1ehllesBLImqRluAr7RobakSESXtsDTKnVa+I6k3IPJJLVOVHB178+vjv7ZMRieNnFcUv6anpE6SAXObsB1kC0NS1naB+x7vtOsTq7zJtTol5tKUuudyHqm0xvXgjUGGPg6z8Z9KU6TyQlA8u3wb7a74jdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732346489; c=relaxed/simple;
	bh=+z64crTzMeFzmw/jT4jJtpA1lPJMidF5DLwvfUo6cww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSgpom27b9t4Bx49yaxJnbAQHY1AZwB6VXGuU/aXEoeUAl2sdtShYfinT4r26IjLLtci8MyKgqttIvQk4kYz8F3CGTuLmRYk1BOaitKCoPpuR8J5RHsLY3oLLwenh/Xg08hzeY3r95fIdtJ4Gw6t5LHLWdoy/pBgQ0GMCB1z6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cure/U5c; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so460689766b.0
        for <stable@vger.kernel.org>; Fri, 22 Nov 2024 23:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732346485; x=1732951285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y2CaneH6LYbzywEj7ypEqXyfCm8sgyQdgBr9xERX0c=;
        b=cure/U5cxm5en35gQes3hMT7f/thZI9c1WrzfpucNtjCrKpVKNB+rTvZcBNZj4HxIQ
         v/T41UDX9E3LVHbZpRIyVZBVbwT48LhoApD2TgYPrhoC2rQ9fKnY50Wbw0jtSytTO7Ae
         MBC8a/+hX8aNhfFPKqiVjwfSllJytrlcnwczaI6zLUMgB8UtBP58bBwsS9/0W1LlX5nO
         MP8/ULSCOPCaMxpzf5RfCzUTv0rVaM4XApcnuLxR4xO6glOBlZVhgb1oBex/MCkAyOxs
         MZT1MoqHqkcC06SWjmpa+n3PNj+glel6tPJmEtby5seWdVFL6Xjkl8jLC8RkGve/iIiF
         ZseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732346485; x=1732951285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9y2CaneH6LYbzywEj7ypEqXyfCm8sgyQdgBr9xERX0c=;
        b=mwIXIriMBPw6q0r27gEUE4oBWI2OoQVTDOW0beUz9O1HBi7Aym+x+5Y88LvczeODry
         xMIq/bYD2rm96Sz4++yPgfqEPXnEFokIha/DuLAC8nv8q0400ACvr3MC6lg7IrGKLZkZ
         Vvl6J5dYHFg6bpPCaQpmjUTYdfbiFuqzMZAkP3TQ6UYDfeQsyursrWK6fhPWSLYbyWUn
         iYZsovr8GkMUkKieXPwRod0jT1znQqckqaeGCzMPS4lEm5OIlErIxcd+eECD4/uX9+vU
         Jjkwsdf4qsp5XqufQuMQZ5zwL87cN2gyx9wjaUw1SB6kN2i5K99RJ/ZwGsQxBh3R7e4V
         ep/g==
X-Gm-Message-State: AOJu0YyDHzQRz2h0AeJiK/Hi5ySQA6EkLfuGK04v/+4ZcXxhYNHAu/Xe
	X+CgIZ8+IkduYYswYgMnyIQMvDRy0v0U6e3QE1zkWL4nrcChoT9hs90j3CdNtzw=
X-Gm-Gg: ASbGncvcC37mPx/m5n4bPdNJaAn3+hMSP8t4/cBBqdYr4XMXjfk7uGWvmyyvDvCVAZU
	A6/z2ktJuth+5LXpUljkGDIp7ZMrauc2nzV++gWH42miyD6y24ImeU6FOvdpm9b7cQvbJs7eY+j
	a7DVYQlFMF2ZHDBV9sdXD2vKXDqIC7mE5ccQPqRvnA5vMQ4T9XLD676GElTulUvUljsFNtAfDIU
	2uTmySDe2ydmqI9ril/SI1zvy7Sojoe7OcMuB2rg24s2V3ox+8K206IqGxhko92FfhhhuYrm9ds
	P4D9uZCVd83iWglmK5woPqftBxg5EsQBpvLkrnUYhEN6vEBL5Q==
X-Google-Smtp-Source: AGHT+IEY8ATKSUaTZnvSh1YYi/SwNKyCxkgCkPA+YBufTqzJcf0vqiSyrwM7memjfbxXU05UWPkOww==
X-Received: by 2002:a17:907:1c8e:b0:a9a:238a:381d with SMTP id a640c23a62f3a-aa509d7c6afmr559551466b.52.1732346485043;
        Fri, 22 Nov 2024 23:21:25 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f12b600023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f12:b600:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01ffd96e4sm1590029a12.60.2024.11.22.23.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 23:21:24 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 2/2] fs/ceph/mds_client: fix cred leak in ceph_mds_check_access()
Date: Sat, 23 Nov 2024 08:21:21 +0100
Message-ID: <20241123072121.1897163-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241123072121.1897163-1-max.kellermann@ionos.com>
References: <20241123072121.1897163-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_current_cred() increments the reference counter, but the
put_cred() call was missing.

Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e8a5994de8b6..35d83c8c2874 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5742,6 +5742,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 
 		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
 		if (err < 0) {
+			put_cred(cred);
 			return err;
 		} else if (err > 0) {
 			/* always follow the last auth caps' permision */
@@ -5757,6 +5758,8 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 		}
 	}
 
+	put_cred(cred);
+
 	doutc(cl, "root_squash_perms %d, rw_perms_s %p\n", root_squash_perms,
 	      rw_perms_s);
 	if (root_squash_perms && rw_perms_s == NULL) {
-- 
2.45.2


