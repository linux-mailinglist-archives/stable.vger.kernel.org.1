Return-Path: <stable+bounces-190021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75850C0EE48
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C877419C478D
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D966308F13;
	Mon, 27 Oct 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmYOQkyR"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38B2D12E7
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577862; cv=none; b=OohFgKVojFoKVN4LPNqdN7SeW5KOVZvrdlju8X60Msk5bh/yeoMN9VLjEOo4+xldYTddoAhscdFnF3Y1X478cgiqWY6lyFbG99meBKdaNW585krOhjV7o5GUufrILHS2knptcaT9+0B0vY8DrmSmYkZ2Ao0DtuKzLpD/jW7xjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577862; c=relaxed/simple;
	bh=EAoPt6jv7RYVLe51KJHBeGBxB13CL2PFw+2NcmecyJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZF0d5tDemhpEicJ7aylS5e+jf17Q0T0NI/MAhzOOWWI7KnqSpRLWU0zgs2LWQ5UBiZV36bh6M/28ykVZfVn4MUgyOeTiWRxdb5Xj4nUZDoOTu0fe9+4B147iUjojzA5jJLjk20l1dJgtYKXLfej5aChGpNFdJnQGnk+F6gamCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmYOQkyR; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3d3e9a34eeaso407034fac.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761577858; x=1762182658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DMx/DtxK2+AXbHtbFOgTT8Th+LDWX/DlurisQVihNgA=;
        b=GmYOQkyRyB4gCvtCHjsZAqrRcL9IRUU65wWy+XC6rOhmcw17MG4FNFiQskzvwGoTF8
         krAeC8Z6ks9seQGu72rUdPTASi+1gMHxUcYYWWZo8rMCGhJzwScLj6ki9KvGn6gstbQB
         Bs1kraj1TMKuFPph44WgGDDIlm/9mjYxGKu1efF+5uVvb7OdvDVYsZDZPRaXfOX9HDFD
         PB7trGBlBV9kTbSs4QlhWxQ2UHuy6mj+jQwqbCguuWgqK+DBBxNphLc0Fueq1hDVZskU
         +yIk5IdncTy5dHmz5659WxD1B7KC54iaXhFBj/J94fdsFuU7o9K5NuadE5Vf8/7gZRUl
         jsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577858; x=1762182658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMx/DtxK2+AXbHtbFOgTT8Th+LDWX/DlurisQVihNgA=;
        b=tagFg+ax4evhXYEpxQgcix+OjEGhapUZmOHe6Z2fLPDmJXrv4/V2+y4Omkphyrb5ky
         dLH1ToyYtLSdmhwT2DcG3poaQmtrPyyA/MqwzyiqhS390bL49RnBSsHuscHzOG0lGWet
         RtRzRnPi91Ja7wZ54b+QPmbKcIKLMfanctATlOYWHUdvRjoSKa42IwmlKOgxTioexcZs
         DL33xPC+R+rGIz3vnKjHWgJXNMMO0zVXRUCj2xyngEe28gkCpDz3jlJp7TqG4LNHEERz
         sFOd+RTHdd3ViptWeu8ehqibvR/qkVkX6CtvyxQwNJxADjYG/uh44vWbw7oiZSaSWb6j
         MPtw==
X-Forwarded-Encrypted: i=1; AJvYcCV0Gb3zAP22TWVV7pbZF/MUBEX1q85xV7se+TKpLcCUJCNoPDPMjb2BMHU23J4/wH3MiCP2olE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwa4Q7CfaD0YofSZxlv+6qn2bU3+KerreMqU/JvlYkBoI9RFR
	clsLgh+GcoLblcT4FMqXBkvFRyWlFmeBM3sLZzrp2xC78PKQtiazvffpHfzk2YTLGjlViGQOGrz
	FwLMm7st6ROmvKAbWsw17pAPlCfTq2bJeodHaVv3+4g==
X-Gm-Gg: ASbGncvtlH9fkJ0s1WjPEzy+44S+V6HLC6VvlX/AjAFGb7h+rpnTac2JGmSDDfDT3BE
	a1HLsscYAAlYYfA8q06WTMu97NdyfWqIl3F0rvJx8x1gxNtysmRtMl7ccWG7OF4qOcEEopEbb4M
	/1Cjo1ZNMn+lsxuLx6Klbdcq9OXU69BxlMW/EeotEGd1K2/vcr/u3Ekr/KmoyCc8557NGaDh/GJ
	r9klZecHAMZAB+sX1FCnmxi9ULmlowTPpG+oNw1a2bO6Yv0TYJmualDQ5KduXqzW/cE1KeK
X-Google-Smtp-Source: AGHT+IHd+W4IcFgJ85hqjhm+BkDqXnza/5grh6+beTj8ol5IgsaZlL3T/yI5duqd9WMVuK7QnVMu5fYn0lx+pNPIZGo=
X-Received: by 2002:a05:6870:de10:b0:3cd:aa5b:9d1f with SMTP id
 586e51a60fabf-3d17757ce8cmr4451260fac.51.1761577858254; Mon, 27 Oct 2025
 08:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923151605.17689-1-johan@kernel.org> <aP91OoGkrSxxpsf1@hovoldconsulting.com>
 <8487acd9-3c8f-4eba-99e4-6a937618aa55@foss.st.com>
In-Reply-To: <8487acd9-3c8f-4eba-99e4-6a937618aa55@foss.st.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 27 Oct 2025 15:10:46 +0000
X-Gm-Features: AWmQ_bk8-GIOj3a66ntdRL-XYsBVqfxaejexXxbTpzCfX6YeH3gwqk-lE3Q3OUY
Message-ID: <CADrjBPrez1Zi3njGMUVgKeyYu_XCt3qNWATfpsrJZk3ALevOVg@mail.gmail.com>
Subject: Re: [PATCH] media: c8sectpfe: fix probe device leaks
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Johan Hovold <johan@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

On Mon, 27 Oct 2025 at 14:34, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 10/27/25 14:35, Johan Hovold wrote:
> > On Tue, Sep 23, 2025 at 05:16:05PM +0200, Johan Hovold wrote:
> >> Make sure to drop the references taken to the I2C adapters during probe
> >> on probe failure (e.g. probe deferral) and on driver unbind.
> >>
> >> Fixes: c5f5d0f99794 ("[media] c8sectpfe: STiH407/10 Linux DVB demux support")
> >> Cc: stable@vger.kernel.org   # 4.3
> >> Cc: Peter Griffin <peter.griffin@linaro.org>
> >> Signed-off-by: Johan Hovold <johan@kernel.org>
> >> ---
> >
> > Can this one be picked up for 6.19?
> >
> > Johan
>
>
> Hi Johan
>
> The removal of c8sectpfe driver has been initiated see https://lore.kernel.org/linux-media/c3a35ad6-c4f6-46ad-9b5b-1fe43385ecc5@foss.st.com/

Interesting, I hadn't seen that. I guess I should dispose of my b2120
board then!

Peter.

