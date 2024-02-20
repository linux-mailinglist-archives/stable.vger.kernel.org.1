Return-Path: <stable+bounces-20845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD7685BFFD
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 16:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12FDB22AAB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF37602F;
	Tue, 20 Feb 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GjHjN/e/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979136A35B
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443192; cv=none; b=Ebzj5Aeq0NSMn1O/OZXlNVEfXoHxeg7CTzcja0PRtJ8xpTspfB+WqkwtDyOn+OfVR356TystgfPG0OpCOYxQ5NV1KNGudKO8D4l0Eu1V0Vec0pXs4Oo9ZtV7jFsS1zbAQ/uCYIvu34yGbNeqLGZAk/ZvDbSzkv+L2j/SGOOAC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443192; c=relaxed/simple;
	bh=ETHZ6lpzXCsHhiWsxxIwp75RUAj4Up5weXzI69QBuak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRYTNc5sUpKjZUkviqqMNqm0kpA6qVJBOZzrF/j12Jk8jd9F4kUhrFXNiXKBM6OLVaNH8nnr1GjbAcqc3OX6zKzfjuGZh6fcR1bxd0k1KapvYZAUE1kRK5I+fYrzOCqyerydrbAcdayE7UmudqdEQNCfe7bbRUd5zSxv2ZexJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GjHjN/e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E28C433F1;
	Tue, 20 Feb 2024 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708443192;
	bh=ETHZ6lpzXCsHhiWsxxIwp75RUAj4Up5weXzI69QBuak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GjHjN/e/pmUdMtw94s0VLK5F3kJSiXL0IgrH9E6rXOQv6elrixWF+MtyS9ho7GAYI
	 g0Ncscfs1kClG31y7BZ4hVjmdwTKX99Uuzn6n3LqOit34D3fVbiXICSl/X+5jdyCAf
	 UcRpnb6CQ9EW+fPonSUvMnHxvdB5C/X/0PSUo9No=
Date: Tue, 20 Feb 2024 16:33:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"Saleem, Shiraz" <shiraz.saleem@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1.y] RDMA/irdma: Ensure iWarp QP queue memory is OS
 paged aligned
Message-ID: <2024022003-rocker-craftily-9cb6@gregkh>
References: <20240207163240.433-1-shiraz.saleem@intel.com>
 <Zcj1JyNJww8njJFv@sashalap>
 <SA1PR11MB6895D85EBD4BEFDCEC57AAD286482@SA1PR11MB6895.namprd11.prod.outlook.com>
 <2024021314-predator-scientist-84cd@gregkh>
 <SA1PR11MB6895AE19B8C02FAD9A84BE58864F2@SA1PR11MB6895.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB6895AE19B8C02FAD9A84BE58864F2@SA1PR11MB6895.namprd11.prod.outlook.com>

On Tue, Feb 13, 2024 at 04:20:21PM +0000, Marciniszyn, Mike wrote:
> > 
> > Is it needed for 6.1.y or not?
> > 
> > confused,
> > 
> It is needed.
> 
> Its just the Fixes: tag is incorrect because 6.1.y branch lacks the commit indicated in the Fixes: tag.
> 
> The upstream version split a large routine up for clarity.   The 6.1.y branch contains the pre-split code so the patch needed to be ported into the old larger routine.

Now queued up, thanks.

greg k-h

