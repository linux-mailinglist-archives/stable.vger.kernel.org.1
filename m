Return-Path: <stable+bounces-108443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE2CA0B8DA
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA76118856E9
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358A523A589;
	Mon, 13 Jan 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er7IWW9t"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F423873B;
	Mon, 13 Jan 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776565; cv=none; b=gm51kuhgDTCpUkn18JCD/ifBTab6FRtxGHFpVNmfrjSU8mMIbNo8BhB9+eCQum9EG5wc5yAXeCq621AaPMvgFDQiSydmb5YgXuJkxVjdBS5ObIqCan671v3bYLLMAxfe8PNrEbKX/5Nsnv0sUuPYGN7V1A/ccUYhR6LD4veO5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776565; c=relaxed/simple;
	bh=mshBAEwfr5yu0m8ynj+lQzpAntkfzhq4eMBSqVehg9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idgxOl9Dr/12FVuQlNWS3ncGr5z+Vb7054Wkg9WefYsrP3t9fq8DoLXJ2nfQbromLxJsZSYbzePJhfdQSnU9gqq/oZj2aMpvzwkpeHpdv6Z9DvcPol+aAwDecudLp1pemo5IYJIYvgk01L8/YDixYLcgnl7B6/daUSDCwG+Nrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er7IWW9t; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-306007227d3so34058211fa.0;
        Mon, 13 Jan 2025 05:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736776561; x=1737381361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeSExjmRo4WXoFQ0cMIEfwi7OpQ1MjvaaauilF1tJNs=;
        b=Er7IWW9t1ePEd+1uUkczkDUFiGWSfQsGsvb0IUBXZk+6ae/eSsziBMd0566qXSLrpt
         dEzd/T1h5+sobb8jak6+bgxf8JHDFPVENXIl3EmvLvWuI+MZjmVx08pMz/2nR3DmnqR8
         h20hyhyW3sXl/Mn2nbu5VVqSQIFUL0/zNHEdyPdZ2zPVM4f+lOrHEJeFbKy9NfFrBc3b
         nT7U0kKKT0LOT54ODohL2IPwpIiNkmgI550bMELnhra0sY/MWN4uKazaaxlvbmgVDraX
         HVuiUt7V6ToVJ/SPCEeQfGhXXKxUQ9fSFmwB909EclPjIKNun06KUKYkvbIkUOa7Y/B6
         xfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736776561; x=1737381361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeSExjmRo4WXoFQ0cMIEfwi7OpQ1MjvaaauilF1tJNs=;
        b=X//86dDNAq03KhxkRupX/1+IiloOFvV5lex05iCfZ6ZQeqgbwzsX2XN1ZnSgaJHjBE
         RdW251P+bSrH7YzC/oCSe+kxSLwp6gltozYKXDlj8OfACABG82W8V0jKXHW3b4U3i3j+
         NOM6y/kTfjno79MqEPRtRdKXGptoTpTakte/nzmBhFu/+j5PnKAcypx198stdRhvbJk9
         dYPAScYgt+d4wSITTYfn5zExxCaIMWKDoVfv2pairMDxZ8aEFC9uPFhsH+Ci1oWgkbMy
         gUz2HxWc+BxgBm17DaMuzt0A9rF2vajT4hT+md0SHkIKdIEp+Iteet3snGv3Gb8LktfV
         GTIg==
X-Forwarded-Encrypted: i=1; AJvYcCU7/smoqFeoH7Os/k5uyGRo+O6182dRCuZVjwSny/Sr0Y7+EPeR2yoHFRD1vlG9cVqJpUFi+83B@vger.kernel.org, AJvYcCVuci5HrWmGmZ8HYwU8y9NiPQvVgo8Qss5EZ3EtVzNW/HnINj3fbraGWLDTQyPEaLerVamTse87w2djXOq0@vger.kernel.org, AJvYcCW75Ya7+c/GyiJYOeQ1Jyf6y9xqs5+2A5zGsPuRieBfFYLYuFvDZ/hH5Qn/VjJ1bSQU3GcYOoxzXK8jiRqq+SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMAGK8zJTuAsNxKxNwXjdO9z/rs/LLScvm52aZNatuXOawvM4Y
	U51L4Wuyx/coemIW9npDs0CV+BGnu+7xkvYn7EsJK8iIG9qRa9Zb5p/pWeFukUKXpgD9cljbd0Y
	JYps2ASwP70WYuxuBGWbu2uTalRg=
X-Gm-Gg: ASbGncsbt+H9TvAWdanCbkNgnJ59krf75sbYPu1YEBM0X5Tw2xXTuwWQ6h5vGnzOhvf
	vOgKX1NTsemr1DDfl9xM8FxXSnoud9236AzYEmZY=
X-Google-Smtp-Source: AGHT+IFhQpNuXm5IlZi1rKb+80EMIkCZ7F7BnQLe538oAjM4A9cHFawq1zp+vwgnsewGQvQ5FndZJS07XPoKsCmeKxQ=
X-Received: by 2002:a2e:bc28:0:b0:302:4171:51f0 with SMTP id
 38308e7fff4ca-305f445cc8dmr58601341fa.0.1736776560795; Mon, 13 Jan 2025
 05:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
 <Z1v8vLWH7TmwwzQl@hovoldconsulting.com> <Z4TbyIfVJL85oVXs@hovoldconsulting.com>
In-Reply-To: <Z4TbyIfVJL85oVXs@hovoldconsulting.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Jan 2025 08:55:48 -0500
X-Gm-Features: AbW1kvah9FX67qjgCiGZHw_ncGPgLBYZWl8MbDAN8O8lywgJcF6pzM69tcxrn60
Message-ID: <CABBYNZ+Pm_+GXWaGcD83g-PPxeGb6a7pJaxUfFZn8ekwbQOeuw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: Support downloading board ID specific
 NVM for WCN6855
To: Johan Hovold <johan@kernel.org>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Bjorn Andersson <andersson@kernel.org>, Steev Klimaszewski <steev@kali.org>, 
	Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu <zijun_hu@icloud.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Bjorn Andersson <bjorande@quicinc.com>, 
	"Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>, Cheng Jiang <quic_chejiang@quicinc.com>, 
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>, stable@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Mon, Jan 13, 2025 at 4:24=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> Hi Luiz,
>
> On Fri, Dec 13, 2024 at 10:22:05AM +0100, Johan Hovold wrote:
> > On Sat, Nov 16, 2024 at 07:49:23AM -0800, Zijun Hu wrote:
> > > For WCN6855, board ID specific NVM needs to be downloaded once board =
ID
> > > is available, but the default NVM is always downloaded currently, and
> > > the wrong NVM causes poor RF performance which effects user experienc=
e.
> > >
> > > Fix by downloading board ID specific NVM if board ID is available.
>
> > > Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetoo=
th chip wcn6855")
> > > Cc: stable@vger.kernel.org # 6.4
> > > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> > > Tested-by: Johan Hovold <johan+linaro@kernel.org>
> > > Tested-by: Steev Klimaszewski <steev@kali.org>
> > > Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> > > Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >
> > > I will help to backport it to LTS kernels ASAP once this commit
> > > is mainlined.
> > > ---
> > > Changes in v2:
> > > - Correct subject and commit message
> > > - Temporarily add nvm fallback logic to speed up backport.
> > > =E2=80=94 Add fix/stable tags as suggested by Luiz and Johan
> > > - Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-=
1-15af0aa2549c@quicinc.com
> >
> > The board-specific NVM configuration files have now been included in th=
e
> > linux-firmware-20241210 release and are making their way into the
> > distros (e.g. Arch Linux ARM and Fedora now ship them).
> >
> > Could we get this merged for 6.13-rc (and backported) so that Lenovo
> > ThinkPad X13s users can finally enjoy excellent Bluetooth range? :)
>
> This fix is still pending in your queue (I hope) and I was hoping you
> would be able to get it into 6.13-rc. The reason, apart from this being
> a crucial fix for users of this chipset, was also to avoid any conflicts
> with the new "rampatch" firmware name feature (which will also
> complicate backporting somewhat).
>
> Those patches were resent on January 7 and have now been merged for 6.14
> (presumably):
>
>         https://lore.kernel.org/all/20250107092650.498154-1-quic_chejiang=
@quicinc.com/
>
> How do we handle this? Can you still get this fix into 6.13 or is it
> now, as I assume, too late for that?
>
> Zijun, depending on Luiz' reply, can you look into rebasing on top of the
> patches now queued for linux-next?
>
> Johan

I will send a pull request later this week that includes everything on
bluetooth-next, so it has been merged on bluetooth-next it should be
fine, it hasn't been merged then please resend it.

--=20
Luiz Augusto von Dentz

