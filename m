Return-Path: <stable+bounces-127274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE3AA7702E
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 23:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F27188D8D8
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 21:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6CEFC0B;
	Mon, 31 Mar 2025 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSBnYYr3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654628472
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743456720; cv=none; b=F58ExMy+ul0XGajkHcHBkdAWgcGlBWo4t2+7/9TG/FIJqrQ+GXuMKb8lXXfwjm/34s6cmujC0uVwvevfENfSVKBo6AJ0YqhpJyvtm0CKfqLjjM6WFktgEoiugmI3+tBhetl8uh29715Q8df3Zr5KSPZV3qHVxSbBA/cNCABpJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743456720; c=relaxed/simple;
	bh=R1xOES8SL+Fk1DGQ2wMiMJFawzJXZNVjN4KGF4q3q2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+befKwhnJLJ/iHpUfYVzQKGwgSFFSkTx5B2vPVS6CkgZShec+VPS6Cq4lFTGI2aFQB7c+wI5RfeMxTcZwr/xSuXAC8e7onAvzH8m58KvZkdZWlFPMXVjdavxarUgDGcRMlkXrlOh2MSHybYEtO0q/7nz56oaegrB03k/bjPKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSBnYYr3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so48443675e9.3
        for <stable@vger.kernel.org>; Mon, 31 Mar 2025 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743456717; x=1744061517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3Exn/wkBTkPhtwKgX8FGnHYhicP+rBh55v518Vsav4=;
        b=TSBnYYr3mKRCvcMtxqivBk43D/FQZIly3tnpWnAgCtmP/StoNGPwtn4TOIwLZ8cwi2
         yKbe8bLh+nwhK+ECndXD3WowaGW+Xvc3NladG4qVPxfUWSSlb/e0UolqxXZ5JwqNusdI
         +0t1cmw3ffCApjZhZlD8onRX4hn9St9Lw/+vWEczZb3DSd4+h8+L6eFBVbSyzvj4MKNw
         AZO97qIJ2r4t5HGGiDMeknH+KYABQ34QlzFI/bZuJ3S4OuO5W1zPl5IWn5vbVbTAXoXq
         TQzNNcmdS+EDnEIWSc1XumzHIxyOHPMSsJfaRV9VQRXTJ6ZzvFd6IJvitZUs1WnRZLNG
         D4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743456717; x=1744061517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3Exn/wkBTkPhtwKgX8FGnHYhicP+rBh55v518Vsav4=;
        b=fW/vFzPbKYpYUAIJ3bjda4ru4N0OLi/vx27Yc084kJ0yWwyWWvFDHQl82/6VjPPq3l
         nTy0BRhEai6SZT+P8guD2V3HrAl3AUqV/BZ6gmIysal/acmS0TY3KTEE8X9rHsbMetk2
         AKLSxfIJ5WqdSThSphiITCHB2RjcG7UQ1YHQNF3MvmyXRM1Tp2OiUbCvedNO3jQkFFRT
         btbNI2xW7Ere0NkpBFWVvHZm20JFuFHyXvYiSmswBbiKn6FCvtTiOTJdry/3z6ZJWvNw
         eyverMH3OzvoVrTAVmyYFlYnAqo4jmW8Yk0KsItTDFaACXh1diBSgOsqYMaR2HZLLa0W
         5y1w==
X-Forwarded-Encrypted: i=1; AJvYcCUZgJLvB5oVvHeGf0GUA6m2P77Qypc96KKSz2Rb1y8KkThZegl/w9iu72ScvGf4pINg88P1erQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTe/fA8XzZZR9NF721V0cANz6SJCBDff60ebDZ72hHqLO22u1O
	Q5DkWJSjcAN/OxxkiNrXcQ+Q9VpDwi4m7SGNVnopZ44pwWEd7isR
X-Gm-Gg: ASbGnct9YKoKFiETnWEwhMsAsvmIQS8/NjLEqXPxGf2NlfczCMhwr9m2Jr2EkYdqu66
	/EgWzRGAd6747mZUqVPyiL9P7ZNnqlbTCGOiYrAUnNidj5X4MSTxpHJq7mSBxw5cOGPfuBZA90N
	mKGcu1pDhdwm/Ibg9jvj3z8wezWJbPIQ2C1lTDzLN+Juj8Yv4Tk0H/E8CX+BBb1CxeAC7dhXzcQ
	o4Wh46fnCL0LTzqFkdQzf2nBtEo4y7KmLNA3Bt7ENkrPZTw6vUpxq/DAGW/eYdA3uwG7BtErw7H
	XKlrn69XKd1p96PsCD2mj4zNK3IN02+cj2iyeljLT+g5ErQpjmf/b6FjdB0gZ0b5LRsMlEsaB/Y
	tyWrbSu0=
X-Google-Smtp-Source: AGHT+IEpCL3ntyjH4x7myZpm1PaA0O4Ri2CUDXSnoYpASpJKwvBumZ7gHb7wXUSsy8vWv8jiGPHshg==
X-Received: by 2002:a5d:5f48:0:b0:391:47d8:de2d with SMTP id ffacd0b85a97d-39c120e3585mr8580667f8f.23.1743456716492;
        Mon, 31 Mar 2025 14:31:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b662c05sm12141919f8f.23.2025.03.31.14.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:31:56 -0700 (PDT)
Date: Mon, 31 Mar 2025 22:31:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: agruenba@redhat.com, stable@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH gfs2/for-next] gfs2: use delay during spinlock area
Message-ID: <20250331223154.1fd4b0dc@pumpkin>
In-Reply-To: <20250331193656.1134507-1-aahringo@redhat.com>
References: <20250331193656.1134507-1-aahringo@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 15:36:56 -0400
Alexander Aring <aahringo@redhat.com> wrote:

> In a rare case of gfs2 spectator mount the ls->ls_recover_spin is being
> held. In this case we cannot call msleep_interruptible() as we a in a
> non-sleepable context. Replace it with mdelay() to busy wait for 1
> second.

You can't busy wait like that.
You've just stopped any RT process that last ran on the cpu you are
on from running, as well as all any interrupts tied to the cpu.
Also consider a single cpu system.

	David

> 
> Cc: stable@vger.kernel.org
> Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/gfs2/lock_dlm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> index 58aeeae7ed8c..ac0afedff49b 100644
> --- a/fs/gfs2/lock_dlm.c
> +++ b/fs/gfs2/lock_dlm.c
> @@ -996,7 +996,7 @@ static int control_mount(struct gfs2_sbd *sdp)
>  		if (sdp->sd_args.ar_spectator) {
>  			fs_info(sdp, "Recovery is required. Waiting for a "
>  				"non-spectator to mount.\n");
> -			msleep_interruptible(1000);
> +			mdelay(1000);
>  		} else {
>  			fs_info(sdp, "control_mount wait1 block %u start %u "
>  				"mount %u lvb %u flags %lx\n", block_gen,


