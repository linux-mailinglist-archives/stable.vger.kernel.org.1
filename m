Return-Path: <stable+bounces-235622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKUvI3Lz2GlJkAgAu9opvQ
	(envelope-from <stable+bounces-235622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 14:56:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A53D7C21
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 14:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0587C3007347
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 12:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D631C84D0;
	Fri, 10 Apr 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK7H144k"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6D21257E
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775825266; cv=none; b=TW3a4poxvt6+AoulvTq0g+HhGjMpYVikRBH0qaRcHhqQZV3IKs5vdAuWiodfVW0J/p//iSO/jft2IDkwuvaFpMDmCuxDFrMc6AU06nWJiA310GZKGSAWXcAgTJ9n4n4unENql+hbXdBlu+Ci7LF+EZu/OlNs1HqXood3lbRvfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775825266; c=relaxed/simple;
	bh=BTYqMuV+pUhcaJcdyMduMX4riHMFdcRbhpnNNW77Ong=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocDgQODZ4MhlXUXyDE8pkJWc27EC18hAlQPFxAUDqeqbUIgxQIfXsCFcakW1Na85x3Sx9Lq80JbeqaqN2ihw3EDjObBzzugBTwE1l3fdaRWKpActAdGY1tp1A+7yiVktNW3qEQbZsAgUIc8+EeVvUJtFc3sk9NmiuGb6OdnwSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK7H144k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad21f437eeso11701915ad.0
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775825262; x=1776430062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KoX3WbY7wSPwBwc2j2U0W0uZOmyQY8MWh9rOIhaU/PY=;
        b=lK7H144kTCi5OtKKo4vbeK630JnmkPxvJGtzurCKrJwwJITtf5ilNRkVPn6tssA9sT
         LP2qJer75qhEM2jRwsgw6vfhGhOtCgAKToDanbHTLyCjF8Etsz2x5dHAeJNjr00Y+7hb
         ZOlB1QcAjfhkyC3t0iSvc4rSLxL6mohTmje71tuU1YUIyg9iRYcOzAQEfJd5KIf0RFxP
         Ct5Hp505jDsH6NCEXXFAmNGizd5fh+MMvbzkDKpu33fzsWqSkzudA5dJz99gmAIYtN2k
         SjY3Bz/eylips5gW5z6NnDM/m1TmdSGgQA6Piyg/etoqlaiEV7iFZAjrOTXHZQanlNd9
         nWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775825262; x=1776430062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoX3WbY7wSPwBwc2j2U0W0uZOmyQY8MWh9rOIhaU/PY=;
        b=FGp2IqpXVpPcfWFP9gukRd/l1ucYHwTaDsN7+dB309rRoDQblHPc6nppd9jdUUYnqO
         U4I4NcdSJNmGXVr9Hmh0MUSmgiGkWvQlqSsS6B6sWlzw1p8CcWxg6TazL1iL1/t5K/BU
         reCB/FVUh/uGGtLIl9uzIPnjLae3xP+FeDzQLsVrAafREdrwVbtCiR0hkRstEfFimk5Z
         Dr821YJ/vq/7OCVRzIkG7Bo0rke2zxJiMYKzX1/tUm+S035EiLQhb4NZ82849S94+MIo
         LmBqXNte6N38mUldlF0uxs7Ehj5j1wyCgpBfqyWeud2Ed4ccyXG6qJyKoBg/cvKgD0CW
         XXZg==
X-Forwarded-Encrypted: i=1; AJvYcCX1qS21rn2brkQ0mAovSpcMxl0POz026j+MnF6lrznOxnPRM32kuJh9/2saxfJDwWbAyXFc76w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSHVl35QLoZ6fobeVR6rxeGDHkFc4xzlUSSExNTJiZf8TQUin
	wKHTD1y+1h94y/NXcTBDH1TrDAcNuCe6ObgI/ky1kJSTRxBNJwzYp0Nf
X-Gm-Gg: AeBDievERXIkAWjYm1WLk89SX9NvYeHVHoYbcR45FJEOY8fJdSZReastxCaD4J6CTsI
	TqBKu7M4jJ1TJg6tgE7vxeXo6CaUCbiju4hPxYtIifm4dhE+NTFn3U/5mwlQDB5L1Q2fg3Qk0aH
	hMuYZqJDQxQjTq+yIpOXn/NsuTklJ6Oh0feTkUWMx3IfcJPgSESuW1ENMwH/Joikzhk7WUGQRld
	xA9IW262b67liKki9Pg0eUFX7Jwiohl1ac9BuCpvLtkuALfrdhvD+IpPx9czNm7t6Vb4vz6G9Tb
	6m8JeW5IBSCJYK0FnMFmCMBE4URN/jqdGxtS5Bws+rVi3zMw73mQYRp4iJJ2igzlshCr7mGwNXb
	QlIuBLT5KedJWuiebRNlujNcvA04lRJPobuKJR3DnWSFVtr50J+PdFgZyHTemH8g2ITlf5vwyeb
	LtbG+8IRkQCKc/AS7VQKRGKg==
X-Received: by 2002:a17:902:c152:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2b2c711e5efmr51316945ad.0.1775825261969;
        Fri, 10 Apr 2026 05:47:41 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4c9dd5fsm27554365ad.0.2026.04.10.05.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 05:47:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: fix uninitialized kobject put in f2fs_init_sysfs()
Date: Fri, 10 Apr 2026 20:47:26 +0800
Message-ID: <20260410124726.2035729-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-235622-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DF4A53D7C21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In f2fs_init_sysfs(), all failure paths after kset_register() jump to
put_kobject, which unconditionally releases both f2fs_tune and
f2fs_feat.

If kobject_init_and_add(&f2fs_feat, ...) fails, f2fs_tune has not been
initialized yet, so calling kobject_put(&f2fs_tune) is invalid.

Fix this by splitting the unwind path so each error path only releases
objects that were successfully initialized.

Fixes: a907f3a68ee26ba4 ("f2fs: add a sysfs entry to reclaim POSIX_FADV_NOREUSE pages")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 fs/f2fs/sysfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index c42f4f979d13..4df0de9ccb00 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1893,24 +1893,26 @@ int __init f2fs_init_sysfs(void)
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
 	if (ret)
-		goto put_kobject;
+		goto unregister_kset;
 
 	ret = kobject_init_and_add(&f2fs_tune, &f2fs_tune_ktype,
 				   NULL, "tuning");
 	if (ret)
-		goto put_kobject;
+		goto put_feat;
 
 	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
 	if (!f2fs_proc_root) {
 		ret = -ENOMEM;
-		goto put_kobject;
+		goto put_tune;
 	}
 
 	return 0;
 
-put_kobject:
+put_tune:
 	kobject_put(&f2fs_tune);
+put_feat:
 	kobject_put(&f2fs_feat);
+unregister_kset:
 	kset_unregister(&f2fs_kset);
 	return ret;
 }
-- 
2.43.0


