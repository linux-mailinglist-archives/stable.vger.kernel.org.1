Return-Path: <stable+bounces-124159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9ECA5DD74
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 14:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7287AB48C
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 13:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E08243956;
	Wed, 12 Mar 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzbZQNLc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808B12B93
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741784862; cv=none; b=jsr33sfLjZ6xqhZLmK+nJoO82yNBvyZBOgFUzuyWUoOGYaDeMjLxn4RcGa3iLHRZRivzKmwCQ3VMrbaRqMg0EHTJZjIC7cj5BMA/NgDq5usrOKAeO2zKlfz4qEAom70qfTeLDKpof3W0EFOKR0TPZMwyGIzt2Hq3KnRL1MjHaGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741784862; c=relaxed/simple;
	bh=KE3VVb/VcsGNUw7lWuEm5cySxuPzoGdkS5CvuzcY1YE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jCrJELr9r0JO0ZSbXCSw6oihPE92FyPXfOe4CIOLpklXf9jaoN08PL7RpX/xV30EoUDoVSwlHviGiJMC65OIOBxMQD/aTKqGmOPA7K/nxahCJ0pS8rJ/jMg03tIb4GYsmHOe2XmR4PEGWZCI4eGymgH0jmiLax3MkXkIs6ZuNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzbZQNLc; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso8446150a12.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741784859; x=1742389659; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wOQY2Sl3cBtp1I4btkzfk+inVIddf9r7yc5Qn2hSVBI=;
        b=DzbZQNLc+fwrHqpCT2IUJzKu7Z/soExoAQQ6NAxIlURN4X6QlZZs2xBVyKD/RN4Fjo
         inluIFu07Gwng/fL6v76yg256Z52XZV6iv9AOKi1jMhe1mt6nfcW8186kTIS5Ryn45/X
         dez6RK1aGfvtXAooZD7+MyWtgXRQpXyfOLMHIQEmijIxSjzDadMrKxnbnyAYEdyF4wN3
         14H1W67w7loNwF+ULI9/Hx7IgmuJaJDFCeSfEA/+i1Oc+3aSf1nkiEKLtS4JHwzlqOOH
         yjpPY6ZpIaWDa2zJ+URiplwvx3hK9MgyHoo1B615+NKQLaia9UBf/mdAl7r2DzBsNiWD
         Z51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741784859; x=1742389659;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOQY2Sl3cBtp1I4btkzfk+inVIddf9r7yc5Qn2hSVBI=;
        b=ipMD1mki1Z7/h9mbEFp6Cj5ZyQOvBz2EW/2CyOUcEmsm03LeIRe+e7xk8+jn9XzMju
         Q4JJmVcHXYHvl//5cn/4lP7zCxdvEWy12bAEzufvwnogxW7XzqUuntWMpyvtGWCS+qys
         aqZEtr5avIWbwNqw5AE8J2y8R+dcP67s24R4JSX0CEt6fcAEtzcvfmOdEFtoMg/dsntO
         dFiYrbkMySC6BgMEUIb28hUR+RlqmI1oQQ3rlVASrvVKxTczRhbG2WX5HC1vUjR3PP7F
         APAqDTJs8GBy7sr3OiLAwFy9p5DRNNHRS7iHxusxejh98CL5wW243MVkka1H0wgPfrHG
         AMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQr0vxaqhSvPr6qrHL9q/bi0xuLzX2eeixKjTkmXvr+kMrgocjBnpAerB48+xMiQp/mE0+OXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmk2xsvwRjOyiynnL43VrjRngCBJdhlaLgrHpv+POLRdJ++LV
	2iey5eYCdiuoyNQmsrfmu7IHNDwwrTQ7DuwtB+mWh/dDzk42SUbU
X-Gm-Gg: ASbGnctFle4JrTRMAAqnRsVBcdMP8iG6ivWvP9M/RzCaMHSRV6lxFiDHe9ttCD8v7sE
	vurCPrJ4TRjAZsONCIf5tBY0kngEqjJwUqR/2GrCDjbq1veYspkgDFMWVbR/2uVxmmtEhaYzZAA
	74VmWGg2rEewAXnKEgJr21rXSkEamDT3jbW6Ja/1QhQ4mRy0LbfrPX4XppmG7avJccr83zON9Ji
	DdgTkBZyzdzWKXskoNGdQrpb7R5W/wBulVtG0thPPMvN9qFPZFWLhSF1rOGW+w0BWS7rHUZYtkg
	oY5c7jrL9h1KXTEJW7NCtqREvswV05VibmwsGXO7CSDy2AwbECVeeF0=
X-Google-Smtp-Source: AGHT+IG83SPr1vXm/EKJaEc3qHbCKbHCH3cOaoWT9J/EiHl38XqabL8gmb4G36WDVu0yC7WgMMy8vg==
X-Received: by 2002:a05:6402:27c8:b0:5e6:1867:3f7e with SMTP id 4fb4d7f45d1cf-5e6186744c6mr18400588a12.32.1741784858251;
        Wed, 12 Mar 2025 06:07:38 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768c2aasm9722403a12.65.2025.03.12.06.07.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Mar 2025 06:07:37 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] mm/memblock: pass size instead of end to memblock_set_node()
Date: Wed, 12 Mar 2025 13:07:26 +0000
Message-Id: <20250312130728.1117-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250312130728.1117-1-richard.weiyang@gmail.com>
References: <20250312130728.1117-1-richard.weiyang@gmail.com>
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


