Return-Path: <stable+bounces-93030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD119C9032
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 17:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F94B44B3E
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA82166F25;
	Thu, 14 Nov 2024 15:56:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C781684A5
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599806; cv=none; b=L826olS3BsqYstsN2EhqFFE+3sGJIjczYQT3TywToCCZlm5so0BMTe9puZgfRTpd7bu/8l0bVo9YE5cldAAUBw69PSLA6GuSTu0ZEMm+bBbUJBRR4GIeTOkobTHlilknU/tWa6jwGLLe8kPXBcAPDx1WXxSW4ott6RDDW5sdHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599806; c=relaxed/simple;
	bh=5z1Z5h5GpYLzNNJ3+bd/sgX3DqRKicC7hgHgwS9l/5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKs12aXaeoF+5Ot/0W2GZB2Fajl1Im1fo+jRRaZwfX0qJNe3wv9HzuXJPbMv22+dHgxuPMyOQrYN/p/tdBu8JAXTlZtRVvhOSAP7XNBLeEqpZiuxaU+RTQONkMnOGbI0qHV9RWfStp3O/LX612VqSpd+Fqdz0MR7TB4jPUI/DRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85F5368C7B; Thu, 14 Nov 2024 16:56:39 +0100 (CET)
Date: Thu, 14 Nov 2024 16:56:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Holmberg <hans.holmberg@wdc.com>,
	stable@vger.kernel.org, Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 5/7] xfs: fix off-by-one error in fsmap's end_daddr
 usage
Message-ID: <20241114155639.GA522@lst.de>
References: <20241114153353.318020-1-hch@lst.de> <20241114153353.318020-6-hch@lst.de> <20241114155535.GM9462@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114155535.GM9462@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 14, 2024 at 07:55:35AM -0800, Darrick J. Wong wrote:
> Er... I'm not sure why you're sending this patch to Hans and stable but
> not linux-xfs?  Also it's already on the list, though nobody's responded
> to it yet:

That's because git-send-email has completely stupid defaults.  I picked
it up as a baseline for some of my fsmap, and it just added random
Ccs :(


