Return-Path: <stable+bounces-166735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C29AB1CBB4
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 20:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E563BE5C1
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A41FF5EC;
	Wed,  6 Aug 2025 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhQjEvVt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1210E4
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503781; cv=none; b=ATB6XZJvfF4XxRI1l08FxiLaihTg6h2frVqbpNWQBgKawDdqKtTeD6FUKsox64YA1sDI8H5KgbRHNB/AoAdBgRmvTgIzfV/ipiYoginD9Pf8dAyzpXfPOESuGmf6xNOdVacPb54NVXR46K9Kgr3YryTBpkygdKdPyJ6gVLwzJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503781; c=relaxed/simple;
	bh=XW4fJQKhpVWtLLRbURa2n6uS1OoOotVI/AulaQSKDw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9H9bgaMC/FujRJ9dNppTFd6JFyGrEQZMAQ2YlO3lY/I+QU4J0hSH2HB0V2gHIH9ZO/s7cdAExMBhWbUq4ea7Y2c7tOmkrtgF3vNEDlckFj1RKSJghHH1wWPpCniKt8DXuz7Ynqm3BzUXjOO+nrueILDlWZZBqKF7hqFdhbO8fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhQjEvVt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754503778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lp/xzAZFz2QzCUmaidxOhS/oOucGpdCu8iObUTLz2sI=;
	b=NhQjEvVtUDelv1HZkaP5yzM2xlBgW8hgsI+9tJW8jzEuMyy5gIEA8W4B9gw2jNKq6CsOjz
	6ejNkYPGkUudJC5VDDZTeo3DcqvxrlZ0oHvBpAf2q7//W22bXCAkoFmKyWMtPOWS3oid0R
	wX5nin7lh5/quWWjLpBsDP9v1h3gDPY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-FKHMMNKAO--klKHrI8HPcA-1; Wed, 06 Aug 2025 14:09:36 -0400
X-MC-Unique: FKHMMNKAO--klKHrI8HPcA-1
X-Mimecast-MFC-AGG-ID: FKHMMNKAO--klKHrI8HPcA_1754503776
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e65340b626so32468785a.2
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 11:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754503776; x=1755108576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lp/xzAZFz2QzCUmaidxOhS/oOucGpdCu8iObUTLz2sI=;
        b=m5vIsbefs8/v8Y6IB1yKFCBgDYSWFR3LzZ/wZLKrN4ZDAO2nZ4uZIbTC8Ai1zyt4Eb
         G0ysMrFvXYxwHifP3IFXzza/UdAFxTQankUW3cJIelSN9TLYJLUBLk6KhQyMp+e9h+Ii
         55MSIAcSZeEktS7DVi4dflFDAeuQis8iQV3bVzJFMWScQQoFln7BzkNPmuw0lEycRfFw
         e1xYsAyaC9uugFOv9rwngQ5oYbIFA/2EJBn/A43Hg+maebhvp5wnlmUZaF6cjBrUHc+8
         kqTsGrHG3tGjmSedgRsGAFIvTYrGiJbD1MHCe+LKyM7druTmQ79D1su4sGCrer8yT+AZ
         s41w==
X-Forwarded-Encrypted: i=1; AJvYcCXKcZTKvhl6P/uYPm8MNgx+ASYHWJvtw15D6ty3IKSQMZdMido/JvUlZvZDkYzYnu34WaXB1YM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxh4/wdFoKq5iEjooE49QzV4oaPLKk5Z6el9NtUsgxgaQeTNqk
	zUDY1BJQlNYnBGPFIBUtgIBvN7TfLCMKSPvFUwZEyDeQpPc0nztLN4RMsJyq3oWakQM4l69+Ca0
	lC20s8VbeBKCIxpzvifsgezisHXPNQjn+zvMRcaT7B4Z6RY8+ZcEFH3Laog==
X-Gm-Gg: ASbGncvLDNNMEpepJkf+REpGWdJ9iEUnKEJ8sKevRxQqAYMWP3+dFZdh/B6SPwy99eH
	HHNY5yQW7dsaJhhRo8tIJxsOAh07SLbLcq6endR7fGRzMb+PLZXOvMlf2JDJOwz2jYTtFMi588W
	Y41lfmsORVom4w4IKbwrPWNC1moQM/p7aPUeKv0H+jxxLvB54jSL+8jM3c4C3OSiKLKXrgRc8Ap
	3YLpePsWkC/Q0kHP3rUnBiimaDCR4gd98ksRlMapX1hZ6COG7YUJI6cNYTLGonXAdCbwlCUUOCw
	ybjDYTnrms0PHfYxxhh3XvpAxaIPhiaSIyFCu+X7bG0OGk+cTitDnDS4/lDKzqIz1S6BpHWdYk4
	/CmvjTnzThnS7DKnSVhn9Sw==
X-Received: by 2002:a37:f506:0:b0:7e6:4fc9:6457 with SMTP id af79cd13be357-7e820b11efdmr25046485a.54.1754503776303;
        Wed, 06 Aug 2025 11:09:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZUienyzEiTH73cCxQzcvtLeEUdg0Wbv5ywibHSA1otSIptcZDf2H9J5vbyp5qib/Hnxqflw==
X-Received: by 2002:a37:f506:0:b0:7e6:4fc9:6457 with SMTP id af79cd13be357-7e820b11efdmr25042985a.54.1754503775800;
        Wed, 06 Aug 2025 11:09:35 -0700 (PDT)
Received: from x1.local (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e81542b0d3sm145980085a.21.2025.08.06.11.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 11:09:35 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:09:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, david@redhat.com, aarcange@redhat.com,
	lokeshgidra@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] userfaultfd: fix a crash in UFFDIO_MOVE with some
 non-present PMDs
Message-ID: <aJOaXPhFry_LTlfI@x1.local>
References: <20250806154015.769024-1-surenb@google.com>
 <aJOJI-YZ0TTxEzV9@x1.local>
 <CAJuCfpGGGJfnvzzdhOEwsXRWPm1nJoPcm2FcrYnkcJtc9W96gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGGGJfnvzzdhOEwsXRWPm1nJoPcm2FcrYnkcJtc9W96gA@mail.gmail.com>

On Wed, Aug 06, 2025 at 10:09:30AM -0700, Suren Baghdasaryan wrote:
> On Wed, Aug 6, 2025 at 9:56 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Aug 06, 2025 at 08:40:15AM -0700, Suren Baghdasaryan wrote:
> > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES and it
> >
> > The migration entry can appear with/without ALLOW_SRC_HOLES, right?  Maybe
> > drop this line?
> 
> Yes, you are right. I'll update.
> 
> >
> > If we need another repost, the subject can further be tailored to mention
> > migration entry too rather than non-present.  IMHO that's clearer on
> > explaining the issue this patch is fixing (e.g. a valid transhuge THP can
> > also have present bit cleared).
> >
> > > encounters a non-present PMD (migration entry), it proceeds with folio
> > > access even though the folio is not present. Add the missing check and
> >
> > IMHO "... even though folio is not present" is pretty vague.  Maybe
> > "... even though it's a swap entry"?  Fundamentally it's because of the
> > different layouts of normal THP v.s. a swap entry, hence pmd_folio() should
> > not be used on top of swap entries.
> 
> Well, technically a migration entry is a non_swap_entry(), so calling
> migration entries "swap entries" is confusing to me. Any better
> wording we can use or do you think that's ok?

The more general definition of "swap entry" should follow what swp_entry_t
is defined, where, for example, is_migration_entry() itself takes
swp_entry_t as input.  So it should be fine, but I agree it's indeed
confusing.

If we want to make it clearer, IMHO we could rename non_swap_entry()
instead to is_swapfile_entry() / is_real_swap_entry() / ... but that can be
discussed separately.  Here, if we want to make it super accurate, we could
also use "swp_entry_t" instead of "swap entry", that'll be 100% accurate.

Thanks,

-- 
Peter Xu


