Return-Path: <stable+bounces-71633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B9966052
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4978F1F286D7
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F33C1ACE00;
	Fri, 30 Aug 2024 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p3gUlQdd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC22A18E370
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 11:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725016285; cv=none; b=gz5yCJOSoIajd+9nz0GgS8PfPtDdA3tx3pdu0WLjbSxUFk6/0w6LoEp/AGTLO/JZ6qMwWiiKpzD1v0VnoHnLajTSZNS83rW7vurdqGqR4J+Xa/ze0/w2c9QnUi3yHUdVoHG/qZye4AlKO4545xaOGpJ2/lvpBDAw7X3S1QI/oHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725016285; c=relaxed/simple;
	bh=cM9xmt07Pvkfu+1ZWT24j5sRlAymClvey1kOvZaesqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5Wpbmw00I58MvYOoIdY/zrecxpIp5MAH0yAc8gJPs6wo/l6iWfLmj164dD6azupsBd7Q2WPPyTcAZ9xfO9JPjaGt/hk14Wq4Ao0FmP9D5+IXO8PeYvRf7BntT306KXgPvGEpjaXP3F6Pj+CyvVtV5zC2ilnBaeIQeC8xy6mhnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p3gUlQdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F3AC4CEC2;
	Fri, 30 Aug 2024 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725016285;
	bh=cM9xmt07Pvkfu+1ZWT24j5sRlAymClvey1kOvZaesqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3gUlQddi5juNXYD89LGFbDjDxD+rn93GTtBUbOwUB/O9ujJZA7X9rSJn6AI6xnAn
	 Rcqvoo4xiUDPmapF68NRYzK6Iknq0FLZFVlzTXX2bgrZBl/g5xVRWzc6K1YKHJvCQw
	 7Dt/rETDxCm9FBf3tr5grdCzJ70imk3zI5O11l/I=
Date: Fri, 30 Aug 2024 13:11:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 4.19.y] scsi: mpt3sas: Avoid IOMMU page faults on REPORT
 ZONES
Message-ID: <2024083015-fridge-herald-1a50@gregkh>
References: <2024081115-giving-hacked-fffb@gregkh>
 <20240816020759.737794-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816020759.737794-1-dlemoal@kernel.org>

On Fri, Aug 16, 2024 at 11:07:59AM +0900, Damien Le Moal wrote:
> Commit 82dbb57ac8d06dfe8227ba9ab11a49de2b475ae5 upstream.
> 

Now queued up, thanks.

greg k-h

