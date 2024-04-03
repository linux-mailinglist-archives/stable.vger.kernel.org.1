Return-Path: <stable+bounces-35660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5978961B3
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 02:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639E61C21BB0
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 00:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DC8DDD3;
	Wed,  3 Apr 2024 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1amFyP/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295028FC;
	Wed,  3 Apr 2024 00:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105790; cv=none; b=E38eJlgJpdJ9lYXV6dWefnx0BqU3qPLSHeYua1Qdh7KOa9OR6PsexgxgWlv3wjPERWMOQPmwaeOA3/d8GD9/zT3mYxCRwSOvkqJphBl+5tpFo7/eAE2/K0FOtGuOUjIluyE+SjIQnXFiir/Uo1v4AvuPQ5s4yYj/kkj1PNiQshY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105790; c=relaxed/simple;
	bh=fckCFmB6zRRDDBaaYGJslC8Bff45qU4MnOFk8AGltNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROWgHY6/uAEpjoZFjRcS+/orzMS9ljFgWiA1NZ4cxetoHpEDpkq/gmbmC5SmRI441D4FmtUHordQoGbxmqrfZgsWAtkRswWnyVqzG7J2i9rmRcjUdvFuykQtUk4XbkM/IXZHe2ppYo/8g9N2J2Vuls0kmq9it6pSzkHKm0FNn0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1amFyP/; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6151002b0a1so5794567b3.0;
        Tue, 02 Apr 2024 17:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712105788; x=1712710588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fckCFmB6zRRDDBaaYGJslC8Bff45qU4MnOFk8AGltNo=;
        b=N1amFyP/MwcINur6eSWmab91lY5cuAYNYNYZt+jLrxTWkL76e5Q4LGr8CA1kj9WRlJ
         RLAW+UJOLiMa1YCPYv4Spfd3kjShvearJulT2lHwdTFyczYpD5at8B52ccF8EmJ6M+aM
         ElFD1zA58uVQ3tmTOfJBsLxQgf4qkVJYs+t5pxayicreBkKbgObhFc4NQRJJ7MmixBxR
         QQCVT9vd+3PT0/o/55qaoQ5+huL//21FmWs0Ttx0hNzvq4ofliRmDdUjGdoTwUR+mv0/
         EfLWcHqgg+6D6C4IobDr+gmKGPyLimx4brYkN2D1WwiraTmwZOKW9WQtB/rWMq0b75PY
         UwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712105788; x=1712710588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fckCFmB6zRRDDBaaYGJslC8Bff45qU4MnOFk8AGltNo=;
        b=PjuiUA/D71cqhSuvIVhXIZKdtHIBy6uP1ohUu652yUF9K4nAU2BCDYjPmhVzhoIpsw
         w9Kxfs57M+/fqLH3tQ5I24OIw7Wr68vnA6NkbvaqU0vQf96FWnaOXVqTkijRLHxByXXG
         82C1JL2hu69gsEs01HB9v/ZNmmrxKNGXN8+/b+vHqfunJhVlU8knOuUQBskOtOXfda05
         F9KQuVALgUphdt75/HVwUh4mjjcYs9G+OcAomCIV4yYLPxaB2gVEHr09EoGLE8Jp2bvT
         38hiMoZ8u15Zb2MeA2aEz5pPBTQ3etJSTTOcM06DeXJh7EfmcHXRioTU/OX+DBZqnEkP
         4Tpw==
X-Forwarded-Encrypted: i=1; AJvYcCXr6VCdOvdovNyqKoRwG/shj3iDpaLNtngIAZM4TNfTj2gNfy2LXtNkKUJeqdts6cv0WYdYaPFBAoLutUSRJZpPTWbSNGyCcFQiB36o3EX2en0kfKjcbha0BbZ9kmBIirZr/g==
X-Gm-Message-State: AOJu0Yx2ZJW1XiqZ5mLzMiQc8LXswQ020e+iZn1hUPXo5mIhjlKkzWwL
	/PTfdzqPZIhj2SH9Ph1SvfssJHn5zHTQfpRnWzcryWgzrF7b3BkrZiWh/1M5rrFkJycM+SZKTpu
	oTJLSUzp5zEEkmXoDyg8sr5qRxZg=
X-Google-Smtp-Source: AGHT+IHgkqd2r5I1JK2/tul3Bu9FmyrCOPrFsJ8HBSKdW9psZHYBD/+A/KUD0Em3ikWwM8bTMz3e8et7CwwwB5pmUsI=
X-Received: by 2002:a25:be41:0:b0:dcd:1cd7:f6aa with SMTP id
 d1-20020a25be41000000b00dcd1cd7f6aamr8571651ybm.2.1712105787876; Tue, 02 Apr
 2024 17:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328151954.2517368-1-festevam@gmail.com> <171165955888.338117.15736314486472326706.robh@kernel.org>
 <ZgyoX55PJD0LDSPf@dragon>
In-Reply-To: <ZgyoX55PJD0LDSPf@dragon>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 2 Apr 2024 21:56:15 -0300
Message-ID: <CAOMZO5CqWEtO8WArfmAsoLhDzfw6QEa15=dvcK8m7GF-UygHDg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7s-warp: Pass OV2680 link-frequencies
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>, Fabio Estevam <festevam@denx.de>, 
	linux-arm-kernel@lists.infradead.org, sakari.ailus@linux.intel.com, 
	stable@vger.kernel.org, hdegoede@redhat.com, devicetree@vger.kernel.org, 
	shawnguo@kernel.org, conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Tue, Apr 2, 2024 at 9:53=E2=80=AFPM Shawn Guo <shawnguo2@yeah.net> wrote=
:

> So it sounds like that the bindings doc needs an update to include
> 'link-frequencies'?

Correct. I have already submitted the binding patch:
https://lore.kernel.org/linux-devicetree/20240402174028.205434-2-festevam@g=
mail.com/

