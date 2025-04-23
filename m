Return-Path: <stable+bounces-135247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3CBA98153
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 09:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8193E17AAC1
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0B4264FBD;
	Wed, 23 Apr 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OwvRxTPr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2162580E7
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394052; cv=none; b=uH8uA6ktqnfAfkWMkmkrFzY2C+Ra0hCv5r421Ted6pKFg+/oaWmRExXlOa6K2pZ/UdAF2yp1YLch5sh1pl8FI+pyRLFu2+SopWBC5QGKZG2M8rRZ9ffu3HhvnCExwQoHPnCE11Mv6JPUvpYCGjwFMoI+dH5X6VBKcPTyuHrBkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394052; c=relaxed/simple;
	bh=qoca2CpMWyZds2Uu5EB4ZL2Mdcm9BXqt/2Ih1pHZvFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUlCZACZ9kwO3fY/SeTTeZTYjjmBTj9RSyACpkJNGfAHKGEd+JCxKxU2ceEbaL50Jb8o29SF/wjSBE+PBSFiIWrG9Bn3H+1DdPeTjEaoIRdyTNpcltyeZtLcZUgBatQNyANer3dwECPEQi+RBxqrNufcf7zZQ4mn69mbd97ui2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OwvRxTPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F9DC4CEE2;
	Wed, 23 Apr 2025 07:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745394052;
	bh=qoca2CpMWyZds2Uu5EB4ZL2Mdcm9BXqt/2Ih1pHZvFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OwvRxTPrEExefIPqjThVC2o8/ZBigYRy/ETdFCHd+8PECHHDX1QHBSUFHNL34t48n
	 nvUM0shoftgIf0ofr3WkoN7KTyNdNohBothlz5eXsibTyLz0TYI52B91umcnPpfLv8
	 q0rS2FVrFPX9LQDx6NRBfQ9uyAzysLEig0u/iDzU=
Date: Wed, 23 Apr 2025 09:39:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Liu Xiang <liu.xiang@zlingsmart.com>
Subject: Re: Please apply d2155fe54ddb to 5.10 and 5.4
Message-ID: <2025042306-perfected-retake-80d3@gregkh>
References: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
 <2025042251-energize-preorder-31cd@gregkh>
 <CALW65jbNq76JJsa9sH2GhRzn=Fe=+bBicW8XWmcj-rzjJSjCQg@mail.gmail.com>
 <2025042237-express-coconut-592c@gregkh>
 <CALW65jbEq250E1T=DpGWnP+_1QnPmfQ=q92NK8vo8n+jdqbDLg@mail.gmail.com>
 <7bf68ddd-7204-4a8c-b7df-03ecb6aa2ad2@redhat.com>
 <CALW65jaLXR3rjcTZN-uojuym6uCT8pMRnTHoY_OqCWJ+Yq0ggw@mail.gmail.com>
 <2025042256-unnerve-doorway-7cb7@gregkh>
 <CALW65jaXh=0+MkkNWHG9PpcDA88zBR5-S3j=pYbMZVcQ19hvag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65jaXh=0+MkkNWHG9PpcDA88zBR5-S3j=pYbMZVcQ19hvag@mail.gmail.com>

On Wed, Apr 23, 2025 at 03:37:39PM +0800, Qingfang Deng wrote:
> On Tue, Apr 22, 2025 at 8:41 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > The commit looks harmless. But I don't see how it could fix any warning?
> > > >
> > > > I mean, we replace two !list_empty() checks by a single one ... and the
> > > > warning is about list_cut_position() ?
> > >
> > > I have no idea, actually. Maybe the double !list_empty() confuses the
> > > compiler, making it think `sublist` can be referenced out of the
> > > scope?
> >
> > That is odd, are you sure this isn't a compiler bug?
> 
> I think it is a compiler bug. If so, what should we do to fix the warning?

Fix the compiler :)

