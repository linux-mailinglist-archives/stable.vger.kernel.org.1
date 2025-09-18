Return-Path: <stable+bounces-180497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C393CB83D38
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 11:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D181736BD
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 09:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6852848B0;
	Thu, 18 Sep 2025 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDJkVhWo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3A28489B
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188197; cv=none; b=bGox7GXlKZtsKXwrrn8csoiQhL2NpSzIpkqtlyxWu832x4VkN17MTkINI+C+xsy8i1gllb+INNZwxSmLtL6yr7pHhgofsLQuor+4yMgh+K4JJkgo/ixMP4wLfMsCm7DTVBeU0L3XYzBwRa8rQQq/clxKJ4P8QuZr+V3BSuGcYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188197; c=relaxed/simple;
	bh=WZdbcxOzbiNsQtB3ULEYsVAVNPqktdSanKBGZLRQ8a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b7pxxOTpQbwGTDWH6puNRdWiF0dp/RpWASwi7KpvxJrKwH2fOq6oJEkZzDLwPhjC8PE4KYwEA+Vd4gFAEuMt+Wr5uRhsThNtnbY5qMrFB5foRt4Yp2tOVvJyZR1uTkP25gD6jUoP/ebQGrhLbHuwQ3m6M49D1viEvM/ubj6yDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDJkVhWo; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54fd723df2so414793a12.3
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 02:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758188195; x=1758792995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SdBtG29DuxWk0x1+vO/vrZiCN7poYWKo12KFNkdCIPk=;
        b=MDJkVhWooo8RgpaixpJ/gWERyqG8ybrXA7r8WTa8+1eV031PisqkSSyqIVRuOh94t5
         Bvg9sUftC4nQXV8JaZJaIhFUg3yqlIa8mi1nKATG5snB5/aa8hz5t06WCjbeGjPkXEVy
         QSvkDHmbXDWElcLjEu3T59kPAFmLIy732ZPWes0UIbAjt/Sbwjg4pz8f6sTWAqP7cwjq
         YvpaZHAcE/XwT9QNO8VV84V+t7Cuzd3qJwQ42VMv4G/k7D9hUGS6NsyQdSlfmg65htVh
         GISaajzyltU1taXqpfg2P0HmA3LcWjjb+tb+VomlhFgsamZtupPFzF9hxGfMYLZ0V5q4
         +AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758188195; x=1758792995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdBtG29DuxWk0x1+vO/vrZiCN7poYWKo12KFNkdCIPk=;
        b=hwgv+s7BU3Du+y5c3f1nz17RB0p08mMSlBdH2/ItJlHcpFvxSHs+4qRVzt+nDw2ZEt
         xGrB+AgBXNm+Api9tcArmP2o5Jb9rV3T7pP4daKGldZVCXeusw3SUnpdZzdr068p38QI
         BpeQcsx75qQxX7xWRVmAQOK3uQx//2UAqCa1aXC+uHy6DJB+ZmnPgQSj8mZpux7D2OJp
         OmoL9u1DNifa5Lqeu8u5JftCvNucf+J4NhPX9+j107fCuoqKnetfOUZXC7g+pOqmDVUm
         91ah3CtbDbQ8J9bGuz/+EbFyw6RS+gnN5oeBjoMn1tiSnd7NlsZW1o2A5cBAQNaQ/TV8
         K+dw==
X-Gm-Message-State: AOJu0Yy8tXw63W5zUhSz7Z8tewyyifzkPhTFaPB//xbK3i8pf2Qf7PZn
	IWI0DuV7djlruCJk3c/MKaqmuAFPJRJPZhyYFI5cljov9xDwlJqNDDbt
X-Gm-Gg: ASbGncscAzixVErdmtNNElfksB9sMn5yzHr0haZEAVxeH4d3UFTWCv8H18iLlegfmoG
	i+jLJA4fnn2kuVQRuoumRktrrvlNTPMGOkkYCGLJ3KJQjSXivk1fzPnyfdMSVdLu5IDpganOuGT
	2iwT80ri/9+f8VLC7GYcuD1HC8dxxYY4bcIDfaJYncc+BQFKDX42NISGzOq0TGbQRmnLfQLct1G
	nBRav2kfPSBKnjnMBYDnLAsJUKarw8uZPVg9ROMZDCT1KwGcfFadgLkwXkozKI1vo3cYAmq4ack
	ElwBJphmkcOHI3n6Vo+Pqhv2Jl05LtVSgt1ovhhHkfx6SKbiQ2wf2gSuEYZPCkT1jVoqYKCydAN
	u68xZ+EbZDXnrlIHpfMvQlxkyMsWSjLJro0y9pBA3/p1AtHuzBYQ=
X-Google-Smtp-Source: AGHT+IHPVQDk6Ab2pQFcVltfSjSsGNPhsS0OloAUxOVgDrV9vtF9WjkL/knZUEDWVPGNTRaOkCpGOA==
X-Received: by 2002:a17:902:f548:b0:267:4b80:29c4 with SMTP id d9443c01a7336-26813ef9f5emr69353095ad.59.1758188195347;
        Thu, 18 Sep 2025 02:36:35 -0700 (PDT)
Received: from lgs.. ([112.224.155.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030d8casm20015275ad.97.2025.09.18.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:36:34 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/smp: Add check for kcalloc() in parse_thread_groups()
Date: Thu, 18 Sep 2025 17:34:15 +0800
Message-ID: <20250918093415.3441741-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/powerpc/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index dac45694a9c9..34de27d75b1b 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,9 +822,9 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
-	if (!thread_group_array) {
-	ret = -ENOMEM;
-	goto out_free;
+	if (!thread_group_array) {	/* check kcalloc() to avoid NULL deref */
+		ret = -ENOMEM;
+		goto out_free;
 	}
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
-- 
2.43.0


