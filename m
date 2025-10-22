Return-Path: <stable+bounces-189031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF0BFDF17
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 20:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4633E18808DF
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4E34D4EA;
	Wed, 22 Oct 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKJju6wp"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA72DC770
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 18:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159376; cv=none; b=OwaOyD14+gzidskVUf7tBLoxZAIEhh6bzHo1gdJJvSIJuDesM6zi/qI9y43OFjJgVUtsWK2fcjlCdZzx3gs0Al7ya56me89WDbEoyjcZLzWD7ROgmn6Z+sMHG/hDvH7WeqwfTFR4Hrvs7LW0Kqwfi6gYQlWxtH4cEIfw8W3Ove4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159376; c=relaxed/simple;
	bh=8+jnRCt38ZENX1NztlGe9YStpU+b5/SB937qYnXD5N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZQBQRPOtb4lqt9E5mDv1HjmBcTylGHJDyskMI614cP2DhPxMZ9DhF+iD+J4p1zp+HMuM/VREwnVfPFMywwYii1LkXBNM/AkzpdbEsy1cHX3xO6e9npRo+eUAU4MSQjZVDDfSPhdbE7VxYt+EHnLqm8dZEn2WNEFwrbc+Rr99iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKJju6wp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-591ebf841ddso2782288e87.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761159371; x=1761764171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycqI0zLskmdJ9GL89kNkCWpDO4WHedc5HuGOuYMuhxQ=;
        b=eKJju6wp6Wg5cBMiybojfICJccR8arciFSlkQk3UArlyhVEuswDS2cmV3szYWoTMJL
         dggIicN+PVmlo+5OPSMW6DEPUu8ooHGybA/ECWKic8nSoU50W702xQU3yUEfb2Sk75vr
         zwbP16V77aZ3cuXrq4QBO8/tJloGqAIebs0Ct+4YE32IcpQfB1/QYeI3FvmnbdG9TvbL
         RwyaJd2qTMjHi1QWevOOXJ3D8Z4MfNPZ/sMVl7LNdqIp3k9c3tFvl5r6LtBjbt3bZTxm
         BdF71oMCNmMxLkCSTxsMwMrtDxR3FCAmuIIwn6qgLa+/srZBPq+WoYo7+ndnkN9BUFR7
         ezig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761159371; x=1761764171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycqI0zLskmdJ9GL89kNkCWpDO4WHedc5HuGOuYMuhxQ=;
        b=K8MMkl+SeRJNckrAcypAw0vmg4ebqWj2mn8mxrnmO9iAVmIvfW0uKOpWIhxENhVU8P
         Niu/PA9knDa8Gmd307xAJR8mAN6k2JWUMwxwQvKY5ZLqC2MatmLlvn5wyIpqbkjlKwho
         Na/0M7nRFSgK7xjTqMrs+Lq/1X+0eBD21HZdn457G9kphVI1BJ9G2TQ/TMmM4gbtkefQ
         NxMV7QiuBr8aroaqp+fdj9ZjJSX9xN6B9MmNF8NoN72p1El9cevsFpXnTm3All2Pqo63
         6oDxrUJHEdwqcK9OuR1O207KrYEBvxFA49wbw0yYk8Hgxah1lYw/m4zMoZR/aCDIJ9Z5
         mxTQ==
X-Gm-Message-State: AOJu0YzbnXTPuubrNPPBk7QL+kTDTVCIMKszSOppSrIgggmqyChAf52L
	ZNcmM6Tx0b0xBpDNaX4VCJNnoWgBJ5WDkv4pN6tY3FfeW25y7Q42GXie7s6YcoVQ/scbTPozkB4
	nSTlRTW30L37bzoB372puF5kWfZfte3Y=
X-Gm-Gg: ASbGnctCgtEBXFDQYzIlyEhAE47vuXmAfD3XTuwTtFpmYDwn0KjD4w1oG6we8HbXpqB
	4YECoGjF9MwYUVgLHGUXe9tjJvtcvatiMNXLvu5123qdf1HJFWAITRhipwCU6wcx1f9f1Ckasbb
	SXQgUnC6JooiuaOYG5PsTss7lX2IlllwqKeJyIV1mYOTkYtIKNQMpREYaP5G0gzpX4uXXNmbJTs
	6hRWOfVfoCJsRyvDmXu8TYb96LCJ1K7WaKngZVfZ0CsJwbWdxTWaHO9/Ci8/FdstzlUbqNNW/t2
	hJXLiNe4ov9DTa6TIs5nMeYEgKTJ
X-Google-Smtp-Source: AGHT+IEQK4lS7wTENTmg3d/K2RTVRvkWxz0OmjhCi4GxGNpOceINpP7P2RhDCCW2CVuqatkVa43OfxUQhgfzhP73I+4=
X-Received: by 2002:a05:6512:3ca9:b0:578:75b3:4326 with SMTP id
 2adb3069b0e04-591d85898camr6905309e87.29.1761159371180; Wed, 22 Oct 2025
 11:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022060141.370358070@linuxfoundation.org>
In-Reply-To: <20251022060141.370358070@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 23 Oct 2025 00:25:58 +0530
X-Gm-Features: AWmQ_bkxIq78J8bGR4Bl7M0BIY16lHxaS-yeq4_ZNjZukPpJrSPGuGvQ-EnMbjg
Message-ID: <CAC-m1rra_aXm8aV9rwQjPKBf9gGDHeqe0E5MqpWHd1BuxgUgeQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/135] 6.12.55-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Greg,


On Wed, Oct 22, 2025 at 1:49=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 06:01:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.55-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and boot tested 6.12.55-rc2 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.12.55-rc2
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: bd9af5ba302635dcb1e470488c0fdf70be8d45cf

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

