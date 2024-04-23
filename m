Return-Path: <stable+bounces-40766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B221B8AF819
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 22:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B431C2215A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 20:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AB3142E60;
	Tue, 23 Apr 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r1gXJ7Q+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DE433A0
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713904797; cv=none; b=YjBbgLof0BIOU26IQD61VssFtns50+rxDdew+wRJJOEidyJk+/OH7MBMUwB8MlAltWB1QRAdvAWv+0Ka+MD3tNC/vjGlzgCqQZ9jiqIi1xBeb8hM8K14lS0Btg8eTBKxCNJkPdHNo1tIuwNgNpzanKWoUgTUNihKhGfhs+RDKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713904797; c=relaxed/simple;
	bh=Sv55w2doqtbN+J/n/RtyegdBiJVNxQbPgZ+58AGzf7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIyqKwFf4gkbPLHcwf0ZwM5u5l4Nw5SpZoR06L06WcfYssrE0MUUCVG8j8Of8d5ug+BAYLEIWjmFy/BgrzXm2VZAMElzPF3Bo9G1aAhzLrHCZPsNfv5ZyE/NdusHRYxA2RHZmkJKxg4b5i4s58ibhC+BdT6uOPi7Vp88tnZxBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r1gXJ7Q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE804C116B1;
	Tue, 23 Apr 2024 20:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713904797;
	bh=Sv55w2doqtbN+J/n/RtyegdBiJVNxQbPgZ+58AGzf7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r1gXJ7Q+67AzmC52goCr8J/d3TyzzX7q2VqB5zRa+vIMx8Yh/h5BOzuOuPgCfMDJL
	 4le5Y4c288ATv/lHJKK5Vm/O2t6hQ20g3PUekZou5YYuvUAzVxzccK4JprJnmzE+HQ
	 6IvqzFo99zv1zWIXQHzRpfsNNKFXwmBsjtJ/CEzU=
Date: Tue, 23 Apr 2024 13:39:47 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: stable@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 6.1.y] PCI/ASPM: Fix deadlock when enabling ASPM
Message-ID: <2024042334-atrocious-drapery-5851@gregkh>
References: <2024021334-each-residence-41ce@gregkh>
 <20240423203402.462761-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423203402.462761-1-helgaas@kernel.org>

On Tue, Apr 23, 2024 at 03:34:02PM -0500, Bjorn Helgaas wrote:
> From: Johan Hovold <johan+linaro@kernel.org>
> 
> commit 1e560864159d002b453da42bd2c13a1805515a20 upstream.
> 
> A last minute revert in 6.7-final introduced a potential deadlock when
> enabling ASPM during probe of Qualcomm PCIe controllers as reported by
> lockdep:
> 

This and the 6.6 patch now queued up, thanks.

greg k-h

