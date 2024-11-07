Return-Path: <stable+bounces-91845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE919C0937
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 15:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C45EB23B9C
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A722E3EB;
	Thu,  7 Nov 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5G3Ekie"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913120ADDC
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990921; cv=none; b=XWMMLqvJONA6nt4+6ClYQA0ZPJeEoF/xrfY1xHdQaLG5FNcZKbqoygGfG3yPKKYtLKAkdDY58+F3xZ7d/GFUL/5+06ZJBOzSNzVWIrHZw55Kb2CrGSnCSMRJ3tJc68TMdYI7Ywlw9UfurBk6pAJQ8Nm+VWg/C7CBhSKdRHOGozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990921; c=relaxed/simple;
	bh=obhoIviuaHhyC0A/b6MUfz2+yt0S4BGH+02rVk3sulM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG43V44czIYJ6LqwDy+ZLwt0kFfDqXuewJPoDtVC02pRklxugsjPKUejWKiS+ytIV8/fJYzGXCmCeJAiyrdicqKEx9cZL7jKpGZdo4OeFZZzZ+TnSE21ikzj7fjp/uX1gLwtBFegs3N4M/iEemeJ9x1YFUEqvmB7KW1q5OoBcWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5G3Ekie; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460b295b9eeso204701cf.1
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 06:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730990918; x=1731595718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obhoIviuaHhyC0A/b6MUfz2+yt0S4BGH+02rVk3sulM=;
        b=O5G3EkieW9L0MQfe8C66bOQaypazCsfoQ54cmZq/jKsw+P60LAPgn2erRJgbAfIKxT
         cvNe30JeYxDj4jmo/RCxDmJq0hhyeiXJHowq4n9IGVMt25sNSFnxwiZB20at3fHj6Nvi
         dYKAxVZHyjZO/bCDEARf1ge36SbkwcSpMH4PbtwHTIpI4aosnJqTFylNF6OfLeGhEEFa
         nQgTv8/SsztI3Hv7lDjacctPOsdocehWYQjpjdcqjkCbKEtWhiwckUkbII8f56YIX1Fg
         RnjFtX0pcCi+i/0WhBl1pKtHfhuvvPUpZbPt1sFkcLvEPbd8MtgxhwmSYLPXymjqXyy0
         IUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730990918; x=1731595718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obhoIviuaHhyC0A/b6MUfz2+yt0S4BGH+02rVk3sulM=;
        b=tFepMEF5jjJYjpwryEoCWQ9GBmYVOSCsNY6YXRhf+g+sJ5WnruUFqZ7a8P5Q5b9ObG
         tSoJRiX7dt9irRBMjCkYRgJyKzOAPvLIE5wB6C7RLDe1WE5++LFCn/mWFtPy5Kg/hpBP
         h+FoQBsn0qp5o+mF5sb1zYQ846BJYc+krnz8MITifR4PSRo7BCkI0yuRbewXEaEglDkk
         VjF3nvdCQpAg7FhzVJpEip+pqipbuqigww6fAShqpBzOBMpPY5oHCp/WfpTynuueJj5/
         gBmiU+A+1FnUVnRXczqXdHamNapwdwQ/MgS6ZiksNGb0EkzmOA9DPqdhK7Y8qMaESPUJ
         uWRA==
X-Forwarded-Encrypted: i=1; AJvYcCUcNfmBHs1CYNmIHiBwl93yDbTzl1zFZitn0+iUHHX2ok3UEAIsYxby0t4oRT/UR9v5ll0wioE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGxwA27AhgBoXXlRlnQ1vs349ZkPMUJRktyK2QyZOY0MRr8zMJ
	f4qxZkC93deCj98q9Cr4Ntu3OKc5AvTReMX6q8cOvTT/1T4ak3hwVPCyoHKfSFQy8UGXVyGd+7I
	rd8VgIc391e4/foG1iWjI94n4TO4lJH4oUxudq/B91TbteK0kt3iW
X-Gm-Gg: ASbGnctgL6p0S6j4UpmlwBck6+lauMTetRpTOU7pTrGlT60SWFff/+npQNLruw6C1Py
	6mwdhSXuWPlswl2xMkehQqHGnuSISbu5JRxMB37JoRHXX5qO5Ri12jv2fsvt7
X-Google-Smtp-Source: AGHT+IFUtxSOl7YCdaawpBadONVmwESllKbqlKdDYg3jdy0lj0KRfJTQJdUdOzWNrbgKvlM+eMv7ydh90ffq9ljzyjQ=
X-Received: by 2002:a05:622a:528b:b0:461:3e03:738b with SMTP id
 d75a77b69052e-462fa619d72mr4247661cf.19.1730990918259; Thu, 07 Nov 2024
 06:48:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106170927.130996-1-surenb@google.com> <2024110700-undertone-coastline-7484@gregkh>
 <2024110725-goofiness-release-bd30@gregkh>
In-Reply-To: <2024110725-goofiness-release-bd30@gregkh>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Nov 2024 06:48:26 -0800
Message-ID: <CAJuCfpFRH_TMJ4v+KsaLMi__yaHg9Agg-HdyUFdHzc=3MeMTnA@mail.gmail.com>
Subject: Re: [PATCH v2 6.11.y 1/2] rcu/kvfree: Add kvfree_rcu_barrier() API
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, fw@strlen.de, urezki@gmail.com, vbabka@suse.cz, 
	greearb@candelatech.com, kent.overstreet@linux.dev, stable@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:46=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Nov 07, 2024 at 07:37:43AM +0100, Greg KH wrote:
> > On Wed, Nov 06, 2024 at 09:09:26AM -0800, Suren Baghdasaryan wrote:
> > > From: Uladzislau Rezki <urezki@gmail.com>
> > >
> > > commit 3c5d61ae919cc377c71118ccc76fa6e8518023f8 upstream.
> >
> > No, that's not the right git id :(
>
> But it is the git id of the fixup patch that I also need to take, so now
> grabbed, thanks for making me look :)

Sorry for the confusion. Sounds like you sorted it out :)

>
> greg k-h

