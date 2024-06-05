Return-Path: <stable+bounces-48243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1BC8FD667
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 21:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F70F1F24EDA
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 19:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C7E14EC66;
	Wed,  5 Jun 2024 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5ANUpTM"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3F41C79;
	Wed,  5 Jun 2024 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615414; cv=none; b=AzPuoxxEyv7G3LRBst2T9r+3Ez3daoN0YTPhpYEJCYaIF2lGNsukDn0cjplLkklz0dzIaEQl8iAkybz/1IbVS85YDtNbF3ennflbg6dAXtOLOoq0sRJuD6y+WJ16geCgM2Wew8biI8yJGaxdsN0L7l11kGBytdmDPsKA57dPzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615414; c=relaxed/simple;
	bh=xEQRH3jAJkXGlRaNB3fgJoxXqBOJ4rsKcAteON05fpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6/eW/sJabUMpoKG1/VJWxVchki1Pj45qdlUQdhKx2Oacqls5p91fse5UrhQClEiHumnKuPsMZhWedlS88Vq4ehi1BGIeZssmqzfDA+cwn/znhKYEecOLy5jVtomlLaIwuM0l1P5cUIW1VHFCClKDQQE4alAmwPeno0V5Eq4ogg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5ANUpTM; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4eb24694941so54161e0c.0;
        Wed, 05 Jun 2024 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717615410; x=1718220210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=usKi1lQoAvyD3EOCOJA05MMV4ZqwLjC/fYmPgHVdfmc=;
        b=Q5ANUpTMfeQs6ZrRn3Uq7M6jOnRqlxeuSiMGZ4SqNIbg4Sot7nh36BAHbvffSYbPNv
         84zYrZiF2jzcETc2yKjYSYv6/i1iLYjOM2dOagkg0bNxed9POjFFmjgmi9aIuHv1n/h/
         xqE/ys97SCF6wV+7gcB/Rs6coKHIjdTk5UqNPclgw2kbXl4QxoOKuR1iJ5AOTycXjcor
         KzyIwVGWQndEuzjV3syrLtVXp/o/thsGuVpj5cfpMO2kczuuDrJu54ZwKMqFHyv4XhZg
         v/fQO6lOloj2rExucKmoa8aWcFrt11Qa5Wv9d+/HnbR6ovqnkcfZrY8hab9LF2WkRpnO
         +VvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717615410; x=1718220210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usKi1lQoAvyD3EOCOJA05MMV4ZqwLjC/fYmPgHVdfmc=;
        b=NGS4Z+fNxd1IVzcVIZx964U/VKsWWI2fjMz3fhJy+RCDMDvavap+cLsOKIhsYUmOpY
         wNWbbzySjl5ucSMQxeYOOY12o8iSZcoE1La08ilWoEyXkWezAnpuiAV4b0/aKtRIinT+
         8utq/2UsJOuvtp50iln4MbFiQxOHF6QNW7jjZt/AKpg7D//9kPg0h123AR7RgIUpkdQ7
         a3iFWpIB8Ke7Xfu2Zfg1IQog4QHWo/VCUdb4PS7BLrkVKRV9bxG+Jtuy0OPmMaFLhrp2
         IPtnafcCNpRrKHguqEvIR33Gdd6q6fujd83YCZ7LwKuI7XVsf9Yca2yZfYl8gUJQT8cj
         ui3A==
X-Forwarded-Encrypted: i=1; AJvYcCVkvBqtygDe3m9v9ATC7c/Vr2pIGEgB06CwOGCNLSpBlPc3RaBDUBlPWmNBttUhds96g/68KFat/SoPKNwTtoKvG3rBjhZ9sJQ/3hek6xhdZXNC557B6F8jCiPEHcnM8SMk+TPo
X-Gm-Message-State: AOJu0Yx17ffWZ91EhNvx74C4jTC3vLJIOIjX1VTG9c4mbktDRDmUtZ4e
	Audw+Ii6mgs80Gr8J78IEbiVkTM/NpTf8Nw1yklZhuTfQRIaH0q2H2sq3lIUxNw+23pg1TzcE5c
	6CU6AnEVjq3L0hqfjX7LGTS+15PU=
X-Google-Smtp-Source: AGHT+IEtnCpQk+OWOTqE1pUcCLDzJn90A15rlxuBjtbvQSMXU3iBWl6WoGClIfj7OA527lJWHaSUhmRMzC6iASy482U=
X-Received: by 2002:a1f:fc4c:0:b0:4eb:39c9:c935 with SMTP id
 71dfb90a1353d-4eb3a4ff73cmr3559305e0c.14.1717615410379; Wed, 05 Jun 2024
 12:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604054823.20649-1-chengen.du@canonical.com>
 <665f9bccaa91c_2bf7de294f4@willemb.c.googlers.com.notmuch>
 <CAPza5qctPn_yrFQrO_2NHXpz-kf1qTwxk_APn2t5VU30sY=-MQ@mail.gmail.com> <6df76928-be7f-483e-9685-88ee245ef1bf@orange.com>
In-Reply-To: <6df76928-be7f-483e-9685-88ee245ef1bf@orange.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 5 Jun 2024 15:22:52 -0400
Message-ID: <CAF=yD-LmCyF2pobgX0nDe0=iEBsXc90Nqe=By2nAqFZd=nL82g@mail.gmail.com>
Subject: Re: [PATCH v5] af_packet: Handle outgoing VLAN packets without
 hardware offloading
To: alexandre.ferrieux@orange.com
Cc: Chengen Du <chengen.du@canonical.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kaber@trash.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > This adds some parsing overhead in the datapath. SOCK_RAW does not
> > > need it, as it can see the whole VLAN tag. Perhaps limit the new
> > > branches to SOCK_DGRAM cases? Then the above can also be simplified.
> >
> > I considered this approach before, but it would result in different
> > metadata for SOCK_DGRAM and SOCK_RAW scenarios. This difference makes
> > me hesitate because it might be better to provide consistent metadata
> > to describe the same packet, regardless of the receiver's approach.
> > These are just my thoughts and I'm open to further discussion.
>
> FWIW, I vote for Willem's approach here: there is no problem with having
> different metadata in SOCK_DGRAM and SOCK_RAW, as the underlying parsing efforts
> are different anyway, along with the start offset for BPF.
> (No, I'm not super happy to see BPF code reaching out to offset -4096 or so to
> get VLAN as metadata. That just smells like a horrendous kludge.)
> To me, it makes plenty of sense to have:
>   - SOCK_DGRAM for compatibility (used by everyone today), doing all historical
> shenanigans with VLANs and metadata
>   - SOCK_RAW for a modern, new API, making no assumption on encapsulation, and
> presenting an untouched linear frame
>   - yes this means different BPF code for the same filter between the two modes
>
> Again, my .02c

Thanks for chiming in. Generally agreed.

We cannot modify established SOCK_RAW behavior in arbitrary ways
either. But there are already two forms in which VLAN data may arrive.
And with SOCK_RAW in-band VLAN tags can be parsed as is.

(fyi, your message was dropped by the list's plaintext filter)

