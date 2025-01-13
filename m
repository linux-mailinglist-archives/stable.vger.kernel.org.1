Return-Path: <stable+bounces-108458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6006A0BBAC
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B0D1622E1
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A7A24023A;
	Mon, 13 Jan 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhhgnmt3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9753EA83;
	Mon, 13 Jan 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781742; cv=none; b=tbaklpe3QYwmgnze0XyE2N/U0YuSI4WETEp4CwdEMPrqXR7eGAZUFtH7a8NVPiisJAp8eyMfJ80Prabs74cya++RgOmQ1YKHzMLvZpRYfS6ghqFhLmN0S/dpPrsfBPTtdzGq6jAfvgIYORzhTCynO6B3waf3UQLJpuWFvGvXEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781742; c=relaxed/simple;
	bh=uH0qJOGgN0jlMNY2ZtVPIgOLwgQbAiU+6/qlWtHeptQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCK+KkmCte8ZlBY50HkQW25JGVFdE+rTNtdLwDCJFzBSA62PBAFD53kn4ToFtfG4A2H7JAtISQ+xRUid27cxnUNTBqGO/cCnTlxtYGRCwKxnkAagdjIM/c82HiLOjPUIPaRmKall/eup7FJU2+nhRgbsptbIzh8E08jK7YIPRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhhgnmt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ECDC4CED6;
	Mon, 13 Jan 2025 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736781742;
	bh=uH0qJOGgN0jlMNY2ZtVPIgOLwgQbAiU+6/qlWtHeptQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yhhgnmt3S+qvGAd3zoUkVPpA6jzqpEzQ93pwLN1EPAQ+/uApFFTXyCHS0kQ6gd/ls
	 lQbTpWFzeDX39gmKPEWUroOfBVf1aC/+b0CScR5CIXYlZYZIDMx9sWRyrcZo7uhzVO
	 bPKdAOIPiy7UcTQqeGvyuXNnNHTMc2i6CN9FT92vd2mEAQjjjgf/zODLMFYIpfwLNc
	 zSLnp/TW7dGy4pq44EJJSJaou1yshXCyzg28bjIKBba15TQYt6sxs5xpIP2K4w45Nq
	 qtyLpApP3wijAqAnSg2WIpCC4Y1H3VnBSTEtjCZsCZt0QG3zoaxlfwO7DgakfLmkmC
	 ZWukg7F9PGXgA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXMGl-000000008Dl-0ZVV;
	Mon, 13 Jan 2025 16:22:23 +0100
Date: Mon, 13 Jan 2025 16:22:23 +0100
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
Message-ID: <Z4Uvr3-FSvfILA7H@hovoldconsulting.com>
References: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>
 <Z4UrYZgYqlTfFc7M@hovoldconsulting.com>
 <dcc54536-87c0-49d4-ad6f-c47abf102136@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcc54536-87c0-49d4-ad6f-c47abf102136@icloud.com>

On Mon, Jan 13, 2025 at 11:15:13PM +0800, Zijun Hu wrote:
> On 2025/1/13 23:04, Johan Hovold wrote:
> >>  		case QCA_WCN6855:
> >> -			snprintf(config.fwname, sizeof(config.fwname),
> >> -				 "qca/hpnv%02x.bin", rom_ver);
> >> +			qca_read_fw_board_id(hdev, &boardid);
> > For consistency, this should probably have been handled by amending the
> > conditional above the switch:
> > 
> > 	if (soc_type == QCA_QCA2066 || soc_type == QCA_WCN7850)
> > 		qca_read_fw_board_id(hdev, &boardid);

> qca_read_fw_board_id() may be invoked twice if adding reading board ID here
> 
> see below branch:
> 
> 	config.type = TLV_TYPE_NVM;
> 	if (firmware_name) {
> 		/* The firmware name has an extension, use it directly */
> 		if (qca_filename_has_extension(firmware_name)) {
> 			snprintf(config.fwname, sizeof(config.fwname), "qca/%s", firmware_name);
> 		} else {
> 			*qca_read_fw_board_id(hdev, &boardid);*
> 			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> 				 firmware_name, soc_type, ver, 0, boardid);
> 		}

Fair enough (but I guess that would be the case also for
QCA2066/WCN7850 currently).

But either way, this is not something that should block this fix.

> > but long term that should probably be moved into
> > qca_get_nvm_name_by_board() to avoid sprinkling conditionals all over
> > the driver.
> > 
> > I'm fine with this as a stop gap unless you want to move the call to the
> > QCA2066/WCN7850 conditional:
> > 
> > Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

