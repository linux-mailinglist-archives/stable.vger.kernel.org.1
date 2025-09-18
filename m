Return-Path: <stable+bounces-180525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36C8B84BE1
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC151C06182
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450FF308F24;
	Thu, 18 Sep 2025 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBVjKobh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A0308F1E
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200948; cv=none; b=GwZ7Y638x0v8o97DHKqxEoqCNUZqSKmWYJaWJWgijs8qirOBtG9yW3yRM/t6WBri9wUyomAo/ZdkqpQB4YhCa3Ecq+7rpny5tLGhyW0yuc14SaEbCMObS7Ta4iT6lkXNTUrkVDgZdkpaa7XTUmJJ2XM4UfL93GK6X1TJeY5LciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200948; c=relaxed/simple;
	bh=Er3PMf9myoYkBBJYaU3UkkQkMikHnD13qA99bQyqK9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8zHahjmiKSO5QAC5y1kca7Jkp1CJAxyt/EyH6+7WMG99r/xkausq9xSe6QJOHAKpcA/ksbqvLflxgD5vv2ekw8s75aNred8kLOUpnC9ZHzCHoJ9hEYTf9FnbA6r9utL1CU9BjQ6MBd0w3oRYle4BIlI0JOh639v3kgBWSDzBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBVjKobh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2698384978dso6854185ad.0
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 06:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758200946; x=1758805746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=icTj2uj2ry4O8N7yW/r057ziDGK4JT3A+zWVTttAeYo=;
        b=bBVjKobhlYKQqf4ZfLBLO7kMyOePOF8WdNgpQf+uJAUr8W157EVFb03uY+Fhn0iM7a
         XqxIjOcUqu8wTttTav3VYi9TLse7s91GUbQwX7D0DsYIinYS9NijPoZqXpxv86XpdsIY
         gAUiRE/KKLA4NQUpWaaaYFz9vL5l4H2it9ZWtzD7W5nMqcXS07zCI5xTKaW5cnnMtD2l
         ErPI2rhrz4DzCm5u8ByAubgqDjHRNG2abILk6rpxH9uUPvjDjpBLRkjdgrSxoXsKVHnY
         bIx+y9aeugeBm6wg1hVrCZt2MfoiYmM56V+UD8Q+RRieY2y+admPZoWw8rFfJsz1k3N3
         +LJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200946; x=1758805746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icTj2uj2ry4O8N7yW/r057ziDGK4JT3A+zWVTttAeYo=;
        b=T6Q6m0miwAnMUx9Ba3KLIgENxWZ0y3eDGC8YwV9CUjRmiNpZKRG8qb1i4ORlMryytq
         O4/GqhQzJ+6ERNFXuCvkgw5B0bGytyd7hVp6ApcPFoWwMtOTNqsQm5hMuSVNvq8ulZYQ
         xUd58OT3mkDxk3ErAgQCtP1MclgoeG1emBT1PjWRCnNYr5nSQnXGtIsqDORfSYzO612B
         nd3TTViXUEsLmScjtvyXyGT2Tf0n+8xXFyGZ348GvdxyrZuZk7cpnrthNaFRSZJ82x2s
         MpklKMPBJvfbYacNAS8PIsUaXlItF5bHmrSgqPsKmakqx9TnK79jB5PZjaEVavRsi9F4
         ljOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTHyHfMit6YNyDyEP+rUNmY2h513fwU5dxSYRcrCaydZ9Fwxtsk6kvKGVJs/dkQMxzbk9gD1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnlBfFLKTXmwtB2NVTjyWORl4XI+J5yG/o37/AveGra4eJByql
	m8h8LhkBWJwoy6Yjhmp+jNLoYwZXRvpGLXmnhq4WioIsf2TUPMlkS/lf
X-Gm-Gg: ASbGncv42jcrKC4He1716Q0juSulEBBYUsT0vE0rs706CIIxOm3NanOSUHIdKsrrhQQ
	j7pdyaJ3NZo01K+selS3z7ZOAn6snfle4JsobAcrgEbx1JlmQwTcPrjZ3qQqXZ1q9YidhAG4vhA
	uS7aYvCjjXVVx2PVA1c2JIHO+I9OFwIeDvWUSlFAqW8msawWRO/c3U08DsT3bxHgbyzOwsHBKaH
	C9ZpVcwTxMCAEgFnPrGO+2AOEktYM1X4prdDZfJHuh/CAoABpGLrnASLjbJdNgv9lseSAPw6DfH
	bCWkboLP9nLSv3poqHt3/TfUoF69kYcHJXknJLeuJRNNugS/cmyXDdJCSKj08cpfOV4IMJSQRgJ
	MyYGc3Tkn6j110qfkzYzC9uWiDhYIhtcs+SpGgL6FnMeBEwGI+GaO
X-Google-Smtp-Source: AGHT+IHlRbybGNvUsZOnopBgfd/M/RrtXbziezoYWYdRaUySLI3fVUiSR65r4mduFiNJCSPyZ5WVSw==
X-Received: by 2002:a17:902:dad1:b0:24a:f79e:e5dd with SMTP id d9443c01a7336-268138fdecemr78106405ad.37.1758200945682;
        Thu, 18 Sep 2025 06:09:05 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:c81b:8d5e:98f2:8322])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033d788sm25878695ad.127.2025.09.18.06.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:09:04 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: xhci: Check kcalloc_node() when allocating interrupter array in xhci_mem_init()
Date: Thu, 18 Sep 2025 21:08:38 +0800
Message-ID: <20250918130838.3551270-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kcalloc_node() may fail. When the interrupter array allocation returns
NULL, subsequent code uses xhci->interrupters (e.g. in xhci_add_interrupter()
and in cleanup paths), leading to a potential NULL pointer dereference.

Check the allocation and bail out to the existing fail path to avoid
the NULL dereference.

Fixes: c99b38c412343 ("xhci: add support to allocate several interrupters")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/usb/host/xhci-mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d698095fc88d..da257856e864 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2505,7 +2505,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 		       "Allocating primary event ring");
 	xhci->interrupters = kcalloc_node(xhci->max_interrupters, sizeof(*xhci->interrupters),
 					  flags, dev_to_node(dev));
-
+	if (!xhci->interrupters)
+		goto fail;
 	ir = xhci_alloc_interrupter(xhci, 0, flags);
 	if (!ir)
 		goto fail;
-- 
2.43.0


