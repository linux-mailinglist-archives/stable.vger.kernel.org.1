Return-Path: <stable+bounces-23883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED70868D32
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DB8287D52
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF751384A3;
	Tue, 27 Feb 2024 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yeslnPEZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF8A1386AE
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029145; cv=none; b=Qi/7fzVX2FOdKhEh6jaAmddaxdia9b/PThmgN1ctT15+lw9XsRHmYNQtE4iCuovWupY2l3i0neZmBrALGZwMvuSH2dFP7qbenj9D4DHcnJrGnMYGNr5A2gaD0nkXkz6CZw91Klu1t75IhxfjHn/RTLvLE85LO70mjFR/U3sbKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029145; c=relaxed/simple;
	bh=qq/x4uqT3lm7iQeLBkqV+IPjB+Hj79kapEVICaffJUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2+0nPd3hCQqUm3NYbRG4qURH+tnAQe4rr4uladSU+Kst+jXpAkwxVN+TZctbO5hFGfxmU1NEk5ql7ECWZ5DM5jXJi5MjPUd4gL/1YPK+cMAUgj/1gA4nb2AUKukXFf9WQk3tURMJZO9oIfufy1QNPgi0vK1fMKbOLFPErOi31c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yeslnPEZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so581405866b.2
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 02:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709029142; x=1709633942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0FSVOhiNb+exc6MwGCyoHyIIb81A/L6JE/SYheRVb0=;
        b=yeslnPEZOFOPq5KaJGdp4+W7PDa/UO/DNfQnrS1war1TRvKy7PZMQ0T2iaYkuAnjhJ
         rthsaxsorQzEyulAjsbqYKwukcCD3Eyt2FnRdJhN8WLDlGWC3jDq2PN6ASusvxin0w0a
         2wF+UZ7v+fy1sYb7VgTVI2fHBF3JDeYo0QiaFQwkccX2qcsRLyxTZ/Hg2IvV5DAD5RLl
         9SxCOCeGNzOcFUD/Srg6TW3Q6RnArmHx1vjPi5SjB7r0pcXi+LrAYSD09gbBu/wLAf70
         81X20bHDTi3HWtWsTfGIGPcYpxO7LF99m/0t5VE8foT77NUhy2y8F7jUudWG/khthIJF
         zehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709029142; x=1709633942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0FSVOhiNb+exc6MwGCyoHyIIb81A/L6JE/SYheRVb0=;
        b=u40UIPzV9NEGHJejn5XmoBNmtDLQ6xS44TY9RAsmgHK9/ztrUQrouAizOxv8j6b81n
         2RQIXCdYZfyR257oKCF4jXh9KGv3yW18Qru1gZBlKqg45YFj3e2yRqBOHKzyi5owHEsv
         lN+i9hb6QQGEL1Tkdq4xD0oNl1ogcnWRitRelR+Pe3rXWQoFL2oBX+sHoGfKf9tK3K9A
         P9u0LPpYY4z8WOCx8Y9imaoF/3VXETAlvdnWG5Qur/TNaFcNPbNE6HZCOWwbCQlBw1Ku
         mDcQ+vbF+rNC5woXe40ay9S8BpYQUw7C2cWFuzOmn6Aao/k8qKnNQdw8C40zVdJkwOhh
         9GHg==
X-Gm-Message-State: AOJu0YzMKRmBQ3s4vpw7y9pNYowfB5ft4IX5Q2iJci7DQ3ojSNXJq6rx
	8lzfO2zDC6GumIXQlvg6iHUHg36jwGxVNxlxkTtD6IYRbIeqm0d7JImc5lefLBTi5ZJBvV5xppP
	pm/5S+dteJvmbty7sAlHkIHdptyucA7y1YII5
X-Google-Smtp-Source: AGHT+IF7PJSQKsole57cpR3yJOT3WxcUVM0Yx+krJPrraEZ425PmAl7jjRuAfc9QZl58OgywXAOSulqvAeaTRPIJDQY=
X-Received: by 2002:a17:906:b206:b0:a3e:ba73:8341 with SMTP id
 p6-20020a170906b20600b00a3eba738341mr6865167ejz.19.1709029142402; Tue, 27 Feb
 2024 02:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024022612-uncloak-pretext-f4a2@gregkh> <20240227100346.2095761-1-yosryahmed@google.com>
 <2024022735-arrange-lustfully-ca5b@gregkh>
In-Reply-To: <2024022735-arrange-lustfully-ca5b@gregkh>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 27 Feb 2024 02:18:26 -0800
Message-ID: <CAJD7tkY1Po3KSu6k3doNVVWVDp9evimKqE0V0O8__vNG43EgRg@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] mm: zswap: fix missing folio cleanup in writeback
 race path
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 2:16=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Feb 27, 2024 at 10:03:46AM +0000, Yosry Ahmed wrote:
> > In zswap_writeback_entry(), after we get a folio from
> > __read_swap_cache_async(), we grab the tree lock again to check that th=
e
> > swap entry was not invalidated and recycled.  If it was, we delete the
> > folio we just added to the swap cache and exit.
> >
> > However, __read_swap_cache_async() returns the folio locked when it is
> > newly allocated, which is always true for this path, and the folio is
> > ref'd.  Make sure to unlock and put the folio before returning.
> >
> > This was discovered by code inspection, probably because this path hand=
les
> > a race condition that should not happen often, and the bug would not cr=
ash
> > the system, it will only strand the folio indefinitely.
> >
> > Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@goo=
gle.com
> > Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > (cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)
>
> For obvious reasons, I can't take a patch only for 6.1, and not for
> newer kernel releases (i.e. 6.6.y) as then there would be a regression.
> Can you please provide a backport for that tree and then we can take
> this one.

I sent one, it's here:
https://lore.kernel.org/stable/20240226221017.1332778-1-yosryahmed@google.c=
om/

I clarified in a reply that it's for 6.6.y. Do I need to resend it?

