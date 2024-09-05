Return-Path: <stable+bounces-73662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB25A96E31C
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 21:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EC91C23BBF
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 19:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1A18D655;
	Thu,  5 Sep 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAq3dtVD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C613D638;
	Thu,  5 Sep 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564339; cv=none; b=VvkvnYxRN5/Ph+8DmDXeAGNMMLJUqNX+3oZ66IHxdIkTD6PJEUB8sRbHYIZSNdo22hFzhcCQuBer68QajEJB1CZcBGqOzsVIy4zZCsULqfzX5g/C7wOIIfvolm3mqixZPzQ9ismIMPwDWlhQQsEvZmeoB6TBaHCyRintL1GE4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564339; c=relaxed/simple;
	bh=5tj019v8QQxODC1ybkWBk9PGHlQJaVbuCywoQN5LXBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWtfNXUxT15KRexn2uFT4Fz/i//gYrhJKSwfS40aAU6omJ7t1NUjZWci1jOvltIvsOaPJXPDQOj+qJOXnzBAMEj6Y0YaZN7w4DwVVBQnl+d9Qd2sHCf5h54GXHi02wZDDN+UBMiTDHC+UaMsHaLJQJZK8wrTCix0xLPKN+fSDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAq3dtVD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53653ff0251so1139410e87.0;
        Thu, 05 Sep 2024 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725564335; x=1726169135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37Tg15gk+odZz6MwlYTyKNfXXG3aJjXQgR9ypqhY700=;
        b=RAq3dtVDxleeGK9di16e+3fNexlhdPgKIAJ4vHn9ei6cIBknZ0ZiGrIAF98GuU/ktM
         qCuI2e5yotxEnwQe5gV8MypqOqlE0067KRbRaV7nnneL5hM7PTDs6lOGDfB5tEOW79bq
         1fEIA2oRAjLDXvTGbcc+GyjAvxmNFVpRv9b+EzUPU4AYqeLGdsKBpxdF4N/MDU6qzjGb
         bwwmeLQWfxFbyazp0lbLjX08fhAMBeYY85yt5QMEmwN122rOE1Xwq8CvNxdim6qjbFnB
         hIZV65MSj52pIVCrxf1FvaYejRPMfIoSAHV2nRQhTTs5J4iY6Gs33DLQpRrKlrRrJ3yv
         VlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725564335; x=1726169135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37Tg15gk+odZz6MwlYTyKNfXXG3aJjXQgR9ypqhY700=;
        b=RNXWbCv1A/xZHZ+g5ZmvCXjYkeLwb5LY7Qu1Jtg0v4ug0a2BSFrczWoHyAYlHDi0sZ
         Mz44zIhAAnpqYm2bQG1jTc2gT9/GlLuzDNI3pgO2M+zULdurI1fwYIKVx2pjNRdEAvFb
         lVMzPd5nF/39uer6Fk9EuAK49U7S1ML4J9rogzZisgX0eDOFpBg/lJHeUhMPumpDzhpc
         lY2XnaxNK/y5wmLm+TyVGbj3MHQzEpzD4IuZuBPzXj+aaAoh+Bsd8vjwxK/0fwj8p8CH
         3A0mR5YfJ4pNwnqVYykEhIKWd/Dq21Bdk62yiR2MAcaayMvpy6yfMYJ0fzDUdsge5e3M
         6Wsg==
X-Forwarded-Encrypted: i=1; AJvYcCU0i2amL+ve1K4PtkP9rHr+hSZkT68Aj0Y32Okla/j2FW8OFH9ARCwJjSbt4bjzXSkCye28pSNo@vger.kernel.org, AJvYcCV6CvMxp/6Jelle3XWB8wOy9GLOQgBpK+HDW0zGrubADAkMYM4Fk3CpBQr+hJ/6pj038hK3TW+e/94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4If9Hwoq72Wu4PnDhGZekH8JxsSrrh1mkLCu/83Nk1H6gXu6X
	yAyNhbQQslfLdMfvkpmKoaz84KXM8RYkpHHGRElgQNRJQno2watYD7Ar6VLe3HkSg+Dg+3icLd8
	z8g0vhfT/tKmE7VW2Wc99KzeRzxI=
X-Google-Smtp-Source: AGHT+IGIL3kRbrPzAbj9XBKfa0VhNAD2aqNLh39x2bbCn65f/CtGWLmGBuBaIB1CtiORRwnP2SdciRoc6ZonZPB37qo=
X-Received: by 2002:a05:6512:23a8:b0:52c:c9ce:be8d with SMTP id
 2adb3069b0e04-53546bc1124mr15047825e87.57.1725564335162; Thu, 05 Sep 2024
 12:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904201839.2901330-1-bvanassche@acm.org> <CAPTae5+gX8TW2xtN2-7yDt3C-2AmMB=jSwKsRtqPxftOf-A9hQ@mail.gmail.com>
 <8feac105-fa35-4c35-bbac-5d0265761c2d@acm.org> <d50e3406-1379-4eff-a8c1-9cae89659e3b@google.com>
 <bcfc0db2-d183-4e7b-b9fd-50d370cc0e9b@acm.org> <CAHp75VeA6N_jmkz0-asjogYx4ig8Q=zxnNM7C4m5FV94pH-nCg@mail.gmail.com>
 <CAHp75Ve4qfvBDgDHnjDbRW5buXnhGSp1aOQ6avOLGYnBY8UggQ@mail.gmail.com> <b439473b-a312-436a-9a3c-05d3eab3e1e3@acm.org>
In-Reply-To: <b439473b-a312-436a-9a3c-05d3eab3e1e3@acm.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Sep 2024 22:24:58 +0300
Message-ID: <CAHp75Ve1RHcKG6gT4sZtquin=PSg4EPjGQ-XxZfJhLvcW5y32g@mail.gmail.com>
Subject: Re: [PATCH] usb: roles: Fix a false positive recursive locking complaint
To: Bart Van Assche <bvanassche@acm.org>
Cc: Amit Sunil Dhamne <amitsd@google.com>, Badhri Jagan Sridharan <badhri@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:23=E2=80=AFPM Bart Van Assche <bvanassche@acm.org>=
 wrote:
> On 9/5/24 11:14 AM, Andy Shevchenko wrote:
> > To be clear, something like
> >
> > #define mutex_init_with_lockdep(...)
> > do {
> >    ...
> >    __mutex_init();
> > } while (0)
> >
> > in the mutex.h.
>
> How about using the name "mutex_init_with_key()" since the name
> "lockdep" refers to the lock dependency infrastructure and the
> additional argument will have type struct lock_class_key *?

LGTM, go for it!

--=20
With Best Regards,
Andy Shevchenko

