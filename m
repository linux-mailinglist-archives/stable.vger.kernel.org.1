Return-Path: <stable+bounces-89712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018FA9BB8E4
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F3C1C214C1
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528601BD03B;
	Mon,  4 Nov 2024 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="BXm9QvaP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F841C07D2
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733851; cv=none; b=SAi/RpCUvta8NUQreEXCUv+KynoKCEPyaOuj3uB52IOa8HNsbdQzWoetRyxlh2ZKLnjKZVQpriosAolfT1pqQZBCjHJ898V4xwginpp/L9IUP4hHc+nEArpoiLnD8K14CLrKPgHhY/s7NrnAwYf/6Iiv7pQ9LlFf2DStKHVPMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733851; c=relaxed/simple;
	bh=FGjsdtKZRiKzGcQMKDBWmkyBiNaLzNOZwOxzLvGoY+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sh7movBy+iwt2N92ChUUt5pe4P6/CceQwn+NAldmQPFjh6hP5csaRL3oIfK7ns+TVJgYCdjC0DN0H9foOGu+r4zzj46/WBtNI+8YtrxU3mT/tv8j0Oi6ddKDWGtr5Wd5OcDaYRxc5eTQNfHiVrpcwOq2AYqtd9L4d011c2V5q90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=BXm9QvaP; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288a90e4190so1966852fac.0
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 07:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1730733848; x=1731338648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGjsdtKZRiKzGcQMKDBWmkyBiNaLzNOZwOxzLvGoY+Y=;
        b=BXm9QvaPUubSj1SgvdrjO66kz2rHQZeG0Yw17eoeUnMi4gu/5Sjl0sM6nb2AyDFJN6
         jY1pwBHyaLPRobapOXTo/jbI0F1jGNGvGKAMexEhyMXAsZsNjkSGV2wsFNBVVRpJniTV
         sNmIGTtSRxi5BqUNTPbIQ/9BHsnz22ryuo800=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733848; x=1731338648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGjsdtKZRiKzGcQMKDBWmkyBiNaLzNOZwOxzLvGoY+Y=;
        b=fvb/aEkj0aV2dxQ8XLHnT1ndVAgPGWJrr5dYEC58AbbGSPol9c4RBmM0gcVLMOa7dH
         hiio0wZ2zaS57cEqCGN88soxTG/iCvU6U6KaIe+8EZX0M6cweyTlhtSGiGGJbdK9iU0m
         72ycsVjX3zsTOW9Uxby+efopzNPeCNDsVcjbiw/jpFObx+DdLB7oQK43Szdi1cIIIko2
         5lG1YOiiq5vYwLBxevxXtXwzNQ65zRNRs1m6Fmoh0Z9lHZ3skqApOXqwrsZ7WK1RG+mw
         oM5qpjwSxNJGiPEFatb4RO6gNQA0Rg+Z0Eb96cpMs/Nsmbzwi8Og5x3HZRAbxHDj5Wh6
         3SGQ==
X-Gm-Message-State: AOJu0YzGy5DY7fKMbyW3ryzvJDa71Xb6jPsWTF76kXfNaGekSJsFjOeN
	MaKSDJI2OB+fHCxwqy3ktlNh2OD9X/BUh8uS+XbUptdOgRTiPiIzb2+nMR1YYp9GRKW9B8f1oYc
	X6dSCn7sFSSEd+1HpiKYerQquOMRMAmjBg2EB9qI7TV75Olng
X-Google-Smtp-Source: AGHT+IGNH3AKPvkeX/hEwTgwDYCtHcW3BoZONA574d06JiVHH6SicQ2TpDJ3Hz5GNHjuu+1ltOonleNU6Icy8QQ6l6k=
X-Received: by 2002:a05:6870:b681:b0:288:39e7:b54 with SMTP id
 586e51a60fabf-2949edfedcbmr9977246fac.22.1730733848197; Mon, 04 Nov 2024
 07:24:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH+zgeH2Cjk3pjgrmZYN45VNa_9v8MA52QRjwdaS9hrKnaJUzw@mail.gmail.com>
 <2024110444-napped-atonable-371b@gregkh>
In-Reply-To: <2024110444-napped-atonable-371b@gregkh>
From: Hardik Gohil <hgohil@mvista.com>
Date: Mon, 4 Nov 2024 20:53:57 +0530
Message-ID: <CAH+zgeECVc0soxeGAJq_SJb5e4vYLeDDS2gHi7ujJbOFGusYyA@mail.gmail.com>
Subject: Re: net: dpaa: Pad packets to ETH_ZLEN
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg when can we expect the v5.4.y release


On Mon, Nov 4, 2024 at 5:24=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Nov 04, 2024 at 05:15:57PM +0530, Hardik Gohil wrote:
> > Request to add the upstream patch to v5.4 kernel.
> >
> > Upstream commit cbd7ec083413c6a2e0c326d49e24ec7d12c7a9e0
> >
>
> Already queued up for the next release.

