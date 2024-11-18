Return-Path: <stable+bounces-93794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBEF9D10D3
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 13:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9239D1F232F6
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F319ADA4;
	Mon, 18 Nov 2024 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5Isaf9/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0D190468;
	Mon, 18 Nov 2024 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933821; cv=none; b=ufa6UZz8b2N8+OrhCnNqM+LrmyLfr66892VrNU0b9F3QGit5JfuIpsR1wIZ4CDp0TwyP4g5X7NcqEvhUsZui4qcryrq+LAV8uswRMP4Z6zTvqao/orIVKpvLBkLwitp9iiKwpTHFyNx1WOLDuHl9uoeqpxpec75ANzUjXbRBXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933821; c=relaxed/simple;
	bh=P33LpuhdOaOsy6SERvgsmmUyXLkRAXCmjvEKqwplfY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBAQeugNYckz7y3JnYx0U8wbF+FBGl2/LQkbyH1LildaP8RSMoS7JvUwpaHQf9hP0/Xlp8a08gWBpkGexygaftWWysSaZe1TN2eyOendS6AzkcK07sOadx/sxpAvTKk3oDTuCJb4oLiTCRG1s2E54etnmJ3yC9CbNDZsZ0ZpH1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5Isaf9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFABC4CECC;
	Mon, 18 Nov 2024 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731933820;
	bh=P33LpuhdOaOsy6SERvgsmmUyXLkRAXCmjvEKqwplfY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5Isaf9/icUMnPspKQTNYNG3FeD9iqRpejGzi+r1UnIf8CZh6mfYuPECYxEA62MLl
	 9RvgHdQYfLGzoKqooDkfys8MTXAjoXwcbb3w/GVnKsNb3fES7EndW8S4wN4RpU6jgZ
	 NvoehrqpjhqlhjJBFeuulZHCJepAB7EbjPF/T3QggVK/wfP9BsOueyfR7zqmSCrCue
	 P2yt+gW4H1XjGs7AznZL276rg/vYX4CI81FdjywhjYlMLqD72nNaZyIQMX7dSoN4Ni
	 jBVOiV5zIeqctOupyA2ZPmFdH6DtZfVjZpXPF8s2lIHUrR1K+UNdVBySOWH/WGNzly
	 +g1kIx/y+4VSQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tD16F-0000000008J-3cQ2;
	Mon, 18 Nov 2024 13:43:28 +0100
Date: Mon, 18 Nov 2024 13:43:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
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
Message-ID: <Zzs2b6y-DPY3v8ty@hovoldconsulting.com>
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

Nit: These Cc tags should typically not be here in the commit message,
and should at least not be needed for people who git-send-email will
already include because of Tested-by and Reviewed-by tags.

If they help with your workflow then perhaps you can just put them below
the cut-off (---) line.

> Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
> Cc: stable@vger.kernel.org # 6.4
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

When making non-trivial changes, like the addition of the fallback NVM
feature in v2, you should probably have dropped any previous Reviewed-by
tags.

The fallback handling looks good to me though (and also works as
expected).

> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

> Changes in v2:
> - Correct subject and commit message
> - Temporarily add nvm fallback logic to speed up backport.
> — Add fix/stable tags as suggested by Luiz and Johan
> - Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com
 
> +download_nvm:
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>  	if (err < 0) {
>  		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
> +		if (err == -ENOENT && boardid != 0 &&
> +		    soc_type == QCA_WCN6855) {
> +			boardid = 0;
> +			qca_get_hsp_nvm_name_generic(&config, ver,
> +						     rom_ver, boardid);
> +			bt_dev_warn(hdev, "QCA fallback to default NVM");
> +			goto download_nvm;
> +		}
>  		return err;

If you think it's ok for people to continue using the wrong (default)
NVM file for a while still until their distros ship the board-specific
ones, then this looks good to me and should ease the transition:

[    6.125626] Bluetooth: hci0: QCA Downloading qca/hpnv21g.b8c
[    6.126730] bluetooth hci0: Direct firmware load for qca/hpnv21g.b8c failed with error -2
[    6.126826] Bluetooth: hci0: QCA Failed to request file: qca/hpnv21g.b8c (-2)
[    6.126894] Bluetooth: hci0: QCA Failed to download NVM (-2)
[    6.126951] Bluetooth: hci0: QCA fallback to default NVM
[    6.127003] Bluetooth: hci0: QCA Downloading qca/hpnv21g.bin
[    6.309322] Bluetooth: hci0: QCA setup on UART is completed

Johan

