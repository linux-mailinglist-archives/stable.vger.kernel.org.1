Return-Path: <stable+bounces-43513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC3D8C1815
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 23:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613E31C214B9
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5884FB9;
	Thu,  9 May 2024 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfOTS12V"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593A84A4F
	for <stable@vger.kernel.org>; Thu,  9 May 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288971; cv=none; b=aL9PK7yX49dFrS7IWCuzZI9Mj5k0vJ9BDu2VvhmiXmqnJub/3yYBEDB2JMoH0pVC9GWQpuMJIArgHeNPyj5CWvtjSAQePNPrCWeSGknJrPqCIGKR0P/MoTwB8rRmoa3l0RpWUypknB0RIJrHI1TWWhBTLz0DiHAdB2uvL8FqcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288971; c=relaxed/simple;
	bh=7cnpsm3ib7QnJPl5zCKiOydDwPHEacdR7vNxGjiSv8Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k8+qtmpxeel7nP9+F/zj8Vvmh3aPh9LvFR8B/8pgdQCtvAyJOHYdeblTjCiKky3j5+v3MqtiQb8p1yPNUl6HEGSYpxGvQsb8quFH4nHSzYijFBFzjwd7guS3hpc5tT7fx5MoAMONUraAb58r40Z6TjWDbshCsnM5NmRZr99V0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QfOTS12V; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso4968a12.0
        for <stable@vger.kernel.org>; Thu, 09 May 2024 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715288968; x=1715893768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IL/Pjb6tjWhJpQQRsXDN6a0F0TkBXzEFnC2pzR1ugRo=;
        b=QfOTS12V8fn4ISODCE15/1dK92LwmWbxTpigiSfIVgz/l1OTaw7ouQnXL5PESDqSDW
         qKsTRWWb7i1dfd3StQT5C+4t5Dj1e/w7OvVwVF8etWprZJxTKb1pFeGSA6m+c7DaqTru
         CyeQT8JLS9vEOPU2ATQQHhZuqRtwoxRWrJ2hcUPK0vT2jm/hTgwKqvcX9wr6k8xsR2qs
         lM2mIxOnvgcSr8Nz2X1shsIu+HqX82tTDVIO8vFqT3V+ehtqXxh0C1KijIqQcMW3+VWR
         f0PlD4XK9h96K1iiBBaojRDq1rKgbF+ZTo4Dt/LK+QpijSMjvNdeAloIQZsA8Xx2X1uY
         WxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715288968; x=1715893768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IL/Pjb6tjWhJpQQRsXDN6a0F0TkBXzEFnC2pzR1ugRo=;
        b=oz6aTY7DIKTDaTYRNeCe62Uc9OGxbnPheVY1vue/bCARYHxy0v6n3ozLFPffdYncVh
         4yIPdsChPJ12sLCkLiOR+T1jKyHE+03tlQix/VeOik0si9MTnu4YliWah6lfIwyzyDy9
         uUgTDfh2OsSoihliMRT3GUnuxPKp4hLuzI9P5S3HFEoMUxMKwI3O2lxVYT7U+1SfZ2Gu
         MvDQr+8VRVant6i2eVK5HLOD8dHOfuYw5rUgxulnR3xQBgn5xLsqCW1aeqmMm6rQMCkA
         rFFAED+zSkekW2BCAtDqEBNxFdV6vY4t0g63FgGqYVjUXrP/yxfN1o1Xz4lr4BlEn96a
         LgPg==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZS3t9zlghGKM/6FuXHMiXAQblPaVkPKO/XU3RDxuHTINQdJK3ZeUbFsExUFa1tBJrb0KMyVgYa34MMo5gtlMlO2F+D9E
X-Gm-Message-State: AOJu0Yzyvkb1zK8gPqgX0RgQoF4tSqINCgqO8SdY3R9btqAF6RFf1i5m
	zYg7S5QXrGIRhDE6BfrdWEtgavw4mFDENnUFIP3w0AeVdgdavdYot3kiUVXJ+p9fAXn8WbNdgOQ
	Y32cOK7eru1lpHSoAkioKw8oL5crUF34+q3hu
X-Google-Smtp-Source: AGHT+IGLbC6d4w8wZMLlw5I4DGRaK7YIk0zlXO0iTIICkqw5Ts8o5uqz4W8LZrRpEWHQYx4NiJD5Ca9wEo2T+5KNyg0=
X-Received: by 2002:a50:85cb:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-57351de5880mr9179a12.1.1715288968389; Thu, 09 May 2024 14:09:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeffery Miller <jefferymiller@google.com>
Date: Thu, 9 May 2024 16:09:16 -0500
Message-ID: <CAAzPG9M+KNowPwkoYo+QftrN3u6zdN1cWq0XMvgS8UBEmWt+0g@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: jtornosm@redhat.com
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, inventor500@vivaldi.net, 
	jarkko.palviainen@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jos=C3=A9,

I'm testing on the 6.6 kernel with a "0b95:1790 ASIX Electronics Corp.
AX88179 Gigabit Ethernet" device.
after applying commit 56f78615bcb1 ("net: usb: ax88179_178a: avoid
writing the mac address before first reading")
the network will no longer work after brining the device down.

After plugging in the device, it generally will work with ifconfig:
$ ifconfig eth0 <ip address>
However, if I then try bringing the devcie down and back up, it no longer w=
orks.
$ ifconfig eth0 down
$ ifconfig eth0  <ip address>
$ ethtool eth0 | grep detected
  Link detected: no

The link will continue to report as undetected.

If I revert 56f78615bcb1 the device will work after bringing it down
and back up.

If I build at commit d7a319889498 ("net: usb: ax88179_178a: avoid two
consecutive device resets") and its
parent d7a319889498^ these also work.

Is this something you have seen before with your test devices?

Regards,
Jeff

