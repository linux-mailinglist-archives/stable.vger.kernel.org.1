Return-Path: <stable+bounces-230937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBBECxcvyWm9vgUAu9opvQ
	(envelope-from <stable+bounces-230937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:54:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE4F3524FE
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CD33009CDC
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E239C379988;
	Sun, 29 Mar 2026 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHikV4bU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAD378D8C
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774792420; cv=pass; b=SPEI0MR6EDWHsnBeU8rPx9D+75acPF5WVLtMkVVrZyhOw/1Ld52MWgSZJp2TxHBQkJ0EekVOdEaT/d72qaE19LBhQ2gCcZCf5WDzsASorRtG85AYppW0OCmQIQwSgzwh8IYvW/MwyEoc+SDExSK0ElQYKVQFch2ymAPDzomebf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774792420; c=relaxed/simple;
	bh=ultkQriYT2Vk5PsqfDg1lhiyQN3IB5SOcSKN2cmMdHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuEXNgIQnybXi66wsSiPLoCkaKxOBw9eztlh/glvQZ4QvkVOtTWpa1+sFq42nqp+K80xBGdfbITqMTfJDyRPhfMIAQkI5qMUzqijwmcEJDrx5aGV3TgzdPKcB+4Av+hGOXHrF+uPBf9gUh5tgmZDhR+WxLqcjfDwIBQY2aITP0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHikV4bU; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66a4c6bb6ecso6395011a12.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 06:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774792418; cv=none;
        d=google.com; s=arc-20240605;
        b=OsS/HDU9gNPsoxVth2YZMpeY02H2aaFVAKvOxE5guphSUAqQUgWUHxF35THwSWlIoR
         /Sicikmtinqd4v5C8tgJJSTbqCTT2db+ktTKs6ycI5WY4khV7CL6cN0mPy5AiOlZHBT5
         4UnWNbeZIpgErFQKDtgxzpH63T80/CkAf1uoFujRZoCqTYzOK1YqautORLJSwDuBYLXR
         YZfjqeupiArUiLV/SbyCWfJAJB/P/kYU5S1g/nPHg3n14lnaZJBIakZLtyQ0tDy6qn9i
         2g27VORdSZe4rMlDNve9AsjsWvPZUwV7rFrnRWReSYWpxZRrxsser7iOqFb8uThY7NaR
         a7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e9NPpYh2vIz2hCIooGcCLPshzGEqsQsQRk7VDx7gvEU=;
        fh=hrV0ajdgPFh1ZZgfEp0fXQqfZ/biVdDagJ066s98SYI=;
        b=EtUTeEGexG8sYZgzVUEDys1kI9uD1MtUDps6N1UoGECDEkxlZsu3s46iSKQcLjr06s
         P0a0i5cV0rLNsY+baOiUdupTsu+7jBTw9ARETUSSeO0C2zG8FcAHp18JiPqUuLbqtes3
         kS20JDfGDyEDBfs8uqK6AdYpDLD0hX4ZRzyAlbwewsHqpF15tyI9ahvq3Cf0yyQmRl/7
         8owH/uTA3BrbwnQYwMi51rlefL/KXI/hsIkdOxCVHPWr+bv4/bdTy15y+9qyB+FBIxpM
         P/aue5LAokFPI/pjVSjFNm9a3+IlxeKvg7V+ySGrh/gvqOR7oeCh9RrPqM5Q6NVTBmjX
         9zMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774792418; x=1775397218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9NPpYh2vIz2hCIooGcCLPshzGEqsQsQRk7VDx7gvEU=;
        b=sHikV4bUAm+0M55BiASTxsQImObpKt28qGXp+/lfAQJiC5zJiY1te9cyzV1LXwTo48
         Ckkqty0eCvhvz4Fus9A17c9ZwUpdxP+LdKamO0sHJKgG2wLE7avqRWb8qG6N3JZ13Nck
         OZezWsWBQxIx2RxwKTyKJJLPiycrcSjtQuPZhB1JCgb/QmL3/JEfrpI9O2P5v30thBGO
         BM9VYyihzgsypgPA3z71d/vf/K4sEcqqXR9q3LREa7xdrKgvkMqRz2D8ah751PVUx2Gq
         n6GTWrTAl2GQ3TJ1VsY3euqqs5nvdYGleW+xDW5C5S1TbIUAA2o+oC1U+YVhCpBW7ym8
         FsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774792418; x=1775397218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e9NPpYh2vIz2hCIooGcCLPshzGEqsQsQRk7VDx7gvEU=;
        b=HRX/ZR11sL5aHU3SJGSEWCxhcM3wEsBuCtTYBgNewyZYwkzA/ild42xDLuaktPL09q
         fNiUNMMfZCEal1BE72UEq9bQxAlLhz3lTtm15Bw/qUmScn6CPzC81Hnroyq5MHWQoZQg
         22WdCwsHOYVGfgjR1KH4SX3wqVZRZkySlkAeP8ek4/0CmQt2P4Y1SvowVHDTpi7XxASn
         w5NbkrNUafl+eAdJy1SKEOSPhOioC/FFC+03LuENp/7jZcEebh5oO1kB7AC15UM5y6+f
         wSUG6wUzehJrIl/uYybwpf7O9+h4e7z5i9wrkzXP2ieXs4lW9afso4f3BnIPr1l3McfH
         r8jg==
X-Forwarded-Encrypted: i=1; AJvYcCVYF2lvHJ2uoGN7nsrJ+JwfDi415W6aWtW7bi45L57zYjKKBmQwV7nZ2mr2hdH9LXk8x1kvAtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3YT3MG0uFxvlk72LOhETB51aYIkqeDMgH8W0cieuXoJsMAYa
	hgIwsxhztcoAvfv/my/crXsCBRldhfL1120mqhitRyKwg+/Y4GCxsGMEL52GWhLs1r/9oTaZlSi
	G4fpfUTZ8GyQF4OVgY7+V5cH97tVFyfI=
X-Gm-Gg: ATEYQzx9OhpXIhfc4S5gChIEbBbHJSOBk3PCGD/S7MeTmuNAfrz2wS3y+ZZ1hgobw3N
	DDXiFMasVUbLQkGn8zJ7Vr0ZaAfhS6gt3BlrNJI55ZY45D3mmde3q1Ta1CzCXDI77mVlgS08up+
	soT6OMDRL5LxJLA1AQuDzYURZ2xEDasIVTawAnm82gqwn4E8mtEyCDvqkxP8kkmFJi4cyQt7/5m
	IrX6lRa1suPrnqSEIWC5xy2Qyfq5PixJAzVTJVL/g5An2Nhj81imi7lCtOKz7pwNmm745esKzMm
	SeRj4WV1
X-Received: by 2002:a05:6402:380b:b0:668:6e22:3e10 with SMTP id
 4fb4d7f45d1cf-66b27936177mr5060746a12.0.1774792417605; Sun, 29 Mar 2026
 06:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329125437.517980-1-sebasjosue84@gmail.com>
 <2026032939-salt-cod-3bc2@gregkh> <CAJD=UNf9Ax4oZ9YTj8rr3jDWaGsXr4bX8uh2A-EE+w49QwSUaQ@mail.gmail.com>
 <2026032911-unison-dehydrate-9c62@gregkh>
In-Reply-To: <2026032911-unison-dehydrate-9c62@gregkh>
From: =?UTF-8?Q?Sebasti=C3=A1n_Alba?= <sebasjosue84@gmail.com>
Date: Sun, 29 Mar 2026 07:53:25 -0600
X-Gm-Features: AQROBzA0tKwIfV0ThA1biQtRGPrgzfZejf9ZBQg9a46gemDh6YmXVr62-PZwW7Y
Message-ID: <CAJD=UNfp2RXE7B_N0a_ux32tP2iArVdosm=Zd=uhMtsd3qqv9g@mail.gmail.com>
Subject: Re: [SECURITY] usbip: vhci: heap buffer overflow via crafted
 number_of_packets in RET_SUBMIT
To: Greg KH <gregkh@linuxfoundation.org>
Cc: security@kernel.org, shuah@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230937-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 7BE4F3524FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It was presented at Black Hat Asia 2017 by Ignat Korchagin with a full
writeup explaining the pattern. When you audit USB/IP for similar
issues, CVE-2016-3955 is the obvious starting point because the
writeup literally walks through vhci_recv_ret_submit and
usbip_recv_xbuff step by step. From there, checking if the same
pattern exists in usbip_recv_iso and usbip_pad_iso is the natural next
step. I imagine the others followed the same trail...

El dom, 29 mar 2026 a las 7:51, Greg KH (<gregkh@linuxfoundation.org>) escr=
ibi=C3=B3:
>
> On Sun, Mar 29, 2026 at 07:34:22AM -0600, Sebasti=C3=A1n Alba wrote:
> > Hi Greg, You're right...I see the patches from Kelvin and Nathan on
> > linux-usb now. I should have checked lore before sending. No AI
> > prompt, just manual auditing starting from CVE-2016-3955, but clearly
> > others had the same idea this week.  Sorry for the noise, and thanks
> > for pointing me in the right direction. I'll check linux-usb first
> > next time.
>
> Curious as to _why_ 3 different people all independantly decided to look
> at CVE-2016-3955, a 10 year old CVE entry, and decide this week to poke
> at this on their own and come up with almost the same exact issues.
>
> What made that specific CVE stand out in the see of tens of thousands of
> other kernel CVEs out there?
>
> thanks,
>
> greg k-h



--=20
Sebasti=C3=A1n Alba

