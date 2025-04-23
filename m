Return-Path: <stable+bounces-135229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA2A97E60
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BA9189E70D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 05:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A95265619;
	Wed, 23 Apr 2025 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gUBzdiNF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52256EAFA
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745387651; cv=none; b=DUn2vOL6wplzWTro0Y9R5MGTjF/1iwjZzl4qWg9e5ay3ffPlozmlmeBakYmPeLqLDT6GVcMztc70w9EQRvZWRyn1hJW12RaGByUTd/UeLosck6UBR72KszGCBI6Zp7KgCDXlZMRRMYpfuHxi7YqLayf3OvddLjERtiiVQC45mT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745387651; c=relaxed/simple;
	bh=4yXdHXSyOoPZeOHOcGnQ9/rK4DlwnktUL47tvWW1aIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEWJoPWtgFoLGdp2Rl4NwTbAOycn+zf6hJBv17V2I9yHazpKJKtGj4P9MTbZ/R5AprMCLQA9lj/vBCLtPjVrlAf/RhfC0GlwXAXoFbpJjhHkxnWna7Hb858AxlDKmL92e93rAFzuPlMi8qDdIaJRPpIkLuvEhiCxwNvWO41B53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gUBzdiNF; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39efc1365e4so2158010f8f.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745387647; x=1745992447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALcJdiww4WhC8fWfEOZv2bWsgQyahkHcoe/b7y8Tpz4=;
        b=gUBzdiNF0o+bsQK57jl3v+iekqCGb+xyA0qgbLL1/OlkdKtbpBIVS7Vt6gFR5ucXYI
         5aNj6+x5dpzO2jcboFxnZHDEQOj2l2frzfb+ba+x/FeseTP/n2mayYvav/tXPiGX2LD2
         cKZuDt+NiFMlgNzBMhUViyxW2TzStRXbkVccDkT03ujS4WJzBHCe9tvjAe1wxeKcD0lj
         zpcIepEc5kzbfS9yqRk/wupio97+0A+AUq5xl48ntSYfCQHfyFqOelo35y6gjJHZguBp
         cR6jRqoqPvVF2GN7DldcmUE49LbLKHgAqUfcRtXVnZ0Gnu8F401RVcqFlPkn0Ae94ahz
         kPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745387647; x=1745992447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALcJdiww4WhC8fWfEOZv2bWsgQyahkHcoe/b7y8Tpz4=;
        b=S5+xlJinlvDVYzczOr3lYYY6XkybcGBtpAlqlqkyvMYgCpI+fvxKdv1dWPnuiAy51l
         rxTmgt0sjkRrpsPO9nIBDZnKtstD7jn78GbEoiN556enqDiVwkuWAhjmqSBXpC5DMuC/
         ylxrCpU4/23ERHJQ2mhJ1Efeq0m0skYojpF0K3OiUNkojUKG+IfyJnzM/v2kgaOm1ZoH
         iS/cxoSMOZo9KRML21T7OiasXhTIXhTwhVIUMBK3PeVjtYn7JF7wKyLSiVfxulKOm5rz
         QhycFuB9K3olkf/S3QQjb3Zl2fge89EMiCNzKosGrMgCLkSuGoawzonBEW7lAfU+qHLN
         Dj/Q==
X-Gm-Message-State: AOJu0YxGa128jaAZyV6gY7fReZyhXEVcq7Fc6dZmRQG4/64aABD05LdI
	ZYS5CHjZ8vVvnlNxM8DgnUWRV76d/2ZtIgND4mBoGo8PhUu7rx4INhncUzM3uwxnefFwOF+6n19
	E3/QxuQ==
X-Gm-Gg: ASbGncsiZ6GJPxS0oTNBQR8YOoVs56hWv2MXVtHI5UqdjUfD5kvR8HjrFk/44VnhAth
	i1s9zyyZ+Pcw2C7zIdslBd5sLJGVO+DcX4fQw3BFQy872cZMexnxbpOEKQWQELrbwHzgG62g6KG
	URHZBA7URVPGNf2SFVz+4ssQ3Tb4kmS6R9K903kEp/JWbjqE6eei9NrefY10jftXyy3a+23iF7H
	KHISKXDnPMZrVkVHSRQFLtMIKRCaSNGAwOMCsLT8h7tK1zDcdzi+9jgpbcTPS0a9zg7H6MeeMTZ
	eeJsb5tZXk6QUoohuedKlKCvOh7Y1ngknO7218gY1SCZxXP1CuTEGgmR0Fm9j5yzqGDYYQ==
X-Google-Smtp-Source: AGHT+IFFaVfDqV318F+P/413HgKLxNLuiKa2lj0QBUhE7b+FT/5Y7lObp08GunZRgt+bpCe/B2MLLA==
X-Received: by 2002:a5d:588b:0:b0:39c:dfa:e1bb with SMTP id ffacd0b85a97d-39efbae03damr13216811f8f.42.1745387647394;
        Tue, 22 Apr 2025 22:54:07 -0700 (PDT)
Received: from localhost (27-240-233-37.adsl.fetnet.net. [27.240.233.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bde3dcsm96138735ad.23.2025.04.22.22.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 22:54:06 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 3/8] selftests/bpf: test for changing packet data from global functions
Date: Wed, 23 Apr 2025 13:53:24 +0800
Message-ID: <20250423055334.52791-4-shung-hsi.yu@suse.com>
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

commit 3f23ee5590d9605dbde9a5e1d4b97637a4803329 upstream.

Check if verifier is aware of packet pointers invalidation done in
global functions. Based on a test shared by Nick Zavaritsky in [0].

[0] https://lore.kernel.org/bpf/0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com/

Suggested-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-5-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 .../selftests/bpf/progs/verifier_sock.c       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index ee76b51005ab..e85f0f1deac7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -977,4 +977,32 @@ l1_%=:	r0 = *(u8*)(r7 + 0);				\
 	: __clobber_all);
 }
 
+__noinline
+long skb_pull_data2(struct __sk_buff *sk, __u32 len)
+{
+	return bpf_skb_pull_data(sk, len);
+}
+
+__noinline
+long skb_pull_data1(struct __sk_buff *sk, __u32 len)
+{
+	return skb_pull_data2(sk, len);
+}
+
+/* global function calls bpf_skb_pull_data(), which invalidates packet
+ * pointers established before global function call.
+ */
+SEC("tc")
+__failure __msg("invalid mem access")
+int invalidate_pkt_pointers_from_global_func(struct __sk_buff *sk)
+{
+	int *p = (void *)(long)sk->data;
+
+	if ((void *)(p + 1) > (void *)(long)sk->data_end)
+		return TCX_DROP;
+	skb_pull_data1(sk, 0);
+	*p = 42; /* this is unsafe */
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.49.0


