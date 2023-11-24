Return-Path: <stable+bounces-304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E40477F787E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754D0B20C8D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1DD3309A;
	Fri, 24 Nov 2023 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XXKfoj9e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C956F3308A
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D259AC433C7;
	Fri, 24 Nov 2023 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700841799;
	bh=Xbv2YQUV1GLAM7/VjlVRIIhik4WoZgE2mGIx3fwAybI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXKfoj9esrjRdAzOsEQVbeIqhQA+R8Lumsy4x+QMGiq4MhdGjKFSmGmwWtf/QJCUR
	 gHwgsJTQXOyPXlkbue5GDGYHivMcQWCdBt1NGgEN7v7qX3CQbtqfqWtdDQz6UBKoJP
	 DNZ+Le0vLUjSmvRF3KsOKKsf2pNH22wJrTsd+J20=
Date: Fri, 24 Nov 2023 16:03:16 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	matoro_mailinglist_kernel@matoro.tk
Subject: Re: Please backport feea65a338e5 ("powerpc/powernv: Fix fortify
 source warnings in opal-prd.c")
Message-ID: <2023112409-undusted-grasp-e11e@gregkh>
References: <87edgl72ky.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edgl72ky.fsf@mail.lhotse>

On Mon, Nov 20, 2023 at 10:20:13AM +1100, Michael Ellerman wrote:
> Hi,
> 
> Please backport feea65a338e5 ("powerpc/powernv: Fix fortify source
> warnings in opal-prd.c") to the 6.5, 6.1, 5.15, 5.10 stable trees.

Now queued up, thanks.

greg k-h

