Return-Path: <stable+bounces-205122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4338CF946F
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 17:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712E93018D78
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651AA338590;
	Tue,  6 Jan 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="i1zDWpvm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6503337B8E
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767715552; cv=none; b=Vh5ve/C+e1/6TCjq1al+TMzqUK35XQYsY7FpVc1aRiEU+RkCCahjBDRU7+kHcIX1pfmcmgnolN4CDJru0njcPM9wLMFEagNKwuzbLLCXC5HiFx0/NbudZjtZqo7zGZuXU/Q16e8v8sl4a5OgVMTI+X+GPf5+Lr4lS7LqCp9IbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767715552; c=relaxed/simple;
	bh=P9pkAPzgU9jiMtELSPkK4tgujKYh/5GTTPxNlHaGGAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJOMgCdgWszlubUTEyywAQMbxNB9OkSr/OiFCLECEI8EOlvD808q9pkq2AmG6oGm5m6241tGSEVxbp92vpD2zueHn0lLS/k2r4SVYr2liBD50vpzhwZpBbnJwmOxUqeUCzBcAWUNjCaMGf9gqkiRsLAyaV2tvOTmWoSI5uu9iXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=i1zDWpvm; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4fb68720518so10711681cf.2
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 08:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767715549; x=1768320349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bxubu6bhf1aeIofDmdnq3Yy4S+a1o4zcmmWzD9LU3qU=;
        b=i1zDWpvmvujJ8hsl6QDaxmK7HlaTbH5xsQQf3kaeLWXQ2Nksg9XDA9sREX2gslCBum
         BD8/cZmedxX3BpVDyMvS3UNtIzZGjBfuk79roGeEJ2N8IUKZQqnK4IAzZZ6L+fpPXxmh
         IzNT41fhbnGq4jvOsVJ/QehnNdzLLVzMmUaGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767715549; x=1768320349;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxubu6bhf1aeIofDmdnq3Yy4S+a1o4zcmmWzD9LU3qU=;
        b=ED8mKBxe33et/KONByGzl0oVGJoe0x4k+/IeUPiii8GWI35Pn44Yw8jktZ81XX1Cje
         QhqRGYM3meNmh+K0P5kcHL+Di6/9WZdG3k3mFqchpAI3qy+9/qcwDC2/MKqgs7OHQmWZ
         JneIgBokmlHv+J3D9+M5s+EXEhYMkVx0zdvNTrBym+cnG/IODvJBcnocg3s0Yi5UAKh6
         VlBtZT54V1z0LnP4qL52Vk8DsH6A0A5g2Qx79GgzVPJjZASY5z/Uc0BPdSARpA3wSPPB
         0ixK09vxL4Qoutbj9VC2/y+g14zA2rIsshl/teZwRGGpNtwp0cIY4TiMgieDyZIDKQxp
         1JtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCSDkQ03+jFvWwu5VeQZ2kbsWNIQT/Z2z73Gj3GD1gE492vjwtwY6KfnKdWL+TPoQcetka514=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzGx6YqnieGXqMFQJhMZQ93kyGkYQyY4afrGvyPbwiaFXXsfSo
	GK5NU5NCen/EAfuDL0shT+6wLx4NDbOCH1Ydx+o2E/21kmorDa7Mm9aD9VMON/fUm8ZFd7V9sTu
	0NcyjitOKqmLwMgfWi5SiUbve588t0DOzXaGvCOZVEQ==
X-Gm-Gg: AY/fxX4aVRy7w3dyeYgFqJ6zcIJFwkWzqBT5a+Uu1az5CzYeM5ce/u5By6rNrNYmBrX
	rG3XoTcJgYHAG36JclvvzlSHKUTg1ujqTWuEj9iDiB5229ACY8UuSYuEvFQWpIyCzmek/cZrYAw
	/V+kJARBLQllKRLszS9YdaWTZWLL/9CRjQJd1qo/vVjGmfAK3nQAiwfozT616DGqX0lF4i99Ud6
	YkFv33EqaUPUdvSR2ViOWt6FHf1CjtoN2/tl2CrErNOH5ttH6FzPrq0E1u3P+IZpcR9Yg==
X-Google-Smtp-Source: AGHT+IFCiBafqUgtl2raN6GQUVNDDPPvtFF/AxT7TW768dFtVoExGBHENTdsULyggB6RdI6ZLBqSAqmAI5g+2iJa/go=
X-Received: by 2002:a05:622a:4c0b:b0:4e8:b85f:8a7a with SMTP id
 d75a77b69052e-4ffa77a5584mr38480931cf.41.1767715549416; Tue, 06 Jan 2026
 08:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org> <CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
 <238ef4ab-7ea3-442a-a344-a683dd64f818@kernel.org> <CAJfpegvUP5MK-xB2=djmGo4iYzmsn9LLWV3ZJXFbyyft_LsA_Q@mail.gmail.com>
 <c39232ea-8cf0-45e6-9a5a-e2abae60134c@kernel.org>
In-Reply-To: <c39232ea-8cf0-45e6-9a5a-e2abae60134c@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 Jan 2026 17:05:38 +0100
X-Gm-Features: AQt7F2rb-cr5B2gKtHwtRDiTVmalqmfCL58if05whOX7dHeEO4sH6ByS6QMbH6g
Message-ID: <CAJfpegt0Bp5qNFPS0KsAZeU62vw4CqHv+1d53CmEOV45r-Rj0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 16:41, David Hildenbrand (Red Hat)
<david@kernel.org> wrote:

> I assume the usual suspects, including mm/memory-failure.c.
>
> memory_failure() not only contains a folio_wait_writeback() but also a
> folio_lock(), so twice the fun :)

As long as it's run from a workqueue it shouldn't affect the rest of
the system, right?  The wq thread will consume a nontrivial amount of
resources, I suppose, so it would be better to implement those waits
asynchronously.

Thanks,
Miklos

