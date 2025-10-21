Return-Path: <stable+bounces-188354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F3BF7046
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3287C50500F
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 14:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30463260580;
	Tue, 21 Oct 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBs96o1a"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A0238C1F
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056327; cv=none; b=ANZlS0TsbsO6g/6rzb5Y28ttVTUC34pXpyHBlOG9v4fJEeQzdkNiTqPfs8t5Oiy4wLBXrND6WltAhSJ1iKbcaeS9xPCoSuS1gM/Ax1W6K0kQX2YLsrZkwPauM3VAc/5qzOtZdV3iQy5ybu6huyIqksEy7gqWysBhPsWOHRdvqKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056327; c=relaxed/simple;
	bh=td0wxdJvwksCsQ8szApwyuadUAHIWrEX7VEhKsxp9ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agHmSV90u7K24DNIDR5t/amNodbBz5sK7ZazQh/yyiMa7BzgxZLHPgzxs/a8QPLVvhR2HfYxbHbjkRlMuVbB+38HNEdBv2SF3igL0qQb2BNqQvfFxoaz+e6zeTRpWjPPMy6AneoJoKMmgMUj959kp/YiMDHPubNDLZQAIDPrOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBs96o1a; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42701b29a7eso2659431f8f.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761056323; x=1761661123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTg6iWTU9Y0FmHMWVr7mpqpsIik70Dq7Hr+fkZkn6eg=;
        b=PBs96o1ah+w8aX0y9oKe7fpZGAOu+zu+VpZA+sClRj0ZqIvIRIN1YOvUh6F5NtPzyS
         8mSsy9/uArSliWIBBMxPkzBP8aQYL8cS5464cU3eTZG2IhGgFUcrE2WCNEeUl0/eIbZ4
         zhNi5HalEiUG5GWsIcQDLF+XVZob0jBSP2POq+nBYpbxUyIIleC93j7fItiBGHaby+QZ
         8FlCq5rwcnTM6s711duD4aKwJ2ucWymccpdZKnHsk4hSsS5iZ/f+uKXlJyfzLD2znLL6
         tns2UN3WiT2t/mcyprUsvuqqGRV4aIDZC83yocuouLJFNir0b1ttUl6T7u6ITzh0pC8O
         rlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761056323; x=1761661123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTg6iWTU9Y0FmHMWVr7mpqpsIik70Dq7Hr+fkZkn6eg=;
        b=bkt3IDTYd61eCEL6Ahk8Me0TdQ+lMT/EMSYl+ftYrl95UVjKCumGUaJj/jvBVzLOLN
         jlMgtXzguwCgMnzJPE8ZIAG48sIk3afq3Cma53eiIxuF24tWdRq+aS/JXpk1ReeM1xn0
         A6QGSS9ED5iIUTgSJlh/IogMTKKM2ThiYaqOCAABBZ1ChdEvKWpGi/WyHBz6uKf+2uYI
         gqnmvzn8kjZK9uOs8Y3uT3wC65YS8Ek/sTGSsxTf/f6DXGBqjhnc35BqhADZcdJ2CANQ
         HpuBrQx1pa1HgHb3pkHWhidVqtf3ITmPAjIUFRXHJX5nP3C0Ox6JVQIaSAjyDSfGU+Zv
         xKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBeECX4Ya/5HCkXCoDnoFS4UFhD965+BifheihyNbKIhecwvqZCFXoENOfyUOIQtb51bnIAls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuToSl31fZX8ezGzIipS5bac4lJRYHzRrXiKqKwrG4jlsfzYTZ
	b9T6YbaGCdFpTTlYwXRhxPGcWhjbJ6WhpnmBXmj83Kf1UxzaG9/ZfO9avffopA1SsAsH04giloj
	/hP4k4xK0dTrPwjzBqythsCOff5FZ+Sw=
X-Gm-Gg: ASbGncvVjDvG4Js6IwmlNOp74lDLVTZ5VdxpG7Q46w3Z/0xs/2PIeytpHoOBJoBWscv
	Mi5k1bg9oK8EEFWOKvAgVxOs4AZTBAfuV5CThY4XnMAt2xPwczb0E/5DaFzca/tStCALA/Zff87
	ads3D9Apw73h1Lzhg2C96AGDH3qdbKTTbfLfk4QU8Cg/8h0i7hUBNb04kBBRQG1Ry05YkHs1mhS
	kuPkIMV/1LRIcU31UfYKeZSK1hI9zTDN/lO0UiMXQX1VmFjZVp6UgMHp5l/aHl8lOv81YOup4/4
	khhQLUf/mRg1L/EqNKk=
X-Google-Smtp-Source: AGHT+IFa3o4oRIU+3qLtptCG5zaP5IZUIUu7lzLKc3QkSze+Ys7kW5YhqHaljicbPhcJw59uJZEAVQ42kFJjUoq0zdA=
X-Received: by 2002:a5d:584c:0:b0:401:8707:8a4b with SMTP id
 ffacd0b85a97d-4285304a024mr45398f8f.13.1761056323420; Tue, 21 Oct 2025
 07:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a6024e8eab679043e9b8a5defdb41c4bda62f02b.1757016152.git.andreyknvl@gmail.com>
In-Reply-To: <a6024e8eab679043e9b8a5defdb41c4bda62f02b.1757016152.git.andreyknvl@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 21 Oct 2025 16:18:32 +0200
X-Gm-Features: AS18NWBzXNiBqt2jGmlRH7AZ1KVpx77wzAqEXOoi8Zzb_trF3c5-FIFSgDdxD7c
Message-ID: <CA+fCnZdG+X48_W_bSKYpziKohjp1QVgDzUzfYK_KOk42j58_ZA@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: do not limit transfer length
To: andrey.konovalov@linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:08=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@gmail.com>
>
> Drop the check on the maximum transfer length in Raw Gadget for both
> control and non-control transfers.
>
> Limiting the transfer length causes a problem with emulating USB devices
> whose full configuration descriptor exceeds PAGE_SIZE in length.
>
> Overall, there does not appear to be any reason to enforce any kind of
> transfer length limit on the Raw Gadget side for either control or
> non-control transfers, so let's just drop the related check.
>
> Cc: stable@vger.kernel.org
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/=
legacy/raw_gadget.c
> index 20165e1582d9..b71680c58de6 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -667,8 +667,6 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *=
io, void __user *ptr,
>                 return ERR_PTR(-EINVAL);
>         if (!usb_raw_io_flags_valid(io->flags))
>                 return ERR_PTR(-EINVAL);
> -       if (io->length > PAGE_SIZE)
> -               return ERR_PTR(-EINVAL);
>         if (get_from_user)
>                 data =3D memdup_user(ptr + sizeof(*io), io->length);
>         else {
> --
> 2.43.0
>

Hi Greg,

Could you pick up this patch?

Thank you!

