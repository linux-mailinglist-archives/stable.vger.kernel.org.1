Return-Path: <stable+bounces-108586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD70FA10485
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 11:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9521881566
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9022DC20;
	Tue, 14 Jan 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnAkZ4mW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075ED1ADC70;
	Tue, 14 Jan 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851498; cv=none; b=DVfXyGJkZcXb00Uaasgwo4wWIzDgfVRpUgi7mDhTgR9J/AzBNyV22q+L3oLkP17lKtxtmGqsknWWa65W3kWpTi1jzq37xMN/uIAd131NSaI3ejIiR79LBnsq8vXTpllUoOg6riGzE3uBRchtsANhtl76dRy72498wC9Jmw0lp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851498; c=relaxed/simple;
	bh=xdj6zI4VKabvlKxtwdq6nnIYS/avU/mTsaqNtJYzx60=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f0IksXwLG22j13rxvmkIBJ0PAZiVewywkIueb6ibcDYNjl7gh84/IuEk5sxYaTJ/fK4srIpO9aQ2s/XYZYtcZJli4rlyADTzwEP56IuTkljqw7o8kIzc1gGQOxoae5sQMl16gcZgnJdfZ6NrbqFiwAQj9zYwzkz1JL8qgDbbs2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnAkZ4mW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43623f0c574so37905655e9.2;
        Tue, 14 Jan 2025 02:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736851495; x=1737456295; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYGccp81SSXOLJr+IMkLll7Z5iuGZ6H3Qba7nStY0Bo=;
        b=KnAkZ4mWHVPoERg9XC5+xKoFjYOiuc6Pxl8EKvBqhRwvlUMKze+ZjFv7dCkG8khMHG
         HV1L/vMUxrRYRtAIBgAwmSj2JxB3YQLDI4ya0ps0SmMN/H7Ca2iUSjlrZ1crrNOLuFd9
         VApwcJ/U4jEE3HCjWuO6iZH+3DETuvCrXeMDEq4dZUcb+D2u5+NdkjSr/l1e9st5MgMp
         ca/EnzpckFh7e6oEbsteqIbVnEF+lZEiwGzLALOezfHKwt8eKOU7Jt1IpPpnup4EO2YX
         z1a2kxaKWsF7lpEw5S7yc1rCrNGO9rBalMAu4dv0IHAfM773Zdp4s1PjirXZDa1TZUI+
         U2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736851495; x=1737456295;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYGccp81SSXOLJr+IMkLll7Z5iuGZ6H3Qba7nStY0Bo=;
        b=gPfjIuQC4vVrobgJIyMqGzH5P8+xI2uLLcbBdP8P6+eGKiDsoRibKvOqJoNNsTALIS
         nNi5fi8jqdKjJdmGkNA5nN4rOsnTdeGdo9GKYfTDfOab8KJ2hbfQkQkfa2PMRqR/SnRM
         faEljJipNeUvfixNIQFuJCUdVplWolqN6bLOD9oez4Xx+NewbTGBJTx0cRq1u5qGggAR
         PJxMDkmUjEXHdAE7sqyhkS4Z7Npsup2gz0eEkipe1GHX+ra0mMCThXwj0VcYrvlXJ5bM
         85IvqMQ1doh+61iIzpnhCa7t9lhsgnGImjVOsCF1d8VrMOEF7yxVKAfcg8x416Sjru9I
         scNA==
X-Forwarded-Encrypted: i=1; AJvYcCVxm+jStM0zb04GpFpxeE7wRLl7Z0jRsoE5rlfjb1TnP5fRqOHe+jSleakQ2naB9YM57rBdgLjt@vger.kernel.org, AJvYcCW67d4T5lNbcaOLIDSNiaRSv3vbyEMat0LYRAXbxJJLuZDlatoPmAh0Alx/qyJmcem8LV3YPc7mtiJn@vger.kernel.org, AJvYcCWwdHZa003Wn82f1kz0/aJtV07L/4gtUU6UvrxgZHQnrARkYKMvpQYK9JzF8vS/n1Yworglo2y3LJEhwpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5X5VaJux6k/5AB4UyC9yO1TvzsVHq5h1GPxlXC0t7mtOJm8D
	S0sF1lIdkVdK+L0bJ/S5idTQHtsSsHl52ESmqYldgy9M+yFDtIMGpPqQJQ==
X-Gm-Gg: ASbGncss1hyUB9tiqez5nq5SVY1fu/w+bb9bPooSZPwujc3UZCLpSGEZw4MsOiZzTX2
	JKYSGajMkFkgbNNTeBs5efH8t/wcarNcoyp9KZ5mQH6xEBtNlvd38cKVgOtFI/hDUkTCw3809sl
	Lxc6ptxxuZeoxooAwsvttaxafqilmrpnPyhH80mXMDFg4a1nSodiGyWrjoDIUsKks7xqpdqbTFg
	7SZ1l9Qiln4gJUrta9B1vflOUgfYSCYIlSzHiNVHztorZzxChXYbYd6e7R4
X-Google-Smtp-Source: AGHT+IEpomaSHHvATjwsHk8UVA+bwfL5HVjsRaMpF+eRPb/SFBEoFtFTRPLGC/F+YGyzLX4rxByipw==
X-Received: by 2002:adf:a3c2:0:b0:38a:88bc:a8e3 with SMTP id ffacd0b85a97d-38a88bca90emr17470183f8f.33.1736851495155;
        Tue, 14 Jan 2025 02:44:55 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:c2a6:1aec:4f91:f2db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c0f03984sm12457695e9.0.2025.01.14.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:44:54 -0800 (PST)
Date: Tue, 14 Jan 2025 10:44:47 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: quatech2: Fix null-ptr-deref in
 qt2_process_read_urb()
Message-ID: <Z4ZAH1JYXFdE6Z4d@qasdev.system>
Reply-To: Z4YytXjBXBTk4G1a@hovoldconsulting.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2025 at 10:47:33AM +0100, Johan Hovold wrote:
> On Mon, Jan 13, 2025 at 06:00:34PM +0000, Qasim Ijaz wrote:
> > This patch addresses a null-ptr-deref in qt2_process_read_urb() due to
> > an incorrect bounds check in the following:
> > 
> >        if (newport > serial->num_ports) {
> >                dev_err(&port->dev,
> >                        "%s - port change to invalid port: %i\n",
> >                        __func__, newport);
> >                break;
> >        }
> > 
> > The condition doesn't account for the valid range of the serial->port
> > buffer, which is from 0 to serial->num_ports - 1. When newport is equal
> > to serial->num_ports, the assignment of "port" in the
> > following code is out-of-bounds and NULL:
> > 
> >        serial_priv->current_port = newport;
> >        port = serial->port[serial_priv->current_port];
> > 
> > The fix checks if newport is greater than or equal to serial->num_ports
> > indicating it is out-of-bounds.
> > 
> > Reported-by: syzbot <syzbot+506479ebf12fe435d01a@syzkaller.appspotmail.com>
> > Closes: https://syzkaller.appspot.com/bug?extid=506479ebf12fe435d01a
> > Fixes: f7a33e608d9a ("USB: serial: add quatech2 usb to serial driver")
> > Cc: <stable@vger.kernel.org>      # 3.5
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > ---
> 
> Thanks for the update. I've applied the patch now after adding Greg's
> Reviewed-by tag (for v2).
> 
> For your future contributions, try to remember to include any
> Reviewed-by or Tested-by tags when updating the patch unless the changes
> are non-trivial.
> 
> There should typically also be a short change log here under the ---
> line to indicate what changes from previous versions.
> 
> It is also encouraged to write the commit message in imperative mood
> (add, change, fix) and to avoid the phrase "this patch". There are some
> more details in
> 
> 	Documentation/process/submitting-patches.rst
> 
> Something to keep in mind for the future, but this patch already looks
> really good.
> 
> Johan

Hi Johan,

Thanks for reviewing and applying the patch. I appreciate the guidance on patch style and process, and I'll incorporate your suggestions in future submissions.

Best regards,
Qasim

