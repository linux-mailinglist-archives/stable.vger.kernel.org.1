Return-Path: <stable+bounces-126864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A433A733D2
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 15:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4075F3A8C31
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3421766A;
	Thu, 27 Mar 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gkcBeA5e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425AE210191
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084133; cv=none; b=CsrMhc8k+a7d5Q45g+bYjCgcBB0xvD3RCyBXqNw52ojLRE1tHbvFAnl7Rm1/vq8M3fmcMenBz2IBsVs+zXJfWDQYptcQHzmQvSnsBlqk/iGKRW6fQd9b0wNWYPGy82o0tLwi94TzR3aEde1y1gJDiw0xpbQEMN3lmuDT+Hs7qfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084133; c=relaxed/simple;
	bh=cqf11Pz9JhbgAIl3asxDpX0Pyj8CKqlu4uBXva96xuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD1sYC8OrhawxR5XswUsFpRVXsW5sQtnqR0Qc/IW8dKOgTKezvC+iJmt7c7SB0opbArMCBRXVmPx5gIwBJGVjXaD3lanLqo9snITSJqRV8LvgkO6Gqhkv9tEOIfO6mGSRBKhQoJ8fHbNWz/M9y+L2Bl0E45jvwILTdd77sMZKcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gkcBeA5e; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2279915e06eso21920805ad.1
        for <stable@vger.kernel.org>; Thu, 27 Mar 2025 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743084130; x=1743688930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I6+lzTRwJoxGLhsBP/jpjF8an5v1mXJJ/EYMWzXoLZE=;
        b=gkcBeA5eyYOFPJgpU8WsgV5Ks9coIAQgltTVZ4dpBrzPoIcWvEcxgK8eWkcyxIZK7k
         y4B4zaHuz+1SjPFAfHRznLIlicOQdXYN/z5JuKRdEa/Cuw7z0gsY4OA/qkEm49EmZTRP
         jDtRSv2ENZ4m9FqQp/zF2l5Uhf4Mu/xZWrTDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743084130; x=1743688930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6+lzTRwJoxGLhsBP/jpjF8an5v1mXJJ/EYMWzXoLZE=;
        b=LwmpsFok3OQC9MBFHhZFmIKNjuNmP+Gzy1F70MAVN/gzg2mZFrTxprnAS8y0qbxeA0
         bALy+V9SiLdZDC1ov32SLbbIdU2kCPMoUP5abKnDZbplzsSDCY0Gt2mitm5fPSfMr5mR
         ndXqlRpP2+MUhZ9Qas2ynkUSttHmZZMnIbC1N3IkI8CmHQEJyoS7xs9RGJd862PKMNIG
         TM4E1U3bnv2okFyQl7iP6vGTmlMlUEbYDNLHooUQLZegEZ9yE98JXAXHlfhrC92XBEPF
         nBYgLiQB1sXWzgF7AOHyZeNsLMSK3Mwmbgzmwg0mfSK4Picn+rAJekv1X4a5GqHHTAzV
         Jxcw==
X-Forwarded-Encrypted: i=1; AJvYcCW5pLtOVZ2aSGSGRLc+CyR/tuSFLT4mkyFs3wG6dQ5q8+cYDgEDDJpM+U2bzayf4XylA4PXma4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG0WCKTNlJP0OG9y++2jrClU3/U3hEOZmAjN9/rQ9I5w9EhYuf
	b78wmVmZ3ViVn6aetQIZZHpv12Zbc0rS+4G8W1gXiruZ2KXOxR7eenW0OANE80Xy/1Ab0mKU6EQ
	UEA==
X-Gm-Gg: ASbGncuQx9o2b9SXe7SXxDsQFwsTQRsrtlepXPeXtJmGALtGe4ZgwmeShOMfW9EgvnE
	OBWt4SKGq37B0KrDgllKcSEtogkp9ZtSMbQUetfQVIqrmApkgFfMa6HLjWJI4tTzqt2w65VlK02
	YLcIGMz/cVRgnT4Q44+frY4jmJ8VX2zC9rdTBL2JRQMAaKcWKyQBgUSS6to41LVQhcXKvduhJOi
	JPBLqKmElit6t0F37rU2Mm1ji/9FF3ixXTHgWkfYFZpwLl/PoEH0AAbKyro7CmHIfXcTR66g4do
	M+btUBxJ1Jx/fr6pbKeO0/QcvlkFmaQ+bobGmQsNC1OTQV0=
X-Google-Smtp-Source: AGHT+IG5RDX9ELKWhy7U+xRS3VIKhi043iiEwxA4WvUdw/Q6+t/DjvYPY7UK3SxprNLahK6GIimuUg==
X-Received: by 2002:a17:903:41d2:b0:224:912:153 with SMTP id d9443c01a7336-2280481cebamr53711055ad.5.1743084130287;
        Thu, 27 Mar 2025 07:02:10 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:cd9c:961:27c5:9ceb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f651asm128518625ad.209.2025.03.27.07.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 07:02:09 -0700 (PDT)
Date: Thu, 27 Mar 2025 23:02:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, 
	Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2] thunderbolt: do not double dequeue a request
Message-ID: <vxocwwtfwg3tmjm62kcz33ypsg22afccd2ua5jqymbxaxwcigf@nnydc53vu3gv>
References: <20250327114222.100293-1-senozhatsky@chromium.org>
 <20250327133756.GA3152277@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327133756.GA3152277@black.fi.intel.com>

Hi,

On (25/03/27 15:37), Mika Westerberg wrote:
> > Another possibility can be tb_cfg_request_sync():
> > 
> > tb_cfg_request_sync()
> >  tb_cfg_request()
> >   schedule_work(&req->work) -> tb_cfg_request_dequeue()
> >  tb_cfg_request_cancel()
> >   schedule_work(&req->work) -> tb_cfg_request_dequeue()
> 
> Not sure about this one because &req->work will only be scheduled once the
> second schedule_work() should not queue it again (as far as I can tell).

If the second schedule_work() happens after a timeout, that's what
!wait_for_completion_timeout() does, then the first schedule_work()
can already execute the work by that time, and then we can schedule
the work again (but the request is already dequeued).  Am I missing
something?

> > To address the issue, do not dequeue requests that don't
> > have TB_CFG_REQUEST_ACTIVE bit set.
> 
> Just to be sure. After this change you have not seen the issue anymore
> with your testing?

Haven't tried it yet.

We just found it today, it usually takes several weeks before
we can roll out the fix to our fleet and we prefer patches from
upstream/subsystem git, so that's why we reach out to the upstream.

The 0xdead000000000122 deference is a LIST_POISON on x86_64, which
is set explicitly in list_del(), so I'd say I'm fairly confident
that we have a double list_del() in tb_cfg_request_dequeue().

