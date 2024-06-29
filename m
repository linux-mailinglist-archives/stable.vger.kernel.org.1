Return-Path: <stable+bounces-56133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5588591CE4B
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 19:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1013B282A5B
	for <lists+stable@lfdr.de>; Sat, 29 Jun 2024 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DB58627D;
	Sat, 29 Jun 2024 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="B+epOElV"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732F22EED;
	Sat, 29 Jun 2024 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719682556; cv=none; b=LMjI6GxwE2tSPV7IhLF3rs/oeF4lvON/c2ui6t9YWxfhQYre064Wi2TujPtuR4iofZLbLEf9YIrKScwvKfc8dNRHzTYTUXeJfBjouq67nGBrZwgDPO54qtNc7jF/hfyEbBuIUeoPNXwVHa/cx8vk6aqiJtHTkEHLE1OVlsLC9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719682556; c=relaxed/simple;
	bh=tsJg2UT0g/WSTAeN0OossZ9r+TgWqAkhMXJOZv5nhmg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l2tGqLxn0Vof7Psr6AMf2PwcynGrE2gSvz9+OoVfoszp35fTUESjjFLpwhLRiL+eZljGAfn/dr5e7IvgTpuW+d+GoimrxcOPKgrWW/GAy8xmh+engq0Tj58Fs7/TOOHjrCp3ayi/Yj0IPdFsRdsbT4f4g9NQjb+WInMZb/mSiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=B+epOElV; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719682519; x=1720287319; i=markus.elfring@web.de;
	bh=tsJg2UT0g/WSTAeN0OossZ9r+TgWqAkhMXJOZv5nhmg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B+epOElVMYgXswpTdA5mRf6qTcC2Gx0fzEhcDHw5s5nkT5d5aMTz1ZhQZFi5hU02
	 3X/+HskmAxZVytDvl8MBVFp/SkcieaiYOLld8ODp0Cz2+uldK966Kxqji29REhhgN
	 P3IJRkiOE989iEhMRrWduoE0JMXAf40AH8KWzoxvv+oaoA8eC8OXyIA+u9Bf6L/HI
	 uEygyCcJJ5k1x1qb/vLVNbJUZ2INU6EoqGAK/1HYiwuB9puvZZGFXKmreMopvroJq
	 JyktWO2a8OYUGJ9PIuHBjyOD6ORUwwopCZa335gyyn3nBu9D+CsZd814Bn3nYBiHL
	 Q1TCBVGSfCwj0LODZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4N9I-1sGYvR0bQ6-00zBAC; Sat, 29
 Jun 2024 19:35:19 +0200
Message-ID: <9f67af8b-9c8c-4ad6-88c3-03d9fd9673d2@web.de>
Date: Sat, 29 Jun 2024 19:35:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v2 1/2] arm64: dts: mediatek: mt7622: readd syscon to
 pciesys node
To: Christian Marangi <ansuelsmth@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20240628105542.5456-1-ansuelsmth@gmail.com>
Content-Language: en-GB
In-Reply-To: <20240628105542.5456-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v8gBJ2lGpjG9X3tIzafMhs3tI5PY4M5B34TedERy2La5e4vj+id
 4Fp2ViEGYUwJKeWuxBkYDYwAPlaXtJbpgWSDpucxZjT/bLtrEKyJTo15qU2ZypHtriQukLW
 95oWGGQ3uQYixiAlYFNCzpWAjQO2zOVBi7bjeNSXeblGoeIzE1zqhHnMeGS8zL6eMII02Pt
 mdRjaCFcl1hGsqIWnC0+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MNZwi5QpEBs=;rNwPC0lM5Jg4hhO2G++/jY1PrJy
 3Vqy/ghHNt3QkFVS1+2qNdMETT7EQEs7epsyP5HuXtx57kvvHufS6PIhuduEV7cyXaZH/kWAg
 gxBhyraJWmtilolZpQctgb1byPcCG/GDN2vAz43As+2mOY7SBdAsyo0sGLrc3fFTbPXg4PZ2q
 iUkl//5A8u0HwULkvavPY3hHIRIgEZH9dQDT5CaEp4X+OO3oaboYuRdcaiVbOfJaItSR20j5N
 t6YRVBR17nGhJMcSB20gYZMZxcT7daciEpT6cacM3f/e4rF4aPoO0DYWcjIDPeaG/nbW0LAlG
 P8/NHTE9X8kaqTqlKo0G4F3u2S4cutR7LodNRAD1gdZxDZnd8yNwF7iZcOuzQmJX0Hd25gwS2
 izz+qS2MMRXs+w2WK6mO8t4E0OxK7OmH2LNthYD9LYPrgOUVT/RwIo87UUSMXFuaVSnRQf2G/
 A0NQSIzC1D5bkpSrI++2YaAQ0AnX+dsX8pI0H+dYkqGo5tISw/2PlJq4QvVYm6/AUCUOGkHlb
 077XAl00o7Q7eMh0zJizKkWLnHwIRzur/A20acj/mmg/MD1wCD+NBsO0K1QoCOly9VXqVJQIq
 9I8ehgJqqNtUWf3g/5E6Ego03gPIp8u8kcAiJZtA0arS99Dii3nDLpqaaDb6UIzQjCDzR7qR+
 jC7bPSbTvohs4ZrhUE48kDQIzCeI1cROuMTTegjfpo7D5S5XxiJOPURMvWTcRnQXBVLRxRKJo
 ux6xXoYfBPgftPf0oh68r207mIaX8dg99ZS90PIjpiQfRJ31O3xjv1xQr4gGWZS1qaQsOhOKb
 bAmELv+sp/7Fqp3miBHR9miIl4tiDouSz/u7Ix+3wTJdQ=

> Sata node reference the pciesys with the property mediatek,phy-node
> and that is used as a syscon to access the pciesys regs.
>
> Readd the syscon compatible to pciesys node to restore correct
> functionality of the SATA interface.
=E2=80=A6
> Reported-by: Frank Wunderlich =E2=80=A6

Was any related information published?

Regards,
Markus


