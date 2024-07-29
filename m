Return-Path: <stable+bounces-62370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A3393EE60
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8B41C216A4
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998648526A;
	Mon, 29 Jul 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ztJXAGpH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5859B6F2F8
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722237937; cv=none; b=hdk+3Yh3iqxFGa4eaDSxokfSC6+EvNfiwEz+j2PkdGrT7g2zcAbZeLPFrDBDctxdsgL9yTTL/9ZIF3iFfblANp+/JNgSI+oDLZZPhULMFzHM3wvbGISOV33tP6AWmdsfaYXumzRz3Cpca6pumJTFIX+sHQUncQKr44bpDVt1MH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722237937; c=relaxed/simple;
	bh=+MY1M0LZ6j3hF/9KUGmSD6LS1tsSva4+lDowlmVxJ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqSv7QJ/6hRZIwZJiZChvGBDxiH04BmDcG0omuHcYT0eV91Xjs0vgK+pAurR/5iH/8Ta4CQHHM1K+foEv5UK/YYrvIA1x5QtCs3oO9Z2t1Q6xGcr4ATfidSHXe1eY31XCfpZzyLOceoMqvK2wgMlEXuwXDAy9EEZgGEiMCdq1j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ztJXAGpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A19C32786;
	Mon, 29 Jul 2024 07:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722237937;
	bh=+MY1M0LZ6j3hF/9KUGmSD6LS1tsSva4+lDowlmVxJ5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ztJXAGpH71vgryjre7g8dzCU82ZfJ0Vx8dk3K/T4F1g6xe2YA9jIfImVXhyU8dgCs
	 bV8YzhvXeijdU0ckGvg/+alH486sgALvBufRTuaT2S3ec/MTNr4LC93MaP+o2SdBWQ
	 lvHG7mFKFiiLCftxd09OcppML7Jk+GIjrI8B620k=
Date: Mon, 29 Jul 2024 09:25:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: EFI backports from v6.11-rc to v6.6 and newer
Message-ID: <2024072926-hexagon-glitzy-9dcf@gregkh>
References: <CAMj1kXH7oTmmxpwO0sFLuEpGY3_3iSJepptV_WOid=w7+PhSXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH7oTmmxpwO0sFLuEpGY3_3iSJepptV_WOid=w7+PhSXg@mail.gmail.com>

On Fri, Jul 26, 2024 at 11:28:39AM +0200, Ard Biesheuvel wrote:
> Please consider the following patches (in this order) for backporting
> to v6.6 and newer.
> 
> fb318ca0a522295edd6d796fb987e99ec41f0ee5
> ae835a96d72cd025421910edb0e8faf706998727
> 
> The second patch addresses a regression on older Dell hardware. The
> first one is a prerequisite for the second one, and a minor bugfix
> itself.

Both now queued up, thanks.

greg k-h

