Return-Path: <stable+bounces-75794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BCD974B86
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0054B2222C
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB70413A26F;
	Wed, 11 Sep 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTAT7VHD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877997E583;
	Wed, 11 Sep 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040152; cv=none; b=DqMVfh862Pw3gn9shTNfsdAn1Uhht8/kIrZTIAMQi5EOm8S6ODxdV5spIjPgdaDxUEpszbTZBpPrUdkdVWyAFsUl1ij/QPfXmEj4mfI0fz/gZM545+B+Me5muciUVoarQdpOdkjp1S/iobIv3iUcLDe8+4dCE8LBW8gpvTcsMT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040152; c=relaxed/simple;
	bh=SK5N+Jo20GWnE++Ph+AYV2AX1Wx0GO2o7rRTpgKVeZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NaRxMeLlhyZLLJK/qmHQOhynZqtdT8jYc3FMWPuuk562lerJmj+cXpaC1PBD1J20j8eseB6nGETKUhUQ6MBqCyPNhoAP72i2LZ1TR2HykSqQLw8ZRfBMVLQVbjA0lI6MEXCeTrIg0D9tnmtnVX+crNNj26CTBnr7QiQF6Cu6/ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTAT7VHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54E2C4CEC5;
	Wed, 11 Sep 2024 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726040152;
	bh=SK5N+Jo20GWnE++Ph+AYV2AX1Wx0GO2o7rRTpgKVeZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PTAT7VHD5sro7EE2FwBqAkT7VRz0GIBy176I0dI9NncCxJlb3WIuhaWRU7FeKXvUn
	 d6AkPxZ/fYWiIh4Hs4oronsllSSPpw6nhD3TKvFap/no65EFs+4iPFxDmXRzBOYAYB
	 +i4z6VhNlb3lJ0ZRW8w7uMPofUTLhWDKbZkb4Vp3SQpnGwj1MV9LFNQFuaFuMCCvwN
	 SkH8I60YXmig79DEkbFQ2yFsqPUpDHf5ip79ahc4TkYZ+OUfjdKERwjtqcRqcB7Pul
	 PVeT8DSYXY5w1H+wYRRtwglS7Q5Xl03VTDITF8Q+udIYdEDp4nFTd8ba9BfQN+5KY8
	 3Y+ivgpixVvPQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, stable@vger.kernel.org
In-Reply-To: <20240909164746.136629-1-krzysztof.kozlowski@linaro.org>
References: <20240909164746.136629-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND] soundwire: stream: Revert "soundwire: stream:
 fix programming slave ports for non-continous port maps"
Message-Id: <172604014927.100094.1768831537403270768.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 13:05:49 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 09 Sep 2024 18:47:46 +0200, Krzysztof Kozlowski wrote:
> This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
> breaks codecs using non-continuous masks in source and sink ports.  The
> commit missed the point that port numbers are not used as indices for
> iterating over prop.sink_ports or prop.source_ports.
> 
> Soundwire core and existing codecs expect that the array passed as
> prop.sink_ports and prop.source_ports is continuous.  The port mask still
> might be non-continuous, but that's unrelated.
> 
> [...]

Applied, thanks!

[1/1] soundwire: stream: Revert "soundwire: stream: fix programming slave ports for non-continous port maps"
      commit: 233a95fd574fde1c375c486540a90304a2d2d49f

Best regards,
-- 
~Vinod



