Return-Path: <stable+bounces-26911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF087302F
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 09:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82151C22ACF
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D05D72F;
	Wed,  6 Mar 2024 08:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7rujQUV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180A5CDC2
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712241; cv=none; b=cfuBAtS33BPaDNNFyxJwCK9Lk32INy7knKHY8toEP+J5t6OQEyiSWqwjko8ouBY5tOIOim7XqhaeQnbSZbtyqKi2V0MO8Z7oa7+sEM21qbcp5CdDxVm2sE3gcABvofiQXfldXM43qvpQg94Mmih7dUVxh/mOJcpYEurZCZTS3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712241; c=relaxed/simple;
	bh=jodEnASZyLUgeoSk8Z4M/Y1uTQ6Xpxy5XIGxKW5nvb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UbuJ7l1qNYKX1XOJDeSPVYwzDDC20PnPDMyIRuoxW6VpbWlqyzueJp+Lu84s3Mu7/Bv70cP0zqGvoN/r1btO3uvHXgnQv9VAzEBYDE/KX4AVWaRb05JeOe6GTuXXaOhdosbqu6JW8AIXSK1LoCrBRDywKp4pjT6kRJ0jmUKAtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7rujQUV; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc742543119so6623654276.0
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 00:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709712237; x=1710317037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNCmhehLL35vXsU0wn+FY52cOQ04rVxtOxTd7hBwrYk=;
        b=E7rujQUVYeoWx/m8hA9hkx0GDzR3BTMLukF0Jetc4sxIjRUFr6uPVE06y91p4nHvTy
         MqWqVXe+IUth9hJkCY1x1pYmXZIWtHH+74c7y3vhSnPaSMqS+7lYUmWF4rkd/P6wgQ6b
         xTFexi7tpMcBqZpQyzn4p8ALXP/NWcpiXE9smPbzk7id/o2A97ZJv7jUjowBmxlhaJTr
         dAU0nDl4js4tgC2r3suA3rxW8+M+HhRzj+Sp4sPEPegi1yk8IqlUyF4IxWnfcm/MKK2H
         t4fOQegPJPTLNJ+E8EUUj2utc00LiRk0R6YtP6FIY0rY50QcsVy0s8VIo20hvpPPXtcI
         Xdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709712237; x=1710317037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNCmhehLL35vXsU0wn+FY52cOQ04rVxtOxTd7hBwrYk=;
        b=UmkVL926h+ORfzyZVvQC35a5z4KnGhVaphznWxUrs8fp2xmhd64srxI5QiTcUWNeCQ
         wFxW0T87sfzskEHb5NgvCTyeffkKHingN3mUU0ojynsW5i4LlCKPuo9Fgxcbu1ECjYGD
         3gp1xLkHTDsSLeEXgJPv4gquk0VVBWPTChEV1j+ZKEJBYx+bn0NQbpsI6+CwXhOo8pGJ
         osSnsWgwpiURjKQepehQ2jmehLQoTFCNRCCHhabCsTpTaHHE/YCJRKGPqZe59rKqKxDr
         6VsEGMiEebyLJQCz65kdmfOptETTJ8Qf0d94zfTIbQVLWPj0BXXP3i41EkNqp7PMnE0K
         8SSg==
X-Forwarded-Encrypted: i=1; AJvYcCW6Z94Lak1Y4JzxhQNA2m3ojN8RKG2xAtajuhTuuEXBV7lFQxGKTxyBHcrH2Xelt2qz8DH3sPaolULMOagpShqMwnD3xN4n
X-Gm-Message-State: AOJu0Yyycn75Xpno8goSjFarHl/OUcMHRKQ0uaa85crYAeec6mDNmD/O
	kXm6YXCdLZuMl1iuZJKtLD81oe4C5tWjLsHq+Km0zIH7rckLMYApNqoxnEDanf5fbz0jD0BWVYK
	IB+qObdaMU1N8ZWxvIGRjMJljKo5hCmUqPcRXnQ==
X-Google-Smtp-Source: AGHT+IFiiALvEe20+2jMao6XZwL3rpAKDRZLIqrCiLCGFKth5eRWTowg8OI5xSsdhVEX4ZwNnmupsmHGl44khhJoAAI=
X-Received: by 2002:a25:aa8b:0:b0:dcf:b5b7:c72 with SMTP id
 t11-20020a25aa8b000000b00dcfb5b70c72mr11184681ybi.0.1709712236941; Wed, 06
 Mar 2024 00:03:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
In-Reply-To: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 09:03:45 +0100
Message-ID: <CACRpkda4pVotd9Fc2Qn0Ae=89sZR7-rXDiZ7OdHE3eDvO=049Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jorge Ramirez-Ortiz <jorge@foundries.io>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 2:45=E2=80=AFAM Dominique Martinet
<asmadeus@codewreck.org> wrote:

> From: Dominique Martinet <dominique.martinet@atmark-techno.com>
>
> Commit e7794c14fd73 ("mmc: rpmb: fixes pause retune on all RPMB
> partitions.") added a mask check for 'part_type', but the mask used was
> wrong leading to the code intended for rpmb also being executed for GP3.
>
> On some MMCs (but not all) this would make gp3 partition inaccessible:
> armadillo:~# head -c 1 < /dev/mmcblk2gp3
> head: standard input: I/O error
> armadillo:~# dmesg -c
> [  422.976583] mmc2: running CQE recovery
> [  423.058182] mmc2: running CQE recovery
> [  423.137607] mmc2: running CQE recovery
> [  423.137802] blk_update_request: I/O error, dev mmcblk2gp3, sector 0 op=
 0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
> [  423.237125] mmc2: running CQE recovery
> [  423.318206] mmc2: running CQE recovery
> [  423.397680] mmc2: running CQE recovery
> [  423.397837] blk_update_request: I/O error, dev mmcblk2gp3, sector 0 op=
 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [  423.408287] Buffer I/O error on dev mmcblk2gp3, logical block 0, async=
 page read
>
> the part_type values of interest here are defined as follow:
> main  0
> boot0 1
> boot1 2
> rpmb  3
> gp0   4
> gp1   5
> gp2   6
> gp3   7
>
> so mask with EXT_CSD_PART_CONFIG_ACC_MASK (7) to correctly identify rpmb
>
> Fixes: e7794c14fd73 ("mmc: rpmb: fixes pause retune on all RPMB partition=
s.")
> Cc: stable@vger.kernel.org
> Cc: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

The patch:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> A couple of notes:
> - this doesn't fail on all eMMCs, I can still access gp3 on some models
>   but it seems to fail reliably with micron's "G1M15L"
> - I've encountered this on the 5.10 backport (in 5.10.208), so that'll
>   need to be backported everywhere the fix was taken...

Which device is this?

I have never seen an eMMC using the GP:s in my life.

Or did you create the GP manually?

Yours,
Linus Walleij

