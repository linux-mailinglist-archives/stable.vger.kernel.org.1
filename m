Return-Path: <stable+bounces-181585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E5B98E2E
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 10:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7364C5CC0
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 08:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A354502F;
	Wed, 24 Sep 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1djX5vS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408D27877B
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702498; cv=none; b=c4t2Wm/MjqBwODlLFY9f7wg5szW7UGayksUVUuRGvB2ZcMCDp22oMh+2fen0ycGum9V4JuwzrI24F35pl2dCfH43NjC101bCaR3D3pLaL4Ks8MvvQFsYdIjQCnpwtIH9Fny6IOs/yp5KuQMgxAmh2IsqW5EpMz3PFC6XJzoWXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702498; c=relaxed/simple;
	bh=n0UzIsMpU4D1UpgP8b7QotbFpycmctuT3gIHpLefQyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ifr6bnyGMbw6U9LV+65TnvQ3KMYPMtMbS/nHHufl5xFtfWm2SYO2GB7aM+69j8Cb0sxzcEaYn3qkEndKJF3mp6dbrbweQGdC7yezdM8twWJHssaOnexENy2Hinbf5rgF1iwycyqIPWM9E2kY78vrAu9F9PKGmbmuSME1f/OQP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S1djX5vS; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30ccec928f6so2765322fac.3
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758702495; x=1759307295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTVkzl6UYOFqbtfOkUTSEgWlYPfNoRJvRz5e440qqv8=;
        b=S1djX5vSsGp5ogvH0nZRqrnFG24Cuko2fJ11Gl8Z2Tlbqr5epcIDbiQVS4hajfGtAb
         iGCP07wa+CGJ4b6+HqI+emi+E9cUIdJcaWhF4kgax3cJKDvWCCAVDREmvd4qVGhlJsHE
         cHjxQXubYf+VMz68dxooTOtVhldpJrvGxt6qJ02SkdsJOlp01Ya/WCD1jxspNNKGsFTx
         nlLphZt3/vET0QpI2E7EPsP2aL/c//gUYhHBHBjY/AKMpviLEf5MHWGCvxXOZ3TxYPXt
         aLE60K+ctvxm9D6cPiF4aS66SwqJgZ6lZZ5ekX7Auc7ha9vViwLnZQV8iy7s6BGsqKVx
         0hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758702495; x=1759307295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTVkzl6UYOFqbtfOkUTSEgWlYPfNoRJvRz5e440qqv8=;
        b=HYJHLn+vPP6Oh8GmaCCDGx5bfIc1RDXs5XZdAnMRwmCInU5V7iLmSUJTAkVrbv0dMZ
         CcWNCJuoztXXV9WrasPHXpt35iOTzNg9YufIKCT8+p/aXCSS1kWTKog1Gj/PEt/pMbT1
         X2o/afMKmQlM8gUcQDAtP4uLoA0KqZ+FgRYrTfTOVfs22gCOGDSRSe/myu0mTTcoilsJ
         0LCxFJAw5+jEzkFusa/IPrqQgI7nVu/62QhQCm9YEkyNTkorNE/UnReCtqbpqzLi23D/
         uO4qU34mMqaEGeAOdhZNxkLE/r6Ypd1mmlVwcnFlqCnH6bgF5FIFDs2ib9sHSFh66FrL
         95IA==
X-Forwarded-Encrypted: i=1; AJvYcCVhh0cz0qq7Fu4hEyykt9KK5El/gomQNmj3jHw55ljUejLVrZNSaeOT/uYAVXewr0pVDseld28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnW6HRFKB7PYldaTTSs3v9DXxtlEE2gcuOj/KT4dkNIGsoAP4
	JzsE4v0tvTp/RkyKP5lv0Wsw1jhE/eF8VpHYftdoQAtdLYK9k4000DXhuq82f42dd81/HCZJxJ0
	oWL2cOARUPNTj7MgWVPAhc4PNwolp7xdjB8CORvSoy9xDG3mizW9tTgM=
X-Gm-Gg: ASbGnctIU/HAc6ZxAW4p94hayKydwi7Qa36XK8J2vuIMFxCW1tJijDyI3U7GWizfMK5
	M4uL3ss69eTQhTqcZvxIj8zno0iaa43UQHo3AfuS27lK7JZxKmbaAqNfbwLT/ZwzOuzEv/YbcHI
	20LhF0iRd4s/OK+fLw34LnhHRecryOEzq5fZOIqBgUvhI5waps4aG27PH3ezkA7EHWHTIFD4yvq
	yr4RlIe
X-Google-Smtp-Source: AGHT+IFiZs3fit7JmrwTrcdOE3PuEb7BgKG0XRjkXlRJI66gxsYXWU/izU5IO2sIbpWcGOQKmMbdO6vVroeM7IP2Zhw=
X-Received: by 2002:a05:6870:a908:b0:347:b473:5f58 with SMTP id
 586e51a60fabf-34c781131f2mr3086804fac.1.1758702495151; Wed, 24 Sep 2025
 01:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922083211.3341508-2-jens.wiklander@linaro.org> <aNENxpvdpW7ItjgT@sumit-X1>
In-Reply-To: <aNENxpvdpW7ItjgT@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 24 Sep 2025 10:28:03 +0200
X-Gm-Features: AS18NWBtHMnzvD8ACh0gV2MjOlJFNbL_oo8xYwwc8TnXxOERP-GW5Ztr25D4Hzo
Message-ID: <CAHUa44FtbqOnbBvOSNkX+jdqUK-+hTAM3hYseMPbhOt0U_Nxqw@mail.gmail.com>
Subject: Re: [PATCH v2] tee: fix register_shm_helper()
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org, 
	Masami Ichikawa <masami256@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:50=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Mon, Sep 22, 2025 at 10:31:58AM +0200, Jens Wiklander wrote:
> > In register_shm_helper(), fix incorrect error handling for a call to
> > iov_iter_extract_pages(). A case is missing for when
> > iov_iter_extract_pages() only got some pages and return a number larger
> > than 0, but not the requested amount.
> >
> > This fixes a possible NULL pointer dereference following a bad input fr=
om
> > ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Masami Ichikawa <masami256@gmail.com>
> > Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavn=
TjJAvUbEiQfq=3Du9W+-g@mail.gmail.com/
> > Tested-by: Masami Ichikawa <masami256@gmail.com>
> > Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer=
 registration")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> > Changes from v1
> > - Refactor the if statement as requested by Sumit
> > - Adding Tested-by: Masami Ichikawa <masami256@gmail.com
> > - Link to v1:
> >   https://lore.kernel.org/op-tee/20250919124217.2934718-1-jens.wiklande=
r@linaro.org/
> > ---
> >  drivers/tee/tee_shm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens

