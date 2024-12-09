Return-Path: <stable+bounces-100270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017459EA2AB
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 00:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076AA1883C82
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 23:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B21F63F1;
	Mon,  9 Dec 2024 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f62AEKK4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931D19D092;
	Mon,  9 Dec 2024 23:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786660; cv=none; b=ZBsChT3E0b5MHGWGwRkeSbQadKsps/B7sDvaoA1SsC1UTxDX9MknxWzeZMrfWB7Rwrr8GqA+xm8xVGVIjF7jEq0t9U7ZoPdJGjWZJ1toXZUek+WV5VfjUEFtGK7JsJCQ7Hn8Jd+dCcmonZ1338NGSuSHlY0t7A0wfOSfu/E7KbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786660; c=relaxed/simple;
	bh=E1IphDxS3ORVprCtYiSW2WjiTiS//F1zBu6nHaY5tRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh1jZxm+MB1SlGkAE6Y3wdnLgsmr045ouvSdtC63tUH+ShNeoGzL24G1+3UFyAsyHq9Ic4fElP7x3yQcAA5JYj9v/8lleejLeGDcLhYq6lgh8Z8BFPeDRciBLcV66IU2hZe0zev+TRfy0xKmizIT4rt9DJ1eeidm82uOE2WlDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f62AEKK4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21634338cfdso25256035ad.2;
        Mon, 09 Dec 2024 15:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733786658; x=1734391458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YG3mTM/FEQ6I0vm5VvHipnykkzlrTy8U2KLGVFiUtRU=;
        b=f62AEKK48AUmy+DrFXPahBQV0E4Z1UZzZ+A7zRJnywW4TsYOEXqSf2iEb5uLYM5Ecr
         bCzAuBzjueGMxCLtNJKgTmBOJbbEPnlKJ2g8OiH3m99PVodDGxY67dYu8TBowvmAdWh5
         o0dkmYJX1w/oh4BEE2sN2A0+/wBhQ3YbNxgxjh1lHz2KMcnYH57EVtl+mKKU83Xyjd1S
         Sl9KR2H1X1o4XHA+YQ42nwx5Mj1JnX/L45crcIxhN+w0Os/t2XDcUmv36YrcWbiZG8Wj
         WK2AUH0xZLWXqDSmwg0Tt9J50qRC25fod6PzprstVUfr/cxAWXWUcrKVQS/2uUVidiLI
         /TLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733786658; x=1734391458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YG3mTM/FEQ6I0vm5VvHipnykkzlrTy8U2KLGVFiUtRU=;
        b=q9BX5ZeG02eFz3/G01IB5phpCcBIIJGFh/TOOG+8W0av0z3tKv5/JVTglOUK81DUrZ
         0PpIFFZzygc25O3feMg+ZiRAH/uTMSmWjZBWLWoHEt+lrNqZExHeluPJZ1WjX2JavKfV
         /Jknc0AV8DNb22pzUg3fT5K59yMTY5Sj48ljF/vqHSwP8D4R+2TkPAPVgyt1ZVK1ZGKC
         xBNOwQNjBzxNk1+fo3t++Dltz/dd5LLp7x4kkt4yGyIAzwnSowH6RtbiIB/wBiFLW196
         G9vQVvWaoj6g9B1/z1HP9IqsFcass1TO6FPuk635Q/Xgwi4AVEzA0jJzTtXcsb4Fi8qt
         TE6g==
X-Forwarded-Encrypted: i=1; AJvYcCUB1nIi3xAWkr04uwmIgLRYdQ0x3oowb4dIc/21HRoc5e7USrAn40OTLQ52RBr9GF1AyAVeR0I93VnvJa6qgZT+Jw==@vger.kernel.org, AJvYcCW5+6/Y8aAPLUhBo5OZkyI87Tfii1HIKTgpWvHToebcYoPTkfi5ztUyxfqHSEB2xY+W3S86xpj5@vger.kernel.org, AJvYcCW9WN3UER3PORsJQEG/KCVyUcXKPv2wds8pl6DMJUbAOgQo2PJHC33WxuReOUQoSyaS/lFoyPFAOOTohIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/28/4mUf/hUdrI7XKSDkriuJ2rO486bVsBGE2PbKqD6jGZaKe
	+CGHhIG/sv/3hm2V0kINVzC5mfQwtKwe54Gv+/GiYnF+GC2cV31s
X-Gm-Gg: ASbGncvwOhcH4RJV/C0bAyv031uFHMdB0gJGpACFTri0li3OvZSr9tn1EQJM4KarhnW
	/CrqqsordblSIzhDQcUWr+8O2BCaGwkmVjksKnD1aOW94eUStzS9tP9RwTsuVqzy4bKQtoY44Ou
	ZMU6lmwlYNuclRaLxmrBP9w8Eyr4UkBgMjERAwZMKGYnjPL7NGAaonwrZ6pn7HS6ZHZ7u305GPq
	9xB4dWGUiFqXcOR5ouDynR/Z/uAMobiQInMIHa4iRe4CHMT9v53eVvvHNlq/pTZFAY2AnWIUNRj
	lcpdgQ==
X-Google-Smtp-Source: AGHT+IGRKFjfA3Zf3oop8a8D8wrJaAdr8DNyoahBEFhMsMFskC8KBJoyIdYoO0MEuounTlwg/snDSg==
X-Received: by 2002:a17:902:ec8a:b0:215:b74c:d7ad with SMTP id d9443c01a7336-2166a07dbe3mr31920675ad.36.1733786658431;
        Mon, 09 Dec 2024 15:24:18 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e7edsm78148975ad.22.2024.12.09.15.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 15:24:17 -0800 (PST)
Date: Tue, 10 Dec 2024 07:24:13 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, jserv@ccns.ncku.edu.tw,
	chuang@cs.nycu.edu.tw, dave@stgolabs.net,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf bench: Fix undefined behavior in cmpworker()
Message-ID: <Z1d8HVO4gXench5V@visitorckw-System-Product-Name>
References: <20241209145728.1975311-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209145728.1975311-1-visitorckw@gmail.com>

On Mon, Dec 09, 2024 at 10:57:28PM +0800, Kuan-Wei Chiu wrote:
> The comparison function cmpworker() does not comply with the C
> standard's requirements for qsort() comparison functions. Specifically,
> it returns 0 when w1->tid < w2->tid, which is incorrect. According to
> the standard, the function must return a negative value in such cases
> to preserve proper ordering.
> 
> This violation causes undefined behavior, potentially leading to issues
> such as memory corruption in certain versions of glibc [1].
> 
> Fix the issue by returning -1 when w1->tid < w2->tid, ensuring
> compliance with the C standard and preventing undefined behavior.
>
I reviewed my commit message again and thought it might be clearer to
explicitly mention, as in the previous patch, that the issue stems from
violating symmetry and transitivity. The current cmpworker() can result
in x > y but y = x, leading to undefined behavior. I'll wait for review
comments before updating the patch description.

Regards,
Kuan-Wei

