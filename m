Return-Path: <stable+bounces-35601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04EE8952C8
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AE51C21B31
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07FE76F1B;
	Tue,  2 Apr 2024 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hIYkaFem"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D7762DC
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060312; cv=none; b=IHy8nGPbOvek4I1NY8p+HgyQ9u+tNqrPziCvZSOUxZnxUJzgLUZIuHdsi/sCRr2NIRh5fTGPTIchc+ti7Ftwvt0wqL0LOiELZg9xmJj6yfkeTQo6I1KB0MaOHMdjrdahOa6AQqcnQn9/kaJNsBxclElUjV+tBi8sKkrUNfpzb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060312; c=relaxed/simple;
	bh=7LQzA8TLbMc/QgqktE7PUJfP/7icGCs0B5P4OmMyshI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfyY7ZN35WzHgiFbXkkr+fDZ86ST56PU2heoFOdSUZWL7LoNpM/ske/GAnw6+WfTJ0Ye9D/hQoEJ/m/jgiOv8J83NkEzUchdD1i2UKtWU3ag8cQiGHXBAekB1icJFU4FFlmlCgfLhU+jsivW5iuYOp5tkHwDPoVDEeVciiR3cbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hIYkaFem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90516C433C7;
	Tue,  2 Apr 2024 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712060311;
	bh=7LQzA8TLbMc/QgqktE7PUJfP/7icGCs0B5P4OmMyshI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIYkaFemKSxw5nT4w4TTboJW4020xaD0wqU2c28xm90WCPZ8LXo4bD+UBEXEKLVqv
	 K4bYcO3EiqC2iP4pdhFrPpMLwlxcIHSS2P3RWupECwW0P/KtnqqqQlVWnw7wMnE8bg
	 H6K6mnm/fQ8RcNuS+M3EgNQMymiDeqWezp1p5Pd8=
Date: Tue, 2 Apr 2024 14:18:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: ye.zhang@rock-chips.com, d-gole@ti.com, rafael.j.wysocki@intel.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] thermal: devfreq_cooling: Fix perf state
 when calculate dfc" failed to apply to 5.15-stable tree
Message-ID: <2024040221-cherub-blouse-46a7@gregkh>
References: <2024033050-imitation-unmixed-ef53@gregkh>
 <945689b3-445d-4915-857e-dda84cc8352c@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945689b3-445d-4915-857e-dda84cc8352c@arm.com>

On Tue, Apr 02, 2024 at 09:29:56AM +0100, Lukasz Luba wrote:
> Hi Greg,
> 
> On 3/30/24 09:46, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Would you like my help? I can create a backport to v5.15.y and send
> to the list.

Please do!

