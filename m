Return-Path: <stable+bounces-163073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C8DB06F4F
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CC03A73EF
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 07:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853A25F790;
	Wed, 16 Jul 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z7XVGeUI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D8F1482E8
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651946; cv=none; b=TGeHFGmKkYeolrZ8LJ71h/vjOknUXWVu8ALzybxOXSFHSK7Gwv/AheufFQl74jqAEuVSjTEhUVsYt8a+cx47IZ/UXAJoQPhT/lh4EkRPPxSVuQ4pTI8z9f+UQVZUDUTM923BFqri6jNejFH1jujbYMiM6LJGjQxuLIm97sDxz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651946; c=relaxed/simple;
	bh=cWxNBZKYRYViHENsLqZ/fWKuMKxvGqr8Q20B8YIQBQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPi5xST5tLAUc+plZaRoqG7qOFo7vK7NJdFN1zjpiTG9JoJoaedhGYv+QiFHDF/86ZCtryXB1r+SzcNXHMa27/SYztNRb4xhAR0FhOzAV28df73YDU5c8EAoHmF+bXeAhVG6PRpNam8QF9UynNDg62bArm4Q7O+xepK1H/yrAug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z7XVGeUI; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so4496056f8f.3
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752651941; x=1753256741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/bM/E4zOsVzUWOeZInPj/1YIo/lBcqd5DiLZY+OsWZQ=;
        b=Z7XVGeUIMnyDUKYb5XDhP916b5xVHsGmMSeQF/fw2Xlm6GR/rviVR+spAjFnv70S1g
         oov/bgOIJbq55cwp1grOb1x62Fn42wFRmudC+heyfDVBmcUSwsEllhw4DZBPDc2/tbYO
         Ew7wfzaX5czPXbSDLGJomhFahVxr0UwkcmL+QE+BtK3awEBd+2O3RWlqlaXV3gPtBxdB
         TifFpmSaTF5N9UtJ6SHdh+OemFcFfIxSIUmy5mSpMqZ3+Bsm9Pn3dQDhHGWFMuTeT90V
         WqGBqsBmNy8ZcRsXuHni0fIkVXtW3xMxnMtTIGNMqfN9XQT1Kcl3+KHsNREFkZT5Os6m
         376w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752651941; x=1753256741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bM/E4zOsVzUWOeZInPj/1YIo/lBcqd5DiLZY+OsWZQ=;
        b=L74348d/gYmeSK9h18alhowePAYLiHAraakatSEiuGnd+je5Umutj28vqmXIDuT5ah
         xvv++ZRGZeo0AcHO7WJamjLfxPMAQjVedgIY7r36tgyQStePecqnv3luC35YddwkDRh9
         yezY/AECT6ASTV3ALsgGhYmFh+uwX69r8vNPuBSMx291O0MutgZF2+lwiL2Eahvd2+/f
         3U1n7lwdWK9zZcZZpcnMFD1NEr1PVAtNuSIkX7m1ntE43vAc7OfFwt3pYPBcUZYa8pMU
         j/SfxHmQIwq9yHb5Tijp0zbvhcQU71XY+mIWVxHQe2foAOzOmqFNBM0j27xDFydIIO9E
         5OSA==
X-Gm-Message-State: AOJu0YyfbwKiOX0KmOlUs5o5yLldAvLuT825KfRKZMNmLu1jhMZc0UyM
	edVjsqS7nhZ1pVSNt9UuYEFkXI/EK4mhQKv8FtyAQZJG8hVzOm6K8Jrh3EFj+3o1+5k4c1IKuCB
	XbdSHq+mmqg==
X-Gm-Gg: ASbGnctNQU8p0U3FoQeLm0dv9jAdQlNr0HU1uwCoNPAFKf2vHvnrC3+DRQs7MHkz2ZJ
	hR23Yky660I6RTGJtGaQT/DaeEWP3RqbE6k3/UrkAxwneqrgkxehS9Oy/nI2miZUC0HgH8m4pVg
	2VESYZJtu3hy73l8qDFdpKO2j3xqekT9wN5Z81kro62bntUquGFDmAHY8+RG1DIQf/MQCUGR8Ip
	bs6VArvASwQO0Xua5gdqyBmLJIGUZvcl+B4a9z0etJ8kx2YvnBdFFF/fY+C+e6QO1ns24QVo0wS
	qt0aLW7T7VJCO92xoPARGVK8RGR3rsMSX+rwz46o+Xh7aOhA9fGRZCZ+TbBgvigh5FNlXDxPfng
	t1MarLZ08zGNZ5chk9urpKMXEC+5jPfHX6xuqj6dwMo/CNt8FlNmZTw==
X-Google-Smtp-Source: AGHT+IHb4IKDFmmNt2CPuYE8Zsi/UM49Ex0Vn2qt/qj3xpSls3GVNTyfDIk9VwPSKOnKI0wVFWBmhA==
X-Received: by 2002:a05:6000:4007:b0:3a5:2694:d75f with SMTP id ffacd0b85a97d-3b60e53ebc8mr962277f8f.52.1752651941399;
        Wed, 16 Jul 2025 00:45:41 -0700 (PDT)
Received: from localhost (114-140-120-56.adsl.fetnet.net. [114.140.120.56])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8bd1776sm17293879f8f.12.2025.07.16.00.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 00:45:40 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12] selftests/bpf: Set test path for token/obj_priv_implicit_token_envvar
Date: Wed, 16 Jul 2025 15:45:24 +0800
Message-ID: <20250716074526.139758-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ihor Solodrai <ihor.solodrai@pm.me>

Commit f01750aecdfb8bfb02842f60af3d805a3ae7267a upstream.

token/obj_priv_implicit_token_envvar test may fail in an environment
where the process executing tests can not write to the root path.

Example:
https://github.com/libbpf/libbpf/actions/runs/11844507007/job/33007897936

Change default path used by the test to /tmp/bpf-token-fs, and make it
runtime configurable via an environment variable.

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241115003853.864397-1-ihor.solodrai@pm.me
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Without this patch test_prog's token/obj_priv_implicit_token_envvar test
will fail.
---
 .../testing/selftests/bpf/prog_tests/token.c  | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing/selftests/bpf/prog_tests/token.c
index fe86e4fdb89c..c3ab9b6fb069 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -828,8 +828,12 @@ static int userns_obj_priv_btf_success(int mnt_fd, struct token_lsm *lsm_skel)
 	return validate_struct_ops_load(mnt_fd, true /* should succeed */);
 }
 
+static const char *token_bpffs_custom_dir()
+{
+	return getenv("BPF_SELFTESTS_BPF_TOKEN_DIR") ?: "/tmp/bpf-token-fs";
+}
+
 #define TOKEN_ENVVAR "LIBBPF_BPF_TOKEN_PATH"
-#define TOKEN_BPFFS_CUSTOM "/bpf-token-fs"
 
 static int userns_obj_priv_implicit_token(int mnt_fd, struct token_lsm *lsm_skel)
 {
@@ -892,6 +896,7 @@ static int userns_obj_priv_implicit_token(int mnt_fd, struct token_lsm *lsm_skel
 
 static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *lsm_skel)
 {
+	const char *custom_dir = token_bpffs_custom_dir();
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	struct dummy_st_ops_success *skel;
 	int err;
@@ -909,10 +914,10 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 	 * BPF token implicitly, unless pointed to it through
 	 * LIBBPF_BPF_TOKEN_PATH envvar
 	 */
-	rmdir(TOKEN_BPFFS_CUSTOM);
-	if (!ASSERT_OK(mkdir(TOKEN_BPFFS_CUSTOM, 0777), "mkdir_bpffs_custom"))
+	rmdir(custom_dir);
+	if (!ASSERT_OK(mkdir(custom_dir, 0777), "mkdir_bpffs_custom"))
 		goto err_out;
-	err = sys_move_mount(mnt_fd, "", AT_FDCWD, TOKEN_BPFFS_CUSTOM, MOVE_MOUNT_F_EMPTY_PATH);
+	err = sys_move_mount(mnt_fd, "", AT_FDCWD, custom_dir, MOVE_MOUNT_F_EMPTY_PATH);
 	if (!ASSERT_OK(err, "move_mount_bpffs"))
 		goto err_out;
 
@@ -925,7 +930,7 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 		goto err_out;
 	}
 
-	err = setenv(TOKEN_ENVVAR, TOKEN_BPFFS_CUSTOM, 1 /*overwrite*/);
+	err = setenv(TOKEN_ENVVAR, custom_dir, 1 /*overwrite*/);
 	if (!ASSERT_OK(err, "setenv_token_path"))
 		goto err_out;
 
@@ -951,11 +956,11 @@ static int userns_obj_priv_implicit_token_envvar(int mnt_fd, struct token_lsm *l
 	if (!ASSERT_ERR(err, "obj_empty_token_path_load"))
 		goto err_out;
 
-	rmdir(TOKEN_BPFFS_CUSTOM);
+	rmdir(custom_dir);
 	unsetenv(TOKEN_ENVVAR);
 	return 0;
 err_out:
-	rmdir(TOKEN_BPFFS_CUSTOM);
+	rmdir(custom_dir);
 	unsetenv(TOKEN_ENVVAR);
 	return -EINVAL;
 }
-- 
2.50.1


