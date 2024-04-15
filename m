Return-Path: <stable+bounces-39408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7828A4CE5
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE959B230B4
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 10:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702C95C614;
	Mon, 15 Apr 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jx6wpf1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85B5C900
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178236; cv=none; b=hEVJ9caHMg+k6HSs74yXAJDkhnvf5am6TZN2XnB5hZUF65owAH7nVrdp22QTO9MliNLjLPQEbGmmAYC7mxFQPtGZfVlnqafXFFJ1oHwaYY4KDGl0gMKGptiZUzoSpvA/NQ0QyDT4nzDPqpK+lRtLBanSeRs2zULwYc6rJNp+EFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178236; c=relaxed/simple;
	bh=nrBDiYpXOHTV4JYboEAHqEMqjTTPcvChf27rTa2y82g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAzw2FXWs70P862+ayhR2X2bapYRe2hyNPpNcYNu6Ziy8X3yxzI9GT2Uu/0JMfPe+Rf2Pvy9YLaIu/E2mozEivfkkMO+SPnitz3mrNsOIAMN4H7xz88lxycR9ZQyU/Ng/c841EMsarTe96N7Yco8R2n2byVbvMiOiF+yYhQ2uvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jx6wpf1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C63C113CC;
	Mon, 15 Apr 2024 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713178235;
	bh=nrBDiYpXOHTV4JYboEAHqEMqjTTPcvChf27rTa2y82g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jx6wpf1pqLylczqq+lILobwlUARDNo/N9E6UFFoR6S36O7duaUqc7u1GZXTpHxMg5
	 zVw9iz7ao4qX12W5uW0QzapGBVpit/9PR/UKlLVE1pcgrqeyxZ9ngqFw8Hkf3O2zn9
	 055lCrRYlssw8/jmZL8HoWHngCPpB36tGRT4x62c=
Date: Mon, 15 Apr 2024 12:50:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: stable@vger.kernel.org, Nirmoy Das <nirmoy.das@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 6.1.y] drm/i915/vma: Fix UAF on destroy against retire
 race
Message-ID: <2024041521-diploma-duckling-af2e@gregkh>
References: <2024033053-lyrically-excluding-f09f@gregkh>
 <20240412070016.273996-2-janusz.krzysztofik@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412070016.273996-2-janusz.krzysztofik@linux.intel.com>

On Fri, Apr 12, 2024 at 08:55:45AM +0200, Janusz Krzysztofik wrote:
> Object debugging tools were sporadically reporting illegal attempts to
> free a still active i915 VMA object when parking a GT believed to be idle.

<snip>

both backports now queued up, thanks.

greg k-h

