Return-Path: <stable+bounces-103983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE8B9F07B1
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69ED816517F
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759D31AF0CE;
	Fri, 13 Dec 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXtO6Sec"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D8199956;
	Fri, 13 Dec 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081721; cv=none; b=XO6e4pZ0tQ3SQTXmj2iIi0FZ373LGGXBPF2YqhdBE0tjEWdAFkVWGqvKmEReWGnD7gMOyCCz/+e7u3zo4+4xPxZ9ImBgEHUex8kO4Gxq6+ZFHtXXqoQklZ/zxLd57uzMFSi5RtC7k6J8Se0U5GJpQGSXLgWxN8ggiME409nOv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081721; c=relaxed/simple;
	bh=1pZwS7TcmAmvi1wRt87ykSfWXKxO0bgHI7AQxo14fME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xa7ofvcnjL1GZ/qU+h0oEwUvdUfTgwgZcGT5qUHqSHnYDPn2ycgPQBhDFHScADF5+m2tncZCyTlfAPjSmykcnf1PYtkX1H0/sbIpgo83ReohD0uSGXrEOWqfKUcqF3eURjbu3pRC8mq5jkdDVJyNEpSJMofU4ZzecloEWTQtlvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXtO6Sec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87C6C4CED0;
	Fri, 13 Dec 2024 09:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734081720;
	bh=1pZwS7TcmAmvi1wRt87ykSfWXKxO0bgHI7AQxo14fME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZXtO6SecypVwW4bZOZYHoRONZHfX6IegE1muMPfVtDTFvbtrwzKTmaTDj4b3BTzuS
	 rEz/tRuT3vckwAmnhZs55Fl3l5H81f5zP0naV3bEUcwXur+BbFPml2Ieeduefx6Xel
	 2fmuedUWzM4ghvsvXTk0brXPVIobaAuj0WGJIeZnsoDQ1MV8tnahutmn653nIITYfi
	 yyoqSug08QA6YEDSB2T7eciPcUcEJu28chNV22Za9X6iEH4m4D0wakkhF1wxHBqwgd
	 dfRgbnQZbtzKvu895tVvZezkoJ/aAou2EvnmWphNy/vb5ZmBBcA6f8NHBQNu2n1yNL
	 oU2iryPTJw2ug==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tM1s4-000000001O9-3lSL;
	Fri, 13 Dec 2024 10:22:04 +0100
Date: Fri, 13 Dec 2024 10:22:04 +0100
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Steev Klimaszewski <steev@kali.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu <zijun_hu@icloud.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Bjorn Andersson <bjorande@quicinc.com>,
	"Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
	Cheng Jiang <quic_chejiang@quicinc.com>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v2] Bluetooth: qca: Support downloading board ID specific
 NVM for WCN6855
Message-ID: <Z1v8vLWH7TmwwzQl@hovoldconsulting.com>
References: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>

Hi Luiz,

On Sat, Nov 16, 2024 at 07:49:23AM -0800, Zijun Hu wrote:
> For WCN6855, board ID specific NVM needs to be downloaded once board ID
> is available, but the default NVM is always downloaded currently, and
> the wrong NVM causes poor RF performance which effects user experience.
> 
> Fix by downloading board ID specific NVM if board ID is available.
> 
> Cc: Bjorn Andersson <bjorande@quicinc.com>
> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
> Cc: Cheng Jiang <quic_chejiang@quicinc.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Steev Klimaszewski <steev@kali.org>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
> Cc: stable@vger.kernel.org # 6.4
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

> I will help to backport it to LTS kernels ASAP once this commit
> is mainlined.
> ---
> Changes in v2:
> - Correct subject and commit message
> - Temporarily add nvm fallback logic to speed up backport.
> — Add fix/stable tags as suggested by Luiz and Johan
> - Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com

The board-specific NVM configuration files have now been included in the
linux-firmware-20241210 release and are making their way into the
distros (e.g. Arch Linux ARM and Fedora now ship them).

Could we get this merged for 6.13-rc (and backported) so that Lenovo
ThinkPad X13s users can finally enjoy excellent Bluetooth range? :)

Johan

