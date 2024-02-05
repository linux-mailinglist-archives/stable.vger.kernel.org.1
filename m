Return-Path: <stable+bounces-18803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E7849267
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 03:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBABE1F2182E
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 02:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C9A31;
	Mon,  5 Feb 2024 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IelBhrCO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9104C79;
	Mon,  5 Feb 2024 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707100364; cv=none; b=ICBnsLM1uEpz3Pm/3A2ZyK+Op08J7Ha+E+X69tx3Gbu19VeqUVbrWwBjiuRg3H7CeDFbUmhXyN0+3S+71PqxPm5QHNcIPiP09tiMhojFNxFUN3h/D8Tp9QnobXLwatZWGN0p/Siy0FhoRTrwhLyoscjO/rkNV34hbYK4K7KnKPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707100364; c=relaxed/simple;
	bh=0xkV+S3jz0FQf5tFUn9aI328bppFR3eEj9vpDnkep4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=sh3sFxkw9z9SaK6qNbFH9ZVOj8T6QDCKMy+ErKdDJdiTf1IHymWIOMXI+yPz9OosjWS0aRRAVZCZpsobO3csw/Co64LN5rUHKamUjUobKQVdfO84ZZshTQRDz/nsACVRnCHE8H/z6sgqH96VCDOndspLW+G9lre7U5NJO1iuDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IelBhrCO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e03af57c97so184258b3a.3;
        Sun, 04 Feb 2024 18:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707100362; x=1707705162; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g6yBnfY3UzFsKOhe3zdv68BwX7r2KJEH3xDafT7AqV8=;
        b=IelBhrCOfZO7x5ZYhwcG+Mo+uYFsYlH9fwgUp54TNfspj5fO3yPWoKtkVQ1VZdh0qM
         3p/3/oFboKl6u1vYlFGKwyMJBd81uztH4wRVsHwGxGV2Nb6nvrfhF2UDoDBCjpE3+noo
         QnE/s2jfquf8wWnZxGtSmTXin75wleDeLjS16U4W+VBehjSO5bsmmyAwrYc0JKCYmNo5
         rPNWm0BNXWaDX59DdWbh3eZtARnVX/fqZJ73D8uZYRO2uVH9GlC4VyXu/hgtZuwxgh4d
         f2JNNVrcRdRad3J1YIbchPAX/AyG3Pm/fBgqnkVmpILZy+CaddzZlGF8i7BVht+LBvxX
         GpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707100362; x=1707705162;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6yBnfY3UzFsKOhe3zdv68BwX7r2KJEH3xDafT7AqV8=;
        b=qXrpP/EKhnzcGMTaHe48GyTHgzJrDwbD2SyUt2no8xRS6RHvo3EKFC4t6atkEsubVN
         D6fHGHfdU3fI7fVNrwwHLU/ZSqrzY/32TWlwAodRdsVFktDxutqc3Scksy59ONHSvOoO
         VEjzlic5TwVkYrYWNaezi4SSVtgMqT3dbDuIAloFheIHB+GLryVleyQhX92sRk7OCMuV
         a7reNAHIV9bzvCzRNoA2785YbdoPD3PeVue7NrKRADxMav0bAJuu6SWN5id652hlOg/R
         BROpPSEmvq1cKRYqT4ZmHqFlwYloMP+FcYaw+UdLCkSdgj5+EyzvEPlX+bliySumQ4wT
         z0tg==
X-Gm-Message-State: AOJu0YzG2ONnsZ7E9ceVW5T/MhdgEDJTHdSLDSAjNuAUaDn4gtnoMewy
	RSaArtiI/v49gkz23t73qqK7ANz8oq+BXlup+FggylTKolWnJrhc
X-Google-Smtp-Source: AGHT+IGdcY1Nn8B3prOF9SJW6zNhD41UvVIGI9jfy7zNT03S5YWpLJ6TKNaSh0/R+t9HO7tEH6SamA==
X-Received: by 2002:aa7:9e8c:0:b0:6e0:3207:1935 with SMTP id p12-20020aa79e8c000000b006e032071935mr2354565pfq.32.1707100362098;
        Sun, 04 Feb 2024 18:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXXL+dMjEU/+VhxzUAuep9fMpIVt+asIaveoFXo/TNJUn9A9bO83QQh0ADgF8nJV9GOf6HCixsso+GvrknZkHrKXZcvPaU8KxbCMy0kzW9oJ9AYnx3+TK0+2znDDudPPCshqWeyeV4U0LnonRQ5OxqBXKqXh+5PeI9/pv9i8GSX6qHFEvlz3ad/LkpuiGzGVLfRSEcaJzhap9Rx
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id y2-20020a62ce02000000b006e039e97d34sm1876721pfg.151.2024.02.04.18.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:32:41 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id 9248D36031F; Mon,  5 Feb 2024 15:32:38 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	Michael Schmitz <schmitzmic@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH RFC v2 1/8] m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()
Date: Mon,  5 Feb 2024 15:32:29 +1300
Message-Id: <20240205023236.9325-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240205023236.9325-1-schmitzmic@gmail.com>
References: <20240205023236.9325-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

If 020/030 support is enabled, get_io_area() leaves an IO_SIZE gap
between mappings which is added to the vm_struct representing the
mapping.  __ioremap() uses the actual requested size (after alignment),
while __iounmap() is passed the size from the vm_struct.

On 020/030, early termination descriptors are used to set up mappings of
extent 'size', which are validated on unmapping. The unmapped gap of
size IO_SIZE defeats the sanity check of the pmd tables, causing
__iounmap() to loop forever on 030.

On 040/060, unmapping of page table entries does not check for a valid
mapping, so the umapping loop always completes there.

Adjust size to be unmapped by the gap that had been added in the
vm_struct prior.

This fixes the hang in atari_platform_init() reported a long time ago,
and a similar one reported by Finn recently (addressed by removing
ioremap() use from the SWIM driver.

Tested on my Falcon in 030 mode - untested but should work the same on
040/060 (the extra page tables cleared there would never have been set
up anyway).

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
[geert: Minor commit description improvements]
[geert: This was fixed in 2.4.23, but not in 2.5.x]
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable@vger.kernel.org
---
 arch/m68k/mm/kmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/mm/kmap.c b/arch/m68k/mm/kmap.c
index 6e4955bc542b..fcd52cefee29 100644
--- a/arch/m68k/mm/kmap.c
+++ b/arch/m68k/mm/kmap.c
@@ -88,7 +88,8 @@ static inline void free_io_area(void *addr)
 	for (p = &iolist ; (tmp = *p) ; p = &tmp->next) {
 		if (tmp->addr == addr) {
 			*p = tmp->next;
-			__iounmap(tmp->addr, tmp->size);
+			/* remove gap added in get_io_area() */
+			__iounmap(tmp->addr, tmp->size - IO_SIZE);
 			kfree(tmp);
 			return;
 		}
-- 
2.17.1


