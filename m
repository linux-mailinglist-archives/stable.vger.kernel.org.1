Return-Path: <stable+bounces-86637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4C89A255B
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 16:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F291F231FA
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7B31DDC32;
	Thu, 17 Oct 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfSm8mro"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D21DE4CB;
	Thu, 17 Oct 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176294; cv=none; b=Jt8FtDiJe0TPISR5nvFl4MTnbtuPX+XPpejSEA1C/IsGHXQpM1hl6zYXmp2VVNrZL6nDhvimESyJNA9TwXnW8agqt8rPDjU9JX+Z011f8nqEEVJ5xQesI1pv+X0kY3ULeuC5iZZpja/uYZpoSHoimLyYQr24SmoozpBHa4JU6eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176294; c=relaxed/simple;
	bh=jaMRLUtiBlWgqNKrVN1ovMPBX1tjqhl1CDqkxOfdEsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhOi04fNxeUmmyB4hRnbwy7RMB0uJ0rUBeW/rPMYsTaWqoidfOHMkHiLXZVubGA948Qz4vyeQjdyQeZPmHjZuCfPi5HR23684YvTB7MY41QCzt2sSQFbuZjhhZM3MHCH8Biht8g8mZ2kPtpsoGbp5vuf2JVCjqqdiur9tBwrJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfSm8mro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CCCBC4CED0;
	Thu, 17 Oct 2024 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729176294;
	bh=jaMRLUtiBlWgqNKrVN1ovMPBX1tjqhl1CDqkxOfdEsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YfSm8mroHwfijgeNnX9iceUwN8SYJd4a9XLqaDZA2gdgk9r1PMBgqJDbsEVLwPA6z
	 BTqWErG83b2KBg0ZeQKM/TUO0Mh/7WRyAxiF1KC9RBmckud368Bb751lRz8bU1a/EP
	 vBQLrlc1JwlShiy5gpaMLoOMCubt6ncH0Q8TOPrv/1bY1DgvytsRj8g5f6sYAemTyb
	 FI9gW/KdigaFTIYVT+bPPL/BvRZNuOpDQJHjbAne4NnUgILujhCysO/29N7QdvSzqM
	 94gkIbwDxpAORHGh9kUEkIyTqdGLayH+I7+3Cr1gQqP6/BDApAlThSZhSIr9JPz5M5
	 eT8EJiskV/zkg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t1RkL-000000004Xn-3mlm;
	Thu, 17 Oct 2024 16:45:02 +0200
Date: Thu, 17 Oct 2024 16:45:01 +0200
From: Johan Hovold <johan@kernel.org>
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] USB: serial: option: add Telit FN920C04 MBIM
 compositions
Message-ID: <ZxEi7cJKnH_DagqW@hovoldconsulting.com>
References: <20241003093808.1628436-1-dnlplm@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003093808.1628436-1-dnlplm@gmail.com>

On Thu, Oct 03, 2024 at 11:38:08AM +0200, Daniele Palmas wrote:
> Add the following Telit FN920C04 compositions:

> Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> v2: add the stable tag to the signed-off area (kernel test robot)

Now applied, thanks.

Johan

