Return-Path: <stable+bounces-254406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLomICHaFWpYdAcAu9opvQ
	(envelope-from <stable+bounces-254406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:36:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6DB5DAC3F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAEBD300C392
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C82413D8B;
	Tue, 26 May 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E52GbOQe"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715240B6DC
	for <stable@vger.kernel.org>; Tue, 26 May 2026 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816987; cv=none; b=cneGfemk8G9P3h1xPulpS1og9Yp4PlNDNAKZ2gROY0NxEsJpNdDxe7zMuT1pwmr7gN0D9pyAEqurfGOf8H7BlYi2573CINzVU9h5D0NM95HNXK9PY1YUL9BgLrC8ovW4CrhO7ttmfXfXHzAlQQ/eO6j/Wuwd+pr7o6iKQO/mkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816987; c=relaxed/simple;
	bh=itptXuNe4ygUJvTHoay1T9eFRWRgrelgdM2TdraIkac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9JDpLQvxs06pNwj+1Pltnzj9x0z+hC0/FFu0qbJQVQCK/CBKPvytbA2lHg72iXg5sYLpksvQxbf89LWHagezGaWMPF0mKKpFtP6b59Nvr9k8oIAJ3lgS/cVa4cWp+b+DozOYtTlWlvMTEoGDrYsd0vtM04LZqN/THU1bLYqgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E52GbOQe; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12ddbe104ccso8106382c88.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779816985; x=1780421785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6BSuOR6NYcvyJ2FNhs6DvFNJ6pd+/sZduNctzVkyME=;
        b=E52GbOQevGEBxOQPl1qxQB0dUsn97zS5LR9l+3oZBlol4j1ufFoX8qVQMWTVPTpSTi
         Wxvthh2TON2z7OYKaP7g8y8xSB3tH+LjSS0e/chjZ5e71JxKpNA/+h/oborbyd/IMy5P
         32zDvu+5Ulf+giwNWsUceGWHmKfz0/cwdp7LFOA9kGIfyfXSwj+UFWWcfhuPpfwjUojx
         rTzweKTQzHpQngjSflXX16ZHFWKaG4MTldw5zlHALSa/ekPldrIXlOWoOw2i0fjyD6cq
         IlLoDvRxSRoEOxAzzPQCW78Wp3yvqovumqpMWEv7tPdHTdBsEvBH15mhjNGyyiNh2EUH
         7oYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779816985; x=1780421785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6BSuOR6NYcvyJ2FNhs6DvFNJ6pd+/sZduNctzVkyME=;
        b=qoSXMrjW5Hdf8qfOEo+xI4f/V05K7DJr8UzXCXZw3XuJyTM/5mS82OycBYykZQEt3a
         FVr8Ui6o5H6x1QsRaLC9NjbmYva+s10pREc0WJMdAE0gvzS6n/+Kni3kPJQKUjhh69Vh
         AI2HzxPUH0E7S+FVOeVqcHfl7woIWKaPO3v/DW4g6wN3GGSQ5NfxTMGsxmw8roZ/nQkg
         O+B3DskYT7P0DQwhL28Bwhj6EVkPdXyfHInGgwhdihtEuayvkUJ6kPDK35lqiS1p3utb
         7IU50yzwQzS4jUwCF1A1HVHK8mVlSAzmhqxB7/4N/rjbfflfkPaQs5cDYVGohesSLi2j
         gTLw==
X-Forwarded-Encrypted: i=1; AFNElJ92LzUEgTw8LMaVnIoYIVgy7iJ3QjDTYFPkN7aE/BmZZLyz3n8m+8feRZoNaZeE0G0EN0KdRDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1pWyJ4z0PFFzzw7M4DPdZQMJ3ELlY5fPxMfrxSfaONVP8Xk5
	0U4TuCe4qSn5OzHwJWo6sFvshv8Kti7gLyLR43jLPT5J4pqQVm6edsLN
X-Gm-Gg: Acq92OHuZ6+V6HC/1TDAQmPuEUPQXuw0GetqxPiEwK7z0u69oY5klegbJefdvRRf0Lq
	tAhPKfSiCub8suHm6YMShziWOjh5MOxYVRmyjLEszSXT3Z2ZdAuXCDX4l7IIX/oMW7X0yyA5Bpi
	AmvSW0A8tirZF0fbhNDAeT94XTe5d1EpH1cED9IPjFYgEDBJCAIhtYkCXkLaYk9Xm8XxCHotYe5
	oL3H2Ef3kvSlWSdyIT+V2HVzJz4oAnC+GFKbG7I/BMrBmF+9ibq+2WBJIBflOwQoS8jhZANwMeG
	TL0m+mXBdPzDtZy0xpu4RKhq+y6Z+ywb/ITAzuyjm+kjQRIfQR2dUcYo4IIxzslvbSbXsQLcPUm
	ypaTA3cHf9v3DKMqhp4nmh1hSb7NTeI2DUM/DXhhVY17H+AO13ETPdNmrBrrNGKr80L7fPx0I+s
	DNRuldBQZ9ZubEVqVBFqHu/HHAtjgHP/w6WuB7r+F6LDtsI/noM1mvwsAI/QNlDWhW
X-Received: by 2002:a05:7022:f206:b0:136:e639:9c14 with SMTP id a92af1059eb24-136e6399e60mr2835502c88.30.1779816984904;
        Tue, 26 May 2026 10:36:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:912f:eb49:d713:7401])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-136b3706ad6sm6655781c88.13.2026.05.26.10.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:36:24 -0700 (PDT)
Date: Tue, 26 May 2026 10:36:08 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] Input: rmi4 - release F54 queue on video registration
 failure
Message-ID: <ahXYreASLGSPuIe_@google.com>
References: <20260524182351.27658-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524182351.27658-1-mhun512@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254406-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8C6DB5DAC3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 03:23:45AM +0900, Myeonghun Pak wrote:
> rmi_f54_probe() initializes the videobuf2 queue before registering the
> video device. If video_register_device() fails, probe only unregisters
> the V4L2 device and leaves the initialized queue unwound by neither
> remove nor file release paths.
> 
> Release the queue before continuing through the existing probe error
> path.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/input/rmi4/rmi_f54.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index 61909e1a39..fca7b9fec5 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -722,6 +722,7 @@ static int rmi_f54_probe(struct rmi_function *fn)
>  	ret = video_register_device(&f54->vdev, VFL_TYPE_TOUCH, -1);
>  	if (ret) {
>  		dev_err(&fn->dev, "Unable to register video subdevice.");
> +		vb2_queue_release(&f54->queue);
>  		goto remove_v4l2;
>  	}
>  

Hans, could you please Ack or Nak it? It is unclear to me if this
cleanup is mandatory and whether it is also needed in rmi_f54_remove().

Thanks.

-- 
Dmitry

