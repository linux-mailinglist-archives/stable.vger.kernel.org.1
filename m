Return-Path: <stable+bounces-76186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED0979C3C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6CBFB22A18
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916CA13665A;
	Mon, 16 Sep 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLiwVIWb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA86360;
	Mon, 16 Sep 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726472946; cv=none; b=Hm3DD+1d2eqgvon1jwj+9o9M58eHT+JgKQvZeErFXGMcTdC0gzvERlWsNx0gITZ8Ozni3hFPeZ1jPVQYt6G9lu6m7g7SEx371mMU1SuDlWuSSAIWKn6Vd49fjzE3vcwHhV3vnstb+dhXW59cjYrDA6QgAYvBkstjligdE56LOl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726472946; c=relaxed/simple;
	bh=UxJDOLsIkLKE+S+2zQRowyEzhpxzfeo5mHf7JBjYlpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znd0kMu1UDT2USAOlkW/lXkkjoJt26jh8QfsQDo9lvnmExnSKrkvrnsSsVejj9PtSbRKljgcJLrpWISmr8zu90GVFMOTXZhZxPJignClH1Kn8LtZ7BdT2AhuiebQMoDB6NrnUyNzOc0P9mUCk+U9+Xud+E71jzlvC5KBgJbcBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLiwVIWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDBCC4CEC4;
	Mon, 16 Sep 2024 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726472946;
	bh=UxJDOLsIkLKE+S+2zQRowyEzhpxzfeo5mHf7JBjYlpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLiwVIWboheUTjYnjo+YcyYUOd2Ccf5RUJlcmBAC7+IBv+vEEy7RCSMKl8yPLEVu0
	 XXeIcoDSi2SK0KM8ZkPq5a7coN2F4KZx6qsjGn7mdEDJuuLR6tLXhmSOu1ofnQX5hW
	 8E7B5dkg5MOJOZCk00cN0F5BmptWOFolLr1mSmGfLAq9jjZvYx127X56+e68K4kcs4
	 LbIYxTJ88fGXJ7pgmX0ME2tthjyNbyxHD8ZriOTOOBg8sSlfYB9xQFianwN18sbjnF
	 AzAir8VTrZGARYMOKGxv57Ju2OQbxf5igqdUZSxLno6Ud/yygZVEDn0RL9NxXKFzLe
	 GCqG8dag7BBOQ==
Date: Mon, 16 Sep 2024 09:49:03 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	krzysztof.kozlowski@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <Zufi79wdsMokxVB9@vaman>
References: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
 <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>
 <2024091130-detail-remix-34f7@gregkh>
 <ZuQnPnRsXaUEBv6X@vaman>
 <ZuXgzRSPx7hN6ASO@vaman>
 <2024091555-untitled-bunkbed-8151@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091555-untitled-bunkbed-8151@gregkh>

On 15-09-24, 15:23, Greg KH wrote:
> On Sun, Sep 15, 2024 at 12:45:25AM +0530, Vinod Koul wrote:
> > > > 
> > > > Is this in Linus's tree yet?  That's what we are waiting for.
> > > 
> > > Yes I was waiting for that as well, the pull request has been sent to
> > > Linus, this should be in his tree, hopefully tomorow..
> > 
> > It is in Linus's tree now. Greg would you like to drop commit
> > 6fa78e9c41471fe43052cd6feba6eae1b0277ae3 or carry it and the
> > revert...?
> 
> I can not "drop" a commit that is already in a realease for obvious
> reasons :(
> 
> > What is the usual process for you to handle reverts?
> 
> We just take them like normal.  What is the git id of the revert in
> Linus's tree?

Sure, makes sense. It has been auto-picked so this is fine.

fwiw: 
ab8d66d132bc: soundwire: stream: fix programming slave ports for non-continous port maps

Thanks
-- 
~Vinod

