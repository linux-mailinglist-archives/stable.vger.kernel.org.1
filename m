Return-Path: <stable+bounces-135227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74FFA97E5E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 575A47A30B6
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 05:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A396A265619;
	Wed, 23 Apr 2025 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q2oU4qrE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B624EAFA
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387639; cv=none; b=RN+NQe1bcpHIJ8zbowtqXtdNkkSsT6Uf+mifXGfX9g3u36F3PMe9zJMT2HPbPLdFrjX1m6dunnayK+ntIUj4YKMnFxMzUnZzGmwjRDV2dVbdXsj0oI3cIKhMLkRtJRPuNApOUJzxj3EN/5eNG5cGY6ZNDXJKlDM2wuTd2uRv9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387639; c=relaxed/simple;
	bh=EYQzQCz7C72VWvNtWOrrmp8UutKyCkSK9hr6Zv6RAvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ry1szgFcPOKLklNcEhGTrYXcFDRj6BAile4YwAyechy8cmqyK27jrRuNO2P8dtKhmdegLh3Mc6d9rq06P4z74KnFMuiKL12WQJuNwTlgdB7WbPPiG6ZJhYgirJKDoBIYthoukqvEGoBUZF3LdI2GOpGp8ycImpMiWQMl0EPqELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q2oU4qrE; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-acb615228a4so99775766b.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745387635; x=1745992435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZfROXRS9SCw0rbLGecUxqxNJyb/ZTqh2axtBOMtS44=;
        b=Q2oU4qrEE9/pLyJ9Ekv6hAGpOl6/jl6wKYjSHDX4CfAn2HvLJLSAxSOH0c+9L/0Cg6
         pwfn+ELcOUsIPHZQp1SThxVQZlZvAaPE42mJSYIRrfPSCSi/D5ZwwPMQ26Te44eSi0LM
         yPTv6j9oT8gTrMtOvSvFNz0sZ0IM/faSfXv3tm13jUwbEU96UDZEqBvxM3s5NZENgYfa
         ojwxFJYVRwFq6dvTO2HG3mAtAwNAtO8FbFAFbVrTG2Fy1fGzlVvtFTQ6x1Q26Pr1/D4F
         e84zyxvKdeH+OhPEiJnJ3vJCvqujS3HkchDv8Eh7zk+Qor34oza5hU09tFKL/DxSHHNE
         GS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387635; x=1745992435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZfROXRS9SCw0rbLGecUxqxNJyb/ZTqh2axtBOMtS44=;
        b=ZxRQDsxnGPM420gkflMQwPdUFQfO0OUkLhSxZg7EoK+9CGwovlnCrY04ckN1J5sHxh
         5W/q6Yuo0Y7HrnAlz36oADWdXLrWCT8Draj8QuLBG5fh+Gm5RdRwTdudiElbiooMgzNC
         j+ipkB3LVCfAA+9jKhJZoOO2sc/0iZ6q3sLUriJZu6vooEWMlysM+1tMHkfWs/WW/pv/
         ZL1ntTTPmv6C9LQSPI6FNaZLY+U3/VWPKRn8FVTLt4sOCFn1bOQcjvKXfnFSH2hSrvZI
         0YUfPoxYsW7/Kpd4qxlzVKPcZCoiwP0E1VzT0+pqfKEKwAP7bNYQ8G0OW1nhx9dLZ4IZ
         9jkw==
X-Gm-Message-State: AOJu0YwWbnU/anoc3daHqWuIwuQ7brZ5xwalkRN7yZcCHFu3+n5KQ2vp
	BKN882Cj39ML2/0+YNoXdPSv63gSRJwdDhHhaRAnDzgD0do/U8Nw0UkuzMYX0NZ8R+ff5jT7ylM
	K/gcJnw==
X-Gm-Gg: ASbGncumiJCYBx2HVcHgNJC+K7+9SUtV0CDSRiLeEtS7CK6nmfVXXyCLoc1rh0a4hDf
	P8AnuNXbW9e2DYE0lXCVPLE/bEE0HKYb7W/daqmdnmfpLCiv8Q7mPWc4Ntd3AOt7btrhjQg6zra
	9w9EuY3e3CyRaqnhS6TMMHKqERKTiDlWBCGR1m/9QowuMzMmHlX/lT43xiWf115HRer/WjC7/Mb
	ZEGSFnL5MoBZdsE08lQv2XBxoQnaiWenKVw4dalgtRSk98NrV+auugY3kLskQxCjYTuM1rHSQYY
	D53dwG8HLmnrm3XKeiFe9N6L0Uvx003x3j2fItvjECtGcTGSHxegK5tr3oZ4FJIH5ZzJPg==
X-Google-Smtp-Source: AGHT+IFxQhP0EZpPF2U49+NMejy7wV6Dh1W6LvnLz3u9R+tWsjb/l0ZsXUdVDt11xLRBnbLUJT2GWA==
X-Received: by 2002:a17:907:3d91:b0:ac7:b1eb:8283 with SMTP id a640c23a62f3a-ace3f4c2695mr117362166b.17.1745387635143;
        Tue, 22 Apr 2025 22:53:55 -0700 (PDT)
Received: from localhost (27-240-233-37.adsl.fetnet.net. [27.240.233.37])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b0db12716f1sm8245683a12.15.2025.04.22.22.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:53:54 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 1/8] bpf: add find_containing_subprog() utility function
Date: Wed, 23 Apr 2025 13:53:22 +0800
Message-ID: <20250423055334.52791-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423055334.52791-1-shung-hsi.yu@suse.com>
References: <20250423055334.52791-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

commit 27e88bc4df1d80888fe1aaca786a7cc6e69587e2 upstream.

Add a utility function, looking for a subprogram containing a given
instruction index, rewrite find_subprog() to use this function.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9000806ee3ba..7c1eaf03e676 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2528,16 +2528,36 @@ static int cmp_subprogs(const void *a, const void *b)
 	       ((struct bpf_subprog_info *)b)->start;
 }
 
+/* Find subprogram that contains instruction at 'off' */
+static struct bpf_subprog_info *find_containing_subprog(struct bpf_verifier_env *env, int off)
+{
+	struct bpf_subprog_info *vals = env->subprog_info;
+	int l, r, m;
+
+	if (off >= env->prog->len || off < 0 || env->subprog_cnt == 0)
+		return NULL;
+
+	l = 0;
+	r = env->subprog_cnt - 1;
+	while (l < r) {
+		m = l + (r - l + 1) / 2;
+		if (vals[m].start <= off)
+			l = m;
+		else
+			r = m - 1;
+	}
+	return &vals[l];
+}
+
+/* Find subprogram that starts exactly at 'off' */
 static int find_subprog(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *p;
 
-	p = bsearch(&off, env->subprog_info, env->subprog_cnt,
-		    sizeof(env->subprog_info[0]), cmp_subprogs);
-	if (!p)
+	p = find_containing_subprog(env, off);
+	if (!p || p->start != off)
 		return -ENOENT;
 	return p - env->subprog_info;
-
 }
 
 static int add_subprog(struct bpf_verifier_env *env, int off)
-- 
2.49.0


