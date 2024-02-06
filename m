Return-Path: <stable+bounces-19011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0C684BF0F
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 22:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BCB1C21B48
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C91B946;
	Tue,  6 Feb 2024 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V15MCYET"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D61BF20;
	Tue,  6 Feb 2024 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707253880; cv=none; b=qx/fZUw49V2GOZrX2x2KNvZ/mpyHZ06zDvMVBz+DITQOBLUPWMhwRJsuGTkESz743ikzJmLKZHExp/MWYGfKzGZHyPd26x5RKIqxd9WTf8HuDSP7ZNAus8WFZfPcAEtr2l5m3Yf5BhlRiOUpUOCnS9/Dw+jSnUMahGL+esV2Wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707253880; c=relaxed/simple;
	bh=6W2qJ7emBHDpfjsMd5I+Yh5aNZEm7ERBKlFcs6o7FCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=R30abWg0iP1JrNiW9zDfW4xCHjFKqVo21Jwc7zm/w91sy7oHgHItOp5oBVq4bY5UrKjgrn3fUj2WdGQm2igmztHkmwElS/Fkq9Rl7ZbT3PcB0J1u7jzrilLI74xPa4tZk61ORy756C4GTCHCFo2erH7ayhJ3bCGrUoXgQbVlZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V15MCYET; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296cca91667so806976a91.3;
        Tue, 06 Feb 2024 13:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707253878; x=1707858678; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I2CG33VPPpXBW0bT6gJ7H7D26BUksG/NvgMt6SM3LZM=;
        b=V15MCYETce+D2589znVr25ARUhG58effZJWBLIo5sEeWg/9ryWMuxbULFxIilAlBoq
         /ybSNJ1JHSWuTJ/8+ZjtLSaF5wtL12cj7KCeLHWyEmvAKwUX6YwEeYqqAKKhlIx729+O
         Rjp7RPa4QapwxPWNPz2IlScQ6PPmOj+mwb6GtM/iTkVHWNYUgADLKzkAKcWLj53jr7p4
         ddFyqcGZzz77/Wuu+TdxxqvTsYEq9CJTb3/gsAzc8mAd1h4MSFF1W9+z7J4aSNIZKIMh
         tBKpUxIkqbdhXGHkWsLEFVNNNtCCDK3TdfZUP/X4JX7Yl7+SbX42XnFYxB/nPWC1KP53
         O5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707253878; x=1707858678;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2CG33VPPpXBW0bT6gJ7H7D26BUksG/NvgMt6SM3LZM=;
        b=i1L5DoJm7Jcpn+DH42x9qwl0IBd4Vb1IeTiu4CIeuZLXCdHEjc9HSrEtlD1kdO+ddm
         Oz8rc2McA8QkHYwQvmzbCIeYIUklEDvHRIPjhzgZmAbS1mNfPTTlcaXvdZ7x6RGxw1rY
         CFjLIWwwGuAqr7XPMDlCNrZmixeX43RlVxRvR6FzoMSu4hWRjnZH/HCh1YYoYMFS5PbC
         E/mzkJ9S6sPRMWjZfZvbDguxyC1QbJ8kA1PsdDtRAqSyDPuGxE6ONwBr+roaLO+pSBqi
         Udd3lQRAQcNizgdNSjNNrwomZVXnXwcX8a88VBlF5hOHmMuO82/mbNP8ktUQ590sCX7a
         HyaA==
X-Gm-Message-State: AOJu0YzzxRuba6mtJ8Pj/j5BfsJgwPOURXoytlDqjC5528ToEnAx3iEJ
	Gh/IFOeOL8yx1FxXTOwf5nhkvn4N2vUoQPw+pM416fXbKlVq3rem
X-Google-Smtp-Source: AGHT+IGVeb5RZpfylDVMc7uFzF0bFVYLKe4HdkLjmpP7649rzmcsyMIf+ArF8LarY9xNjUUvum2wXQ==
X-Received: by 2002:a17:90b:1bc2:b0:296:a746:67f5 with SMTP id oa2-20020a17090b1bc200b00296a74667f5mr713716pjb.44.1707253878470;
        Tue, 06 Feb 2024 13:11:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5VIR9m9MMf8pmz/Juke+rIkiaThYJzHJEqOC6aLZ9e2M+FwS4sPB2eyROhKpqeAHdIkbPQy2JINmb71r9IAgdX4igZZDAs3slsD2qWziJjP51PAEccx8LWS+M1b2XHsOAQW8nETQFLTVwyfZMKjNLdGW+H0GH+lVta8YAKMl8wyRejRxG5qCyXKC1LrSmpMtYgEZQW89ZewsAwjsJPJbWycuIzCPX40cyUwyZW1iWp8JE37FBsk/fcw==
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090a468600b002961ccd55e4sm2143578pjf.31.2024.02.06.13.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 13:11:17 -0800 (PST)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
	id B2A2036031F; Wed,  7 Feb 2024 10:11:13 +1300 (NZDT)
From: Michael Schmitz <schmitzmic@gmail.com>
To: linux-m68k@vger.kernel.org
Cc: geert@linux-m68k.org,
	uli@fpond.eu,
	fthain@linux-m68k.org,
	viro@zeniv.linux.org.uk,
	Michael Schmitz <schmitzmic@gmail.com>,
	stable@vger.kernel.org,
	cip-dev@lists.cip-project.org
Subject: [PATCH v3 1/8] m68k/mm: Adjust VM area to be unmapped by gap size for __iounmap()
Date: Wed,  7 Feb 2024 10:10:57 +1300
Message-Id: <20240206211104.26421-2-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240206211104.26421-1-schmitzmic@gmail.com>
References: <20240206211104.26421-1-schmitzmic@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

commit 3f90f9ef2dda316d64e420d5d51ba369587ccc55 upstream.

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
Cc: <cip-dev@lists.cip-project.org> # 4.4
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


