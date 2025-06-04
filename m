Return-Path: <stable+bounces-151410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF71ACDEEE
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D51A3A6D88
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275728FA83;
	Wed,  4 Jun 2025 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2f7uoZHK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFB428F958
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043346; cv=none; b=n+l2m7wbzbnZZC9ChyxY7sUTjXoDF3HPJLUZiUl5x7+qq+m5JqWZ+nRlD/e0Faxx94ruKIdAd4FCd1Hb5b5Kc9Mgqzd9TbJzJ892ULR1oFn0LCR3loH2XFvn3b7iALENazy5y3vI+KEsoCC6lD/OGMO2r5kJl3XauQh7mfA67Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043346; c=relaxed/simple;
	bh=kQiu2pv19nQyJEwf8rI9ujLcz+sZjo2vxmIsFKttTnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBrhsC6RNNDOv4126yFszdlDbhHcMZbQ66raqU8tTSqOyK/ec6XFrVAJx2m/yMhbAQYymaNtxpViBzyfcU7NIJZrtvJU1mXcTGbCPxLZdnyPjmBSg7z3YTzcP617kaNH9YfAWgzEIV6+4KvN5fi6SenESRefi5iLVWzJhUywYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2f7uoZHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B890FC4CEE7;
	Wed,  4 Jun 2025 13:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749043346;
	bh=kQiu2pv19nQyJEwf8rI9ujLcz+sZjo2vxmIsFKttTnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2f7uoZHKJ270ZQUI4WAvIYKmx1iRFuKmNb62xDD/gqklIlrDCi8WqtfvoGl0KjHdq
	 YknJV5NOgGL0xG6xA+xPXXPkqpRhh9PYw+aT8+VqzwQy5TQQCtL6mUZqqgIfd6vaxS
	 xHOuvYjTUyd05ZyFsTv7K7DV3YqRA+RfUGSsQNeE=
Date: Wed, 4 Jun 2025 15:22:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sasha.levin@oracle.com>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	Kees Cook <kees@kernel.org>, x0rw3ll@gmail.com
Subject: Re: [6.15-stable backport request] ACPICA commits
Message-ID: <2025060414-reselect-banana-b683@gregkh>
References: <e2affd32-9b1e-4849-9e65-38b4ca592f95@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2affd32-9b1e-4849-9e65-38b4ca592f95@kernel.org>

On Tue, Jun 03, 2025 at 10:41:18AM +0200, Jiri Slaby wrote:
> Hi,
> 
> can we have:
> 6da5e6f3028d ACPICA: Introduce ACPI_NONSTRING
> 2b82118845e0 ACPICA: Apply ACPI_NONSTRING
> 70662db73d54 ACPICA: Apply ACPI_NONSTRING in more places
> 
> in 6.15? They fix the build of acpica against the kernel -- __nonstring is
> undefined otherwise.

All now queued up, thanks.

greg k-h

