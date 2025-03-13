Return-Path: <stable+bounces-124202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DDDA5E90E
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 01:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45E61893C2B
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 00:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855666AAD;
	Thu, 13 Mar 2025 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="It5epQqq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AFAC2D1
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 00:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741826822; cv=none; b=hGGJdxWGsjELbeZECNfVHbFemfWWJcsA9W92nvdSUDBHC94/dSMWjgMmfN29P842qMw4Xj7XoHjR8s58zrOBtX+Iba/sFFjL8cT/BM7QKuZleBujza2rmpYDeWy6hzEd1V3I4PqBAOYczr9Ob4qkAGrFh4tyS2SCgiYhxqlIqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741826822; c=relaxed/simple;
	bh=WPU72+Y1ga+DiactL+y7ZYRgAAU6hBeWyVS/OFb7HI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUxHcRRfy9nbYyY2b+GSXPCr2iGx/LB2BqzD4P5Js7uwBgcRFlInIklMyVNcGO1BUumXrWAtMhbmWCiMl9tvTh1qpJoaBLwFoDX3nVlddEuZ8VeHTpkvWPvRLVo7u0t7OvMBo0rPKQ5z1qAXrhL4SDsTEaU8rz86ysRDiVD6D+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=It5epQqq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30762598511so4741511fa.0
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741826818; x=1742431618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wOPhYxd+v4ASdWl9NlF7B1oiomg9NbTmCV332MQzSY=;
        b=It5epQqqJkJSajDxGWygGe2IEhPSrHbi7rsDVOJQ/vJmaxFHUG8v5nWGEyybQXZSMA
         VbMt/4/4qE568rSK8sLtuyVpo9Q71EzW1idLubvwboY3YehJk4G27cHTzIqPG/6z507O
         ito3V/ghj/9fNMDsLPqzg/xmSXek2TSazRsOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741826818; x=1742431618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wOPhYxd+v4ASdWl9NlF7B1oiomg9NbTmCV332MQzSY=;
        b=HZrDdcxvtFWs0dxNLpCCJW44C5lWuuQuTRk7Kd+Nj9hrlhWbHYEp3NsZH+4g0nxpSV
         3DEYlMdDd1O31bJ5EnbQxBWLppZE1wjIahBUh3jAQTJIB+Y/S1/Tinm874HLNByfSwqg
         cUIzAUEU+AB7LIeo6St34pIvJJQGRhg4EzEkYFrEs17fM2kjQ/hi4DbtPNOWnW21iUo4
         kBen13PhMYwqdGSNWD+Fiwl4He4+k+pbZCtuIjnmRYxrleqcg7+sV/nWekuV9JZPs7qZ
         CxHlPNn32Nu0q+Wkbd851Iq6qy8EEF6rQBRCmdrvQSa70oFHU9cUzFvtsDYU+jxtcFug
         R/bw==
X-Forwarded-Encrypted: i=1; AJvYcCU8gX6ywIdtZyJsyWBiDJIMtPilmAsmLYUOYy9W1C7/+GT7LtMnOzT7dqe7xvzRCg3Z1LdpB68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDbPPMOTccV3xiZ9L1GRb4oiCAh8Axn4OcGWV8FDmKddA0jqbv
	vtCpI+hmICOgL2VhsEJroq27WYRa8/9MIQRb+r/tx6splD/wHmN5aXRJvYeq7mkkAVc3lq7DqMm
	nYfxR
X-Gm-Gg: ASbGncs2j/sAXIrU7lyzZKcxn0r7i49WOaTUfNwAZ+wZZfbWWEWzaZdMXVSum9S6Esf
	OaMjiime9OsHDNekbfP1X1RzOjoQhpVlpHDHlJk838qK3b66qMOT/2t1lwmySkCqxXtpu5bJE02
	n83AQ7EbvbPKxbN2QFtBm5Dk3PopS+/SCQIDnJ7jvXvuI9w4g1NmCyQTK6PKBmskkRevTSJsmiP
	JdWWyg1wmjDslpPTZPkMHzEPlA5MhMCWjdCpap3yeNdQwgXnySmlyoZzUaAexHFAh4PKOtkimFD
	8MYzVbdm5QHJxmNbw969OPDv4rPi7TVQKqA1Qb2IWq8bP2PhmVi0fu1CuAuZKcqIz8ja4KpNq6V
	2bAwA05+DZBML
X-Google-Smtp-Source: AGHT+IG1yyNuMSr3/McpD8qSWvS6jw4bv3VKynO/+lzYPSh51x2sFnGOQMDqqcgpMEWwIOSMrFplOw==
X-Received: by 2002:a2e:a9a7:0:b0:30b:cef8:de87 with SMTP id 38308e7fff4ca-30bf44fa059mr89986021fa.4.1741826817984;
        Wed, 12 Mar 2025 17:46:57 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f117405sm227711fa.62.2025.03.12.17.46.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 17:46:57 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30762598511so4741331fa.0
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 17:46:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQCvQTCAHggeP2SGlJJptr/oGDhYs6np4yZ6OLRvF5pG3k67UZbutK766kQ3BrotpnVoY3kDM=@vger.kernel.org
X-Received: by 2002:a05:6512:281b:b0:549:4bf7:6464 with SMTP id
 2adb3069b0e04-54990ea9485mr7115862e87.38.1741826816614; Wed, 12 Mar 2025
 17:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311091803.31026-1-ceggers@arri.de> <20250311091803.31026-2-ceggers@arri.de>
In-Reply-To: <20250311091803.31026-2-ceggers@arri.de>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 12 Mar 2025 17:46:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9WRjcxfYRtBWUe+twqjqkmW4r_oZYo2xJ4PctXgBQxw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq0-SLDcKeX8oiWyKvQkAVrt3keer7p83h3mGU_CX8qI6SRix9M-0SOgk4
Message-ID: <CAD=FV=V9WRjcxfYRtBWUe+twqjqkmW4r_oZYo2xJ4PctXgBQxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] regulator: check that dummy regulator has been
 probed before using it
To: Christian Eggers <ceggers@arri.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 11, 2025 at 2:18=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> @@ -2213,6 +2221,8 @@ struct regulator *_regulator_get_common(struct regu=
lator_dev *rdev, struct devic
>                          */
>                         dev_warn(dev, "supply %s not found, using dummy r=
egulator\n", id);
>                         rdev =3D dummy_regulator_rdev;
> +                       if (!rdev)
> +                               return ERR_PTR(-EPROBE_DEFER);

nit: it feels like the dev_warn() above should be below your new
check. Otherwise you'll get the same message again after the deferral
processes.

