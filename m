Return-Path: <stable+bounces-154557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0FADDA62
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 19:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F25019E53CB
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE4C2FA65C;
	Tue, 17 Jun 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fo0EChMa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01F2FA624;
	Tue, 17 Jun 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179595; cv=none; b=lTqTAs+YM8XvlhLoRLQQ0mYqJU/xrbBv6DzwFuVa3wJ+YjImDhf9CjbSArdQE8otikj4LLm6vVxnyetxy9ZtgL71KuQsjiubI1C6oY0+egwcHqntCLNh940Hv2HNTVdf9DE2z7N5AFGlpkrQrZK0juvtBARRVCVZd2fvJTmGucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179595; c=relaxed/simple;
	bh=uEOMgL0enjAcnngHzRz3sXuDxKITAnkXRV1o9HPvaIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6i7NtmBSPqv7B7I3hDbF7otmGujDTmQXSKYyXkjq5RMNAY11ptyoKzNqbW5s/ablKQCs1pyDF9Y1jBnaz+gyFYLZPsZg7F4x8hJfKwxDz1jNiWc20n/eFREiWkEJTGz4kWM/UVOfyzSvKNV05Mu85arxPDB5xEDma01CHHA+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fo0EChMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D13C4CEF0;
	Tue, 17 Jun 2025 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750179595;
	bh=uEOMgL0enjAcnngHzRz3sXuDxKITAnkXRV1o9HPvaIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fo0EChMa7s6vQniwm+xb0uKPr5MvPVjqgu2ivI/SpK3Rvof5c0D/40E9AGjA8WDmy
	 9jE2igMgBxD3NJCCiUDZlGAdmpIcz8ZkXLEtJEuXzdivjH/vBnhOWZ0l9YHyv8+ojp
	 3/McfGdtgmSajg4anTY9MfdwOhN5ysAxheAxoPKs=
Date: Tue, 17 Jun 2025 17:56:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aidan Stewart <astewart@tektelic.com>
Cc: "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"tony@atomide.com" <tony@atomide.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] serial: core: restore of_node information in sysfs
Message-ID: <2025061740-sustained-linked-a845@gregkh>
References: <20250616162154.9057-1-astewart@tektelic.com>
 <2025061746-raking-gusto-d1f3@gregkh>
 <915d0631ac123bbbb5d3fac1248b97d9de3295c6.camel@tektelic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <915d0631ac123bbbb5d3fac1248b97d9de3295c6.camel@tektelic.com>

On Tue, Jun 17, 2025 at 03:46:37PM +0000, Aidan Stewart wrote:
> On Tue, 2025-06-17 at 06:44 +0200, Greg KH wrote:
> > 
> > On Mon, Jun 16, 2025 at 10:21:54AM -0600, Aidan Stewart wrote:
> > > 
> > > 
> > > +     if (IS_ENABLED(CONFIG_OF)) {
> > > +             device_set_of_node_from_dev(dev, parent_dev);
> > > +     }
> > 
> > Did this pass checkpatch.pl?
> I ran checkpatch.pl with the --strict option and I didn't get any warnings
> or errors. Is there a style issue you would like me to fix?

You should not need {} for a one line if statement.

> > And why is the if statement needed?
> I guess it's not really needed. I was trying to avoid the call for non-DT
> systems, but it should still be safe to do. I will remove it in v2.

Please do!

thanks,

greg k-h

