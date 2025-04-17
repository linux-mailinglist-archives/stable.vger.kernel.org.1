Return-Path: <stable+bounces-133099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7327EA91D4E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F76C7A70F4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2A241698;
	Thu, 17 Apr 2025 13:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrV+GUKg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279F64A98;
	Thu, 17 Apr 2025 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895271; cv=none; b=B05G8dbCxPJgdghoCzHVbK4zRs2AtpSBhY8391ns1a3sa5IBkuO2zb3IiauFioUNeYy+vul2fcLjgkVkwWhp1UCjN6L7wRdxfliDjFbvO74iOjiKv9R5hu/frLZKVegd49aoqPvYRr617R4OSvLfkIm65Y2h5oLKB3gig9au198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895271; c=relaxed/simple;
	bh=UjV9aC2iKPYoWSiVENtanYjNOx1Slgo6xak/xSRZJqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUwiJPCcpeKdhaWpSesUa2utLUFHwVnLhVaQq2nu72vksKgZAcICyOUiV8XCAJxw9IA9WAvZhypIoN+bS47OSRI1Jyl91Zq74AYzDLaafi2TXfK3kgomqUFpfSaDB2jqcLYMtvZkXDmY2QHzGsiPCOZmdGRF6m6kKbyKUrYg0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrV+GUKg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c2688619bso478020f8f.1;
        Thu, 17 Apr 2025 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744895268; x=1745500068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CdZ/++ZH3GtnA2ccX3OYnMNThHIYKD/1Ho+RU8AFgE4=;
        b=PrV+GUKglNUrO5zhuW/47jQ9sjWYUlDPbUhbcg/DhXhGI6AZ2T+pdTl1F6TRBACmv/
         hAne3AFFdVGPwO3YlOQMgy2d5LWkqvDgSnxbP4tH3GKTUbNUNj43RnifWzv9+2R7oMhb
         +qHSBrsCmh0xnKC2wjNrG3KnaQ96Rm2sLlWWsBi+ZM9R7FOsxDPprC5eSLiY0/6RKf1S
         Zna/aM22yKns68aetLSKo36qE/gf1CS6by2gsaNKhQcjvTAuUYoz5vvVKK1T9WJSh/Eq
         Tx6Mw5BkzgdUpUkAI0++fpbZX/BAdGdt//YEXZlJsd2Ig8Umv2tgS32HAaGMnIMnMT3h
         yDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744895268; x=1745500068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdZ/++ZH3GtnA2ccX3OYnMNThHIYKD/1Ho+RU8AFgE4=;
        b=cl+E3KzXpMVTo4rQKCu0UfRKQqr6L/cDuoBfalZ7Jt0U7U0AsDgKDyx9SogbIvP3Yz
         E+kzKdKwAS4Y7+xMFQ6TydoXZMdIfWQrLDg7mSow3fLdUyJZOIU6DymQjyjKob+tN8/C
         rAa0hx3KNEkFZYlTxogwX+ywzWvPPFsFWqjcRS0uHp8RXVzwckJjKJx9OoPL+ma50yv6
         sTLtjObzNGGwZlLREivSi+nUqFDh8McsiSxYFH2dGpLwalJ7L0h2lM2iZXoJa45033fa
         GjlBptQnTmB6k2R2OGtuhXc2qS5X65g8hsGlZJDen4dfAo5lHezP04jaUOmgVF+Pq/57
         oM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/xMPWTJOGfhODsNgNeOTsO1sFShTv5L2E5GCiU+lwEWJd+0Os44pwpAL0Qn95AHudzlFDP70akLKaRgw=@vger.kernel.org, AJvYcCU5QgWvlsVR4qo0eRrkVued1OtJ20v00ucwiAenBRgwpC1M5Qr7SdojCD5A91QTZgRDASBWXPUw@vger.kernel.org, AJvYcCWMbziagGpQFUiu1K4CuFs9yt+gpz8jjsjhLPOIAfNbOpMSkvnVL8qOoEaINBdLY+z6s82+Y9c6@vger.kernel.org, AJvYcCWN/jae5NnrvWTDm73RI1OKgvdRMLMWbgzp2TFCmop4b14DXbFaAsK74vnqlFEHfuOJ70+77++WDTrs@vger.kernel.org
X-Gm-Message-State: AOJu0YxMg1+YgSdCjz1HkLYpguA0CnfwYWOBDAvR0sD04uNAmQ4neqss
	YCy+9uW5W+HLhp0Ysctg1giNmVkuuTKo2/SA6u280rKsOai0Tz3E
X-Gm-Gg: ASbGncsxeMPjcum2O4gKlNUrOEQ4Ion39LWRAxKzZmXuzKIspQX8Pff+snEXkiI2pPv
	U2304EYXo1uYJxWA9E04dVU1GGdLbNVWYQxBDzqJb/jN9/HW1D9fs3QfZmq3i5TQ/pjfYjYIh/t
	0ESTel/ymZP+WQDAp3oWdSxLQUU0qgwEmDMUVzZ4kvNbb4UY/ZcGrQvkhqWk7EXOek4lo4CAoV3
	A+Juqjq+0FariZr5OIJWXWa8/ZMq3OJ+lafwKU8sF8tREcqwiTCQeRUoI5hghMvndT3m3yYVelS
	9ohpExjcNV9mX2YB/bEeh/aTzer+2NTkh2U4XTw=
X-Google-Smtp-Source: AGHT+IHb8mvMFNp6gOWVQLM5OsbQP1zjX7lIIaNxG4URsFT43g10QOXLplmQlUjGdo3GH+1kBmp/fw==
X-Received: by 2002:a05:6000:1ac8:b0:39c:266c:421 with SMTP id ffacd0b85a97d-39ee5adbf1fmr4730232f8f.0.1744895266662;
        Thu, 17 Apr 2025 06:07:46 -0700 (PDT)
Received: from gmail.com ([2a02:c7c:6696:8300:30d6:b851:2d62:d3f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b53dee0sm52901945e9.33.2025.04.17.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:07:46 -0700 (PDT)
Date: Thu, 17 Apr 2025 14:07:38 +0100
From: Qasim Ijaz <qasdev00@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] net: ch9200: add missing error handling in
 ch9200_bind()
Message-ID: <aAD9GsY02U4dGBJ1@gmail.com>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-5-qasdev00@gmail.com>
 <20250415204708.13dc3156@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415204708.13dc3156@kernel.org>

On Tue, Apr 15, 2025 at 08:47:08PM -0700, Jakub Kicinski wrote:
> On Sat, 12 Apr 2025 19:38:28 +0100 Qasim Ijaz wrote:
> >  	retval = usbnet_get_endpoints(dev, intf);
> > -	if (retval)
> > +	if (retval < 0)
> >  		return retval;
> 
> This change is unnecessary ? Commit message speaks of control_write(),
> this is usbnet_get_endpoints().


So this change was done mainly for consistency with the other error checks in the function. 
Essentially in my one of my previous patches (<https://lore.kernel.org/all/20250317175117.GI688833@kernel.org/>) 
I was using "if (retval)" for error handling, however after Simon's recommendation to use "if (retval < 0)" I 
changed this. In this particular function I took Simons advice but then noticed that the 
usbnet_get_endpoints() check was still using "if (retval)" so I decided to make it the same as the others. 

The behaviour is still the same regardless of it we do "if (retval < 0)" or "if (retval)" for 
checking usbnet_get_endpoints() since it returns 0 on success or negative on failure. 

So in ch9200_bind:

In the first case of "if (retval)", if the usbnet_get_endpoints() function fails 
and returns negative then we execute this branch and it returns negative, if it 
succeeds with 0 then the ch9200_bind function continues.

In the second case of "if (retval < 0)", if the usbnet_get_endpoints() function 
fails and returns negative then we execute this branch and it returns negative, 
if it succeeds with 0 then ch9200_bind function continues.

If you like I can include this in the patch description for clarity or remove it entirely.

