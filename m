Return-Path: <stable+bounces-95677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173609DB1EC
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 04:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA67167D7C
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBEF347B4;
	Thu, 28 Nov 2024 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2t+62c/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D68467;
	Thu, 28 Nov 2024 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732764648; cv=none; b=sSKXnI7g963CgZlhrtMHRlEsqoooWEhdNVmmOlpf+lF/Q5nLA6H2g7AAj2CCJ61sMonCj6fxjiv4DOs1pxqfPqCB5Wbm/Ftv+d+DhKW90Nsqh4OOcswIr1AUgAM+1xHA+v1hTpjObHRUQhZirNRLl18Rr1esh9R9XF4xUlQLn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732764648; c=relaxed/simple;
	bh=mXI5/P7rjRpurou4EN+hPkLSLgprtGvBBiBodwW/sfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KyD/hzoT7cP8tH4hxave6AOJZfgJ9CzEUUkZL3TbiN5dXO9a+BM4mY0ppMGZ+H8OH9oSTOzATGmWwMDTHwLiLYl/K5FDMYoueyr80QhgW86OlKxBTRn+Hyavz3J2l9upWjcgvB1fQYPDnPbtue6LGsl8nYZyRU6nx8yj/kaQZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2t+62c/; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-466966d8dbaso2957021cf.3;
        Wed, 27 Nov 2024 19:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732764645; x=1733369445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+1q2PpIS7yFBr1uci4IR9wEJt25TAA91J8szdO/JSQ=;
        b=L2t+62c/myipMT7Rd6aMbEW+bdBoJFigak+2aBmuXQIT5rT+lZ4Pa+xsx5m1c5nb+D
         FlilBkTxvTmyKMotikoIE/2pvkkRKqt3vFhsTcFzBTKsoLfYQzIuAPE4MndgVM0ZlWAn
         +mboXQ7L3UnuUeU6gELHdeKRHkdM+UpKxxiJeUBtmh0cxCCUe6wCy/iIESGMlkrHbea0
         cL1Ov/SvmIuKN9bqBdIMn3KUli/4XJXeeix23TilGWSNy23xmPU8u/xlwpprR6qf38df
         L2LsAnaWuuB8P9EFaSi3zJNfdLHQRqDU4Te1s0aDTTu5uTnmzoetdoptS8tq+B7Yq4jn
         5Cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732764645; x=1733369445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+1q2PpIS7yFBr1uci4IR9wEJt25TAA91J8szdO/JSQ=;
        b=S9xzi0gEDWQvaPT4Ko3xQLb4eVXfrN4u2QTpCs16glYJ3FvdNQLs1nvNJgj6a8MOkX
         Ryv1Wb5GomWhLzi1Tl2SRJ/+rFLS/54DHQxV6OWninRFVjpDkI2r6Naw4ovmR2xn3UOA
         GktBgNJseL9HgWVM7gRUQTJ69pup9pkE+MCa+8knvIYzGh8UwYzNcYphyHUPMF+TyEH6
         n4sEnPaAiYSfZlesj/POJZ8tttU2n5+u9/Y1JGWr7DQJ5S883CkIgYIV1qx4hS77v+AW
         Hb49YzTH/FcmIWLf1ddAjMRgpD6yXprJtqLVWi1v/Ba5GP2ZzkMkj9r+w14DU2+6f4Mg
         wNuA==
X-Forwarded-Encrypted: i=1; AJvYcCWx0TJSaY6LXCUf7GB/60U+fJRlUdQgs1qByf21okgDqMPzBGQgliXj/m7o0DA+KG3EYcUWZZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatdBzZEHFgpnSRrbGDPZvbn2FX8KuvAAk47aquROp+Cc34OMS
	Jw2WyP3SH+g1EP3BClea1HKV2vT+A/bV3V+g6PEwqWF/FY0bGbpl
X-Gm-Gg: ASbGncvJbiwNNbZVC018jlNhcBVOekkNf5pTaJkDHvVyeGEIvIuj0nLRWuFX+lOOC8S
	IgRrfYvuCFDFqmRiY62Q/I/Zy3GV4yLXjn5Qg7HwaU7DRC/JH3UkuHBd5cYEXmOzbp+a7LH4EG0
	S0vCb++KBB7x/pqUP6xDWBfoyMTH5YHwVef7b2PKal9ICL0kKcFu/UVRWV9wqttaXhUxIpNgEv3
	TME+x1oKVtwHta5E9sl7KBrtWqNUe+h3wRaSOTRoqqtgJK3c0wJ17v4y6Z6BDpDEg8=
X-Google-Smtp-Source: AGHT+IGO0p0StxzMxQr5tA4lnc46AewnkOkSoQKcBiT9TZYSr7rfVLJyevmagl4F2FCMfFZB70IFqQ==
X-Received: by 2002:a05:6214:130d:b0:6cd:faea:9f78 with SMTP id 6a1803df08f44-6d864d1dff9mr62175696d6.12.1732764645641;
        Wed, 27 Nov 2024 19:30:45 -0800 (PST)
Received: from localhost.localdomain ([50.217.163.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849b916asm21890185a.113.2024.11.27.19.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 19:30:44 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: mic@digikod.net,
	gnoack@google.com,
	jamorris@linux.microsoft.com,
	jannh@google.com,
	kees@kernel.org
Cc: linux-security-module@vger.kernel.org,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] samples/landlock: Fix possible NULL dereference in parse_path()
Date: Wed, 27 Nov 2024 21:29:56 -0600
Message-Id: <20241128032955.11711-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

malloc() may return NULL, leading to NULL dereference.
Add a NULL check.

Fixes: ba84b0bf5a16 ("samples/landlock: Add a sandbox manager example")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Cc: stable@vger.kernel.org
---
v2: Modify logic & Add Fixes tag.
---
 samples/landlock/sandboxer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 57565dfd74a2..ef2a34173d84 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -91,6 +91,9 @@ static int parse_path(char *env_path, const char ***const path_list)
 		}
 	}
 	*path_list = malloc(num_paths * sizeof(**path_list));
+	if (*path_list == NULL)
+		return -1;
+
 	for (i = 0; i < num_paths; i++)
 		(*path_list)[i] = strsep(&env_path, ENV_DELIMITER);
 
@@ -127,6 +130,11 @@ static int populate_ruleset_fs(const char *const env_var, const int ruleset_fd,
 	env_path_name = strdup(env_path_name);
 	unsetenv(env_var);
 	num_paths = parse_path(env_path_name, &path_list);
+	if (num_paths == -1) {
+		fprintf(stderr, "Failed to allocate memory\n");
+		ret = 1;
+		goto out_free_name;
+	}
 	if (num_paths == 1 && path_list[0][0] == '\0') {
 		/*
 		 * Allows to not use all possible restrictions (e.g. use
-- 
2.34.1


