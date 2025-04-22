Return-Path: <stable+bounces-135031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FD5A95E24
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F4B178025
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1731FA262;
	Tue, 22 Apr 2025 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="szExnW2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0201F4CBB
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303268; cv=none; b=l8x55DN7e45TJLAqVfNhCYZ5X6W7BBz/11GKPuvipNq2KETeGpQIK2ee6EHc3N2h1+UYXflQvrzSLvh3kpSAPDcppZBHeiGor8dXhhNzV80JH+BOl0zIVIJbFk/i75gSbJDjDPgV9F9vfmaumIxwfBMyFnTy4fR0pERzGnlDVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303268; c=relaxed/simple;
	bh=BPilZrFD+F/xsQLNas41i6uz8EFGR8RRTWS3ra4Kx8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNtSgx57tU92neP3XoiFQ2SkMjTbirAhLW+gDSklDJC7QP5FUqjpozE5FrIGSkedFrIWFLYJTemhdAoIl39FeGMxvJubWAmLXdWcHTxCq/KrF6DzmH8fcLXM7Qnv/JuK13FDSqwja6YollNQX1jL5Rk96HSeOPVBAfk9F5khISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=szExnW2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9B2C4CEE9;
	Tue, 22 Apr 2025 06:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745303267;
	bh=BPilZrFD+F/xsQLNas41i6uz8EFGR8RRTWS3ra4Kx8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szExnW2chQfkeZ+nngfQ5C4OSKF15/0YwrYU4Gy3iVtri5GK2KaePXCPmNnu18lhi
	 DplhieF2nFjE0X54ZJ5BSOZ9bkbO0Qv1bXIzb0wPoxjobhpUU+1dTQVBhx6lbreeE5
	 BLI3sTqjQe3m47HUlatM4bV6qoYMbvOMp4VQI6ZQ=
Date: Tue, 22 Apr 2025 08:27:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Liu Xiang <liu.xiang@zlingsmart.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: Please apply d2155fe54ddb to 5.10 and 5.4
Message-ID: <2025042237-express-coconut-592c@gregkh>
References: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
 <2025042251-energize-preorder-31cd@gregkh>
 <CALW65jbNq76JJsa9sH2GhRzn=Fe=+bBicW8XWmcj-rzjJSjCQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65jbNq76JJsa9sH2GhRzn=Fe=+bBicW8XWmcj-rzjJSjCQg@mail.gmail.com>

On Tue, Apr 22, 2025 at 02:10:53PM +0800, Qingfang Deng wrote:
> On Tue, Apr 22, 2025 at 2:06 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > All mm patches MUST get approval from the mm maintainers/developers
> > before we can apply them to stable kernels.
> >
> > Can you please do that here?
> 
> Sure. Added to Cc list.

They have no context here at all :(

