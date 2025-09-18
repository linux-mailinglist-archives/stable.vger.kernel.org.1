Return-Path: <stable+bounces-180527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F11B84C32
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972C2484A9D
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81722D3A6C;
	Thu, 18 Sep 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QupOPcvo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3B246BA5
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201345; cv=none; b=FnsTTqwUeHIpBHbbDX2uFdK9M6WfGrt0gSO122OFn9mAW4GfXEmihiW455+RQWvXotrcPmPDG7bIWuk8k697oium9L8Rv5CxOTpf4SqKRvYWxE/z56/jn8fozKvwDd+ZqedWNUJfpItyhg+wz2lkN0OIHmiUvr6VNr8fAlXCfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201345; c=relaxed/simple;
	bh=vCwW3fPtoB+FbX1hIE9ZZO2T7qCinTOaCrEh2NsxC+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4GOp1Obii6ObDAaFaZcfPdAkscRCy0tNV/MfGV0TaH2VvmKQPsdduAlvRBe6imJIlCxTsb20iX7QwCS2qAw8w9SWBXOI7vaBNg2gmIioqHBgEDzdb3cW6ferfuGUXKhu3LuAtlJljWojcsRvXBsficb3mJZUX9RJW3OAn3uAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QupOPcvo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-267facf9b58so6976315ad.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201344; x=1758806144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yE34uiJAxjOCRXMZb/gdhVBd/0cCnsnfIfmCkzSAFk8=;
        b=QupOPcvovHnbrAVMbi2CBDv5Rdo6CyBlGgfHFaNTEnLmktwdkfFeYvjBQvM1IPt/Q3
         4c4ncE6OSVoJxf2vzeL4SmXQH6tGiTF36BgKYFXI12ERdaXUREettRdiErgtcZhgTSpV
         O7Rc4dODBg2gfGRQoowzCh0qYZdvHFI1UEYMq03F45lDyo+PwxQ4JTPc/dO3KLhjr3zf
         WK94K3sCwEiK4V7+4Xam3wmfipVYG2x6XbXY6pLuRXUjU1kV687OBMtzaeSZcWMp/OWz
         Z5OFRq95WBzmPmCoMXVAX2Fgq25TCBLJChD12QdEqJXSJBU06MdFYMiGegMbJwWdlXFe
         dtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201344; x=1758806144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yE34uiJAxjOCRXMZb/gdhVBd/0cCnsnfIfmCkzSAFk8=;
        b=rCZm94E066SP6wm9u+ynBjJhrGersJdud51J+GNqbcDUJ6GSWFcGgobJW26qQArENj
         rTHqd7ai0sMtsB2/pARC1nVijfuTnzoHJhO9u3tNCkBLFWWk1VDaMZt+OdMIOjj8BriX
         y6ECacH1rig9sOiXn4W13+fNZgukFyc1G+qag7PRs50o/0msuuE+fZ82840J1a4j6lM9
         ngQ2VeRTxA9v/4Ha8RhSAgTbfqz2SI9eSWNqdowAnFrrEKlvs3OjHmIYXqbbI+4e2Lj1
         jxdbzPqR2ZsF9/Hp5fWSdRJtveM+NRvDWRRIV1KuygdvVzhMueafQbLRTsY6JNc07DuF
         kYNg==
X-Gm-Message-State: AOJu0YwAEuIP+taUZlfYCsBSXSpfNULD2n0zOG0vr5OLgZX9LVELIazN
	U2OJtT5SM6er6VaqZuh9QAaa1A6OqRNlyvPt+88wqOVYviNkVkSU/iDB
X-Gm-Gg: ASbGncsribUEJ+46GZ9WziwrHNDVNMe7N72HlNdAmLbJGFZ12TOuUwBUPWADgOUBqhG
	GPj30+pwDRow2EsIbC3919zmeFWYHXQv7V5f5Y2Z3arwl1uVZOAyBq3g9gBSvncqsT/wQHSml0p
	f4BJT9+el6NRMVr4Km5EIzax8nUuMKFkrBicunMu/UJOD4ZYR8UZXcj6qmzpza/frdqqgV9+eRa
	BfA4RcqkyVbOCUbH+kdA/x0jkZBOameebjHrwzz5mk7jGY9bZh7bttHanbxgfVMTo3hAv0B4Sza
	JDVG4un5VpHz8d1+7baWBgQGT5z3kBrC40I10nl/Wt08zDK8ruQitCuEx0CJuz8ORTTnjPmr73G
	4qNEvDsi5QPJTqhU8vITsfmzzLkruVqF34P0f2bvR8A==
X-Google-Smtp-Source: AGHT+IGsMo/8lQqefuavLtapLE7AECgG8b9jcfsyTOPdN+syxzbumlh0WE+7dvjsyXF6z+BpZPP70Q==
X-Received: by 2002:a17:903:fa4:b0:24a:8e36:420a with SMTP id d9443c01a7336-2698aa45676mr34911085ad.40.1758201343497;
        Thu, 18 Sep 2025 06:15:43 -0700 (PDT)
Received: from lgs.. ([2408:8417:e00:1e5d:c81b:8d5e:98f2:8322])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033ff66sm25343095ad.133.2025.09.18.06.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:15:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	"Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/smp: Add check for kcalloc() in parse_thread_groups()
Date: Thu, 18 Sep 2025 21:15:13 +0800
Message-ID: <20250918131513.3557422-1-lgs201920130244@gmail.com>
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
 arch/powerpc/kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0..fa0cd3f7a93c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,10 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.43.0


