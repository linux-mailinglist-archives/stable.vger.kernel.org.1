Return-Path: <stable+bounces-80752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A267990605
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1062B1F226B4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9D2178E4;
	Fri,  4 Oct 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qmQLn0IM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D87B217337;
	Fri,  4 Oct 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052003; cv=none; b=bW/pPj+TEenrFReGM39bihK2iqWhjKwW8VTAy1DtptJdDqM3LyNMnGw0M9bkRxWUSEWa75iTX6hoeU7+GNGJxV5OCHbkrapSRBpY/nqoLaZVrIAN3LnDWHAwAPLjPaoCF8dqXCYLd2KkFVyZQzl/JheQgVXADvMO+H1e/IqwxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052003; c=relaxed/simple;
	bh=+ti9K+32pQI1y8rcF29ooClB5gUnpQ7/Uklnj9C2cuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idVsNftNTQsngtZjU6OPuFfCarO1ORtFhChiZMl3BlMnQVibPd2fbtWo4IiXeI/xqSvpb93mgGnfNsfFq/ONCt0+Wc2IwqAdBIWVIoFd80o8jUNXzTtexkq1HNxpD+oLcOhNTVn+wW4PnxpyzepKc1U+nEMWESVS9MJCgup60PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qmQLn0IM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C3EC4CEC6;
	Fri,  4 Oct 2024 14:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728052002;
	bh=+ti9K+32pQI1y8rcF29ooClB5gUnpQ7/Uklnj9C2cuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmQLn0IMamgFaVl69uhLndRs1GxrOnDUr1xJp4y1YYQl73oZWyB0b2F3yS6cy4hwh
	 Y1A9RmWPg6ULRzGgvCLOxdXwgMdrsf4LqZC7bh4yZyU+er7MowiLL2v5uNIyxpsOFr
	 i57QuZanU581fdtCyw9ypyrlvvGaqO2m4al2ibnc=
Date: Fri, 4 Oct 2024 16:26:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Youzhong Yang <youzhong@gmail.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	linux-stable <stable@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	Jeff Layton <jlayton@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 397/695] nfsd: fix refcount leak when file is
 unhashed after being found
Message-ID: <2024100430-finalist-brutishly-a192@gregkh>
References: <20241002125822.467776898@linuxfoundation.org>
 <20241002125838.303136061@linuxfoundation.org>
 <CADpNCvbW+ntip0fWis6zYvQ0btiP6RqQBLFZeKrAwdS8U2N=rw@mail.gmail.com>
 <2024100330-drew-clothing-79c1@gregkh>
 <A8D6C21F-ACAD-4083-900F-528EB3EB5410@oracle.com>
 <CADpNCvbKGAVcD9=m_YxA6qOF6e0kohOfVsKOqJeVmrYaq0Sd8w@mail.gmail.com>
 <2024100420-aflutter-setback-2482@gregkh>
 <CADpNCvYn9ACkumaMmq7xAj6EQuF6eYs174J+z81wv5WqzdWynA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADpNCvYn9ACkumaMmq7xAj6EQuF6eYs174J+z81wv5WqzdWynA@mail.gmail.com>

On Fri, Oct 04, 2024 at 10:17:34AM -0400, Youzhong Yang wrote:
> Here is 1/4 in the context of Chuck's e-mail reply:
> 
> nfsd: add list_head nf_gc to struct nfsd_file
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e6e2ffa6569a205f1805cbaeca143b556581da6

Sorry, again, I don't know what to do here :(


