Return-Path: <stable+bounces-107867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B73EA04522
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 16:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B3916165B
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162F01EE003;
	Tue,  7 Jan 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSH7W7D1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5B1EE00F
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264920; cv=none; b=Mp+P6NOtf3+KKrkHMWHgCpRXvEgvqLo/mZho0GjIQWUYbweK/BqA6Dhtr8QE2N8voMmvOFrgeoiwjeA5lIdyKjwBf+nhGLheFjSZb07psZk3XhbxD5s+7N/fjtFqZn0fuyvVfMrtTH3BKXUshpyD5AIt2J+PP9WA2lSOpdhtfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264920; c=relaxed/simple;
	bh=zHSxnQvEb8UZztbuDFW1UWtGRXNHr4k7c68bvF9k58Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OdAPUP97Yk/72NvEYQF8hWyunRYc4fn8YX+kTzonOpYzx7a9g1Q+DTUKFVA1uUQWlyGoC2Q0Gbkm/MrHuchdT6aGD/+2Ek45+7lHxxRDMtgYP+tdOnjs6BJWyHIOmfAoeQmTPHBdjjilgOG2cM8IccS1Fb0G3cTSDyuaBoDFfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSH7W7D1; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38637614567so7194630f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736264914; x=1736869714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTv0piVgUC+YB8cY6nEGnXIfNYGA4ovWnbmblZRjSGs=;
        b=HSH7W7D1+Z4c/6MjimOrfxw3SestdHAVNhcmJYGNTyT9Gj2VfPPZPEl3evb6iUeSRi
         EnoZy9wZdSWd3VJ6OwJ8I1GxJIu8TVDDjUMG+wzX2/M0Hkf+7eXz3ySaZ1dqx8g0K1De
         pKDGh2Z+z6YP/0dZJQrV1dUH4HWW64zPaGeOZZrLnN4xCtpP9y9mkCop1VeLnJhTNoFE
         xBovSeL+gcobmKeGHfFJ267YWxEStVbsS8vnh7uTHrcAcC9XjpwoMSWFTbTmYGU2bq9n
         AF1E9PuWB4Bg1yX7GIqkS9H8aSFqibGHJHv9uQ0b7NOuiKxVXbSJIDNHNbAFVdhUunNR
         0dGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264914; x=1736869714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTv0piVgUC+YB8cY6nEGnXIfNYGA4ovWnbmblZRjSGs=;
        b=jDjQ6ZDLg0bKDqVXjFReq/rng/lqGqMAYYMz7V3sN4dNsnLiAZCCmYP0BohUHEr0aW
         kIH5O8K4s9vTm83Uj9zlVrdJlvyU4glUhvdE3qGc+/MHk87Wf+eRalTjEvjSdhdRwJC7
         vIxP6fvvWldkGltUxOgNgWk2LdjmvKBu+OQetADIQ1VhNtKpb1YaUJBDE+hv+hBrV2AM
         JlVHbHtd71nOOYhO7XgCE8xkMvP0+VCMeVlFEU6hf5Jio80yvrjlupxNH21tGBN7v78V
         K4C+8OZw8xEoriN9fNiItz2VZiA+7DHXvKgyixQAMHpvA3OPlfo3sM7xNukFdw7HZw5l
         3cLA==
X-Gm-Message-State: AOJu0YyyWmVnRppY1069rv/HzxAv3KZTnOEJxLmXUzB39DLtrE3ZsXFc
	8YaTEvcN96zj/1b6UhYqr6wymnst4pnBJYrdWnL8YRJAkCC+TtoG65t9hg==
X-Gm-Gg: ASbGncsJdjGFwFUFCUeFKSEt5MyZAuLy2JeJY7K9rMVeDfHGTr7UO+z7yj4FRqQtjNg
	CLIBL0Rhonn/pJ5dDT/pVTt/1h72NDo9zAXeQckAyRDvaNe2deHdEDPFBcymH3IWcbWGSdGTGe6
	RZBycZky4qgtBx5uXyDyxEyXuQknSdycWpQBOKhfx1tH5Sg0AmeclN7gljxIS+MKBcHr0pRsbL4
	CP6ohzwk3hhJlAyYJ5uGBbFra921pvsdZ5o/JhdNSWLwRFcG8l5LCdUFPbg6hPmJIfg07X/P7Qc
	oY678No0qfCZdDBL2c0bQDIo
X-Google-Smtp-Source: AGHT+IFStaQ60Gj72ivc1xpL3DMDwxxZNPlR4BqR07cDPPFkt2xmzdnCYiM8rZqRpvi5D2KBWVLcHQ==
X-Received: by 2002:a5d:5f51:0:b0:385:fa2e:a33e with SMTP id ffacd0b85a97d-38a223fd369mr49518115f8f.43.1736264914273;
        Tue, 07 Jan 2025 07:48:34 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8287adsm50005522f8f.16.2025.01.07.07.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 07:48:33 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: stable@vger.kernel.org
Cc: patches@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10-6.1] ceph: give up on paths longer than PATH_MAX
Date: Tue,  7 Jan 2025 16:48:16 +0100
Message-ID: <20250107154818.2658618-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

commit 550f7ca98ee028a606aa75705a7e77b1bd11720f upstream.

If the full path to be built by ceph_mdsc_build_path() happens to be
longer than PATH_MAX, then this function will enter an endless (retry)
loop, effectively blocking the whole task.  Most of the machine
becomes unusable, making this a very simple and effective DoS
vulnerability.

I cannot imagine why this retry was ever implemented, but it seems
rather useless and harmful to me.  Let's remove it and fail with
ENAMETOOLONG instead.

Cc: stable@vger.kernel.org
Reported-by: Dario Weißer <dario@cure53.de>
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[idryomov@gmail.com: backport to 6.1: pr_warn() is still in use]
---
 fs/ceph/mds_client.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index da9fcf48ab6c..741ca7d10032 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2447,12 +2447,11 @@ char *ceph_mdsc_build_path(struct dentry *dentry, int *plen, u64 *pbase,
 
 	if (pos < 0) {
 		/*
-		 * A rename didn't occur, but somehow we didn't end up where
-		 * we thought we would. Throw a warning and try again.
+		 * The path is longer than PATH_MAX and this function
+		 * cannot ever succeed.  Creating paths that long is
+		 * possible with Ceph, but Linux cannot use them.
 		 */
-		pr_warn("build_path did not end path lookup where "
-			"expected, pos is %d\n", pos);
-		goto retry;
+		return ERR_PTR(-ENAMETOOLONG);
 	}
 
 	*pbase = base;
-- 
2.46.1


