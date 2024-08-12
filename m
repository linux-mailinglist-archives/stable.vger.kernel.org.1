Return-Path: <stable+bounces-66483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 167AD94EC12
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E091F22680
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40B177981;
	Mon, 12 Aug 2024 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TE/ACCSK"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6153B14EC53;
	Mon, 12 Aug 2024 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463348; cv=none; b=qxwujHhG4YexF8p85xwYhPA+ptLkVXJeHeZXi/7OIooARYcZS1/BuxGslaqKriTgIdLzi71bzNaoA5X+L94bz6VxBe7K6XeDbwq0sPcPrj1RaNSlsz+trACUMR8kOyW96bnnLGCXfLuJ3Suuf/Fv7J15EjWF9EwdTHu3kuXqLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463348; c=relaxed/simple;
	bh=MU8n8oNR6sTJ4DC5O8p1KYQRyc33ljDSlbHVDD1Z76E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl0JRlnRepH1s2m+wSdMb2PwLxpOggiIEn//Gt8xURALSxpvpdibqo6JYeHxoUCt+BPu0uuE8jbhxTbO+9Ln731Flh4yrnp/3nshm/SkUUxTfStv/LMUrBhTd1Iz7npvkffhYYD+zt8VKTg2l75U/Pk3Kin0lAqzJ0AICTltfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TE/ACCSK; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=rR32OfomYnPAod7zuZyAeQ+ekw2kljmsFCxG2kUM+TY=;
	b=TE/ACCSKW9zHy5P760ILZFKHEACTTXrtntOFRsc/MfkWrsS8THkY2Kstq1Lt+d
	pvdYqZJ7g8EpE9cLGvEpKJRnYMY5nvXfgcghNnnV7J7DoHgaSbV26B5i+T8+W6vE
	kkR6gpXW9mwUJa1x+Wdb/koGOXANAGxWcYEQSSR9x5SyU=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp3 (Coremail) with SMTP id M88vCgC3H+2U9rlm+ZMQAg--.48176S3;
	Mon, 12 Aug 2024 19:48:38 +0800 (CST)
Date: Mon, 12 Aug 2024 19:48:36 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp43: Increase LED current to match
 the yapp4 HW design
Message-ID: <Zrn2lL6E1IEBAlYj@dragon>
References: <20240723142519.134083-1-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240723142519.134083-1-michal.vokac@ysoft.com>
X-CM-TRANSID:M88vCgC3H+2U9rlm+ZMQAg--.48176S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryUZw1DAryfJrW8GFyDJrb_yoWfJrb_WF
	WxJFyIy397K3W8Ga15Krna934a93yUJF4xtw1Dta9agry0yF48Jw12qr93ZryUZF45Crnx
	Crs5Ww1xK39I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0rsqJUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgM5ZWa57+IRVwAAsZ

On Tue, Jul 23, 2024 at 04:25:19PM +0200, Michal Vokáč wrote:
> On the imx6dl-yapp4 revision based boards, the RGB LED is not driven
> directly by the LP5562 driver but through FET transistors. Hence the LED
> current is not determined by the driver but by the LED series resistors.
> 
> On the imx6dl-yapp43 revision based boards, we removed the FET transistors
> to drive the LED directly from the LP5562 but forgot to tune the output
> current to match the previous HW design.
> 
> Set the LED current on imx6dl-yapp43 based boards to the same values
> measured on the imx6dl-yapp4 boards and limit the maximum current to 20mA.
> 
> Fixes: 7da4734751e0 ("ARM: dts: imx6dl-yapp43: Add support for new HW revision of the IOTA board")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied, thanks!


