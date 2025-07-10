Return-Path: <stable+bounces-161582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AA1B004E2
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392041C40C3A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF397272813;
	Thu, 10 Jul 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYlLOM/P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD71442E8;
	Thu, 10 Jul 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752156922; cv=none; b=ZVzI0u6boMkGbpfYdeA/mzil8nFFxTiC6xqai/VbchITKE8pcq3vsryUDeJiuPqaIwLVd6+GxQnGVw+q0Sol4lHc15EpJQjhMOqBaRVpPZTHLRdISvttJM1jj9oHue4Wjf4hJ+bV5PswiUoY27hSmo8SnXeMSLDNyUDuu0QVWh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752156922; c=relaxed/simple;
	bh=4zfxTFyV/TN0ivVrKUj+cVKgP4/5alPqCqzx7/Atvrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nah5tpvbmXcc92X3WoLupnw7prvjx1TDfq9b6lMuYm5rOd+4tJf+bd6VjsTKp5tqFD2pn8FVxgjpebCN8XPaMmMg3iMtlk85y06jKiNXnGZDDvn0bBWGrXM+mbXTwolOK3qvcSI8L+FcIYe6SNKX9aouFZLHebY6I2/p+Zpe7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYlLOM/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E31C4CEF5;
	Thu, 10 Jul 2025 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752156922;
	bh=4zfxTFyV/TN0ivVrKUj+cVKgP4/5alPqCqzx7/Atvrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYlLOM/PU7zbwRj1NHMVtATCsOdF0WkYlS+M30bqNfbPVVgqXHCTswwJ92npqwTvu
	 xnF2Xa6jfPZ1qLuR9QhSYdKUd90BJRSHDUMud1zVDP/huKkUUXlqfOWsC4BcbcHAJu
	 FxpsAhzAoC9FqQG0mRsxZB4vIJY3EjBN3GCDbd1ikTY1ecyFmAYp+riTZnNaxMp6qe
	 H+fgLpHDp7Q03lUcKkL4rsImllpYqEqe9v8u0Vm4e3Yqzmn8H2DKb5u30QsQ0TN5wJ
	 gDzC10J0JTm5pHnBNuOFFqwJWr/v20lqkvEjL0gHyP9Hg+YfS70Qa9tbaqBkPpoKy8
	 866YKfRy1en4Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZs3P-0000000050N-2Cft;
	Thu, 10 Jul 2025 16:15:15 +0200
Date: Thu, 10 Jul 2025 16:15:15 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] USB: serial: option: add Telit Cinterion FE910C04
 (ECM) composition
Message-ID: <aG_K85kECOF0hx34@hovoldconsulting.com>
References: <20250710121638.121574-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710121638.121574-1-fabio.porcedda@gmail.com>

On Thu, Jul 10, 2025 at 02:16:38PM +0200, Fabio Porcedda wrote:
> Add Telit Cinterion FE910C04 (ECM) composition:
> 0x10c7: ECM + tty (AT) + tty (AT) + tty (diag)

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
> v3:
> * Add missing change history
> 
> v2:
> * https://lore.kernel.org/linux-usb/20250710115952.120835-1-fabio.porcedda@gmail.com/
> * NCTRL_ALL -> NCTRL(4)
> 
> v1:
> * https://lore.kernel.org/linux-usb/20250708120004.100254-1-fabio.porcedda@gmail.com/

Applied, thanks.

Johan

