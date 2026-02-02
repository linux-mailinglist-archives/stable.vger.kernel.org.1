Return-Path: <stable+bounces-213050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AILGDP99gGnE8wIAu9opvQ
	(envelope-from <stable+bounces-213050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:35:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A57CB0C5
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFB13301C5A7
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 10:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B98359705;
	Mon,  2 Feb 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+LKrT9E"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F7F3557FA
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 10:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028126; cv=pass; b=qDWAxSVbK22LuXKervbVBU0We00CcGpRURXtIJndvlsEaxqcHRX1ODiKZpmrIcxbzdiY8in+O90Vy/Mx9Cd9OtsHTftzra7k5wJfQn7O2UWeSotn6AQXCFdZHdpUXR0XInUeDb4n8XaeBfDo3GfQ7kJEZ/3MPl6hwcFBx9FPMIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028126; c=relaxed/simple;
	bh=nBdkcEQfMyCOW6kSj/WYXUCLYThl2kQXvWn51vv6mrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMsJxq0RL130ND+jJ0A6/zSzjZXVAilmPePkly9Hb0XdjrJH9dhZ9KtmRJ9Va6005MS0FNp28g1lm3EeUjkQ/cfG2e2u1L9Z3rfYx8At/XUEnIi1sN6Aa60VEDNk6bIjt9Ae8wnjPaSsHxbi/LgvaXgx4J5ylE5pI6fOPwTZoVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+LKrT9E; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so1718916a12.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 02:28:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770028124; cv=none;
        d=google.com; s=arc-20240605;
        b=QXY9gNl/FwBnuV4fp87Ogce2FJR914tHuB+7A5tQ8NVt29vrBjyZuopW0w6CRrTVgZ
         PQx0/e30+yxJBghvsu1L/JaMvKlh/K2MJKl3iwHClT2WMCyTPKTeEMSIpcl7iYweB1mY
         TYXp0X8cVSeYNpJ8xXrMzagLioNo2ekYl4zRPCPYWngdOHGt0mGhJIijfpOPRLnjDUgW
         WzJRLMLSeomxuihebUsHNfwA/yOyKFBudj2RIv7Tl2OU/Fuixh9ryJRHPVHQ3fkgrvld
         Y3ZLV46YxeBHtlCyQxDatDKuduDJvdDJyO2yc1+DLGKktNxlFKG4IfkpzA7up2TXJHxm
         STeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFOpNv5aGURhK7guif4BLW5/Z1g5jtAibOsBQwSYIj8=;
        fh=LPeStGzDovWWEJ5hoVuYUO5gJgTIJ1Rcf3izgbAZUa0=;
        b=JAvHoEwJvrb+jUSIYgbp84ikdZeQJUvBFU9kzHVHrnVNGQS4KNHFUVxz4xkQJHAzCI
         3o0rPNvrWbEKlM8sFQ2y98LI0qSsLi07AaILWihdK9LyidPTLJGEGyLrFT7IoleC2+jU
         v7a3sP042J9hT2tio4Ea3w+8SrEUGB9SctrC6LzARj1VGTT6JgRt6Oo7rYMYX3k0DOBz
         uiQSAEFqbKd4/XFUzNXdRQDt0A1y205S/Tftdc+eWvInDeS0fnK/XrixT/KzQbrCWxon
         15q1kbDO2AMWaP77FUaVsfxJpEIf4WWzY1NjvFc2Inb07VizCzjT4DncUQHc/lvpvvua
         FhPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770028124; x=1770632924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFOpNv5aGURhK7guif4BLW5/Z1g5jtAibOsBQwSYIj8=;
        b=d+LKrT9EE1qokG6CVypFD344h5EUkqPNcPC2lBT2HDGk+sbhTSm6I8oGMos+kVvuwm
         6jy4v+usK3ZXmCICXKYiHoKgRQoFR8iZbYyZbS9ARsCZ1sMrH7+cDyx+kolKJWMRKKDu
         9ZIYL0SaJXH4FeqI4e13x6izOuQ2pbz1UPzxAPZ3z/nSXhkqtLrzOkO4zf6zBZQ4c2tO
         Vsoa8JY6pCz/p3kIKAu2sq4mRbxphQmrU/Sf9IUeSqwvbrwzdsUWh8km1HXUszTPG5ND
         MbRQJP1Waqg9JdDiVjzrKnM1zNaYM4jWln8oosBzKFDcaslMD6MhpoYILTftjaDDDrFJ
         MM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770028124; x=1770632924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MFOpNv5aGURhK7guif4BLW5/Z1g5jtAibOsBQwSYIj8=;
        b=llK+P0SaaObA6vab4xaQbuXI2TMJKQSEdnPDMvQLyuDqqIlMlNISMk1uNTzJBJ4S3G
         eIuplvGCp0kI1meJPbd8f6AilF88CW/D+skj+dhQIJWh4DWX22BLHlnGNM5R03p2cSPK
         D1tEb1MuN2C6a//dIUA4h6qFP5TxU8kqOjKXMyEes1EbTK3lFNihBl1DakcjSTlw3A+a
         t+iZnIvQn1lDoE6DzEUhDT8X2OQvKieKhEOSeFHGoWsGU/Wg1UrrPDy59zQyGk8IC8NT
         ltrlSM3/tHF4LoSf2DoAKYrQ+yLa8mSdwlRJx35z0z1Sp3dmZZRaMuKEMYdq74p6YK+x
         dafw==
X-Forwarded-Encrypted: i=1; AJvYcCWEAy1DakvWH4ADDwolVY8im+eB8RtRKvAqvaz7Mr6/iZSCKlgtQ+GzaI56QWC+vPV476iznA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzex5XHc+JFMhHDF7Fb06nH4VnnB8Dc5ER57d0eB8P5d/rNWl0M
	UxDnOrfAzKj7GutYco2Ff4cTOmxomJ+z/rELAhlsv0HDKa2tLkHWRkNREAycOLyP2lIsFQQ4nrg
	aTsKJ1u1RYrkAW+ARRaeG6Nwv+R9LK0U=
X-Gm-Gg: AZuq6aIjnVk6+itw3qDvGj6G+MriGeFeNwnQohrLzBn4PcFCd8SeV1iSAedCtxrqBgU
	YLPBcrg9wmon09kez8ILIUCh66v92R0T/GM64xHe2nWeuaq86HTgHbyiBm7saVx9kgcJMgIaT1v
	bN13LcyvC+zFVRZ0wTwv5escv682xkQCM9cwLhoT1uOs6wXJ2csgR3lvJinsFZUt6d/KqtHHeBQ
	VParLuEzIIZunycE73WHRxHjH6f28rL9RwPr2r0lAuI7dj1tDtIzWla5sO74FnxAWRp6osNmwCc
	yJz/7X94
X-Received: by 2002:a17:90b:3f85:b0:341:8b2b:43c with SMTP id
 98e67ed59e1d1-3543b3d65e2mr11169058a91.18.1770028124249; Mon, 02 Feb 2026
 02:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119082553.195181-1-aha310510@gmail.com> <CAAQKjZMHSQrowPWnWaO88Wynub00YjGLPnSNCg4n4CyNwgYtTQ@mail.gmail.com>
In-Reply-To: <CAAQKjZMHSQrowPWnWaO88Wynub00YjGLPnSNCg4n4CyNwgYtTQ@mail.gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 2 Feb 2026 19:28:33 +0900
X-Gm-Features: AZwV_Qg17xGCvCzPBxDLKPqusD21IoQMfG9fEwI1GEiMPhdbVzUTaXzYVLC5Kk0
Message-ID: <CAO9qdTHodCQ=SnnSASSNnNiTyjxb6r2yfVMuTvdT8+LRLtf4Hg@mail.gmail.com>
Subject: Re: [PATCH 0/3 RESEND] drm/exynos: vidi: fix various memory
 corruption bugs
To: Inki Dae <daeinki@gmail.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	DRI mailing list <dri-devel@lists.freedesktop.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213050-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[samsung.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 84A57CB0C5
X-Rspamd-Action: no action

Hello Inki,

Inki Dae <daeinki@gmail.com> wrote:
>
> Hello Mr Park,
>
> I'm sorry for being late. I forgot to review the patch you had posted bef=
ore. I will proceed with the review soon.
>
> Thanks,
> Inki Dae
>

Sorry I checked my email again and realized I forgot to add the Fixes tag.
I'll write a v2 patch and send it to you right away.

Regards,
Jeongjun Park

>
> 2026=EB=85=84 1=EC=9B=94 19=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 5:26,=
 Jeongjun Park <aha310510@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>
>> This is a series of patches that address several memory bugs that occur
>> in the Exynos Virtual Display driver.
>>
>> Jeongjun Park (3):
>>   drm/exynos: vidi: use priv->vidi_dev for ctx lookup in vidi_connection=
_ioctl()
>>   drm/exynos: vidi: fix to avoid directly dereferencing user pointer
>>   drm/exynos: vidi: use ctx->lock to protect struct vidi_context member =
variables related to memory alloc/free
>>
>>  drivers/gpu/drm/exynos/exynos_drm_drv.h  |  1 +
>>  drivers/gpu/drm/exynos/exynos_drm_vidi.c | 74 +++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++-----------
>>  2 files changed, 64 insertions(+), 11 deletions(-)
>>

