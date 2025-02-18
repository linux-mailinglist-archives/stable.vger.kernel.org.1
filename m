Return-Path: <stable+bounces-116759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA9EA39C04
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E14188F67E
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D92417FB;
	Tue, 18 Feb 2025 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR+loHcv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307BC10F4;
	Tue, 18 Feb 2025 12:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881203; cv=none; b=n0CcKBEh6XB5wPEoWtFgAENDJwmOUemv3276nnlD1l42DC6ygoZF68la6N3tbcdskJH1XvphYkTVX8AnJqQpXpTQTOiGHQ+dZFtiZkG5VhUL3arfoBh+kxLg3HZI+OfBzNhcwhO/60ISKLKZahLLMGpKTfu1EkgMWfswvLpXgGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881203; c=relaxed/simple;
	bh=4tj/uKB2dgnjPTdijnM3vXriuzb+4MfuEX2Q/7/ORiI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e/TWMeFaG7OHv/rTuwD3QArI7J2LJt+eo3GpX6SEa01zfFDxv6iyVgBNQjr479QKKgj4E5yF2pVP3VQpVEWkdt0LzR2hAJAvzwFPoizGhFZg1Q+7hKWOGejVE6e/nhUGTMU0JgorbXtqwbZ/I4yMyXRWsCetbBb2jGQJRrwiDUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR+loHcv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so1311275f8f.0;
        Tue, 18 Feb 2025 04:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739881200; x=1740486000; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YI0Ifn7vvsd2ZeXns6IUX10UekanaA4DCvpGAYoOivQ=;
        b=SR+loHcvlKFpnepbLbGmd2S9Vm9u00KFX0I7CJMT45tmiZ1YY5yGFJaxKbDN14xx4c
         fQ4mTgGUQU4dKYxIkxryg1Z7c/BmaKz9rp5JQVe8GRiTUNrPkED76kHfWPSaZo3liV19
         KsD86tBvBjFfyi3+64WY83rZoAGyFQZLPwC13qHGSw0LExUUH7Nd3LAqbOaOipRpBU1z
         hWKT+D253xLaUGGhpHwysipkCRrHyY1KRpnnBP5PZvyu6i/ZC1gADAeOlI160hoJ8jQx
         nG2pTnXDYbw6LsDXZt5AY5ut5SiZNnf8CM8o2g6qxOToPXfqnwe9Dt45RgNStMC7eI6F
         lvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739881200; x=1740486000;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YI0Ifn7vvsd2ZeXns6IUX10UekanaA4DCvpGAYoOivQ=;
        b=Mm48DdxXubhwvHMSz8Tw2zLT6GxCwBEnt19l3bW0fVESusoGXLWkEaGSA8AHgd2yE6
         48V+bZ1iTa4ZXNc30+6AzvH21v0ZHQgCX7KuaEQZuqOKCSP6P9xi25USJW5knMrvFeCu
         IjlxR6GcH/GldQtCRLtJLWuSxOJYmrndmhrHhNh8z74sIqNsH9KTEsP9SndYzcPHOd7x
         it786cB6ICydtfRIe1yfITxMTe6MrYUkMgjv7YJsM46CQhzYAUzQ7bhsBnaRQzIJ1Mrn
         6KzfHk3fDwd0XOwnmexfwyw6JWbzvL7QRw8bf0wAmJjiGz2F224k0+W9nxUJFg+hZ5xF
         mouQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhNQwPbe/pIx0SMbzGoqeQrD3dk35UDgihcyNpXMDRVzutViHOERvoCte4aZHkDiBqX7gr7A6j7OIo/MY=@vger.kernel.org, AJvYcCW3AX+AUmu4WHRITi9R16uYY6Gu3KyFfMPxMG86fXEVx4MOjkTfJcIawGbpB1Go+eMlxdROydbk@vger.kernel.org, AJvYcCWVpWaDK1GvOu925P7pppsAXBUqcaafgqWkuv97O3850tZSAhhuXUuzD+VXgiDWUkIHj27ASp2F@vger.kernel.org, AJvYcCX24h4qQvCg7W5nCueP3nwD93F6WURaTbOIupLc9vIOCONZc/+sMwdK8go5xMLU4i4sSVOPwbaYPVg5@vger.kernel.org
X-Gm-Message-State: AOJu0YzoKoD9A1oPdVOP4b5oLDKh4fuAkXA5u+kMLlQbmyFbqX4+shBY
	4G9wUT8vUog5SegOmTQKAKiGViERb0H+C4SjjPKDs6DqOK73z0kB
X-Gm-Gg: ASbGncs7Z38Ip8ZwIAxOPjSocOBuxYfEyd4oXEKpU9jNr8fnsO4IHnvquO30dLM1oZX
	ZuCD550HIM3GltEEf20ITUiVJg+hKwP6xBBojI602qzN0GXWRleNo9/QQ/2HyhPGnm1ri3bZje6
	cSMT0xDe2WbZFo96Q75vCy4T0xnCBbeDFWubSkmbq+aQx1zop+0TdTJchY7Legd2wb9bT3Qusqk
	4IU+g9IUgWyijGukR2BNKap1JPCBeWT+i2FWCsG4X6+qaN4hNTADDneGYjNplcniZqsYFN/gKOq
	uUNtU+AsZd+g9goSLy8=
X-Google-Smtp-Source: AGHT+IHlT4BxvNGeiNIO+gy5eC2ESBpBIhLS2/P0chI7LitN4FV9GGXXLs586hiKwDjI9OiT413wcA==
X-Received: by 2002:a5d:6c66:0:b0:38d:c2d7:b5a1 with SMTP id ffacd0b85a97d-38f33f28cb8mr11802160f8f.19.1739881200078;
        Tue, 18 Feb 2025 04:20:00 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:5092:6ded:7935:11b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ee2sm14652183f8f.80.2025.02.18.04.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 04:19:59 -0800 (PST)
Date: Tue, 18 Feb 2025 12:19:57 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart()
Message-ID: <Z7R6uet1dJ1UJsJ1@qasdev.system>
Reply-To: cf0d2929-d854-48ce-97eb-69747f0833f2@lunn.ch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2025 at 02:10:08AM +0100, Andrew Lunn wrote:
> On Tue, Feb 18, 2025 at 12:24:43AM +0000, Qasim Ijaz wrote:
> > In mii_nway_restart() during the line:
> > 
> > 	bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> > 
> > The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> > 
> > ch9200_mdio_read() utilises a local buffer, which is initialised 
> > with control_read():
> > 
> > 	unsigned char buff[2];
> > 	
> > However buff is conditionally initialised inside control_read():
> > 
> > 	if (err == size) {
> > 		memcpy(data, buf, size);
> > 	}
> > 
> > If the condition of "err == size" is not met, then buff remains 
> > uninitialised. Once this happens the uninitialised buff is accessed 
> > and returned during ch9200_mdio_read():
> > 
> > 	return (buff[0] | buff[1] << 8);
> > 	
> > The problem stems from the fact that ch9200_mdio_read() ignores the
> > return value of control_read(), leading to uinit-access of buff.
> > 
> > To fix this we should check the return value of control_read()
> > and return early on error.
> 
> What about get_mac_address()?
> 
> If you find a bug, it is a good idea to look around and see if there
> are any more instances of the same bug. I could be wrong, but it seems
> like get_mac_address() suffers from the same problem?

Thank you for the feedback Andrew. I checked get_mac_address() before
sending this patch and to me it looks like it does check the return value of
control_read(). It accumulates the return value of each control_read() call into 
rd_mac_len and then checks if it not equal to what is expected (ETH_ALEN which is 6),
I believe each call should return 2.

> 
> 	Andrew

