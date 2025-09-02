Return-Path: <stable+bounces-176966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E82B3FB90
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0492C17F5
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CD2EE27C;
	Tue,  2 Sep 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzsM0CZ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7782EE268;
	Tue,  2 Sep 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807179; cv=none; b=YOoIuCSW3gJBllxzRFct/oMceRYz/+U1WKyQ0seYJ8kRFK06RjMvo9nJtIZZfku+rpLxX3yuLNMyLI4d9rLE/QCESe7A4b5baGr4YXEMa6VD5/MasGwogKIMtDXhcp0e4pPByh4afrkdEDjyUmnRjoStoQ4ZlLJYtI7xLlRJxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807179; c=relaxed/simple;
	bh=M22+uJTa/W0eNL+3Bo93sBc6P8ROW0P0TJeVjfjQk18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhbMPSxxnAkWwhJ0KE/tcgYRrJYLXSeKhE6ShnsavNxaYMR8Z48s/W46Kt1LQxREAZftLW/NgCtg3gkQ30hp05+wMwQduF/T8c7aTFFin7l3NISUD8juzUKEVGnU2k+TdsjcDLBmg03Kr+DGw7kPIlarh43MrRtV9dKqy6yCIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzsM0CZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99184C4CEED;
	Tue,  2 Sep 2025 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756807178;
	bh=M22+uJTa/W0eNL+3Bo93sBc6P8ROW0P0TJeVjfjQk18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzsM0CZ0400pFYojaPSN3T8hh4EfIYl7a/Mi8NEmZ1c6qb4DouJ9/F56YeIqbtCnD
	 XPjcrINJyIv8Zbh4dunh7pNK5xMkUjpk+oYVqLjqfbzxZWnOAxGUKQfxbo/NDarrLJ
	 JEW+8E1V5q1uCg7ZvVmDiEcF1mytSCutnNt4yLJ1BwpC6WmsTcll0jR2OlqMNpgpsV
	 +dZOiaM6VTJlzYzIj7P5wZSj0CV9C7St6uj3cJ70LnbR8UjM3Z82ePB9Tvd8WUfoMp
	 B7ZXtU1T6VcWritj/lKN9Hr5mDw/AXbn9BK/gnC4OUSgis9QTFw+s/4MJ1IeivSKee
	 3/US+8bpFiBUw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1utNnQ-0000000080j-2mDu;
	Tue, 02 Sep 2025 11:59:25 +0200
Date: Tue, 2 Sep 2025 11:59:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jan Palus <jpalus@fastmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: quirk: fix write to string constant
Message-ID: <aLa__M_VJYqxb9mc@hovoldconsulting.com>
References: <20250829132152.28218-1-johan@kernel.org>
 <aLG5XFHXKgcBida8@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLG5XFHXKgcBida8@hovoldconsulting.com>

Hi Sudeep,

On Fri, Aug 29, 2025 at 04:29:48PM +0200, Johan Hovold wrote:
> On Fri, Aug 29, 2025 at 03:21:52PM +0200, Johan Hovold wrote:
> > The quirk version range is typically a string constant and must not be
> > modified (e.g. as it may be stored in read-only memory):
> > 
> > 	Unable to handle kernel write to read-only memory at virtual
> > 	address ffffc036d998a947
> > 
> > Fix the range parsing so that it operates on a copy of the version range
> > string, and mark all the quirk strings as const to reduce the risk of
> > introducing similar future issues.
> 
> With Jan's permission, let's add:
> 
> Reported-by: Jan Palus <jpalus@fastmail.com>
> 
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220437
> > Fixes: 487c407d57d6 ("firmware: arm_scmi: Add common framework to handle firmware quirks")
> > Cc: stable@vger.kernel.org	# 6.16
> > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>

I noticed that you picked up this fix yesterday but also that you
rewrote the commit message and switched using cleanup helpers.

Please don't do such (non-trivial) changes without making that clear
in the commit message before your Signed-off-by tag:

	[ sudeep: rewrite commit message; switch to cleanup helpers ]

In this case, you also changed the meaning so that the commit message
now reads like the sole reason that writing to string constants is wrong
is that they may reside in read-only memory.

I used "e.g." on purpose instead of listing further reasons like the
fact that string constants may be shared so that parsing of one quirk
can subtly break a later one.

Johan

