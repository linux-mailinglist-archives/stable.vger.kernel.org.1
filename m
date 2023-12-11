Return-Path: <stable+bounces-5259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C9E80C2B7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 09:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA65CB207DA
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3458620B22;
	Mon, 11 Dec 2023 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvVtjOw1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB020B19;
	Mon, 11 Dec 2023 08:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557A6C433C8;
	Mon, 11 Dec 2023 08:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702282038;
	bh=3GqnJlLQgzJix4uleFQHfKZjGRQYL0QZLwm4aAsiEkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvVtjOw11aO9mExns9Vh/CwD0zBcHAhfP57vRwAHZ14s4oH5bglxziHG/3/I3exA6
	 tsRvtOK/xvqi6pPrBTitdRhGV8G0D7ZBiwv/xzzAiJAjVBuo/vbAcrmErpzgolBFm5
	 Rix3xhfcyefxA+rsQOzZZTGub0tRHg95c7VZ4eVK2/e61czbbjIdgtKFPc3GoWKtAv
	 tgr7HK0Iz0FWjWAMv5POP32INgUXkUUVhbIRMYu3agqwbJ6AF7/2Qek5iYhDctqGi9
	 eDsnDcOrS/WBiIj1nSAJhuhbi8wbfRMYKweSHXLDv4h0ck1NC8sB6DID59+SfoDfDp
	 EwBG1iqaXiaSA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rCbKd-00016z-2a;
	Mon, 11 Dec 2023 09:08:04 +0100
Date: Mon, 11 Dec 2023 09:08:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
	srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 0/2] ASoC: qcom: Limit Digital gains on speaker
Message-ID: <ZXbDY1iA_DQLIzqq@hovoldconsulting.com>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>

Hi Greg and Sasha,

On Mon, Dec 04, 2023 at 12:47:34PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Limit the speaker digital gains to 0dB so that the users will not damage them.
> Currently there is a limit in UCM, but this does not stop the user form
> changing the digital gains from command line. So limit this in driver
> which makes the speakers more safer without active speaker protection in
> place.
> 
> Apart from this there is also a range check fix in snd_soc_limit_volume
> to allow setting this limit correctly.
> 
> Tested on Lenovo X13s.
> 
> Srinivas Kandagatla (2):
>   ASoC: ops: add correct range check for limiting volume
>   ASoC: qcom: sc8280xp: Limit speaker digital volumes

These were unfortunately not marked for stable, but could you pick them
up for 6.6?

The upstream commits are:

	fb9ad2448508 ("ASoC: ops: add correct range check for limiting volume")
	716d4e5373e9 ("ASoC: qcom: sc8280xp: Limit speaker digital volumes")

>  sound/soc/qcom/sc8280xp.c | 17 +++++++++++++++++
>  sound/soc/soc-ops.c       |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)

Johan

