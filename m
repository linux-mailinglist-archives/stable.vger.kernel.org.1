Return-Path: <stable+bounces-62416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A853F93EFBF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534051F22CAA
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021C713AD3F;
	Mon, 29 Jul 2024 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J+FE2Gal"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7463328B6
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241207; cv=none; b=YX/h9xjaRFV2ZnBK/q09xOGbQR96vuxKaWQtEewFhthzGk/qzggiwGv14HlZWYTPMvt58aLJsKMtatyBTHvVE1tpBLA4DAQDjjWl+VjIpQIC0rOgsGxd+DFFOPf6XIRn5rb1stF+6Q4deLQr4M3vtb1tjUwFaXMCJpxSLqxtyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241207; c=relaxed/simple;
	bh=5vbzTNmRGeujo9d1LVAWsgBIYOFy5tlcCcJ1oPgtfSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmexSIgRH32TJpT9Ep7+u1wbg8crSqbzvWFsChQGg3i9pfAbRvZ/xZ4LRMqk3EjQGIX+OUl1KvLtVdnf/qXeSJzIPAjtsTx0ollG3ys+rcxtecFxYSWp0DQxdeDMd94bETZLEtYrrZBhnvLAd1TzesnJ8KnljwTB/gWbf82fD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J+FE2Gal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72B3C32786;
	Mon, 29 Jul 2024 08:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722241207;
	bh=5vbzTNmRGeujo9d1LVAWsgBIYOFy5tlcCcJ1oPgtfSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+FE2GalzisOlv/AkMRf2LVucswLM2tHE1Z9jC6MMm/f8snZ0XvfTalIzyYh7pjBd
	 IOo8Kdy/qAggApDjaULBWoaqDAtcC8xWyEDnTpmWIw4uAk8BwUT5OQFKMP/A5VX12M
	 qPpLbsDCfVVEY7hBRTTwtDv9QtI7dUv8CNqTbwJs=
Date: Mon, 29 Jul 2024 10:20:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marc Zyngier <maz@kernel.org>
Cc: catalin.marinas@arm.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] irqchip/gic-v3: Fix 'broken_rdists'
 unused warning when !SMP" failed to apply to 6.10-stable tree
Message-ID: <2024072946-charbroil-emporium-ca54@gregkh>
References: <2024072916-brewing-cavalier-a90a@gregkh>
 <86wml41uup.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wml41uup.wl-maz@kernel.org>

On Mon, Jul 29, 2024 at 09:10:54AM +0100, Marc Zyngier wrote:
> On Mon, 29 Jul 2024 08:51:16 +0100,
> <gregkh@linuxfoundation.org> wrote:
> > 
> > 
> > The patch below does not apply to the 6.10-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 080402007007ca1bed8bcb103625137a5c8446c6
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072916-brewing-cavalier-a90a@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 080402007007 ("irqchip/gic-v3: Fix 'broken_rdists' unused warning when !SMP and !ACPI")
> > d633da5d3ab1 ("irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs")
> > fa2dabe57220 ("irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()")
> 
> None of these three patches should be stable candidate for 6.10. They
> only matter to CPU hotplug, which is a new feature for 6.11 and has
> no purpose being backported.

That's fine, thanks, it was odd that this commit was tagged for stable
inclusion at all...

greg k-h

