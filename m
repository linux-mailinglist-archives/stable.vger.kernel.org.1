Return-Path: <stable+bounces-53683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FD290E290
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 07:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 606F6B2231D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 05:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DD6524C4;
	Wed, 19 Jun 2024 05:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1wWjIkSo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FAB50280;
	Wed, 19 Jun 2024 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773817; cv=none; b=X69YY2o8XI9RX7GQ8IA0WcGRBI7O0uSdGvtGEjIiMuFPm74tzbvTpvnfO8YFmKqh6DOVxOHVFJ5iwpmMZaGlGcqD/ne40I8weh41twVzpxGEXefowlp4L9R4115YilS9CE3mZAg0DQ2PR946VzSdTpNlEkU27w7Exr4FtLa6xcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773817; c=relaxed/simple;
	bh=BMRHDddXQbT7sXetp9OyuKJuPZPI4jJlgICusGcSAhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2tDkrKRsTxYkAEHlcqp5nNweeclc5saC08Y93Mb36om8TkJfwY8S/1ov1we4RoFucvhm9246cLUW1WMbJZLRDC8KQ0Fzq/1n7eqp3nt0nX8cwYGIAvk/HcDGYRYwzH6bU8QelkiDZWZW3X4ofDP9jsR9zfQujgHLY9S7AC+NpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1wWjIkSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA968C2BBFC;
	Wed, 19 Jun 2024 05:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718773817;
	bh=BMRHDddXQbT7sXetp9OyuKJuPZPI4jJlgICusGcSAhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1wWjIkSouz9yjWWMclSXwVU7txRXxEYi+YuLoIOHdg5MUwIPSxES8k2FHfq7+dV/7
	 t7y5tcoD5Q20mDVEKIsuV+8o7q3ZFl/ypBW+5IMl5Wde4EOB8aypOBrUjtzs8agl9F
	 pMbEgSwlsLfLs3QdYq6N8R7xhR0X+kg0/ODlFWHM=
Date: Wed, 19 Jun 2024 07:10:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v6] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024061947-grandpa-bucktooth-4f55@gregkh>
References: <20240619050125.4444-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619050125.4444-1-joswang1221@gmail.com>

On Wed, Jun 19, 2024 at 01:01:25PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> This is a workaround for STAR 4846132, which only affects
> DWC_usb31 version2.00a operating in host mode.
> 
> There is a problem in DWC_usb31 version 2.00a operating
> in host mode that would cause a CSR read timeout When CSR
> read coincides with RAM Clock Gating Entry. By disable
> Clock Gating, sacrificing power consumption for normal
> operation.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>
> ---
> v5 -> v6: no change
> v4 -> v5: no change

If there was no change, why was there new versions submitted?  Please
always document what was done.

greg k-h

