Return-Path: <stable+bounces-124456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA677A6156E
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0971316C00E
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37EC202C3D;
	Fri, 14 Mar 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQhFt/v9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B2202994
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967789; cv=none; b=ANfJuusHHfVDZwL+4xQlDuL8PLOQD/RcO5H2tJNzfo4Lkc95rNLkju2+agpC0hH4d33bMKI5i6muddpAbf1IqdqsJ43p42lyZP7VwpAfw7eWbVjGxRpY47FVvX1g4fTvH6WMmKAua+dE6jXtbdVl2XCOcS17C2PE/gXJbwMGW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967789; c=relaxed/simple;
	bh=I7WfoJdrMa7iiui5bCs39L2nw3ehuuL7qs8ypQidpC4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMGuqgg0XkFpL7Vrn3rmL6M9zOCDSbrdwIecKIRInYNCwFuIgsQAzqFzpwE7yog1zT5nf+j3P0NDvgQtgj5F8Qf0T9BDm7OI6HCV2SIoP1LsU73u7MeAd9MMkBhZWQAS9Q0G94owhtKlsjlCWl9mcoJg3mUM9VjzyQw7VPaeNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQhFt/v9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso15431125e9.0
        for <stable@vger.kernel.org>; Fri, 14 Mar 2025 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741967786; x=1742572586; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I7WfoJdrMa7iiui5bCs39L2nw3ehuuL7qs8ypQidpC4=;
        b=DQhFt/v9nfss5saXPC3XavcuxWFTs4+kZPx2c6sMgZkJcT5H1QyDCwtx7KfdHdWlw4
         7qQGuMQZgaBFbOCq2rKep2nZXV4jVkdhzAMei0ciuvz5tj9fDVWocl29IQ5N0HVrtoxi
         qZoORn1Upqt4+iAu2iKRBh6rZxAIShrGJhidZC6nKs4+eYBChyJAANDqmDy2i8e+mmlU
         aIeeZP5GQR8SDlhuM80Xd6jvshkKE3kgLExTbc0zSbBUZVkXxInQW4WCzayYI03RAXmY
         71cLUcY7kYAXNLd5nXtNINmE+UDyQzVZvkH/8xkOVhBbjKkm0FSmczHgk65WUzsUnYhA
         zMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741967786; x=1742572586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7WfoJdrMa7iiui5bCs39L2nw3ehuuL7qs8ypQidpC4=;
        b=JwSUlIO2SJb/YtCmgUewBsHevKue3SvRPN5rSdHClaXLWA5cf5CTIgs3D+oriYXY8M
         nnNN+IRjHjUfKryK4wC/wcKTQ3l8Q6sluUn2bBsJ1pPsD4rDHbIauvZGAPY0GWmEpSUt
         3agBVUNggPPkbGcrOyGBAhRpiFkUEMFE35H5e3VvvzYXc1WzOaFmnbrwCYJuxbBbU8GZ
         cDV4yBZwQXTI7mmtdqWkMixihVScMwrLxvtZBeEsD5umYEGeCcqxF36qQWeOTC4UMlrB
         0WaSYhbSkpTy4q0nIxz8yH/wuWSC9tIBvBEg9kQ0jmCW6Y6vder14WraZ7rG96jBr+Vy
         GrAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/WhMT54ocPp402sPoojQVOjz1NRE4S8bmB6U4NB3Gai9ad3CQfhEmWDO/a1HL9pq8LFR6aBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xAKTTqSjVm5HiKDw+R5ttE0BxFMbAom7lyGFSRIkjI62qo2v
	37jX99ZKpT4I/P6ZC8IsILKsmQRq1L2ldmyjxkciNK195kuY+lxuwj+jByP3M+I=
X-Gm-Gg: ASbGncsRPeFv9Xx/RAzhgusqGF12rJHJQxadUHYJaGy4BjRCBMxyEA+9yNys4z4aB5p
	tnaJ3wj+YNRMNGqC3K8kysPZLyEVwq0up8KrYHbYa46m1Y8lvzKv1Xyu6Vqc8LDMs86tEGs+sr7
	Q/B0OOhmmiXQeKC7Ex9UGl42M+zG7u48jDpUFLcyeVM9X3ISAEybJrS9BmU4zmqwccMF+/FhMIk
	1/3wfSbNppJWzM4yJ4UqIbxTpKDraXtPbpkSDJlPRJLfvp2sdZPtKuyPT4twrxINbFB2aMJNbfF
	ifzccuXZOqNHpYVazc8I5uBtqof0cBBm+p0QZjcAfcvlUFJOaO2NYsPCZfM=
X-Google-Smtp-Source: AGHT+IHCF3yVkeabT3o+pvpbobh6GwFZochyn0C61kckJRZQkd4Gy9mZ0YDU7EMFdvPBpYowc1DQVw==
X-Received: by 2002:a05:600c:4f87:b0:43b:c6a7:ac60 with SMTP id 5b1f17b1804b1-43d1f235e45mr40033045e9.10.1741967785964;
        Fri, 14 Mar 2025 08:56:25 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe60b91sm21467905e9.31.2025.03.14.08.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:56:25 -0700 (PDT)
Message-ID: <8ccfdccefaf0cd651a3f085aa78227907f03a478.camel@linaro.org>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: gs101: ufs: add dma-coherent
 property
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim
 Akhtar	 <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Bart
 Van Assche	 <bvanassche@acm.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-scsi@vger.kernel.org, kernel-team@android.com,
 willmcvicker@google.com, 	stable@vger.kernel.org
Date: Fri, 14 Mar 2025 15:56:24 +0000
In-Reply-To: <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
References: <20250314-ufs-dma-coherent-v1-0-bdf9f9be2919@linaro.org>
	 <20250314-ufs-dma-coherent-v1-1-bdf9f9be2919@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-14 at 15:38 +0000, Peter Griffin wrote:
> ufs-exynos driver configures the sysreg shareability as
> cacheable for gs101 so we need to set the dma-coherent
> property so the descriptors are also allocated cacheable.
>=20
> This fixes the UFS stability issues we have seen with
> the upstream UFS driver on gs101.
>=20
> Fixes: 4c65d7054b4c ("arm64: dts: exynos: gs101: Add ufs and ufs-phy dt n=
odes")
> Cc: stable@vger.kernel.org
> Suggested-by: Will McVicker <willmcvicker@google.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Tested-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


