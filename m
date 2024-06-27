Return-Path: <stable+bounces-55925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEBB91A078
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 09:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45631F2171E
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CE4F20C;
	Thu, 27 Jun 2024 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2vV8BJu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69C64206E;
	Thu, 27 Jun 2024 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473723; cv=none; b=TN6LHn6RsKGaXaS/mc3e4jwPvoO8AYiUaRlBcbhlRzBvnnD2imP+UtpRCstNro8PG/F1mT9z4yEiOhgXsj4Bu30F/b/Z53AbuAbTb8ol19/ucj92WUSlZYAkqFHLQka2Wivwsz7X2/C578BqRwZWpyclN5qE3h5JbSMiikBPzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473723; c=relaxed/simple;
	bh=EBVtQzYYf28HCqiLVfi9dagu/Hn6fovIcMy9j8tI0wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iexR4YBwG1jXMejKksYS7FCeDcopc/TvUleJw8LIMaopDJVVRIuKXSrhUU/0hSMfrWrEPE45MnWFwCRZ2K+lkhDU0BXhZXHjS0rB1QnpkXWbW7K440kagNiLjnrqUN4GgR4qqrH2Mm2mtAKq7cph/9rqCSvUdzy5JZA3GPTm8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2vV8BJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFE5C2BBFC;
	Thu, 27 Jun 2024 07:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719473723;
	bh=EBVtQzYYf28HCqiLVfi9dagu/Hn6fovIcMy9j8tI0wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2vV8BJuL7yNvQYdm494+Q/1/p2WLcty+bvq7+U+7ljb/I9Obn+AxmgWASyc3Fj+O
	 C7GH/DZJ+TizgrSp8zG6YLcJmEIba7hDBX8F38VcxmZDAhSd/VabARLnZfFh75DG5p
	 8Z/y+S7YWhwOTmyLgtVDwcifqd5Kv5Ga3MNS9I5pqBF+xQlwSo32KDI+VQ2R07Zn8d
	 blM6e/mEnqoYuY/LFd3qnUVwURRM/6+Njs2YBKPM2xUZJZs1hXfU7NAaQD/tU/6aFL
	 uyJBhf90ToluJe+EHN+h3rf3wHmXQaSHOXxQYdF6pRgwfUP4D1KjSS5AXi078PQ1WX
	 kYuA/WW9jOwgQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sMjfM-000000001Qn-26te;
	Thu, 27 Jun 2024 09:35:36 +0200
Date: Thu, 27 Jun 2024 09:35:36 +0200
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM350-GL
Message-ID: <Zn0WSAHHQQr61-Og@hovoldconsulting.com>
References: <20240626133223.2316555-1-bjorn@mork.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626133223.2316555-1-bjorn@mork.no>

On Wed, Jun 26, 2024 at 03:32:23PM +0200, Bjørn Mork wrote:
> FM350-GL is 5G Sub-6 WWAN module which uses M.2 form factor interface.
> It is based on Mediatek's MTK T700 CPU. The module supports PCIe Gen3
> x1 and USB 2.0 and 3.0 interfaces.
> 
> The manufacturer states that USB is "for debug" but it has been
> confirmed to be fully functional, except for modem-control requests on
> some of the interfaces.
> 
> USB device composition is controlled by AT+GTUSBMODE=<mode> command.
> Two values are currently supported for the <mode>:
> 
> 40: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB
> 41: RNDIS+AT+AP(GNSS)+META+DEBUG+NPT+ADB+AP(LOG)+AP(META)(default value)

The order here does not seem to match the usb-devices output below (e.g.
with ADB as interface 3 and 5, respectively). 

Could you just update these two lines so we the interface mapping right?

Johan

