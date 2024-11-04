Return-Path: <stable+bounces-89740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A179BBD33
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A399E1C22BC3
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5991C9EDB;
	Mon,  4 Nov 2024 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBWwq264"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C51C729B
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744463; cv=none; b=Qs3QrvQy29Q8TxWHaLbKqlLnNxFLWD1soOJH0smI2MuJyAMT8E0UZLlZI2XS9+4vOmCGkY20q/RtjHuO6CpHtVxjECKCf1WGEYXEvdfJqaqQBLBeSFdzOjH/hM4n9YJfM3JAbat+XDGjGdSE689ibzos1da0Unne/7qX1Ni6FYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744463; c=relaxed/simple;
	bh=M6xDzNAKcs36VWJmqh7kjILMTWmZO9OGbW4mqT6HmyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqUrt9Cvv8h8suwV0byFKInRSgkqGRJLo9hTkS9O35ZceJserNpamRu7k4pR2Eeqf0dutsJUyOJL9mHhZwcLlyzFhBn2zdnFa7eQBNmnmTWmIYHY/TNYPHnFykkbW0fvOIZX6idiTT3JfKbH5gZjjwKlpNjNMF1eEGDadfvWLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBWwq264; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315eac969aso27924925e9.1
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730744461; x=1731349261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvgKojtjxMMS6cqT1h35DY7bZCxI4idU/B1S0RQ7cd4=;
        b=kBWwq264szWaphLKiF9s/eMuSNA6tvH37jOs/B4TBl0RQzxPmKzZu4iIgfXEDqj0VA
         G/LZ0wi9JpyPtN9tIY9orcifFYVpXCs/rxRhPtGypf/CTWso/LZlpUJde/EjzZN77SKr
         qjbyewRA32ztUzEUzTMGwCj9jC7DMtvFe5bEjB9faQPrUMmcIiLWEyWae2N3tNDPUAtO
         oOXjHeUnwiUl3csBUYxMQtHTgOSKmy1eX+XwSRAbBQ3I4mZRJ7HqNryhA7fEf7lgLVtf
         Hj5q72WFEL4lhxNT+FEWJ8jdhQ8LAZ4+tBoLTyF6DHogJhlRSejlrxD7WLhykz0IScT3
         DsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744461; x=1731349261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvgKojtjxMMS6cqT1h35DY7bZCxI4idU/B1S0RQ7cd4=;
        b=M7ypig9WUp55aw8Pmdqo6GKn9QK3gEPZYSfJi8qOBsx7AFYxy7J8Vr9mQD2guIwzOB
         P1FOSlgX4oIL0yP9hBgPfB51YENYo8ICIS9t+IHuNf/hZ8ZvIEx7kAyC7kEjTV72yCd7
         ZVKkTKgwNSYeaJjPZrPeSDQ4L8T9es2/Uc8oWmUnxQ0SUDeRiIa+LLIcRXBcC2wkksZ3
         AypRZTywpofEr2jafm3rJ2yu/Kjl9NwZ+IjYUt5X2Zs2Gs4pEOA4s+z8lVvioS2FO9fu
         GuBSbzoQ9sGMu1K7sGrhcGs1+6VogCLFJSRe9VnlmkjOErjX4qykliXzgzISo39fNVgJ
         Op0w==
X-Forwarded-Encrypted: i=1; AJvYcCUIOr5iREJlSfkeIXy3cKc7fmqq9iMRMFzcZQNwLifsfSel7Gw5/Urp9lL1GNpmcxw7rY/Vfbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dRSSDofC+ctuG9K54fNHtnkE2w1LGUDOq2adPecgvWF9T6D7
	TC/4Kary3dz86nuL0QiV1M10JvDpp9jvew3nNJQwsEQzmmWUoUqMV0fwRAGUJg==
X-Google-Smtp-Source: AGHT+IGCf2kXxmfohJmBXmuH3j8pJHDrbqFMRzviLHJM7ILP9HJYPdAB1K5kN0pfn2Myr89luXLdlQ==
X-Received: by 2002:a05:600c:4449:b0:42c:ae4e:a96c with SMTP id 5b1f17b1804b1-4327dac7732mr131855855e9.16.1730744460604;
        Mon, 04 Nov 2024 10:21:00 -0800 (PST)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7e2dsm13835508f8f.11.2024.11.04.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:21:00 -0800 (PST)
Date: Mon, 4 Nov 2024 18:20:57 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Message-ID: <ZykQiY0jvxKqrCIb@google.com>
References: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
 <0bc2e4b0-4dad-4341-a41e-a98fbc4b1658@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc2e4b0-4dad-4341-a41e-a98fbc4b1658@quicinc.com>

On Mon, Nov 04, 2024 at 09:12:09AM -0800, Jeff Johnson wrote:
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> And it is exactly this kind of issue why I'm not accepting any __counted_by()
> changes in ath.git without actually testing the code that is modified.

However, I was really lucky that my setup used nl80211_parse_sched_scan
during normal operations and triggered bound sanitizer. After the patch
was developed, I accidently wiped my device and couldn't reproduce the
bug again normally, so I had to use iw tool to trigger
nl80211_parse_sched_scan manually to test it properly.

I looked for some tests that cover this function and that I can run on
the device, but couldn't find any. It would be nice if you know about
such tests, so I can check if there are any other places where bound
sanitizer may be triggered. I only know syzkaller tool that may be used
to get more kernel coverage in general.

Best regards,
--
Aleksei Vetrov

