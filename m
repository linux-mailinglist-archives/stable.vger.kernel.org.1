Return-Path: <stable+bounces-158668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00266AE984B
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 10:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F5E3A34BB
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 08:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053F525C712;
	Thu, 26 Jun 2025 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOkqdz5p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CC21D5AC0;
	Thu, 26 Jun 2025 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926520; cv=none; b=J4taCTzIuFehY1/ENozT0zRm971kQ9F7AzfDsU/ujh+StQkZicN7v7S4bU3cUq5PHY5/B8GI3Jru0hCfHiFovQb3aUEw3sVWQSWbhXqDUmmdPoKZErSdlEBViI88QjNA2en+cxtRAqm46cpjpfgGhbhDmb0OEP87NGQWjMZeQQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926520; c=relaxed/simple;
	bh=pciYiVVe4/P6aZZq4WAVoeLPQn83rYOW42I1tvwODuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou3pIRzIqriuz2oZn+PWVF9llu4SyW64CYXq+fRfVScfTOBaWPjxHtgoqeteja0FrgX1bhSXUAFm6325PRjX1rbF+N6L+duQLB8UvwUxnx216WDiP/NtECwyV6VlGfIWuU5kkoA05J3QXW6YJP05SRB59g5laiKWG90VpunvOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOkqdz5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF8CC4CEEB;
	Thu, 26 Jun 2025 08:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750926520;
	bh=pciYiVVe4/P6aZZq4WAVoeLPQn83rYOW42I1tvwODuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOkqdz5pCs1uzPe6pFXCXZHulG/uMZzq0NeSCfZ8oTbxEUkAMC+YifYfX5wkdzC4L
	 o5wUDtfX1GSrosDzTBPzg84+V6j3fwu9584V6MRZ1z6gPlXkDX8CD6LIFr+C4bkO0C
	 cTUy+IYU0P3XWeDufJFtGs6Wz9Q0Q6NinMV0hrlQEk9GX/yx2SFWzdcjNiNNVat/E6
	 8fy2tCapflDasOEkkgNKl2d0oDg9yLc7I3dMScNts96TwTjPzHBCrRCWCNv4ZZLKjx
	 xRhwzApA7NJzjg4D6B1aGBo3YOJtiACV+vCSlH/spy7jDMVzVknFhL8jSxUinIPid/
	 3Rl7d+NOrcxeg==
Date: Thu, 26 Jun 2025 10:28:36 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-tip-commits@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/fpu] x86/fpu: Delay instruction pointer fixup until
 after warning
Message-ID: <aF0EtAnVEZ9fwTVj@gmail.com>
References: <175089453700.406.1518104364215542733.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175089453700.406.1518104364215542733.tip-bot2@tip-bot2>


* tip-bot2 for Dave Hansen <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/fpu branch of tip:
> 
> Commit-ID:     1cec9ac2d071cfd2da562241aab0ef701355762a
> Gitweb:        https://git.kernel.org/tip/1cec9ac2d071cfd2da562241aab0ef701355762a
> Author:        Dave Hansen <dave.hansen@linux.intel.com>
> AuthorDate:    Tue, 24 Jun 2025 14:01:48 -07:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Wed, 25 Jun 2025 16:28:06 -07:00
> 
> x86/fpu: Delay instruction pointer fixup until after warning
> 
> Right now, if XRSTOR fails a console message like this is be printed:

s/like this is be printed
 /like this is printed

Thanks,

	Ingo

