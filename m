Return-Path: <stable+bounces-210463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7907D3C395
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 913194898A8
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F73C1FD8;
	Tue, 20 Jan 2026 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="BimZu0Su"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2D3C1FD7;
	Tue, 20 Jan 2026 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900875; cv=none; b=jzcGv5KGKwdy4wCC0zvJXETptAdyOYzHljHuaLgl3MiLcxn0MgPuklA6gf/Opx5VK5eMBBxU0Yv9HYuGiCPLw/exE4oLppw1Q7OE9/1IhRdRre9Ns0CBTBoOJVZJoKgCR0hoFihHLm6sMFv9yzZMYHlw23M1Eq7oC0BN4NdmJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900875; c=relaxed/simple;
	bh=OXF/P9VEQfJJ8i8D8me4MwtOeFLxEnKqU9NmPAC1YHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAmhpJw2Y1OKEBJO+g8oEbNo+U5BnxcZEbvoQmVQbGxMr7Vw8baRYcU7+8OxNLnwT5PtUXGLgjGrT3aYBMPyA/1D6O/IG9FzX1wkwQqXma+UnxtnHyxtPMYj5H0EXq3C01M1/dUA/fg8NiYwl771FkTx0FzZ5vL3sbs4KMslFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=BimZu0Su; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=OXF/P9VEQfJJ8i8D8me4MwtOeFLxEnKqU9NmPAC1YHc=; b=BimZu0SuvzB3jaUW5oNSKxEaOu
	uB3H3zCEEpx7yA6si/29a3bsR5iKClQLYlHKfTbQFEk8Gmfzpt+z47v2bP3if1Ke0/7lrocAxi0I6
	tc+T/tBM6Pz5+/9yzGEFeZYC5BzyOpLC5j3QS0gTRKAdGEG0We3410D6IoeBzojXifV5W1oB5C8c2
	lt+LPC710XKWmU8vMpx50S+2aKaaB5Dspupzyyc/QNocLut0BI588Ganj5QG71PMidnAWVe9p7rxn
	rTWbRKfShFWUmDMHqf8GqLJFhgeoaK/Bt0yzBGCMFxxuG8m39cbaNJza5UI+pJZwGMbHkeLKXyocU
	UGHAiwmQ==;
Received: from [192.76.154.238] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vi7v3-003KRU-PW; Tue, 20 Jan 2026 10:21:02 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 Re: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
Date: Tue, 20 Jan 2026 10:21:01 +0100
Message-ID: <40619400.XM6RcZxFsP@phil>
In-Reply-To: <8960787.MhkbZ0Pkbq@diego>
References:
 <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com>
 <CABjd4YympEqbiN9-Kwv40YtaCh6bu=3PBQPyvvGgKCQbLeZmZw@mail.gmail.com>
 <8960787.MhkbZ0Pkbq@diego>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 19. Januar 2026, 15:42:23 Mitteleurop=C3=A4ische Normalzeit schr=
ieb Heiko St=C3=BCbner:
> Am Montag, 19. Januar 2026, 15:05:16 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Alexey Charkov:
> > Happy to make a v2 with an explicit pull-down. Will wait a bit for any
> > other potential feedback though.
>=20
> I'd side with Quentin here, having the pin firmly on one state, when no-o=
ne
> (board nor driver) is caring would be my preference.
> Especially as Quentin said, this is the hardware-default too.

Also it would be good to send that v2 sooner rather than later, as we're
pretty late in the current development cycle already.
(We're after -rc6 already)


Thanks
Heiko



