Return-Path: <stable+bounces-94012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554599D27EB
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2CD28110F
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D31CC17F;
	Tue, 19 Nov 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2G08xEXt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA343179;
	Tue, 19 Nov 2024 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025865; cv=none; b=UUJA8CJSmAx/2a3B+7h5osWriyroyUPBS63p2yZGxhbB80CaD6mgVGcXBR2RNEjr+8uSvszPihF/NCNO6VbZZXhUnyi1rVCGyz9Mjsijvm4OyOfZuvXoT+H7jznztxiJKfEGoTANzs1gXJca/5j1pyROla0bSSq87OIlrBEXvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025865; c=relaxed/simple;
	bh=q1lgj98oD4uNwPtv+m1HjwuIp7uRDVxEFx5Up5x8CF0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJTfanTfMC5eIdoo9HFINReZ2W0yJDEZ4vOykkzrp38nwE+Sg5wbIKYln+LUFfTFqlgMYJ+ULw1NpgONSSvwwU0ewHSS+/964KQ5tIBYEI5imuYqqgVABFfSd8qmGwR5YB8ABIAFs+g991IKJDgj4U3mUlU+l5Wi2/ynZ/akChc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2G08xEXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FBCC4CECF;
	Tue, 19 Nov 2024 14:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732025864;
	bh=q1lgj98oD4uNwPtv+m1HjwuIp7uRDVxEFx5Up5x8CF0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=2G08xEXtVfeLjPCCYeEv5p5vBo6jVJq60GLLNRGX2J2mozz1cEAPrq9JHOUfJEwcT
	 gxws05q71pvzzi+TAlPvhgPukaO3xP1Kfer4AM9MhFwxCGFymVXqPD2o0mJ6NKLtOy
	 6jLkId2xrum9Kui6+LQgFzEM56CGc5YdTLhDXvLk=
Date: Tue, 19 Nov 2024 15:17:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Jann Horn <jannh@google.com>,
	syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com,
	Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] mm/mmap: fix __mmap_region() error handling in
 rare merge failure case
Message-ID: <2024111935-tabasco-haziness-b485@gregkh>
References: <20241118194048.2355180-1-Liam.Howlett@oracle.com>
 <qmmd4lujbzwyhxmjf3wagmfakbirjleufgkh6ozh5wbled3zp7@2z6trp6xlci7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qmmd4lujbzwyhxmjf3wagmfakbirjleufgkh6ozh5wbled3zp7@2z6trp6xlci7>

On Mon, Nov 18, 2024 at 03:32:14PM -0500, Liam R. Howlett wrote:
> Okay, before I get yelled at...
> 
> This commit is only necessary for 6.12.y until Lorenzo's other fixes to
> older stables land (and I'll have to figure out what to do in each).
> 
> The commit will not work on mm-unstable, because it doesn't exist due to
> refactoring.
> 
> The commit does not have a tag about "upstream commit" because there
> isn't one - the closest thing I could point to does not have a stable
> git id.
> 
> So here I am with a fix for a kernel that was released a few hours ago
> that is not necessary in v6.13, for a bug that's out there on syzkaller.
> 
> Also, it's very unlikely to happen unless you inject failures like
> syzkaller.  But hey, pretty decent turn-around on finding a fix - so
> that's a rosy outlook.

Why isn't this needed in 6.13.y?  What's going to be different in there
that this isn't needed?

Do you just want me to take this for the 6.12.y tree now?  I'll be glad
to, just confused a bit.

thanks,

greg k-h

