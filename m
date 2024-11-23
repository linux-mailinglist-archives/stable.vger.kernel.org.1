Return-Path: <stable+bounces-94672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984D89D6806
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 08:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126B8B218E5
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 07:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64E17D896;
	Sat, 23 Nov 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Uk05GTB8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CA165F1A
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732346488; cv=none; b=HI+w28I9TYBLM+TXmDwftuxlqY4BeLDkVNkFUjIMu5gxIGIOlWeTSUPJwVDvlsk49CH+JzBlhlsIdPsgNVvPLA9NoqdLVCeb2Bfauw4xbuMaPwjnM4ccW0nphQgBBA+2hUEdyU3QffFoAm1rli5K8qlVLolxCw5J8iIQrHjUu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732346488; c=relaxed/simple;
	bh=+Uh18BnwWLPB7ox5dDwpLR/2M4WjGNtc7pg5MyVHUEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYjrBf/zAqmoqo0Opdy0noBkCALJSeuxufsSKd4Y5e6kEBpzAVKZhqNuWU3+1Tb2PCS7wLDYKhnE8GVci5B2zB7rbmQwxEZsaagi/UDz3Ck0DbDnSQBQsT+MxUHLb2XSB6OKGxbR2JEbzqjfZvpLqDc78j38KnhPbk4SPgi8Rvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Uk05GTB8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cf6f367f97so3314620a12.0
        for <stable@vger.kernel.org>; Fri, 22 Nov 2024 23:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732346484; x=1732951284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/YTNmEWfSDtA7h9QFVeEH/ye6CcFDrvL5f8PLeF/T+E=;
        b=Uk05GTB8nUAMRYjwQvNPtk8cpgWtM72DeYgoQl6V+I+VxYK9UJja+pzd3XeKoB0TcJ
         E3KfMXbp0gsMqUZwvs/r54HryN5+awdj5BlQvcNZ4DNtepozyP26+iutPXhuu+kT3lXi
         Y5oqNJPgaVmwjI8icDHZH19aNMlz1G4iB+XPX+NbNtV3OM50Y1LETOYzLNjIkm3QkDSs
         q2yiZliz2N7e3ZEsR5P+j9rDeMAwX1RBS3xEvLvb5ZKP2gxpNE6ESSGaxXurXl1XLPJ1
         y45QHho7KNouBRpvt+59WEv/QW7vVzOPYt4W0Bm6Fo4kYMTGAaZsYHuyUpQsmCD8bYsH
         uJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732346484; x=1732951284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YTNmEWfSDtA7h9QFVeEH/ye6CcFDrvL5f8PLeF/T+E=;
        b=iJZvJH+QdH/u1vJGgEJFU1j2bhvId9jCepaec6Ydytxtlgigm4aRAlv6GkyYB1Z73p
         l1yAQzR8J8CJWEuqZrRd+HFElcTFUU9ChqEYOs+3C4bYFXY6qpaePeSFtZUXh5I/922g
         YmPT7kYhjmTbCEr1VdX7uH+x5NULgArC4gHzllfMXOIfBTQFGhunv6Hn2lYRWDeA4UO9
         mQ0Jg/J0Ml5hpSK9Oya1bIHwUu+pQHLn4zDyqGmgsbtBE5HvaCgm9KzTuzGFPoVcL1NS
         25EGExv+cSujysltz/IheMuU5NGxSX9VCpWMB3S1VSw249rRpQX8m9G0P2ibzQSvs6KY
         Z5jw==
X-Gm-Message-State: AOJu0Ywl3rIlMIrz3ElXM9zTUuNbkKB45WykZc+DztoqU5UHZ+D3lcge
	43kStLGdfyjTGnHZgNu4eeZ8A2orcnvN1mKYP7HBVY5qvcu26UocLVjgbOrkSOU=
X-Gm-Gg: ASbGncsLmJ4knzhaJ1mNC+ddR2CpqRfzOyn4RzJFkyXi0eM1SKm2uZvhrbz8D5CYg7r
	KGcLaTGaxUJ9sQ3AmPrLyQ9kiDhCFwooEEjPkUvw1zVgXGC9aBKubdxVBrvdcrNRenbdARuetGu
	DqkjnqfdgLKWAoNKFmPIIGp4nwKYteY0gogfgxQ2HmEbNTqn67IJekMbSpnF7p/fETMxVP3Swzv
	anRokSGehqk5ueLhz+EEVwGeMkCILGId0bM9z2o4hqVz3QhyOMU1LOWeg1bG53BO6t0L5nDGzfM
	MQSiYOLslql3AL2aL2Fnpk8iCq8vO7r2NN2+1onq4gq72Hzmyw==
X-Google-Smtp-Source: AGHT+IHXLdLmo1tmtjgCD0qXUsxAXVAd8FLm9qOjaiXqI+c53wWX0tVyWhZvrhtWm4ABhSfP9OWgKg==
X-Received: by 2002:a05:6402:5212:b0:5cf:bb9e:cca7 with SMTP id 4fb4d7f45d1cf-5d0207b2521mr4251606a12.28.1732346483822;
        Fri, 22 Nov 2024 23:21:23 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f12b600023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f12:b600:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01ffd96e4sm1590029a12.60.2024.11.22.23.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 23:21:23 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 1/2] fs/ceph/mds_client: pass cred pointer to ceph_mds_auth_match()
Date: Sat, 23 Nov 2024 08:21:20 +0100
Message-ID: <20241123072121.1897163-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This eliminates a redundant get_current_cred() call, because
ceph_mds_check_access() has already obtained this pointer.

As a side effect, this also fixes a reference leak in
ceph_mds_auth_match(): by omitting the get_current_cred() call, no
additional cred reference is taken.

Fixes: 596afb0b8933 ("ceph: add ceph_mds_check_access() helper")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 6baec1387f7d..e8a5994de8b6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5615,9 +5615,9 @@ void send_flush_mdlog(struct ceph_mds_session *s)
 
 static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
 			       struct ceph_mds_cap_auth *auth,
+			       const struct cred *cred,
 			       char *tpath)
 {
-	const struct cred *cred = get_current_cred();
 	u32 caller_uid = from_kuid(&init_user_ns, cred->fsuid);
 	u32 caller_gid = from_kgid(&init_user_ns, cred->fsgid);
 	struct ceph_client *cl = mdsc->fsc->client;
@@ -5740,7 +5740,7 @@ int ceph_mds_check_access(struct ceph_mds_client *mdsc, char *tpath, int mask)
 	for (i = 0; i < mdsc->s_cap_auths_num; i++) {
 		struct ceph_mds_cap_auth *s = &mdsc->s_cap_auths[i];
 
-		err = ceph_mds_auth_match(mdsc, s, tpath);
+		err = ceph_mds_auth_match(mdsc, s, cred, tpath);
 		if (err < 0) {
 			return err;
 		} else if (err > 0) {
-- 
2.45.2


