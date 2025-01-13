Return-Path: <stable+bounces-108452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA3A0BB45
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C65FB7A2030
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FC2243322;
	Mon, 13 Jan 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXDlo1Rw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDFC240234;
	Mon, 13 Jan 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780640; cv=none; b=Yn1JxfELSwoWsbS/vONVYP9c91hAgRkCG9BQerKlgNhmc2SbhcfIC21CkvXuqUCAriQtSbmsVmqgWB0qpjTnoOlc5NvZ9qtAwKT35k19rcoCazxGjTLaQIiTVOQDQVjV1vQYCHhxKErTPo8hTe6Tl8YzBEeTzVxagfZtP6yDDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780640; c=relaxed/simple;
	bh=Skyh1dXrIWPboxjQCS6LLTrvOOWzuK2eDE4/gZIOsLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRCMaElkMDsKROTlBTxNhqPPGaGiLKpRdBr48jKTX2yIJS/0ewv034Wd/Q1QreNdD0EJ+Eg32QlzqiRU4CYSMyDJ+ZcwGAZ54kqDCA0V7n1X6TTiUTrUMFMVDeaOjJxPPfc3PYAxNeb/ZCjya1bLJsAkaG1iN8m0yTg0ODeQYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXDlo1Rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB07C4CEE3;
	Mon, 13 Jan 2025 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736780640;
	bh=Skyh1dXrIWPboxjQCS6LLTrvOOWzuK2eDE4/gZIOsLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXDlo1RwUiDuKZ78WPQvYEi4yDAqzqVk3GnxEuB40D+R8kLm74PE9fxHaddNt7wjg
	 65PpIAA8nqVYHwMg4dfb77SuXrGGOVheWN27oYdjQcviXX0FykTsLm22doc/6xvuWQ
	 SiFY40Lsi77F1tIzcUpXmuDxmy8lAlkWX19vnLi9MmtrF0dUsOib6ljB5XEriCx+/8
	 ted/aAp6KbWJW3C9FRTT2Wx/SAdfgdVCrwKtzUAE03OkUNbkcJW9axhrgSDc3x0MZz
	 oW0P12KdN7QIQALIM4Jb8EW2udz4pX7aAvqsjUikjl/GK9GTHXZHZ2Kl7Ym2GW2s3M
	 DBc1Evj3NKAXQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXLyz-000000006EJ-1Ee4;
	Mon, 13 Jan 2025 16:04:01 +0100
Date: Mon, 13 Jan 2025 16:04:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Steev Klimaszewski <steev@kali.org>,
	Bjorn Andersson <bjorande@quicinc.com>,
	"Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
	Cheng Jiang <quic_chejiang@quicinc.com>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: qca: Fix poor RF performance for WCN6855
Message-ID: <Z4UrYZgYqlTfFc7M@hovoldconsulting.com>
References: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>

On Mon, Jan 13, 2025 at 10:43:23PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For WCN6855, board ID specific NVM needs to be downloaded once board ID
> is available, but the default NVM is always downloaded currently.
> 
> The wrong NVM causes poor RF performance, and effects user experience
> for several types of laptop with WCN6855 on the market.
> 
> Fix by downloading board ID specific NVM if board ID is available.
> 
> Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
> Cc: stable@vger.kernel.org # 6.4
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v3:
> - Rework over tip of bluetooth-next tree.
> - Remove both Reviewed-by and Tested-by tags.
> - Link to v2: https://lore.kernel.org/r/20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com

Thanks for the quick update.

I'm fine with dropping the fallback logic, but you should have mentioned
that here.

This still works fine on X13s and sc8280xp crd (hpnv21g.b8c and
hpnv20.b8c):

Tested-by: Johan Hovold <johan+linaro@kernel.org>

> Changes in v2:
> - Correct subject and commit message
> - Temporarily add nvm fallback logic to speed up backport.
> - Add fix/stable tags as suggested by Luiz and Johan
> - Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com
> ---
>  drivers/bluetooth/btqca.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index a6b53d1f23dbd4666b93e10635f5f154f38d80a5..cdf09d9a9ad27c080f27c5fe8d61d76085e1fd2c 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -909,8 +909,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  				 "qca/msnv%02x.bin", rom_ver);
>  			break;
>  		case QCA_WCN6855:
> -			snprintf(config.fwname, sizeof(config.fwname),
> -				 "qca/hpnv%02x.bin", rom_ver);
> +			qca_read_fw_board_id(hdev, &boardid);

For consistency, this should probably have been handled by amending the
conditional above the switch:

	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
		qca_read_fw_board_id(hdev, &boardid);

but long term that should probably be moved into
qca_get_nvm_name_by_board() to avoid sprinkling conditionals all over
the driver.

I'm fine with this as a stop gap unless you want to move the call to the
QCA2066/WCN7850 conditional:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

> +			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> +						  "hpnv", soc_type, ver, rom_ver, boardid);
>  			break;
>  		case QCA_WCN7850:
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),

Johan

