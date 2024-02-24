Return-Path: <stable+bounces-23555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 458798622BB
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 06:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663851C21C2B
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 05:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2AC1756B;
	Sat, 24 Feb 2024 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbDQ0hTm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE5F17586
	for <stable@vger.kernel.org>; Sat, 24 Feb 2024 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708752576; cv=none; b=NVLxbKvD4BhiWrAy3YGw/y9vdLuLV0miaCkFF6tghqPof0m0T1215bDPA+sNl8fU0qcbajLfVRzuXeAYDL3K10YlwiCEf/7lOP81k9NLqdBDpgUPWvLCPhNFqfg+MFEddKGj4XcGYNSuP0vB4PV+Jn6gupV+R+FINs97rhPGbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708752576; c=relaxed/simple;
	bh=QkXAVadBbbhC7bhRBuY+zfwSKeZe3vRCZjDqgT/q5E4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGpEa5m+2WqPizPYyS/ibXZhv9Aabucgwk4MKKsEQVjSLtt+nnfNBwYgWzFtuHr8vyZE9M+J0BgY5hYbp0RZUmGj1/TtA6bu1o8+2RSiqs7RP/OZu1begDt83ZQ80ac88f54kqfzcqbpud/UzGzM4zNYeDRdr4jVZDrxt4t7J2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbDQ0hTm; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-428405a0205so118121cf.1
        for <stable@vger.kernel.org>; Fri, 23 Feb 2024 21:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708752538; x=1709357338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4n0EEX8jNZZC2pFBMoUXcztzFChc13lSIA8SSXtQGY=;
        b=gbDQ0hTmEDJJkN4Rn+l/tjzGEcrhkJEwyJFLzHTGEbnn/tjoXYn0NKKn41X+gmpVd1
         sKe9N5sSLZcA8X2ut5zIJ6EgDf0EVmiVs9m8RqwwF4+IoLF5S/2LR3s/oWCAgd+P2dNB
         pVyq90wnZbcYu+3ge7duRBffT1EL1d9kqjlBGjJPfe9aiRkDUA8SOtKYcWkZIuOEWvYj
         60dGKhJMsBj3j12FtW6Ufyf7UVJxBQlagFngR3iKxtRf/0dttEBKQHGv4uS0/rKuGoFx
         yYrEYCtR6aLU9i2iGCHrI7ZQOz2EXkMUe1cP5VWd87VJhwLjQ+Y7g0b1I3Y6fdGkKj3W
         GC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708752538; x=1709357338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4n0EEX8jNZZC2pFBMoUXcztzFChc13lSIA8SSXtQGY=;
        b=BP4oMqJD7RIwVvD/1nnaK1r/2YfJG0SPAcoK7cAnLbaZdlPQtGFvFRIonUIR/8q0D9
         qTjWm9d1Mh2NvsbF1pr6J3ZyGagvwsaKn7p7c3TxLmDf3eLuJvzhBuT2vXr4wfZqV/k1
         TF+14zrOW5VXFlwn1OagewTNEnZWOnobaB5dIeUd5J78RIXSq9Ka1lQ3aVbOghSoxuoT
         P4fuMk8qnOobuE2tnUDsj3zbwLOJGoAQBC3WYzpSX3nHpxsjB77TQezGW+nH/tB31wOE
         JAw8y/8yBE4jyJ2150aMr7Va0NdAo/djb5GD1/+hrH0I4+m7ffQapsgaIVUQ6ZaV5w6e
         RE/g==
X-Forwarded-Encrypted: i=1; AJvYcCWOkq+dhpvglJlJkeogXh0OMKuobvtoRI86ajL8Wn04ZT9TYNYAyJ6wQ88qQTJb5NaXHwr33F6xmof9HvM1Qu6CHlmKd1hl
X-Gm-Message-State: AOJu0YzNd7J6uudPsgNOuexpnwuhJZR6hkFzp8itnkV9yQ9pBxfx0/dn
	5NByhqkLUoRSbfExKemZqiBV3COqtrbZq7RUbkSJECoW2yMWOCjdNzqtoxfvvxWD4DhnipWNQIg
	XvkcyhK0agItAQJJsDQ51Gz1ycMEHg05ch0zX
X-Google-Smtp-Source: AGHT+IGpkNG50duu4FZuxCsRIzu/MxR/r2Jlc+Yz2igEuZwxMMi6sJnFQEo2easuFJxkbpyENtnHU5eQlCmFdM642q8=
X-Received: by 2002:ac8:524c:0:b0:42e:6b39:9df0 with SMTP id
 y12-20020ac8524c000000b0042e6b399df0mr162594qtn.1.1708752537610; Fri, 23 Feb
 2024 21:28:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224052436.3552333-1-saravanak@google.com>
In-Reply-To: <20240224052436.3552333-1-saravanak@google.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 23 Feb 2024 21:28:18 -0800
Message-ID: <CAGETcx_m22xLSDz_kk9ovw5veKaij49+LdcRx0iyzEk8iEz_+A@mail.gmail.com>
Subject: Re: [PATCH] of: property: fw_devlink: Fix stupid bug in
 remote-endpoint parsing
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, kernel-team@android.com, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:24=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> Introduced a stupid bug in commit 782bfd03c3ae ("of: property: Improve
> finding the supplier of a remote-endpoint property") due to a last minute
> incorrect edit of "index !=3D0" into "!index". This patch fixes it to be
> "index > 0" to match the comment right next to it.

Greg, this needs to land in the stable branches once Rob picks it up
for the next 6.8-rc.

-Saravana

>
> Reported-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Link: https://lore.kernel.org/lkml/20240223171849.10f9901d@booty/
> Fixes: 782bfd03c3ae ("of: property: Improve finding the supplier of a rem=
ote-endpoint property")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Using Link: instead of Closes: because Luca reported two separate issues.
>
> Sorry about introducing a stupid bug in an -rcX Rob.
>
> -Saravana
>
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index b71267c6667c..fa8cd33be131 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1304,7 +1304,7 @@ static struct device_node *parse_remote_endpoint(st=
ruct device_node *np,
>                                                  int index)
>  {
>         /* Return NULL for index > 0 to signify end of remote-endpoints. =
*/
> -       if (!index || strcmp(prop_name, "remote-endpoint"))
> +       if (index > 0 || strcmp(prop_name, "remote-endpoint"))
>                 return NULL;
>
>         return of_graph_get_remote_port_parent(np);
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

