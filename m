Return-Path: <stable+bounces-83225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310A1996D7B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 16:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17B51F257EF
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7019AD71;
	Wed,  9 Oct 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jny8lTLS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308E18BBAE;
	Wed,  9 Oct 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483534; cv=none; b=nb3c3HO98W3KzHL5qU6yYgydyFpyAQnlLD9hVxQpYxPXDDWhZVTfCDqC0az3PEhUaAWU9/ex8Oxt7HYl+ihoHTgYPH1bRcZ28lC+7ok7fJrgHx/9CAe6a0Qs9ImpsjBUL4dIj2+v/4g3/EOrr4quPXAUZ/UvArr215C2VKSxt0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483534; c=relaxed/simple;
	bh=VBskg2wVfEFkbPB53AfAAzDzNO02s+0TAmdzX//SQS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rD0My1vFSgGBcMhNNQ48hMOoaqKCPdO6U9/7YMQllugafBIN6c6lz3PXvaMst53mIyphOqcWAldR6ZEv6v8ER85YqhNvCqwF20Tv7fgcZQao5z+SptnEc+bWiNiikzknWhZoII4yLnU3FjqW8T9TA9X5qwQ5YLGjRPZilzouiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jny8lTLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C5DC4CEC3;
	Wed,  9 Oct 2024 14:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728483533;
	bh=VBskg2wVfEFkbPB53AfAAzDzNO02s+0TAmdzX//SQS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jny8lTLSc0kPAgazaL3Uq2KTTFs8VllU7bql+ZtlrxlxJkGwcfemEHtc6Nx9vfNuo
	 OWASyn3Nf7OHYhWfvaujJTjLu3XX6KGAS9fhmsgpyQZ+pVgIeyHzn1Yq55DsbgjoYF
	 n6B10hhAQPZaKz1NounvEb5el/JMauoNLh5YGscbd9/XKBdXXYxBuHqbdLjJeIZm3Y
	 Cl4XIT63ynwn0sBnoOgrA3bfSgZjBj66FRooEkRzgNatilHzYzqC0lj6pZUNq7DXCV
	 TXokP530hZGPMGnHRFsMwfSdLCByb1pplk1M9YLwl7uh9KUDGxaW5zkBvCsoh5Qsk0
	 Ov4WQtRhJ+B4g==
Date: Wed, 9 Oct 2024 16:18:48 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	W <linuxcdeveloper@gmail.com>, stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ata: libata: avoid superfluous disk spin down + spin
 up during hibernation
Message-ID: <ZwaQyGkeRNNgLwef@x1-carbon.lan>
References: <20241008135843.1266244-2-cassel@kernel.org>
 <5bd13541-4ac0-4171-b4e5-0dedaa9e88b5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd13541-4ac0-4171-b4e5-0dedaa9e88b5@kernel.org>

On Wed, Oct 09, 2024 at 07:44:31PM +0900, Damien Le Moal wrote:
> On 10/8/24 22:58, Niklas Cassel wrote:
> > A user reported that commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi
> > device manage_system_start_stop") introduced a spin down + immediate spin
> > up of the disk both when entering and when resuming from hibernation.
> > This behavior was not there before, and causes an increased latency both
> > when when entering and when resuming from hibernation.
> 
> One too many "when".

Will fix up when applying.


> With the above nit fixed,
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Thanks!

