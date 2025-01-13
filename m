Return-Path: <stable+bounces-108457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C39A0BB97
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 16:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B955188168D
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3824024B;
	Mon, 13 Jan 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFj1+NwA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3224023C;
	Mon, 13 Jan 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781449; cv=none; b=CepgOA54LaNh/RQ2WntcZF43IrR35qlgyGfic+UzQNS6o16cEAvnbat9JJJ6A5uwZlrScgPpCxv4rFojvCmkh4ETJHol/4afIJqDZoOUtr416Tk/vZOG+gw6BvQw8yZvNbhmEQgE6ky2MU0r2SpW6dQ9Cell3rt8iDpC3hYYhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781449; c=relaxed/simple;
	bh=GmEIoyiDHgvNx06M6EwwSKjJJ7q0/bOAqaLjQAlJgd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi8rbfuS8t1cZdHW2MFCg7AyLF1iHvk4FyA6Rwicgh0Wr7k8jX5P/3VbVV3YZbbgnQKlC6EKD49XlLZNtKdG6lMcyxCF8t6uCVLHTzLfQNsHAX5S3POiXAMPxHyWFELbjWHPCKpXGqaFzENM8Ahlop2TtLp8C7tvum6iWLGsbw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFj1+NwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ADBC4CED6;
	Mon, 13 Jan 2025 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736781448;
	bh=GmEIoyiDHgvNx06M6EwwSKjJJ7q0/bOAqaLjQAlJgd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFj1+NwAe1PzMmr2dBiohjQIID2G3xLSjJetG2AI+tzREKm5T79E64UmoDzCdFXgr
	 rU3XCdDTmKznDDud4Shx+AyDzOOzXhXrrtMrZLMXXKSCXIPof9H0XeZNTdIPbgXKhL
	 +G+skIHUxjlZOyeDKlu2kyPmDIQpqRhQdCKK47u8ev3DlQdk7a/2+U0B6qHIlNjU/N
	 H7EBINH08APYS3TYv4NnAY/dOB8qGh+BqgxkYvcMrtdbLBpMr7ZoPXn/5rbqmtGv83
	 FlAW107/W92fBg7kW/4dZ/cKlRu1AD1FGH6cDE6est7NStpIi3cZHXIJ5TydLIQyYs
	 OxDNIqRb99IeQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXMC1-0000000084c-0noO;
	Mon, 13 Jan 2025 16:17:29 +0100
Date: Mon, 13 Jan 2025 16:17:29 +0100
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
Message-ID: <Z4UuidlsPyC5mHjD@hovoldconsulting.com>
References: <20250113-wcn6855_fix-v3-1-eeb8b0e19ef4@quicinc.com>
 <Z4UrYZgYqlTfFc7M@hovoldconsulting.com>
 <63830aad-161b-4b9a-81ce-1437f66f70a7@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63830aad-161b-4b9a-81ce-1437f66f70a7@icloud.com>

On Mon, Jan 13, 2025 at 11:11:00PM +0800, Zijun Hu wrote:
> On 2025/1/13 23:04, Johan Hovold wrote:
> >> ---
> >> Changes in v3:
> >> - Rework over tip of bluetooth-next tree.
> >> - Remove both Reviewed-by and Tested-by tags.
> >> - Link to v2: https://lore.kernel.org/r/20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com
> > Thanks for the quick update.
> > 
> > I'm fine with dropping the fallback logic, but you should have mentioned
> > that here.
> 
> the fallback logic is still reserved.
> 
> look at drivers/bluetooth/btqca.c:qca_download_firmware() changes
> introduce by:
> Commit: ad3f4635a796 ("Bluetooth: qca: Update firmware-name to support
> board specific nvm")

Ah, sorry, thanks for pointing that out.

> > This still works fine on X13s and sc8280xp crd (hpnv21g.b8c and
> > hpnv20.b8c):
> > 
> > Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

