Return-Path: <stable+bounces-66367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7D494E1CE
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD041C20444
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E48414A4DC;
	Sun, 11 Aug 2024 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NE1WLUYH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F5EAE9
	for <stable@vger.kernel.org>; Sun, 11 Aug 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723389963; cv=none; b=NBAovK3AQuM6pAk5mr1GSQPz9rXjNQcL68bs90PHdY5phqHjeSnsZcOIRe1Zqjr0T8W8/ngZ4veBVqPDaUmuazAP+GYTj6yhfj9g+WTd+6x/L+psz0LGwHJvA45jnFE22HPIstgO1ncnfo41pBJEu0z4/CdJ1UXsP/z6SQDrWVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723389963; c=relaxed/simple;
	bh=HObL7p6icmixYw4pRtXUqRvJCp0m6GjW/mwjEvnuEnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TznbhzZT29m9TtN8QxWAWf6MB6fwmnEQ3zR8IHDmhqBlvxIrTIzI9QF5RjqaEhIKvjbBhMZh39vjfP4V2PA/F10xgJO9aDngOuDib4KOafhdw0tIRu8YGNI+SC01ljV63+gBAui6KtyzqMk2O3Av9E3sutZHiO/EzWBM+n2Vct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NE1WLUYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0C9C32786;
	Sun, 11 Aug 2024 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723389962;
	bh=HObL7p6icmixYw4pRtXUqRvJCp0m6GjW/mwjEvnuEnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NE1WLUYHXOAbO0pIcYLDJZMovjSNTvnWBaJIoQqNV4MPABNPzdU+YVwJ/GGY2WnQx
	 o+d6XkAlggGEocQ/He1okfjbQoKdM2dQeZd9vSwMYQMzzWNQtOM3KBNrKpGTmWFuWK
	 in9pifwKcTjrUZBnRFeI2BHm3DB+ltJVfAwr+82M=
Date: Sun, 11 Aug 2024 17:25:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>
Subject: Re: Telit FE990 hardware support from v6.6 to v6.1
Message-ID: <2024081152-unknowing-observant-9f91@gregkh>
References: <CAHkwnC9B9TxSei36tkBe_GE4q=1DudUyD2uo9VuCa940qABHjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHkwnC9B9TxSei36tkBe_GE4q=1DudUyD2uo9VuCa940qABHjA@mail.gmail.com>

On Wed, Jul 31, 2024 at 11:49:27AM +0200, Fabio Porcedda wrote:
> Hi,
> please include in v6.1 the commit 0724869ede9c169429bb622e2d28f97995a95656
> "bus: mhi: host: pci_generic: add support for Telit FE990 modem"
> https://lore.kernel.org/all/20230804094039.365102-1-dnlplm@gmail.com/
> 

Now queued up, thanks.

greg k-h

