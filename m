Return-Path: <stable+bounces-100598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881BC9EC947
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 10:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF0628270F
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF92E1A83FE;
	Wed, 11 Dec 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlC0ubis"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D01A83E9;
	Wed, 11 Dec 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909893; cv=none; b=UX9atzLaCzv7PiDbgViOl+EBEQrr2txyCKO/R3PeNFtoUz95yZZwYcW1qEYk+y18ZydoNenQbLYEj7WxyiETheRcE3tA3zn+lxgMM/Ws661OwMO9OcLzG1xjlfELz1fI0HYbnGsqOcYUCRIgzrGF81oBaAc80LwF2YO+8YjBNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909893; c=relaxed/simple;
	bh=z+d+jdtirrJWeIw2nBKJdv8caau4JNAT5u37Dp6mTws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz4hUFnPL7IVAz20O+HqNd9dokVwmRFrgB3HqEvFtXicsSdguRmIzDnlyjZpNj7cL7PEpl5Cro/U8dT68woDHrTnBXan7W/ycJ+wL92+PXUsGTwSrNbHKB84EgUs5pVUL5VKE5cghJA9MzcZcG1T1y4m9xDDttavf0tLmTZV7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlC0ubis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391F4C4CED2;
	Wed, 11 Dec 2024 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733909893;
	bh=z+d+jdtirrJWeIw2nBKJdv8caau4JNAT5u37Dp6mTws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KlC0ubis2o7JfJGDdNpnfGLsZ8V9WmPMvq6/xCP8JIxzrPIUDYPLUMMBScZaWbvh4
	 PHK4gBUEwDWKbqNuoTOlErILD8Hkxzri/9p/z9Tn6IsjcYQZBkz/SP1y+/5SdVfZCh
	 qZHpHIe053NwyMmXHIq0f7cc5uKX2y63e5VWsil2Wfa4neIqBIuMZit6iMmUJcqbZd
	 gK9ieA54q49bgbX27/BJPoIZLbF4gvbmW8q3f3Vin9fS0TA1rQlx2BRbbOgvzJrfJQ
	 ZHlfJPbSXiHBP2PlIhKt2ML7dXUHwe/n/zqNFLFQ1Vcq58YGpOaF/WonDmAWOP13B3
	 0JyrBTljvPzIg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tLJAe-000000005Am-0pX3;
	Wed, 11 Dec 2024 10:38:16 +0100
Date: Wed, 11 Dec 2024 10:38:16 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] USB: serial: option: add Telit FE910C04 rmnet
 compositions
Message-ID: <Z1ldiJcsjRxW682Y@hovoldconsulting.com>
References: <20241209153254.3691495-1-dnlplm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209153254.3691495-1-dnlplm@gmail.com>

On Mon, Dec 09, 2024 at 04:32:54PM +0100, Daniele Palmas wrote:
> Add the following Telit FE910C04 compositions:
> 
> 0x10c0: rmnet + tty (AT/NMEA) + tty (AT) + tty (diag)

> 0x10c4: rmnet + tty (AT) + tty (AT) + tty (diag)

> 0x10c8: rmnet + tty (AT) + tty (diag) + DPL (data packet logging) + adb

> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
> Cc: stable@vger.kernel.org

Applied, thanks.

Johan

