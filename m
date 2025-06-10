Return-Path: <stable+bounces-152314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47695AD3E4C
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 18:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5732167D58
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152623BD14;
	Tue, 10 Jun 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKrbBD4u"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD251EFFB0;
	Tue, 10 Jun 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571643; cv=none; b=eR5Cm5dfkOLs/eQ0Jo0tS1jC23O4HZeq7meumTVVAHKBF/A1cK/eh4lTfLVYiYN8cl7YwdQun2KxIMMt0PVHyBDN65rkkrBexPQkzzqebhJFUvZqltkIeh6xebbBuLcwW5Ny+njzYlkvitf3NzT9GYNjZKE4WFo7lah3hWJ/pZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571643; c=relaxed/simple;
	bh=8zNGx+1TfyYD5oN1/GqIAxOb3rPE9mEmCyDVfCgaVus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWxeCFyV0EUj9NaCxLINV4dUHusbUPdeDKtSanO6YLy9I1koTEU40SV05qoTEHEaD8LwEb8m882MPY5ZyIodrA1rzE719csb7RN5GIGIsPs6txM4raOxOAhPPJPZJVe+1w6z7zETxcPaqA4O25EtXIfIY6aF+8iWR5MTGNytoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKrbBD4u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso36045625e9.1;
        Tue, 10 Jun 2025 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749571640; x=1750176440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z7ou2wgwMn8L50XyIhGS2KTQ/Rr3tzpT2R9E2FFdIyQ=;
        b=MKrbBD4uyCM2MUoX/Yavg6BO3qCFz/YOVBAEs92hUxYwXjgOvSslegEi6KQW2qs64v
         iJNKsa780BlKG+rh/ekLnjer7jkwlRSJPrAbAohbzPDBexKuMpG5PNSDQHSRez6QOVDK
         oPo99Ce2cpT141rrpP4K1ucpP25pqz1tLAFr+kCMzmxtQgf6JdSMFvUKctnFqHZePHi3
         JEq82fxSBZUJd3hU+f/CJhgQ6U5v6IGNqa0EYycFp24qgq3NsLzVKsYfpOxJeL0TkXeK
         rUPmK2cHl4GVSRuGZB+f0/yd10yPXxm0Sd4FpGMrT6ysVE5L1+RRXO5l774XeFynNvRa
         RlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571640; x=1750176440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7ou2wgwMn8L50XyIhGS2KTQ/Rr3tzpT2R9E2FFdIyQ=;
        b=YfMq3kG3k44Eflc5peSPFRVrFay7530gZAzXT52eHggjmjS6m5RzCpr/DM982p3o4y
         v+9SD9spabnAD1NBC1JCsMrf1pJpPVGD3pNxaREeGtRkR+AbjXlILT5aY225d1zePcxF
         Y8AEEVALgsarL5Ras10XSSS99SwmkdZQhHqrgN/eHTy4LJyD8RQ1ISAIpZ8HgNzBq0SQ
         YYzt4TUfz4Czl0RMVV4qAOa3QDQI8iHnkBrw0qhxD+ynKtOyqfJItM2Sor81tBg9UmF0
         oCku32TzkeIhID+1ed5aCSGW+oOOVqrCrMSOH3W5wrHb/zthEmLZM4mCdDZkPCpdiZog
         P4wg==
X-Forwarded-Encrypted: i=1; AJvYcCULjyK+wvSG0ttL21akqrtizo1oANKyl8l0VNWt1JhoH2Ep2abO63RSosVTxrCs1WwwxfhqvDWZ@vger.kernel.org, AJvYcCXQT9PEgSJmA4QVOuzY8tyjPtniVJSU7TLQ/NDHWXjdJZ1lJBnOJ8N8mpKM6zst3s7LFewD8frouZ6z3M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDCB1FK7sxeSdxK+BtFcmQsj5/5SV9eV+7+uXFmZVmx+km3E1
	D9GC3HZcEMeRakfAV+u0fA+o5KMJ1g4P3gkoN3Hd87IxT6gTyU0KqNNtBtGVTrXD
X-Gm-Gg: ASbGnct711dUyJaENTQRhfFb34iD5EAw4r2Cl+jcWmVwlSfpu1QEiGV7eVBbE3pQHNu
	3qqF+n5pjxC6FNpZ5Qrk5o2yJyMS3zbrP40UYiRbuK1uN2pNwpZeueRfw9IXN6AknQvJ7DRYa4j
	sIB3LqsW9fnM1oWDIJBKeXYAdVI1LmC/miJPgYHMihgwvpo8DplctElR93nxoqj/TkVXzf9aWeV
	AiKc+dKCqC0INUQPJy8PU7+NlJFLaII3YMmJSMepBigNBbDxrw9wDR4DB8aaZuIVk8iEN6/y8/s
	O1UFtz+cFl0A9Z+0D2QRNa0yafn5IKGHh2jk6gRHy8I7Y4gDiHZnI6jWm6QrjLNdG/NURLs/f10
	c5NlPAEM=
X-Google-Smtp-Source: AGHT+IG674JmgBiPcaB4UmFqjKGqkZ9XBcLDUGtubIQ1Xl+6o2MuAifxrpaudSCBVzIVfN2uHeDBtA==
X-Received: by 2002:a05:600c:6207:b0:442:f4a3:b5ec with SMTP id 5b1f17b1804b1-452013fd6b5mr165358375e9.4.1749571639370;
        Tue, 10 Jun 2025 09:07:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:3033:680:23f6:dd44:9038:c392:25a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730b9b27sm141709185e9.23.2025.06.10.09.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 09:07:19 -0700 (PDT)
From: RubenKelevra <rubenkelevra@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	RubenKelevra <rubenkelevra@gmail.com>
Subject: [PATCH] net: pfcp: fix typo in message_priority field name
Date: Tue, 10 Jun 2025 18:06:12 +0200
Message-ID: <20250610160612.268612-1-rubenkelevra@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix 'message_priprity' typo to 'message_priority' in big endian
bitfield definition. This typo breaks compilation on big endian
architectures.

Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
Cc: stable@vger.kernel.org # commit 6dd514f48110 ("pfcp: always set pfcp metadata")
Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
---
 include/net/pfcp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/pfcp.h b/include/net/pfcp.h
index af14f970b80e1..639553797d3e4 100644
--- a/include/net/pfcp.h
+++ b/include/net/pfcp.h
@@ -45,7 +45,7 @@ struct pfcphdr_session {
 		reserved:4;
 #elif defined(__BIG_ENDIAN_BITFIELD)
 	u8	reserved:4,
-		message_priprity:4;
+		message_priority:4;
 #else
 #error "Please fix <asm/byteorder>"
 #endif
-- 
2.49.0


