Return-Path: <stable+bounces-15755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C683B5FE
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3388D1F22802
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A680A;
	Thu, 25 Jan 2024 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR05cyLd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED126ECC
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141800; cv=none; b=aoEIV6gyTqi4pLenusFnncxGIHtzrEO4p5zCc6rk1rNfQOb3rvtHxgn6RvCrGjO7D/HDebQB2P4LwmYxroK1QDxMAS357xmW7UW/c1YsfYgrfG5m1BE3n5rZXlopHTLm2va88+u1NSUuUkSwL18h+MN8pu4ijAmvjVJ9cUFPnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141800; c=relaxed/simple;
	bh=hDPzj1VwoYCcTAPxOsfIcu7ratFipPkHMbA2qibAj7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9B8UWesM8SZxLfSYwEEACP+W6A/zWTeCdFb7QH8jTaUng8ZVsYmSzUkIIjTZJAm58AYAGqO3QPNOvXAu8P4d7Nv8Pnhk+9dgi+98qZUSbLZlUrWF5HP+aquMsoqavBZ7MsGZehAFOg+Xy0YoyMv3ukaSZf56vSL34aAZRcjxHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR05cyLd; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55cef56c6f9so278016a12.3
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141797; x=1706746597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gkmmUlGe9QhRzYR1X8PGM8hRTkskqSqlGQlYJMgOlc=;
        b=cR05cyLdcUmpx5aJcu6lwgFuXqwho1KVQbe2uf3d6AounELjbBcUWsXjgb5ivfm/Iq
         +q/r7QrvujwaPNMjUFBJ2joehk58DdT8q1/NBN0jD5VPlvrXbrRw4aHBk4ZBJZk8H3dv
         tPSM7D2RkewLPlzZa4hBoWFmLkNV0YIvmvGcG/ETEwhnC45KFvIj6EyYWx5CBQIkhB8R
         sncwJPPi9xF2mqCCIyuwJje++a3A8cuNPteGFL5N3pe45CnJRmeDAgwml+NqL5FxXJUl
         yti6mppZfNYS7mloYME3D1YZGX5n0pBvyvyXTxRLSUrb/wUAz/jN9QxKzbCjC8d/N4sH
         0kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141797; x=1706746597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gkmmUlGe9QhRzYR1X8PGM8hRTkskqSqlGQlYJMgOlc=;
        b=UDvuJddtD5nQZi+Evp7BqCtDFzCv5UVSxB6t875d/Y/BTlFQ73cgsEqM58I+95DxcH
         MZ7Bi50Kr98x1lzC1DSGoe0pYa1CKTO6pu5KIjPE0t4fJZxfUX0iB5uG0bT2QRl0AU7Y
         dXzfGuUBhu+VaF8ClvjRq2YF13n5a7Ge0jjiu9qZwJUU1b0byKuqb1369eg+EPuVSTw3
         NM/EdF9tgMZzHrTyW2Dj9H/cj/FAAb2tvSwLpR/UFZnw6peaLH+VQmuFH1VtfJHzxA8u
         R1veihdehZtvK5KpRsJLEeSKmPq7UAbpODGS5W260PJQFgdgp1MVRk0hGuKAXVzgTEHY
         DNMg==
X-Gm-Message-State: AOJu0Yyhx6TqPjdGEhnc8UEWhoTQj31IBitbxmvpPof8vXllKsNCyMaD
	OK6saJRLOpNJgGBSMUy1Rc4GY/RJ9u2RB0RTojoxc2LRuccZVGNbYFQLsnwt
X-Google-Smtp-Source: AGHT+IE6PuSN00sA/VwESrXepmqiVW+OfgIJZZJvMj5vihJTn60IwsVqHEaO/WsLEky59d8J2blRcA==
X-Received: by 2002:a17:907:a70d:b0:a31:6f04:cdb with SMTP id vw13-20020a170907a70d00b00a316f040cdbmr75240ejc.111.1706141796887;
        Wed, 24 Jan 2024 16:16:36 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:36 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: stable@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mykolal@fb.com,
	gregkh@linuxfoundation.org,
	mat.gienieczko@tum.de,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.6.y 15/17] selftests/bpf: test widening for iterating callbacks
Date: Thu, 25 Jan 2024 02:15:52 +0200
Message-ID: <20240125001554.25287-16-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125001554.25287-1-eddyz87@gmail.com>
References: <20240125001554.25287-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 9f3330aa644d ]

A test case to verify that imprecise scalars widening is applied to
callback entering state, when callback call is simulated repeatedly.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-10-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index fa9429f77a81..598c1e984b26 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -25,6 +25,7 @@ struct buf_context {
 
 struct num_context {
 	__u64 i;
+	__u64 j;
 };
 
 __u8 choice_arr[2] = { 0, 1 };
@@ -69,6 +70,25 @@ int unsafe_on_zero_iter(void *unused)
 	return choice_arr[loop_ctx.i];
 }
 
+static int widening_cb(__u32 idx, struct num_context *ctx)
+{
+	++ctx->i;
+	return 0;
+}
+
+SEC("?raw_tp")
+__success
+int widening(void *unused)
+{
+	struct num_context loop_ctx = { .i = 0, .j = 1 };
+
+	bpf_loop(100, widening_cb, &loop_ctx, 0);
+	/* loop_ctx.j is not changed during callback iteration,
+	 * verifier should not apply widening to it.
+	 */
+	return choice_arr[loop_ctx.j];
+}
+
 static int loop_detection_cb(__u32 idx, struct num_context *ctx)
 {
 	for (;;) {}
-- 
2.43.0


