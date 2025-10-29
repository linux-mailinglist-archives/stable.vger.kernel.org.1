Return-Path: <stable+bounces-191593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB7FC19F0E
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 12:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 967FE3537EE
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 11:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680F332F774;
	Wed, 29 Oct 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMkOPDNj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473A329C71
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736446; cv=none; b=AMpmB3EpFahtpd334sm3h9dmtl1qQVEGrjg3mAlbxuPsTZ2N2yND2lMsh6r6L/ZnJLT4U8SJbp9WLttK8vqhU99nfRMf0OeaF/6NpTgETTZ9Zcs5aQWw+8tMZ6+jwOq7HrfZurkApO5x6pvOYEBPcV69qeBe+4K6N+rqjnn3tJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736446; c=relaxed/simple;
	bh=D/lapmvTOwB4w+eO4w4TOz+x/hybYzymaElHesTMXeg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lsNwaRLrHcs8lS9k3GBwmt1Un2TnBgIJ31WZQWFCjs/+0NyhG1oWtaGwcjXforIeXmSCFIzfiEjPq0SQLt4juwRxXggjX9SuQj79TozhnV9SKr2Rxi4qwBFpvQwXDV9ZMQxUj6VfPHHkssIvQRnyb1UKnu5XBizqh3tHzPFdCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMkOPDNj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47112a73785so45284065e9.3
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 04:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761736442; x=1762341242; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D/lapmvTOwB4w+eO4w4TOz+x/hybYzymaElHesTMXeg=;
        b=HMkOPDNjTBtwNSGyUdsh90hVcMTgwt29vCrohawwxgBIRvGVcsrdQl4T7uJck6O+R3
         8GCqfr4X3NJWetrtdmX6vbozpxVLnOhbeQ+yNTjDOImQe2+vW6vGUt8hKmPhCySmYhX3
         X+eHLlbaPkZomu0wIyN3RN8EpkqrIqtWdaC3l0eOLj8rgeqW3VIosa5A603xlWzlLH4U
         mfkyajlp/tzIApDVErxeRPyn6FNSeDAUffVockuf4LJMnYIKpMaPXZo0vHb6ogroup+Y
         Oza6KTz2GE7d+a85ZfUV/jihKxsr0J5/5sogAo9vNBIEAtZh+tHcJWAK6D0rUm0Xuc2k
         WfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736442; x=1762341242;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D/lapmvTOwB4w+eO4w4TOz+x/hybYzymaElHesTMXeg=;
        b=DgI/emzuIjLts/j+3paywffvC2w9/qgcoWcx52W4XqKDKZ2q2qZeig/aC3VT8ZprmW
         LTp4cfAArSKgLEsI/cM5g+CJnQZqnKbcc/Tx4TTUeqvXNa/a2hssVPAaydPlrtuZkKlr
         nwupNbWOtBwNcq4Wn5FdFmTVF8ybLTXt6We3q4wCyqwiRLOLzI0AYLZubinuo/zeucir
         XPugUVEfsN2pcCGlG1p+RPArRVPQbvut18Xa5stvPEyiEUN9DJN8tmS2dNIxL3lpq741
         ZddMloGz5W2mMhtX2SfsMWAGzgsfe/ewh23DO2AM5absyl+4Zt27cBKXaN0iv1eAB6l2
         gkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa9yUWrGFF3zOFDIyD15yzx0c63vwSh3c319pIjNjTRRRzT3+F3SDM4d12rt4CArct65YVvf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1HyEO+KT/uF5VvtVPI+E9PoPNSE31TNW/cwbW532EaFtpKGs
	0J4Qk+ZWsnKQI1rcOluFYhd/hfI+aNPk1bsCWkW+7Kpbt6XQOOt76uHW
X-Gm-Gg: ASbGnctfaBdZf1k2zo3u3CFvnNRvXM1YO/hw6KUpGkexPEgkwd4bzl9cAIismZE48wR
	5NObHADM47ZzvlXbLqpWK/8ncMG4hb4BTy5H35i+1er/D64gvwyfVOI8W2USgIVpXsTy8/+lq/x
	OPK5nobswqK4a+CVeYZoUUGrrmqgoF8LLc15tTR1CF0CY8pJg0F16iE5COf3AblbrYHB2lKLM8z
	AhseCRGdegJadyj+Pz9rx90lEI6jzcRkFNRnmAMGuK/6E8zc4DGLhtoMVcz7y6fkyNDd6VVcYEL
	vqZhXrvRG0MaHn4jlJeVFNSD00kW66WbgWHdHmbFtL4mYqN+g6IaItLOZtJYKItZ45KAMpAtZex
	clhNLiGnlhE86loK0RdodBaO+HnxvqjlE7/th/FJzpsKauH0Bfhv1n2sCAFLQmyHOsiJlLm8lMC
	1TFaJAz3psQSWzTyf/nA==
X-Google-Smtp-Source: AGHT+IG7oVJwZfUJXNbRBLD+lo+88EHLuFLdA49goSZs2zZITHJszlARkVGhqDOeg4E/63DSjHyGIw==
X-Received: by 2002:a05:600c:34c4:b0:471:d2d:ac42 with SMTP id 5b1f17b1804b1-4771e333a08mr22980435e9.14.1761736441418;
        Wed, 29 Oct 2025 04:14:01 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e18caebsm44190725e9.4.2025.10.29.04.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:14:01 -0700 (PDT)
Message-ID: <ab9c1f88026058fde8cc37057864f25889ce47d1.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] ASoC: cs4271: Disable regulators in
 component_probe() error path
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni	
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, David Rhodes	
 <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela	 <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Nikita Shubin	 <nikita.shubin@maquefel.me>,
 Axel Lin <axel.lin@ingics.com>, Brian Austin	 <brian.austin@cirrus.com>
Date: Wed, 29 Oct 2025 12:14:00 +0100
In-Reply-To: <20251029093921.624088-3-herve.codina@bootlin.com>
References: <20251029093921.624088-1-herve.codina@bootlin.com>
	 <20251029093921.624088-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

On Wed, 2025-10-29 at 10:39 +0100, Herve Codina wrote:
> The commit 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
> has introduced regulators in the driver.
>=20
> Regulators are enabled at the beginning of component_probe() but they
> are not disabled on errors. This can lead to unbalanced enable/disable.
>=20
> Fix the error path to disable regulators on errors.
>=20
> Fixes: 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

--=20
Alexander Sverdlin.

