Return-Path: <stable+bounces-120394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C78AA4F2F1
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 01:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE3718852F7
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 00:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0C3B2A0;
	Wed,  5 Mar 2025 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y58mnnc/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601F32C85
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135709; cv=none; b=t6XEMa36oYe3njZ4xGLni7gEuyuVtz68LoGtFG/I0WzRQtIL3GcW1HZDFcAxnJpAczLSYSLrRKPZrJ/XE4Oh7TI8tYiNrrH6G+BuW8loUU4FlCFCWV0jyUZgFp7uaJ5eLiLo2Ivs4XnQln57YJWAYagQfXF9CPWJnX6b2Rb0Jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135709; c=relaxed/simple;
	bh=3U6BVYINcede1cjJtqc/3GZyBpvRQDUdQ5t73UI9vNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZrLWoY8HY6TniDiZdmdHPLzwri9dzMlkoiU+9Hb5Gygu8g5ksxARQx6N2GJc6EYDES878aFgknNxVYtisf+v2mAYu0nwlC3KXwrVQE6ZUdUUchafHEEpwLwGIfjpuxul3JWSn2fbblUj8mtrlZIaNhCLrLQhq31YOGLS/dpKIYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y58mnnc/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso394197666b.0
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 16:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741135706; x=1741740506; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RBLmvV7Q4wPiI+MEo68mMCleA6GCDfzaBhVQhk2842M=;
        b=Y58mnnc/8k89ubm9ZpGEzU6q7b+CEm5h8CdBGjqVDFH1IyRZr8Ou/mnEnUfmrtg0ou
         QP7f9s/0VT9/2ww2lxwC5ab425EWcP0mpBIrhWNPWdcN8TnKuAB4IpOXu/f9TFsmdjNq
         WHABH5yaj9eIas4/jhdNvJmD6MkkIRhcVLv/m+Bb7VX+BcL4FLgRPsWK5DQnreCgHcFE
         tCOlRGd8KtVqwKg2L4ohoMZik76nufdUPfynjMeuI7DZHtTxdD131149Pn2AKtCHMaAA
         sv/nTac1yTz/2zIF9LCM3fkYczWiyEou1C2F/Vd93lOVOpGS2HZ5fAVjuXFFDCCKw+8f
         O6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741135706; x=1741740506;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBLmvV7Q4wPiI+MEo68mMCleA6GCDfzaBhVQhk2842M=;
        b=W2ZbLgOSDfNiZvB7GF5UVpEWc4lf+EHdtkSRBYFnTkq+RzIzVRwbFLsBQqgBaLBwCC
         Q+DjdkOGPYW/Gb6ndZFgY8X4mZR2IGPsNC290JHr31wSBqDJiH/DV6r3eltDCTpSi23l
         y3w/RUYh7jojPkPqtDlefq5/nSohhneEmwnUWPLZwVUeYEGIVT+lnAnRfxsERToKIVgh
         7RnwQyB0mAkPSmhrQ+VgMMhURg8mbodOIiebPZTXad7LBR52YsxrBRtxoxqC1ICzsUgF
         Te1hF09YEfE7rgIqk8WwcodXzMS38mD3uc49ETg94T0Qrbkb2cxcIISerHpGj2QO61hN
         oVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdtjnNuTgRQKpItPaevN8nb8myeZrkmgUUbgoc98NgPCU2E6yv6crFhr+GdUYbZUX7EE+6SQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8D8xYdyKhS8pszMduuMUHqdY9b8BsfCPjsxWk9v7aqBabdzEw
	CSx/XH26/r8E1cqpqKTs8YKJP/M3Z/4xy2Ejn4PyEp4Xqsth+3Tc
X-Gm-Gg: ASbGncvbO/Do/fqNmy+2oNUbd4bwCzdpixGcldPz29rDnwfW6RcRRw9mnU5AsMgxw/2
	53a/XIuOV5mi5jSy6CmQQ4yLeOxI0S+ZYku2M8fmXAd3w6uKumAvOifFjMdX0JWHc99zPVuqTH/
	FCCJYkVmhAnEw+KtyHtmcfBs4TsGSFLf3njtjCIIH7ie5pgyAXfrVLMAH59Nu2s3DY/PS1t1swb
	Z38KHsWBS0zI93cyN5CQwwlc9G8F5lO+tONAX6Pvfj2nkZLLPqhHOwoNrvxwlnPs23HwUNdlvih
	ZhhDZKC76pVRxepC0Y99bUcwtwHDExr9coDHpUQw586e
X-Google-Smtp-Source: AGHT+IH7JduumBC54MsqAZwaR/YjmJeCZFd8YNGuXmtmsN0Q1iOjlUkgz58LK8J++G6AvfBKf6Wqow==
X-Received: by 2002:a17:907:944d:b0:abf:7b59:6e6e with SMTP id a640c23a62f3a-ac20d02d7admr136834366b.0.1741135705610;
        Tue, 04 Mar 2025 16:48:25 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf58fe64f5sm647903866b.133.2025.03.04.16.48.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Mar 2025 16:48:25 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	stable@vger.kernel.org
Subject: [Patch v2 2/3] maple_tree: restart walk on correct status
Date: Wed,  5 Mar 2025 00:46:46 +0000
Message-Id: <20250305004647.21470-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250305004647.21470-1-richard.weiyang@gmail.com>
References: <20250305004647.21470-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW
states") adds more status during maple tree walk. But it introduce a
typo on the status check during walk.

It expects to mean neither active nor start, we would restart the walk,
while current code means we would always restart the walk.

Fixes: a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
CC: <stable@vger.kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0696e8d1c4e9..81970b3a6af7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4895,7 +4895,7 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
-	if (!mas_is_active(mas) || !mas_is_start(mas))
+	if (!mas_is_active(mas) && !mas_is_start(mas))
 		mas->status = ma_start;
 retry:
 	entry = mas_state_walk(mas);
-- 
2.34.1


