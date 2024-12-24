Return-Path: <stable+bounces-106077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DB09FBF5C
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 15:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8381610B7
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 14:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142821B3945;
	Tue, 24 Dec 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="lnF2N5Su"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2338F91
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735052203; cv=none; b=gqajA0dX5WuMy3pUoFGWLYMOxoER0A4ou7oxYqTys+YKph2KltOSJIyep32cB1UrmlnMJ5Ix3xNe3Bw/mJ8tdmzpdrwfA12E0m3odqMRy8tRXwAE0XBVUQ5hfZbyN9MsNwCASdT7GJ1zJFLaXMbd9ChuA9MGme/YK/WadtPXbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735052203; c=relaxed/simple;
	bh=liH6r+RRpNET/LeUU36Jm7/mrnAwMM4s8eS+LWPZg+s=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=u4t5JiLo+1ag5vJ9EwFIE3qIGqhTeZEcoocmg7A897HK9MPFHsx4OPu37oYtskvQC98D06ZlGjUqiF9rc5sMWP7AJeJW+88259nkNMaEfxw5DqbRXZeIQZqDY/GN55U3RBojKtqM8byBVBh8gPmIXZ//1zZjMW9ywPw5oHz/kVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=lnF2N5Su; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from rainloop.ispras.ru (unknown [83.149.199.84])
	by mail.ispras.ru (Postfix) with ESMTPSA id A4F3340755C3;
	Tue, 24 Dec 2024 14:56:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A4F3340755C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1735052191;
	bh=liH6r+RRpNET/LeUU36Jm7/mrnAwMM4s8eS+LWPZg+s=;
	h=Date:From:Subject:To:In-Reply-To:References:From;
	b=lnF2N5SuVzJC8mdZ8jgnOVhgatdTvYH2r1sooA1xmvoA5GGsmPcZ9bZiDlxtpVUNw
	 XBx4ubvBAZxxL4MrqfM1pTJ7qCyNf1kwWw9Zov58kcDvokuVnGCJIVSaFIVz7Ks2qS
	 G2D907y7dCHD1W6PxcE2GvQU0LQH1fvfcK28jJyE=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 24 Dec 2024 14:56:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From: mordan@ispras.ru
Message-ID: <1ca017108b4be8195b597ed5a2c22504@ispras.ru>
Subject: Re: [PATCH] usb: ehci-hcd: fix call balance of clocks handling
 routines
To: "Sasha Levin" <sashal@kernel.org>, stable@vger.kernel.org, "Fedor
 Pchelkin" <pchelkin@ispras.ru>
In-Reply-To: <20241223093223-4173e9cdd41aad4a@stable.kernel.org>
References: <20241223093223-4173e9cdd41aad4a@stable.kernel.org>

Hello,=0A=0AA required dependency commit is missing, as noted by Fedor Pc=
helkin:=0A=0A> The current patch was added to stable kernels lacking the =
necessary=0A> prerequisite ff30bd6a6618 ("sh: clk: Fix clk_enable() to re=
turn 0 on=0A> NULL clk") which is specified in Cc:stable tag of the commi=
t description=0A> per stable kernels documentation [1].=0A> [1]: https://=
www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1=
=0A> Could you please cherry-pick ff30bd6a6618 ("sh: clk: Fix clk_enable(=
) to=0A> return 0 on NULL clk") to 6.1.y, 5.15.y, 5.10.y and 5.4.y ? It a=
pplies=0A> cleanly.=0A> Thanks!

