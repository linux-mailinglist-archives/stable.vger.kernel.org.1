Return-Path: <stable+bounces-40734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7708AF431
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FF121C22D2D
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653C1C2A1;
	Tue, 23 Apr 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UjE1zqcm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773CD160
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713890036; cv=none; b=fQZ+/05vXh5yeKlsiOWhjjCi9/bYhIS45URqH5yOd5KCrDl+FE+/endFr/PZEEXBgdg2cLwjLNbrhBGGomGPJCZSDdU3Ey0yxokCRRNwKoyvmkTofk/d3MmXt4q7dauSNyxm2Do4Hg9jve/qtd6mSsLgfgkAqeCj/LWrnKa5fZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713890036; c=relaxed/simple;
	bh=y7X/i1dGpYR+xUvsiuDkbR0+eorI6DrPrUuwk/jmru0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBkfojTwuhOMlbLemr0XBV889w1ckoCIVrDwUhNgH76fdACHNNYhQGlVHEj71vvMI4e8kJ8yeP1T9cAe2qgE0Sv4+KodWxAszcN0G+qglibJUDPtSWYpfIw8zsj3eKz30Ac3eyZVvBTlrfYuaScXTIYUIhhdDFE7Qsv5IzYhnh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UjE1zqcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6928C116B1;
	Tue, 23 Apr 2024 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713890036;
	bh=y7X/i1dGpYR+xUvsiuDkbR0+eorI6DrPrUuwk/jmru0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjE1zqcm+JVnchQ1neAoRLXNLxjQ+jzRB73WpOgNq1zq+IjWiQ70OcuXwyaQNGxfG
	 CHtUZpaXiqclmH7CbDlS0ritf5fWYI5mqtu/83U0h7kNytjtM8MvpdJbf2gOAxZ8iU
	 vadmpFyfmTSmmaLQyoe5zx8QvmuADg3BJBVFtR1Y=
Date: Tue, 23 Apr 2024 09:33:46 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] powerpc/ftrace: Ignore ftrace locations in exit
 text sections
Message-ID: <2024042337-parole-stylist-7f62@gregkh>
References: <2024021902-authentic-handpick-da09@gregkh>
 <20240423084717.286596-1-naveen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423084717.286596-1-naveen@kernel.org>

On Tue, Apr 23, 2024 at 02:17:17PM +0530, Naveen N Rao wrote:
> commit ea73179e64131bcd29ba6defd33732abdf8ca14b upstream.
> 

Now queued up, thanks.

greg k-h

