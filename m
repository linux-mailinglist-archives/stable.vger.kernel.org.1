Return-Path: <stable+bounces-56333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2DD92398C
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 11:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E43B1C21C69
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08277152161;
	Tue,  2 Jul 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pQ5vJqlD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD3156F55
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911485; cv=none; b=LryMOwHMbudMHs6SPU+FrBkUZwDsYw60jAy2cQHuF9Zpualp72pbO/cyeUF7HSYwrLtMhSw++1nZO6SnklcZkC/o7ioHbldBqk2y1CClP9rrD4RJNNLlQynAOBcB6fLqLlUjoc+6XcGQ95AhXM90kF5G+AkWeUSRogsXEfTeRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911485; c=relaxed/simple;
	bh=FEV61FocoFxJcnReu6pquuss/8LJMBziMctBrOWTMbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+DQSJDnCe8eOmkAODJrhN+jlQlhAyd8v5p/9p/LquDTHo3e3FP5Q9HkQiu5WAWk+OiJOu+nrh1cU6dhi/PkzTrd3SYEBew7PZxq5Am1B5NDxOg8A4E2EpBRK57tE/DS8UuFOos+i+8NRuP4vI15HnDq2BATUgW0rrbXJjf++2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pQ5vJqlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1834EC4AF10;
	Tue,  2 Jul 2024 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719911485;
	bh=FEV61FocoFxJcnReu6pquuss/8LJMBziMctBrOWTMbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQ5vJqlDDKFCmkEAmjR7d1uQL7dSdAZWYzQCF8qJIHJ8dP6B+54D1E9sbrSGed+iJ
	 ST4ynHnhc0H/aUlzoOzcBET4B5s84ygIzYFVKtheGmXXD2a6b7eu1YoLDtNDrZDhIq
	 V83SYcCgNXXs1NXIi40U8Y1GLUWs9K6+6TFQJfQM=
Date: Tue, 2 Jul 2024 11:11:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: cassel@kernel.org, hare@suse.de, john.g.garry@oracle.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ata: libata-core: Fix null pointer
 dereference on error" failed to apply to 6.9-stable tree
Message-ID: <2024070208-dazzling-charging-d5db@gregkh>
References: <2024070105-falsify-surrender-babc@gregkh>
 <64b91917-f2bc-48a2-9382-e4045c91dad9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64b91917-f2bc-48a2-9382-e4045c91dad9@kernel.org>

On Tue, Jul 02, 2024 at 06:50:05AM +0900, Damien Le Moal wrote:
> On 7/1/24 23:31, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.9-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 5d92c7c566dc76d96e0e19e481d926bbe6631c1e
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070105-falsify-surrender-babc@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 5d92c7c566dc ("ata: libata-core: Fix null pointer dereference on error")
> 
> Greg,
> 
> I am confused... This patch applies cleanly to linux-6.9.y. The procedure above
> also works just fine. And the "Possible dependencies" on itself does not make
> sense. Bot problem ?

Odd, this seems to already be in the tree, sorry for the noise.

greg k-h

