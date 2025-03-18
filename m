Return-Path: <stable+bounces-124766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B64A66B6C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 08:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4941896144
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DB51E8358;
	Tue, 18 Mar 2025 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHXwonhQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE471E51FE
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282405; cv=none; b=rVS+nFg4o8eJ4ufP/PoEfctzGFErxBkgZKOdlFwj/WeXvQFNrNc+fyc2eY8SarMCPQstNIOXf0x8tJwOwfI9eiYISspOIGMP2182hy1o7wgFshkulaksGCSE+PaWLMRmOE4IES9QvAUMy0L3IyWX2Iu6bIgtdjnyoWkaS0wgyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282405; c=relaxed/simple;
	bh=KE3VVb/VcsGNUw7lWuEm5cySxuPzoGdkS5CvuzcY1YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BJXBbPlwPTelupJoEhFL5FEbhreiZtuef3v/iPMIClyH/VMpUgC0yMSwv9RMnKL2Ko5/NUxcJ5Ru86thoT+FR8+ob9U2tWOwbclcB55OKoFW2PvEPIricweGHUkgulzjYo8sR3JLfwAx+PY62j9WqIV5d4TRgU6BDrPHPEYcDzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHXwonhQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so1176717066b.1
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742282402; x=1742887202; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wOQY2Sl3cBtp1I4btkzfk+inVIddf9r7yc5Qn2hSVBI=;
        b=kHXwonhQF7WQigjLP1NPz57OONgvnL69h+H5vy4+CW2gCxc/yMSJxG2EJC6/k/IcRA
         SKyIIvd7wukjRWcLwMo5IloAeaqtoVgfRqb4JNrNYpEG1+R0DXH5IAevmmoX9NHgRq48
         kuHy6W8k/Xa8qnwJ4FEUM43+x5C4z1qTtjqJ9ACvLrw20MEMxAfGYpWUZ4agLQuYrfK5
         v0zQUUi00orRgPsTXFTeCRVCJ1mI+ebQ+Uf8SYk/MZWc5IEapyIrAjd+4A/QFiyfCf2g
         P3pngeEeggdGA7r/MCLHUe5z7E7G3c8GJFg9dQEEx335BNQf1gimBEbzQ3uEXWou4jjK
         r1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742282402; x=1742887202;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOQY2Sl3cBtp1I4btkzfk+inVIddf9r7yc5Qn2hSVBI=;
        b=mtABKgEkYcAhgoGNuF0yHo/TQdofMuU3NGDeopb5Fe+UNR7W/A+q1gbpBly4stbh5I
         w5f0YotAtW+urf2CLfZYGIDYBrVVMX/pkzeWuLTA7+4TZOwJX9q3MYnncZJavbIw7KqF
         M0/jLtimvHI2/r16kxGUiU4zohrCWPAmpgo0VioZJkhJR3Pjse9+Di0PZw9GP/dnHT6G
         EkmiSDNUs5FbbKsn83Uf8sHOpN0XvWyXMtwi0WwpxjylKOYVE88fRlg0yBrOtfjtlSVp
         VmAY7B5IFcr4U/QxBeyysdSyyhylWN9c29uh6EId2akmISU70BIZ5gCB1wVJRCyMez44
         eh1A==
X-Forwarded-Encrypted: i=1; AJvYcCXCP02DqT5vQFMHYFiPsPx2nA8RWeMwLDtZkorHke+zQP2JzfjrjcPxPr8wN+UlRQLvFF+SA6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLUjbgu46Kple3/qjvva9p2HwXijWmBOGbBVpDXgfdviGUU1tg
	QFY+4pGo/SbYW2weyROEXetfOu/jsQEdsljbUAo2IvBLzZrHK/ik
X-Gm-Gg: ASbGncurXapQcYgYY+Ae+7st0jZjSMEjzanLtR8Tnz2BTRYtgH/l0r6uAsjW4MZ5wXM
	CNkHrqCV/7w61S0zXA8vDDlb4qAViM57R48rZjcEz48M4nC+3SsA5tl6yM/eVHF8uaokyVv0dW6
	vjCIrJr93W/f8zTHVHz99rcvW+seHMqM6bIVqveESor1Q1tKMNP3coCWayBkyIIPxcThLEnRAxU
	DXS0e2Emk/VggMShlv3CzTo7KmCxGMqwJWnI1dH4dE+M58T90dkzfgA8TptG682FNWgRz08FYV9
	auQ5WoRfIDcf4SCs/KBiPOanv0qlkIS2Hsk/FyJOc4eQ
X-Google-Smtp-Source: AGHT+IEhvb2+ZHW8QgmHwfldMUR1fhrpDw+JzWWWNaRp6WVUAp9rKbOnonL/rxePMCqjODSEKhw2xA==
X-Received: by 2002:a17:907:868e:b0:ac2:c1e:dff0 with SMTP id a640c23a62f3a-ac38d405dc7mr252426566b.19.1742282401863;
        Tue, 18 Mar 2025 00:20:01 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aec28sm811551466b.12.2025.03.18.00.20.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Mar 2025 00:20:01 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	yajun.deng@linux.dev
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org
Subject: [Patch v2 1/3] mm/memblock: pass size instead of end to memblock_set_node()
Date: Tue, 18 Mar 2025 07:19:46 +0000
Message-Id: <20250318071948.23854-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250318071948.23854-1-richard.weiyang@gmail.com>
References: <20250318071948.23854-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The second parameter of memblock_set_node() is size instead of end.

Since it iterates from lower address to higher address, finally the node
id is correct. But during the process, some of them are wrong.

Pass size instead of end.

Fixes: 61167ad5fecd ("mm: pass nid to reserve_bootmem_region()")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Mike Rapoport <rppt@kernel.org>
CC: Yajun Deng <yajun.deng@linux.dev>
CC: <stable@vger.kernel.org>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 64ae678cd1d1..85442f1b7f14 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2192,7 +2192,7 @@ static void __init memmap_init_reserved_pages(void)
 		if (memblock_is_nomap(region))
 			reserve_bootmem_region(start, end, nid);
 
-		memblock_set_node(start, end, &memblock.reserved, nid);
+		memblock_set_node(start, region->size, &memblock.reserved, nid);
 	}
 
 	/*
-- 
2.34.1


