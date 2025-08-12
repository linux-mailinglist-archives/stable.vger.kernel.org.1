Return-Path: <stable+bounces-167241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE17B22E20
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA266227D7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE882FDC2B;
	Tue, 12 Aug 2025 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2MZtf8l"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DA2FD1D7
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016897; cv=none; b=GNViS2AbvJgUNrVbCmKvfzvkfbMW9rFNK3qka+Mle4Qo/DikXnDUXyZ1EoRIy80+WBls2laoX5bzO+QSgCJsN0noQZfdHLd1z1fdGN5zpX8XyAZFAlMp2O0nN0f+okNeB+kbVT60F/6wiKnY+tbo1XAhlwzrJFQbrrQx0xxGawQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016897; c=relaxed/simple;
	bh=eLQFHw1YjW4WC/8GE/HWopiKMHoNSSL/rbE6CfBVMIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsAclpo9pqL+uh8KwsQfag64upVd86SAaPqtAfOjrxq0DFOibAR6hCib27loPbgxPvxikMuX2jQB2UeA6sQGMFMVanMdndKT1H8FZhNHLAijNXNqAS+Gauxko37AQY1lspb3e1fJ39nSoBo+8SwHBoa3IM594PVzz4Hzfgy1MBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2MZtf8l; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b0bf04716aso344131cf.1
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 09:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755016895; x=1755621695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLQFHw1YjW4WC/8GE/HWopiKMHoNSSL/rbE6CfBVMIs=;
        b=i2MZtf8l3nZJvTMFa+zblEtAvfmPrzzIs0HVz/56Kvck94xUKi6IWretuOdNJPa7n6
         xVqtusQnrnLw3X1wRD3BxItM5QTp2fFuyuK+vFY6d6sVUWVpaFq4VjIbwUnA/lkAQTqa
         zVUAkcl5pivBlVhiyymKn+gtyCG8FFl7RCORYzs4/FKZTjAmd3Sd385r+31euuGEBYVD
         N9nrp+o5LOXeqqJvYWDzihjo2clb6olKniwCROzQK713y5PoFSVAL5m9V5FmGim8xUyX
         +C63PQJo3lti01APDfAIExB7Gn/cbh/xizGxsiubQbABuQSnCQoNIJ8Bnl7JpMqetFpr
         6sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755016895; x=1755621695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLQFHw1YjW4WC/8GE/HWopiKMHoNSSL/rbE6CfBVMIs=;
        b=Kqd8fDjczw8PO9KZmJJMiYi1RxxwgKK+u/EbRZi1JSdU/ohou3Y4EWFullKydfz9D2
         8oJBPDJ5IfZ0NO2sWks8D/1ey9yIEjXdLqhWk2nyrM8dQxkbqrizRz4ynuBWKRY/OI2k
         8PZMgdkMamUKN5y+unAsLGGsQwl/a9QlQmk5Z5dQYKX+0jf24fgtVKzJZ5DG8GULDEXz
         uCmNALyi0ecdcVYBFp3xNncNBT2kEkbKWKVpYX5huxBCmi6xMogaTWDC6b2RXR91JlnR
         ilRp2+b79lyoFUNtvjRcwK4Dr2lh1xf1LWP62+D6LkV+fTElmVPd47w6yEpAsj45hYwi
         8jqg==
X-Forwarded-Encrypted: i=1; AJvYcCWCEa2nYFhQkF+uyZfGca0enXH1RIGzjalNhcOoPFAl7bav1pK9m1CuVK0DZLsN+D2W0QE0CMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvBY5XIzCEGeJVLQvmPvBvuZyQ5jX0o92s3zylauI9v1E0JwD
	T1uLd5eRApXmt/3C43BM9AwpUhIQycNrnYvIr4l2M5m0KwlU7fLz1IHUrqQl5tbvF+kcksWuTTo
	luMnHfWARYlTFin37npaZyJ+w6RmKi/2DlQ8rml7n
X-Gm-Gg: ASbGncu63u4Waa1Xp/V+LnTBvzL8/7QeASj5OUwkBjinjNSzajAMYZBTFWF5WTvptx1
	jQobFgQGZc3G0Mi//OP9nYT0qdQKQQlGb17SN/cWbi7rg3O/XbOOFhnTafXLrUlWp0X1+lQSr8A
	3kuPEu/iX2IaxRzCrTLk5LgohW+D9sPeBu1IBLb1JhzdqjsupZUmhhqVMHrCx08DoKviAJnzOcQ
	Za9TNkHTy8fomkx0tlGi0/oLKQKobcaMRA=
X-Google-Smtp-Source: AGHT+IFGgehguDRQNzY6bYQkQxHSEA+mkXQMbSl2TMkLCt0/6JBF52ndqixGQmic/YmL/SFBdVGQOnsPufHIbXg1y0s=
X-Received: by 2002:ac8:59c3:0:b0:4a7:179e:5fec with SMTP id
 d75a77b69052e-4b0ef4ce3admr5325411cf.15.1755016894531; Tue, 12 Aug 2025
 09:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025081237-buffed-scuba-d3f3@gregkh> <CAJuCfpE+Rj5J-RpDEnws=8qydVUGFf=QE215qtaztuTZLGB-wQ@mail.gmail.com>
 <2025081229-pounce-idealize-9144@gregkh>
In-Reply-To: <2025081229-pounce-idealize-9144@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Aug 2025 09:41:23 -0700
X-Gm-Features: Ac12FXyBSRokyYFHvHMMFoflTX2fYxNoYvqyFJ0kbDkmrUGxCuwXVKYH2Nep-rs
Message-ID: <CAJuCfpFJRAPzsCaBy-2zU0rPw_mruwtewt83SmN-gJTPMYp4UA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] mm: fix a UAF when vma->mm is freed after
 vma->vm_refcnt got" failed to apply to 6.16-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, stable@vger.kernel.org, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 9:40=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Aug 12, 2025 at 09:34:06AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Aug 12, 2025 at 9:18=E2=80=AFAM <gregkh@linuxfoundation.org> wr=
ote:
> > >
> > >
> > > The patch below does not apply to the 6.16-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git comm=
it
> > > id to <stable@vger.kernel.org>.
> >
> > Yep, that's expected because 6.6 does not have lock_next_vma()
> > function. I'll send a backport shortly.
>
> You mean "6.16", right?

Yes, sorry :)

