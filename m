Return-Path: <stable+bounces-90046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA07A9BDCED
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AB71F2130F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B6019007D;
	Wed,  6 Nov 2024 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIKigZNR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3570718FC79
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859590; cv=none; b=dcxiqa7jGWbxMVILs+M9VvyLfh/zKqduuX/zekFkOaCEVu17U4gUkugE/FekXqeAyj6NyyGmAIW2184U4GM5HK9JYxb6Fy1oKIY+iZF1nfexDauseQt76fCB6ukmUbhNetQI+qkOBLuZaC3FPXeswyKkUz4Tdyg8CC6UT2+5uE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859590; c=relaxed/simple;
	bh=b8q2jY8ZdIO3Ym97tVpGEDxv/nMS39Kw1g/jf3jclLg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=N74f0sL22ONP7iKlDOWT3GJ0D31iGgDuK5qgH3tmfyH2QTaEIzXK7a+TRQAdfYLL0Z1/U99p0PvEoPLhvz/mzssbSrPf+zB0NxTsQuCiVDOtu1fat4tOOTTCvXCabEVKT+6nz/vnpAZhMjDb7n242vkaxMGHayvxal3DykLjtGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIKigZNR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20ce5e3b116so49667395ad.1
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 18:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730859588; x=1731464388; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMwHZbqveg3qfQOk6hXWoEkDSZ7gjetBd5tA/0pn/RI=;
        b=bIKigZNR6I6/XOjUbUZMTRz3PqfJuK+1bWdAgJ9AdgnwwQ2qq5mLfbcESFVtm4pxII
         uFIIjExoHCF5joDo0FYow7n6H+Z5BbTdbmzMX5UZ4th1mCE+ojzJIuUnWFSWjJmlXueb
         Zvop748N2lSYGi95x/keGSvAyVs6Vuipl3vw93YrhIm4dy2VI/0U8oyCevishWhL4wNX
         kG3Qx3zaC6cA73k9NYwyjvrUrOzsZlmk4ZwCs7mY22eZ60CBJpOgdSlETbKSB9k/enhh
         sMymXX7aRLIC+996ff2DlDLvPVrs94tJsikXYs/DyvXF5Rmv14rHOUohSYBDokE1gV0w
         uilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730859588; x=1731464388;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMwHZbqveg3qfQOk6hXWoEkDSZ7gjetBd5tA/0pn/RI=;
        b=K5owPIUtlWSzRDtkijH7Qr/qh4ASuCo88mrOrjMnIltEni/CPkjjZAYsOYSWtV4iZE
         GJQ0rwd/+fUPadXjmlMU8MtYqta1Hq4EbdZ7H+D8+8Pq8H0ZiR23t+ApItN7zq43XxVR
         ZWNb86HMfn376rPF7MPFvMqpS8hHQbkm+mFWWtPwHdkdr3oIGx+acIr7lS94d9Mk1onf
         ++WLe5Xx1wvCegrZAPAxC8OGW0sUBkL1gW4hzXuT3j5j2K8wdwhCZCR7NRyDJeWS1vA1
         3af2uftGM+X40fse0OOEPSHEwQ6Hu8nw+21gGYjCidB6xyE5nv0bhSDAg/O7FkGklRF9
         tGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDv5cOYmSM4B2FkDmZutuXNOxLUGB0QdDqX4TUfNVW4mFHt64pfpItjoOPGZnaO4vyXnsx1Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PdgSPrFs+v30FwsG5bgr+jevcdMHGaTmayMu7Drr2FG88loK
	/dyf8blzM0pzN0YC5AvuJOnPFWTe0MDp4418pezwUS9Ygl90PJNaeygmckDu/w==
X-Google-Smtp-Source: AGHT+IEx7//yPBQ3NT/CkT68ddSvV9UoTv2LGlCxfnUWr1gNgfBvRseUNmE7hQwH0O970Uk23pjQ7A==
X-Received: by 2002:a17:902:e5c3:b0:20c:aae9:7bf8 with SMTP id d9443c01a7336-2111af1cfe3mr222576525ad.5.1730859588402;
        Tue, 05 Nov 2024 18:19:48 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105707e43sm85878085ad.97.2024.11.05.18.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 18:19:47 -0800 (PST)
Date: Tue, 5 Nov 2024 18:19:38 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
cc: Sean Christopherson <seanjc@google.com>, Hugh Dickins <hughd@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v2] mm: page_alloc: move mlocked flag clearance into
 free_pages_prepare()
In-Reply-To: <ZyrHSfS8Ro0l5VCP@google.com>
Message-ID: <b0802ae7-b9dd-da98-1268-9084f269ebde@google.com>
References: <20241021173455.2691973-1-roman.gushchin@linux.dev> <d50407d4-5a4e-de0c-9f70-222eef9a9f67@google.com> <ZxcK_Gkdn0fegRl6@google.com> <ZyrBuZPBjJi75gGU@google.com> <ZyrHSfS8Ro0l5VCP@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 6 Nov 2024, Roman Gushchin wrote:
> On Tue, Nov 05, 2024 at 05:09:13PM -0800, Sean Christopherson wrote:
> > On Tue, Oct 22, 2024, Roman Gushchin wrote:
> > > On Mon, Oct 21, 2024 at 12:49:28PM -0700, Hugh Dickins wrote:
> > > > On Mon, 21 Oct 2024, Roman Gushchin wrote:
> > > > I don't think there's any need to change your text, but
> > > > let me remind us that any "Bad page" report stops that page from being
> > > > allocated again (because it's in an undefined, potentially dangerous
> > > > state): so does amount to a small memory leak even if otherwise harmless.
> > > 
> > > It looks like I need to post v3 as soon as I get a publicly available
> > > syzkaller report, so I'll add this to the commit log.
> > 
> > Today is your lucky day :-)
> 
> I've been waiting for it for a long time :)
> Thanks for forwarding it my way!
> 
> I'm still not sure what the conclusion of our discussion was. My understanding
> is that my fix is not that pretty, but there are no better immediate ideas, only
> long-term improvement projects. Does it matches everybody else's understanding?

Yes, that matches my understanding, and my Acked-by stands:
thanks a lot for keeping on this, Roman and Sean.

Hugh

> 
> If so, I'll prepare a v3 with an updated link. Otherwise, please, let me know.
> 
> Thanks!

