Return-Path: <stable+bounces-233460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FEZKMA81Gl4sQcAu9opvQ
	(envelope-from <stable+bounces-233460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:07:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2A3A809F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC80A3043D04
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 23:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBD939FCA8;
	Mon,  6 Apr 2026 23:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Hw4oZ8KZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3094A304BDF
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775516858; cv=pass; b=TfFgB+IfXAc42tRKMqLdh4lIPvv/jItXjdp+fGYGcbuADpAs3Tw0wLrX92N0m53HT2BXahwWwo7Gh/YcenS9SWaF7Nd7CYKWQMLiIa5evFwM97LvMLgCeqlTbjfQp9mKB7YI3d4EojEnh9zXYYzOboEi4zgeBf+3dcNuDBo1U3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775516858; c=relaxed/simple;
	bh=f9GmValrmhOWiwWMx0EWjyv9yPicU1uiSH27G8XHZ1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgjNFbePto8xq4Q5hJV8a5QwWGbjAIyqG/jO4SSAV9GP80rO7T0DocY84p+6JgSzP/JXuekKf6b+i1S3yAI/leZoayKUmHbr5NfNrYFKwvrfaB7UayQKV0sexcZVuylH/45GHtyBqS5mLOWCf6qpvgrg2uZioFHGXPGzkqYaEXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Hw4oZ8KZ; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7927261a3acso36971037b3.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 16:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775516856; cv=none;
        d=google.com; s=arc-20240605;
        b=CFwC8lqZWYtmvXuuo3Z2XB1mXHr4waNIXvJLqL+z1cqiPNHk7AEBwFo4CbC7BAV+pJ
         EKqHYLxQlzkuXv4YSYoLl3frfznmZYQANEH5O40kPgorKhofMQYBIO5me9S02ml2eFZ/
         XfxaH51Q9YvK0J52uqf7yCqnJY6R3gSvDnn2XNEsDzTjGwzHUKmTUEeYzjDtpccvoEHb
         Pe07m0HkfAaxw7pM2rMxL/PQnWKLbKdn481O8HnnZcHso4Yi3QEhLLFrh3+lnaKvI28I
         eC2Lkm6IwJoT413EhdRQOnhr6tW1DrrZW5YozKIhbi7sL4gBSaHB9C1h2XTOMdwp1tN3
         2F5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gA0Yacyf4du/VBGxhfihlMdchZvBBnBUviHIV/bu+f8=;
        fh=A2iXMGRHXu4d2OClmQiuK9qrC9furfDxHPpem+6M/2M=;
        b=TUFz0zKSwuwBR17QSFKSmeyswlLwoFGAjF/h5YocUzBe5A62yb9p+VtvFDjePpzhp4
         AbsV+vteSeMnyKXXzL4Zw0Aby3l64QVCtbmrjvCwrP3wd0Ew6EOSsfocBsiBWhKKiCHB
         JZVMydJQuivqUvT7q5YC6Mo69BGBl/kpSWj78ePS+aDtH484aeoWPke/Ya+brRIwLzxG
         MTbYTdHHHoYMQaOKUvWClOEtSXRVdjgYY6wduRYZwMs4ycmFP9DOh5GqxE+hpiK3Ire6
         Le1yDdlrPjzRpwKJ6czdHoQhhb0jKDz+x1DcEY2dMwaIrRNts82dapnEHGXTnPFaXmvt
         qGng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775516856; x=1776121656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA0Yacyf4du/VBGxhfihlMdchZvBBnBUviHIV/bu+f8=;
        b=Hw4oZ8KZvoKZLbzgzG2piM3S1mAmjBPiS/hlwHYR9t0JEyrk6iAD6WTXBvEv8je/Ct
         //D9lq4DNoLFvWH+muSsHubtXLnyyi1iOe9EPlZXpgPXg1YI0dIDACLtthJ/RMWWG1QE
         FrSd3KO1elZCBrDg0ziW+XGwjwn7SbY7hauA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775516856; x=1776121656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gA0Yacyf4du/VBGxhfihlMdchZvBBnBUviHIV/bu+f8=;
        b=JpHLMulFU8Ho30Fb0Z7BkZqhNlwObrdxZrY9u5qKKLXRAYfNOi3iXp1u+Y/DMQeGCj
         SBwfAyJG7SLAwzMn+jz6td8Ow285AJJrWu74mA+UUgNJEiucQuydPDT6MCa41RBS4w+A
         eMO9ta9GACuyBzHdvS+ForeDTXFbintZta0lZVBlqwOLXUVD4AobEQ4AQg5aFxUibV98
         CxpBKeFqoWG87khYwbcdu6LfRySJp8Qq3dR5I+4Wniu4DWJXl6UAPfpOodkijxxuDhYT
         4J7H+0xSZxjnpP0r3TmPenFPy/iSXAx7R1EYOJ4TMnRGqtWGkCSAUntyz3DBOMCeICIP
         AH3A==
X-Forwarded-Encrypted: i=1; AJvYcCUBQ3lDMrZJScVcImk1jmF5ma2oZtFu6ZBvrGe1Rq1hy+Gl+5hVq8Ma9j62XQORbRdkJMz6fvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpbD2PlUn6qNgJtM1qNOzF6gV+lDKhbIobJkMcSzAqvmRuhtj
	SFGx00JeGQZ6HQQ5rm7Yi2tPpxknwF/qKym+9iAT/bdN+d6aLTp7YFW6XtdzZ24zv7p+vG/uxrC
	J7UQqxquBYsGOpm53u3Oj6GYJDy5Dg74ChID1BHzqAw==
X-Gm-Gg: AeBDietIQyhNxXmF6S+t7vrLrnGK2XaBBcAl3out1b3S7nb4sDCye264t+M7uoXHp3L
	v5KLJT7XI1PQf7fd048Mzt6FTnYEh0r3W1WEJVOOcvBrdCmWddNNMjfRnVXsE+DEO61Z7iouOWG
	xzu6hMmg67/rh/wrsbXCUwaiOMTHJkmAqAgYEYGGspNNglBEDJyZrUaHoC7/4BhHNUqCCCpdE+Q
	FQJaMPm6fJ7/XSChkxILksphhYMkb0gLadjZ/b7rUCO54N/64TgGsL2DSDvhlWynz4ImbrZfMKq
	XCs+wkuyn1SD8B+KvqZAWGiP8qrWsFNlJLMQ8qpO9++i5RErdjLr9J0Q1hXe+2dKuRIVO2Cpcwf
	dYFiXlup7OTt/3iTBaM5yrA+E1CGuKBk6UxQ8OEAI/6ApuDoOurdDS9OkDzLhHjI=
X-Received: by 2002:a05:690c:19:b0:79a:b46c:e60a with SMTP id
 00721157ae682-7a4d8db073bmr145384387b3.44.1775516856254; Mon, 06 Apr 2026
 16:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJpGJTzJZ0OgEU8NhyJ3dR1Y1V5x6CwbBjLW_kYLu+FTt9woQ@mail.gmail.com>
 <20260406221743.GI2551565@ziepe.ca>
In-Reply-To: <20260406221743.GI2551565@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 16:07:25 -0700
X-Gm-Features: AQROBzDCxn9K8JeiKcrx3s0AoD0G54QL3yvv-7cfxuIx0UsddxRYRS1TosoShE8
Message-ID: <CAAJpGJTBy+6pAr8s5xGZerbCaoybF8v-_ZSzdHkfjt_o-iPcAw@mail.gmail.com>
Subject: Re: [PATCH] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233460-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sina@openai.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ziepe.ca:email]
X-Rspamd-Queue-Id: F3A2A3A809F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 3:17=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Apr 06, 2026 at 03:00:36PM -0700, Sina Hassani wrote:
> > Bug: iopt_unmap_iova_range releases the lock on iova_rwsem inside the l=
oop
> > body when getting to the more expensive unmap operations. This is fine =
on
> > its own except the loop condition is based on the first area that match=
es
> > the unmap address range. If a concurrent call to map picks an area that=
 was
> > unmapped in the previous iterations, this loop will try to mistakenly u=
nmap
> > them.
>
> Does this mean you are also using the automatic IOVA allocator?
>
> It is certainly an error for userspace to be mapping to IOVA that is
> under concurrent unmap.
>
Correct.

> > io_pagetable *iopt, unsigned long start,
> >                 iopt_put_pages(pages);
> >
> >                 unmapped_bytes +=3D area_last - area_first + 1;
> > +               start =3D area_last + 1;
>
> This seems like a reasonable solution, but area_last + 1 can overflow
> and that needs to be delt with too.
>
Good point, done. I sent you a v2 patch.

> /* Do not reconsider things already unmapped in case of concurrent alloca=
tion */
> if (area_last !=3D last)
>    start =3D area_last + 1;
>
> ?
>
Done

> Jason

