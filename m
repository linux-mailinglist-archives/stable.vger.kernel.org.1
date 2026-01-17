Return-Path: <stable+bounces-210145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52748D38DBC
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 11:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DEC23020487
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2853016EE;
	Sat, 17 Jan 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbkArC1n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED462D6E78;
	Sat, 17 Jan 2026 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768645533; cv=none; b=DtbJ9X4uUXf/AQWFhbGP9+9TPABS0NNM2nYjqnZCmNv2RYKoDrtap16Q/J8CsZncGEVzoFZ+sWDOVFWXO0uVDsZnS6oFSP+SzLhhuADJHdJFGNIL2I09CNKaPkRQdyEKJY7WFgOeTUdiLRJff98QgwzUZ0VCkGjJ6WVPBB2OgmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768645533; c=relaxed/simple;
	bh=/wlHReJAaFuyQUmUuxzixZ5WkqjotRcfQ1PQBBZR9U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwa+3sEVuXEh7GY/YajtJ5R/Nhk4I+5QwxJUXs55ILGjQxc+K1BQ65OUnSchtV1sUHgdO6aaZx6Te8CoBEy+erTaIJ58jFPF3P8oifxdRacVnTI5d0m3UVron2iBtl6zWsb03ThYve3/SQsi2ZaA7zkyZsLPRrqrIi0CAs37wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbkArC1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD6BC4CEF7;
	Sat, 17 Jan 2026 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768645532;
	bh=/wlHReJAaFuyQUmUuxzixZ5WkqjotRcfQ1PQBBZR9U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbkArC1nka4PfEy1RC9nOZio3pkiMF0Ki5IUmSfGSXM0+6f2pr91s90jsiJACf9yA
	 ntDVmvcSa9TYL11HAVijJBMLmDVIHoMZha1jSemCJvP3Goo7UOpchJh4icaNlXdPsn
	 AuawUcvave9rhJoVdDkrhH8r775CPssyawFPIMCY=
Date: Sat, 17 Jan 2026 11:25:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: he geoffrey <geoffreyhe2@gmail.com>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: xhci: fix missing null termination after
 copy_from_user()
Message-ID: <2026011739-attribute-manicure-e852@gregkh>
References: <20260117094631.504232-1-geoffreyhe2@gmail.com>
 <2026011725-ecosystem-proved-a6ba@gregkh>
 <SE1P216MB1822A187820001789CB4EE3AF28AA@SE1P216MB1822.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SE1P216MB1822A187820001789CB4EE3AF28AA@SE1P216MB1822.KORP216.PROD.OUTLOOK.COM>

On Sat, Jan 17, 2026 at 10:13:35AM +0000, he geoffrey wrote:
> This bug is found via static analyzer codeql.

As per our documentation, please always state this.  Please read the
documentation and follow that for your future submissions.

Also note that the analyzer is wrong here, please report it and fix it :)

thanks,

greg k-h


