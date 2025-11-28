Return-Path: <stable+bounces-197577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25656C9198F
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 11:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C352234E7D7
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F430BF64;
	Fri, 28 Nov 2025 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFGeA+A6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42C30B51D
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325125; cv=none; b=YmDxSgiW5Emf37aphhKVq84XJcI91Ji/5MD0neSfj5HNd1EAQZO/4stalwbYQ2bNtCAkBJeoXmKT8D4sVVZVgiw/FvoTQET8QUWJawrnezq6qDSt6BOo473g3TgiqPAwVKX51x3IWAU+VNrmcMjdtLcRshwYLq3A6vR49Dx37vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325125; c=relaxed/simple;
	bh=I+gwoRSmagBgStXSAMUxGw3r28zlsiNpuvXg9C52lGQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=M6pgk1vbE67igr2KptP3DedJxGmWwuEScwxImDFTL/nG0AYjZ+eClRBe/gYPGzuG2k6j3R3jZL2U6NO41XBlaPFZKsoO3LpTiZDav0arFtZWXVyRlcB/kQhJPqm600ut3IqfDcsNXq1vc9ydE1F0d0dG2IN+dEqoH/bDgcYn82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFGeA+A6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso1374499a91.2
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 02:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764325119; x=1764929919; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKbiTeUE4R3+lfUE5lplRGltmZWgZb40ftgeIyEu5hY=;
        b=GFGeA+A6SGxlci2XgI0ZRg/5C2ftJ6qwowNe4p2ocYYgKD3nbtH40k/M8Q9xGB+Ygo
         bloo5h5s8djELhZ6/sOd9w4Ya/Sd2dCyKutgixf+9PTFtPt9QVuZcCjbjU7xOTM7ovBQ
         O75CpuffVBZbNIyUL1ygl9L0NCYMP561EbBkCClqvsw3KPtUUa4o9u52F+y/utjTIwgA
         u/Io8+RPe5HoJ7AIyCsEe7gAtSIFd5rEM2xr5si5q+O0JPYoT5D33ogRPYMlOz748Uri
         Nfbne2E1oDoxioKPIVIWg8oqMHn80KUZJLrA4ey01eBmq3fB42/EimytnT+mijG2lm7q
         hs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764325119; x=1764929919;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKbiTeUE4R3+lfUE5lplRGltmZWgZb40ftgeIyEu5hY=;
        b=NLxSJvrN99qLyUP7HTn0SKkm/SO+BJeNsZsDLTyCw1lpkCSH2SGO2L4TDfg8UASuvi
         ag6xAomxjaGjJic64QAxG7SOvWs8lOCZeecb0y6FhcRA6cDirAIIa9rapSHzzbdHewTD
         rnmaaGyeL6hLpI27Sv67Ro1sy5kGGvWEa0YWH+xieKTaSeR0QFrLbKgMF8DEXrVfi21U
         zYAeWwCtNtT/tz2UvfWoYgFwABtXJ8jvwxrUZ1py+b7+OohsA2SMsycfXicb4kA3mOll
         l3I/AXnsm4P56Hee7vNsq5i9958swCU86wEerAuQ4inPPxoPx1NbVN4NyBfRXCPGk+A9
         F8eA==
X-Forwarded-Encrypted: i=1; AJvYcCUMNY/VljJKxhtSSLEhh1CFXrzOS6264nLFpHBEsH+tfEiuixiQ814SdYLFMWhIabynfU5JOxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56vB9S6DL+RDO1kjz0fAZIz9ulvrfSPlb0W2p2l9mVtFUjSAC
	Gv+Aqr+0WrJMYlo2XHKIKL2O9Ao9RuXGNJcGjmjsnH2dWFhbj8UAD59na/M/Qqy3
X-Gm-Gg: ASbGnctILWYp5GnQKhe13JCYXZxP3KI8ZiIo/NswsE5FE1n3SCKDR68rWZ2rL48a5sp
	DZ2cY82Dn1C7VINohEp5N+sRGUUiCoSzXgw7D3cfqsGzggjAE8lwtDXhPT69z/ArIkg0i1bO5ZA
	4DiLLPV0AoIsIEywGlyQkFgU9SpB0WiFu0MpRd68Tur2BtB+KQar63TWkBqi33Vj6v8CSZhwbLE
	BAEck6vGKw+1/HaSA9sRqztszyDa10+7lfPfxSVlfy9vysH8UG7/fq9RVb9iYi48qL1q1g67R20
	6xTS8LoipfNlf3DQ/XyOyLhMhsi/I/9kJ7qA2Qn7FLwbkiMW8NAd55t2vVHSJkcTAm/oH5NkEb4
	/2qBZ3K4tR84eLYSDGWemmmRRdbp+Zumn1H22AFwBytxRWhDgWhyCVLxpwgacY68jN2miHaYguK
	xSc9+qXQ==
X-Google-Smtp-Source: AGHT+IGge2gq0mku+sItZjWCM+QW1VZVA+myW1HYnwoNnxALy8Q8T5+kveNTTgNppIT8jE40jNKyHg==
X-Received: by 2002:a17:90b:3e87:b0:343:f509:aa4a with SMTP id 98e67ed59e1d1-34733f50568mr23997342a91.36.1764325119491;
        Fri, 28 Nov 2025 02:18:39 -0800 (PST)
Received: from dw-tp ([49.207.234.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a7c2ce5sm7999198a91.14.2025.11.28.02.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 02:18:38 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages
In-Reply-To: <20251021100606.148294-3-david@redhat.com>
Date: Fri, 28 Nov 2025 15:42:00 +0530
Message-ID: <87v7iumpov.ritesh.list@gmail.com>
References: <20251021100606.148294-1-david@redhat.com> <20251021100606.148294-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

David Hildenbrand <david@redhat.com> writes:

> Let's properly adjust BALLOON_MIGRATE like the other drivers.
>
> Note that the INFLATE/DEFLATE events are triggered from the core when
> enqueueing/dequeueing pages.
>
> Not completely sure whether really is stable material, but the fix is
> trivial so let's just CC stable.
>
> This was found by code inspection.
>
> Fixes: fe030c9b85e6 ("powerpc/pseries/cmm: Implement balloon compaction")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/cmm.c | 1 +
>  1 file changed, 1 insertion(+)

Make sense to add vmstat counter for BALLOON_MIGRATE as well.
The changes looks good to me. Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

