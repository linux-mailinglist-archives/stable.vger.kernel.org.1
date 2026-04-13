Return-Path: <stable+bounces-237593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIZFEaso3WmVaQkAu9opvQ
	(envelope-from <stable+bounces-237593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:32:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 956CC3F1842
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED7F3077554
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5133C536;
	Mon, 13 Apr 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="D7f9NjGi"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF733D6D5
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100503; cv=pass; b=S3rGQoDfoHOQ+yPBvRYoEOdePnmy+8gsDGPwXlRB6JJHHTB3rUhqay/JWOLiQUJF6v6SitdqGeVmNkjExAgGrvb0qai+MmWKzBUPQCrL2gLWwYLBaJ+evmyCVfVmyCKtnSpaHcSeLGt/WtBgrO9WgJfLnF+49LZf0R6wx3ikKrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100503; c=relaxed/simple;
	bh=mJqI8FaBpCq6Q8my/gjI9enGPGsVFf6sqA8FvAAq50g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpWgKyXhH7k0Ont9flAJABcq0W1Ur38g132WmIvgOOgnRXCGosLdPiRcvyYYc+twLsvoM2Ttx2he2nCnVdWQe+gXZ18obkQWBgL3CTVmZn38c34EBwch976KZpghh+51SIPMakBpQNZrf2lFZ6uhmnorXVRja6RjdmU5Alw6Cmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=D7f9NjGi; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a7109f568so53783027b3.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 10:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776100501; cv=none;
        d=google.com; s=arc-20240605;
        b=c0U8qojvpZveLukd3hXPw1/ngV7UkjEttmxTBUa6F02ZGFsdVZAmRPhyyndAeapbjB
         6P2pBAy0p5ybeQT+5KbF8drHwlSpF/3JrsnJNM00mAkHK92ixf8+wSo4aVbVC8hdAb4+
         6dowmLAInmC3zdGW5LoxfzXZo1LyBd76mtCkPWdik7DVKwEx6xAR7HiaJESkIH0LyZwk
         pSb+XIC8FcNcgjbXDOLdJuO5xhCjzU6/APcJyXU8uOk7paiT9mNXfutjkjJBPe0/4NMw
         JfzigxoLerCjNVROaKdNp4xXwBLNogCCUSCnCcb7zOZNj3SdfEOGUaQvahL8VtMtzBOQ
         /uUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5BELIkiCypTZxDmr5+xtV7esxMT0E1Vw9Qw7kOi8Vz8=;
        fh=meWhzy6sojhbFGTagKWwSJrodauZCAHSzCiWVx83hUI=;
        b=jFdi7dvoVq8Vf3Rj0vHNzaggmx7vEF6ubnPfRtICuwbGRadwxO5IKMDT02fCZgvnE9
         Hbc74yTdmRjfz+fDyhsSJrBP35ILxfCTsP4gs3vLN7SwNsetxLvycieE/EwBa30Af16o
         GWUTOs511i7SODop6DNHTpruyeYyWzxvOa5i55+K7sgl+qkZBCz26KkOA6jSoKCd2pwC
         AwTq0ckQpjDVigyppecBN27eDVKgFJW5S92uaxfwYxzeu3G+dBQk3DgrHba/tx7NwWhE
         ni7zczwrHf6f+RYbACvk/UoR7qMKXaJ9vT7GKV702a7e/SJhd/94nQCOt0b35RKtp9JX
         TdRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1776100501; x=1776705301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BELIkiCypTZxDmr5+xtV7esxMT0E1Vw9Qw7kOi8Vz8=;
        b=D7f9NjGieDy5SxeXdDWOcffur98GS3jDLsbu6GuQrM2FuI/zsXNObDaRANDLDArabK
         KGt9DSMC21rPkSmKWooYg8QfvcIaksC70VUDrJCmULf0UOESDoFUzABiOGZpeKaxNffW
         kdbH0coQmpUbZuTXAsRXFoxtaBhQCmrklNWcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100501; x=1776705301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BELIkiCypTZxDmr5+xtV7esxMT0E1Vw9Qw7kOi8Vz8=;
        b=qYRxyNbN/44+UojzSkA+d6bX8wn0by5ETV0SQhLikdr84sFcYPwbaS1/HJbDGu6FUa
         V6M4yoxeJ08XEvs53GneIeILi8MxX0hUSIJkIVSEYProEWYwY7s636NGx6DLQVKHK/83
         8aqSWLFr3FMaNLYmWFRuyXdMzvRE+JPvV8yNZAUOMU5LGVSTyPTMj/AC9wa8J3X9sfDv
         7myCbi3DSqj9uylsGFx5SB/FpbLeGiuf6qVukyvSylL/5a23VirffZzcx+9kJBDJB7bs
         q/URm+KtkWO6fIRY2ze6WlEOjzTy2x/jSkgE+J7Pkb4vH1q1iaOVxH1Wo7JaAzavFQGe
         SOMA==
X-Forwarded-Encrypted: i=1; AFNElJ9pOPPY054U81fZQBTcBLdlr2vOYgH5lkj1lJo4mfwC5T1OIxTx6XeRitwSg63GCU1Uq4UOqoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtL0PO2e41tgXZvckNYvBJ/x68K0Zjm5aKcpjxyebjDlp9T6tF
	8iNhy/tuu5TcufQs9bdoyKPrMoCe1T+mbpt1AftWbgvdAhBb4wJruu0n8y/PFSBfVmYZWNh615V
	Li0F1vZBwcKHJz+X0SuHZx5+USfZ1Km8LMlPgJdsNgg==
X-Gm-Gg: AeBDietKgkUJ+auaaGqqXc6MyGcmRB27RJCKO5i06KWc4SSupZrL5gpl+WGpZgLva/Q
	msaL+lN+JRI07CPufds/Qpk0A6WtUFWuOfFvhe4JD13F96m0Ff466ZP+1y4G3UlZtZgLMPDJNnp
	z88uEIzho/FvSHmpf/WrOo2Z27CWd1QHOLVUlCsDOm9qKpgQOJ3GhtgVs0yEZD4ZehnKSD0XMQF
	DkqXH3pwGA1BWHyzbBTxFyKmoFrTQBI79k7A571zQjPqbhkWeziE0813qebgVN45RY8oFTLdxSH
	Sslw1tNIKKbPk1MmyjBHm5pGjQ2rcfr4EDxMuQngA5l/HBzdobZgZfoyW7At1X0AQkmnBkb1t5T
	XEBz4Wc98bRdXo92qIjpMOpBB3C9Ame0R6GQdmQ1hHxwFV1p0IfvCl3vyu+PSzV4=
X-Received: by 2002:a05:690c:6d84:b0:7b3:3a49:73b with SMTP id
 00721157ae682-7b33a492a9bmr44979817b3.25.1776100501093; Mon, 13 Apr 2026
 10:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJpGJSR4r_ds1JOjmkqHtsBPyxu8GntoeW08Sk5RNQPmgi+tg@mail.gmail.com>
 <20260411130354.GG3694781@ziepe.ca>
In-Reply-To: <20260411130354.GG3694781@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Mon, 13 Apr 2026 10:14:50 -0700
X-Gm-Features: AQROBzDB9pPQWsjdy6qpC4ePls9wmfXy8CWLdDAZ17Sw34wtz0EFUiM2ReyPXW0
Message-ID: <CAAJpGJTE5MLh7w+uq1LExwLBJWNLMqhhLRFQb867X_CoqtV5Sw@mail.gmail.com>
Subject: Re: [PATCH v4] Fixes a race in iopt_unmap_iova_range
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
	TAGGED_FROM(0.00)[bounces-237593-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ziepe.ca:email,openai.com:dkim,openai.com:email]
X-Rspamd-Queue-Id: 956CC3F1842
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Jason.

On Sat, Apr 11, 2026 at 6:03=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Fri, Apr 10, 2026 at 11:32:44AM -0700, Sina Hassani wrote:
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
> >
> > How to reproduce: I was able to reproduce this by having one userspace
> > thread mapping buffers and passing them to another thread that unmaps
> > them. The problem easily shows up as ebusy errors if you use single pag=
e
> > mappings.
> >
> > The fix: A simple fix that I implemented here is to advance the start
> > pointer after we unmap an area. That way we are only looking at the
> > IOVA range that is mapped and hence guaranteed to not have any overlaps
> > in each iteration.
> >
> > Test: I tested this against the repro mentioned above and it works fine=
.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sina Hassani <sina@openai.com>
> > ---
> >  drivers/iommu/iommufd/io_pagetable.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
>
> The patch is corrupted but I fixed it up by hand and applied it
>
> Thanks,
> Jason

