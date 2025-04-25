Return-Path: <stable+bounces-136668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EBEA9C096
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F6D9A0CE1
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2DC233714;
	Fri, 25 Apr 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BK3wka5+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76886233707
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568775; cv=none; b=XAH5QiPpLIqOrDZFkORWWxN/J95U0QeADhHzO8TUHmN6QIsjIkcyw5Upf8lQtXdswtpCj6ZAiWF0UzcyPb/ffe5adQbGKdZwlEY28ryEA0kdMMBQqAmmphbMBSkj4HNKN+ZJzHM0Nz5iU1EMLH9FS5UA3s+OM98Bcswio9vLFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568775; c=relaxed/simple;
	bh=OLfZDj8Cmv682BBF2HO42YXr+iiHVfPPHffAWnQqCho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fh8ks0ohD7kPuvzeazPMLGFHySoP346YJ4nZN+YXNix6yGHw9KOeWogqrrzYTufBtIJjSpeZuST1j8HSdnjSoQwcFSiHDo0x5Mx6k0MLaSxN3wAirO0njUm9nj4iCrMSA2YmJfaWDhhBEh3y46bv9Fx6nwXe5VWhP9ctplYZs2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BK3wka5+; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ac2963dc379so288125266b.2
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 01:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745568771; x=1746173571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D0nDEbzF3or8gCu6P+1h+5wrYE/PRT+vOuhnxtWWOQ=;
        b=BK3wka5+dsyuongDt1402ix3iYxFU1yCXec20+diClBeOre8KaYlap/4LkNnIGQy0T
         mJq/+VH4y06hd037Wkg5PzdeIrGAGHKB0wg29bU88Pa6q9pThtwZ+g4ri5HkwuEvubXN
         fCn0RsqVC/UQskYr6U2ByNL7iCyCaoovizhU2TCVDvDuN8Xg32fVoK0C7OlyT7BFhbnY
         b5qaedVZgrMckR06j7AX0nX7DRgag/5p5NYf63N8PQFqzn/j08lynuIdeW1x9FsiO7Se
         kib5u+iXxoRSrPRK5B4TdMu7wG0hK/lnuM633Zo0wRj7NSeHE97cvcUF+ASQf7plsVip
         +NNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568771; x=1746173571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0D0nDEbzF3or8gCu6P+1h+5wrYE/PRT+vOuhnxtWWOQ=;
        b=Hz1wGyefj/g59cDD4Y32daDwlP3YclT8CNeYegW263kIyOj1ZSxZ66TsfdqUkgf2Y+
         kchQTL8oLkwiH5glnveZJo4IhGS2RYp5CQCrPaAq9ySNAx6vPwV8PfBGWuc3M47VN0rB
         UYgLTM5U84Mub+Rv8LGDTe6kIq0Ig6i2Pv7qpDANAgs7FFj95r9rmyRPsemkb8a1GC+r
         bcEi0mvdOM+Ltj+ITmJ1S+dJi33uK502bEDBFbx/GdbtZRLDq+WDiL8ocpVDbHwFMZtW
         WYE9nHCFVsdd6ygIJ4bX18m9WLLlzJq/FzlrPtrahnhU85ufRe0feQWrcGyUNMF+SAju
         Fsdg==
X-Gm-Message-State: AOJu0YyvKEWonv2zXvucpsIi8JgF/deOtbKv0M0WCZz/+sK0tBkt47W+
	M6xLvViN0z2iYqfIqCmY1hgE3uf5rGcNWbeuyJZtZ5hlY7454bxOccbpa4yUyc34rqXNBYHd+P4
	MVQfwJQ==
X-Gm-Gg: ASbGncvv8gR9YudEvOeEo3ejwIlLDAjiJbEpUWKoXUVfJ2ySUQ7QHEPmGwmp/DorVtZ
	FCDvYQ/un+mU4I/niOl5DJkK27+tCfcmR9PLvlVkkCb2tAg1/4zQGgPqnIkz9xbAp++9/f2CdlH
	NSJmC0cIc0xH6N+ypgZonT4o9lOJfUHTcUBWhB1p5XqllAlmEsg0t2DwF8VmNeZnTPGLxQYXUBs
	zEJoAIMYILaIC1JbXo+NuWK8h7cYPT9VjPl48FZopc7aWMnpEA0fJwhMfVS+IXdizRW/24XXC7m
	gMVfgGaB0Qgt2Nw//RkXHxGnXnja+SCBhzTk+OkXyzU=
X-Google-Smtp-Source: AGHT+IE6O50KpAysIv+ZfbhzJkuHc3coN/v/i2pAtNQ5hYmFdfIqgjhFiJTcwsQ9jETk2brLi/8xnA==
X-Received: by 2002:a17:906:9fc6:b0:aca:c6db:2586 with SMTP id a640c23a62f3a-ace71098d11mr124849266b.14.1745568771100;
        Fri, 25 Apr 2025 01:12:51 -0700 (PDT)
Received: from localhost ([2401:e180:8d6c:c147:7e8d:44fa:c193:53fc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-309f782d486sm971747a91.36.2025.04.25.01.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:12:50 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 1/4] selftests/bpf: fix bpf_map_redirect call for cpu map test
Date: Fri, 25 Apr 2025 16:12:34 +0800
Message-ID: <20250425081238.60710-2-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425081238.60710-1-shung-hsi.yu@suse.com>
References: <20250425081238.60710-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

commit ac8d16b2d3772934f4cba44cb01bad05b4b2864c upstream.

xdp_redir_prog currently redirects packets based on the entry at index 1
in cpu_map, but the corresponding test only manipulates the entry at
index 0. This does not really affect the test in its current form since
the program is detached before having the opportunity to execute, but it
needs to be fixed before being able improve the corresponding test (ie,
not only test attach/detach but also the redirect feature)

Fix this XDP program by making it redirect packets based on entry 0 in
cpu_map instead of entry 1.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
Link: https://lore.kernel.org/r/20241009-convert_xdp_tests-v3-1-51cea913710c@bootlin.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
index 20ec6723df18..d848fe96924e 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
@@ -15,7 +15,7 @@ struct {
 SEC("xdp")
 int xdp_redir_prog(struct xdp_md *ctx)
 {
-	return bpf_redirect_map(&cpu_map, 1, 0);
+	return bpf_redirect_map(&cpu_map, 0, 0);
 }
 
 SEC("xdp")
-- 
2.49.0


