Return-Path: <stable+bounces-237701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IR+J6mg3WkkhAkAu9opvQ
	(envelope-from <stable+bounces-237701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:04:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8143F4E32
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 04:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C398330131F6
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE92D739C;
	Tue, 14 Apr 2026 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pY96Agag"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79286341
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776132257; cv=pass; b=VzPT+Pt0fAzEaugL7nmhDh0qAwn3PdOswaeT7p8zKoQEu5ATFggRZngO0FHqBtbv5JtZo0HXlm7f4x2Le4V2vxTLde0EsRyW5Wc81NpXL5+LY0cxxCmUwQvEAbe7GnzOSvkvZt2GehoFXaPM/JXPL8YM0Cqm7S8LgLxU47f+HqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776132257; c=relaxed/simple;
	bh=vh5kRDjzzBEJ7r3I1+/zHm3OqBBaVfrc2+H7j4HGEXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1Gk9spFrZUDzxzxDhtif1jVeJppjHFy4qb/3pQLldiAY6j/EPkzz5Rq1FwLL/llx6E6GUya+HBe6+5RKeLiQfhyzp5WMWfYMCFOBt5YtBaVnu4V8RrOsk45kSrEUIXtocnYzGVHVXxY08TB2m7xCG5x7QxuDFfSIh71hcP2sh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pY96Agag; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-799001d73bdso38300707b3.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776132256; cv=none;
        d=google.com; s=arc-20240605;
        b=RKq7wd8HGbMMXR1zEmOz8BeYTEmdj/Zy51IAYxowtDu5c7yvZKZHIubUduEJ0O2a+l
         goEgo3UEmIlr8MWme9yz76lYL5EGVhBk98nA78rFEpxjWCTl6XnuNkrjxxLgZSGGy3sG
         4VwUYbKe40XgQDWoP/Y8ZDyJ8mu8trKDRZgmt0XNRUVTE2i38/515cXMC5sH1nEV9S2e
         e/rEHCANjDEknbVGbk/+krUCR0wB+j4v1kNGIEVL7WNjXdfJ2//xPoIVAw0uu7JnKn9z
         ZVdoG91WcK7e8xYr2XGbWFpzZWSi9500ILWYpkoIsuNbRg5s6LTx14Xeu1j7KzTTXRnP
         qdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wo6qnMj7T215aHzWxww/SxbyHvlT9Ci/8Zz3mgbJ9ms=;
        fh=hs7iIR1EtNOOwVWcFMwF+IxGosJzx912dOvOi8QfkHc=;
        b=gXxrSn+kdgPzijTZRXEZAJAIQSjHq2ph7I+COiDo2g2H+dOH2dauW/o6KFnN7GF09P
         k+oD+vFlhvcqvz3ygyVfUMs4U8GxLGZsPYdHheTFShBjRrDccFKxIkkTABBQdGOldYQw
         vV3ty4cQil27g8eEudNwVrgzenuCjlEinB9vZmPFq9EaKIe5BBgGUugPDBJdusbMTB2Z
         HALMLZVgMCF4d5BU2i+VMz5bwnQfnSMUpqhOfbUh4XPh2nMRt9wPOypLLabV+L7VohZ3
         In5eYtbOePaCyvZsj+Vp6pv+p8CNXYL7WgeXrzBMAZHd37nD1O1jID0OHtN24NlxUzpG
         U6Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776132256; x=1776737056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo6qnMj7T215aHzWxww/SxbyHvlT9Ci/8Zz3mgbJ9ms=;
        b=pY96Agag8BYNbxaXrSjpT/JR3UupQsg2LrPA9rn6zgYwpN58S325uMdrmO68wHcWtC
         nbT0erB/ovGBY40p3NRGAOLqm8zhWqJukezC3oZWCcVjqMjHl3rDznCpk8JZ06u6J4xn
         S8eGHY2X39mbEsKJ6Kd9Ne8H6VFKZQWjDCEek8N7imXDkeNNgiSVPJSbbGPBpGgRQ1nE
         tJnfceq8rBKqs8YdgixgQcmGZQUBp8OShmzHAKqO5cTvoxJYK/8YSYqmZbSEwDtNKoao
         bHX7ifAEAPYpF6Ld+aay+0E1hCKls/K2nPOGgKZfnQhfculd6Hl2xFrpJGP0xHEnSI71
         xg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776132256; x=1776737056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wo6qnMj7T215aHzWxww/SxbyHvlT9Ci/8Zz3mgbJ9ms=;
        b=Gc5DE5M5KxW1fZxYsJV0LkVFIFUQVFtx//id07hE3ePzZsxg3+zYRtGKHLVfXRJdJn
         k5hcPuFKGQYwVNf0h3p+osQsvkND+OCesBL2sUCAfkZz2gcsW2HxQJW4Coh1RWzLP/EQ
         73OKuBEOMoO6Pmi0SfcEy+mVPmieEMCuTkUf+ZR1xBhETj+AbRWAWH5UlpkgGlvvudwA
         2sDAcr3GC7wNQNqmVzDajtdr+c0okCgxsg5hLrVV+9vqB67YmCSJtpfed4lzmfiqLAMW
         HGZlzHtJRLERB2J93hJYP9iNQg1DtwBad+1tZWa4+1caXhSpzGJRX7ZI1qoSyfuQibhY
         aR7A==
X-Forwarded-Encrypted: i=1; AFNElJ8+7MZiCmrLpbp1+FyhZ8IK5UFZLWuTapSdoOp/ka7rkVIImqFpjJluvb+I6H74E4Ty2otS9xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyLQJvh3gz2NLABnLBItBrpmRrrwyY0ekkoOLYcX/p2mgNzSe
	XIALOmZV7MI6UgcvNYBxF4FlP6UhNF00uY0OE6R97xNTVhsJH7QvJunimFFEsK7L0lXE2q+kQol
	yMRnXwoEp0xLuOd9aQVQrrVru44/PkXo=
X-Gm-Gg: AeBDiestpk1tpQuEcMRiAhGzZXL3UsnOD/NQmKAn+zQID+Ah5EjBMqVuRCaRy9N4T9b
	1FUVf7cUMlKLj7ZPSBCzPLMhW7gYmklr+ALPmrwW8aT9wNF+MR2TVhDw+9Hwj4aaBvCclnB76Hf
	U0IJiwqpMqsMgZcXcxVasjoMfzD8BcS54rloQSQnaYbI/eIVrqa0mVnJppXygcPRH9FSkLrfCvE
	kFw8LNvrsl9P7PMQJuXYzWaqTZgBD/51qpQeaj02GOKW16cX4NZi0tAbnm9jbzUs+A5DzcseqlB
	1RCg6IkSWCtOboaLxY+fc/3VM+TZzVGM3eqUfiS4B33uyyy3bk1RjN7I4OrMAGDdP1gaV2qzQ/f
	DUp3YDd0=
X-Received: by 2002:a05:690c:7681:b0:79e:d0e5:4069 with SMTP id
 00721157ae682-7af7128890cmr130644267b3.26.1776132255660; Mon, 13 Apr 2026
 19:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324015539.1451660-1-kartikey406@gmail.com>
In-Reply-To: <20260324015539.1451660-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Apr 2026 07:34:04 +0530
X-Gm-Features: AQROBzBGXuCtCKG-cxZVZu7rd6hK9P4Nkojn7_9jzlW3Cgzyw5bPtdgXeOtNo58
Message-ID: <CADhLXY7bMxKXbSkZbqquq=qtLKzYcHLN5E5MPoCspUei2NWDPQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: ec168: fix slab-out-of-bounds in ec168_i2c_xfer
To: mchehab@kernel.org
Cc: harperchen1110@gmail.com, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237701-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,64485d3659c4c07111b4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9A8143F4E32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 7:25=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> The WRITE_DEMOD path in ec168_i2c_xfer() checks msg[i].len < 1
> before accessing the buffer, but then reads both buf[0] (register)
> and buf[1] (value). If userspace supplies a 1-byte I2C message,
> the read of buf[1] goes out of bounds, triggering a KASAN
> slab-out-of-bounds error.
>
> Fix by checking msg[i].len < 2 and returning -EOPNOTSUPP if the
> buffer is too short to contain both register and value bytes.
>
> Fixes: a6dcefcc08ec ("media: dvb-usb-v2: ec168: fix null-ptr-deref in ec1=
68_i2c_xfer()")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D64485d3659c4c07111b4
> Tested-by: syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v2:
>   - Fix author email case (Kartikey406 -> kartikey406)
>   - Add Cc: stable@vger.kernel.org as the Fixes tag points
>     to a commit present in the stable tree
> ---
>  drivers/media/usb/dvb-usb-v2/ec168.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb=
-usb-v2/ec168.c
> index 973b32356b17..ebfb02826b20 100644
> --- a/drivers/media/usb/dvb-usb-v2/ec168.c
> +++ b/drivers/media/usb/dvb-usb-v2/ec168.c
> @@ -135,7 +135,7 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, s=
truct i2c_msg msg[],
>                         }
>                 } else {
>                         if (msg[i].addr =3D=3D ec168_ec100_config.demod_a=
ddress) {
> -                               if (msg[i].len < 1) {
> +                               if (msg[i].len < 2) {
>                                         i =3D -EOPNOTSUPP;
>                                         break;
>                                 }
> --
> 2.43.0
>

Gentle ping on this patch. Please let me know the status of this patch.

Thanks

Deepanshu

