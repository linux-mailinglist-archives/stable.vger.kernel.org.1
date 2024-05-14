Return-Path: <stable+bounces-45072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BB68C55D9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 14:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DEA51C21E22
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8954B3B1A3;
	Tue, 14 May 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZ5gaZsP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB652943F
	for <stable@vger.kernel.org>; Tue, 14 May 2024 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715688799; cv=none; b=X9+MiwKJp0a09WZiQSNQvf+4gMK9i79b41yr5CDIYy21ebkWJokYSxODg4qVqku0c7PNk5Pwn09CBXiHvycH8cyE4dQ0RtNjY78N+hKFM7LxiYz75QziTGuQBh+wfGq1sL3VXfywlSXm/wGtBtTH3z6biGIb3mxG/chRAtAQntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715688799; c=relaxed/simple;
	bh=5hiF9FxEgrW/EzTlBTesFGe4n6mn1iseQrcYBIMf1jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYQw8Hkgh/12gmRkvspeF0hUFFPiuQNzz8/gnzlL+4Cff2e3n8m4zJ3ypU6XnuG1OB3J+xooS/am0SE+QdEwsg92L/sFhWJ4m/ziHt86oo4kKAbtyr2cpEjz95VghyG05gwrYG2OrmhfCCVtgqDJ0ecsp8B0GbUVnMNerF1VaH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OZ5gaZsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4F0C2BD10;
	Tue, 14 May 2024 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715688798;
	bh=5hiF9FxEgrW/EzTlBTesFGe4n6mn1iseQrcYBIMf1jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZ5gaZsPFY9LtZASYkuchnwF3K7eY2onOgmOvR5ZgVn4u2QxlpVXbePfFFCyi8Zbs
	 TrbI35fstccAlZ3K/3P3c0KokEVBJsSzpMBSv4KZI5+I32lY7yhR4qD/bES/gyPyHg
	 +FRmWdaoKDgAe++SjEIMdnbUTmXha1AXtuKr+xy0=
Date: Tue, 14 May 2024 14:13:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronnie Sahlberg <rsahlberg@ciq.com>
Cc: stable@vger.kernel.org
Subject: Re: commits for stable 2024-05-11
Message-ID: <2024051424-twice-risk-55d9@gregkh>
References: <CAK4epfysW+3vA9BM94iQVUaH3k-DNoyHAwUeYaCeGdbZ3dOyQQ@mail.gmail.com>
 <2024051256-joyfully-unframed-dd66@gregkh>
 <CAK4epfxK+6otyj-N5mdQuPtPAKtqJzc2vUgBS+_idHDL_Lf=0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK4epfxK+6otyj-N5mdQuPtPAKtqJzc2vUgBS+_idHDL_Lf=0A@mail.gmail.com>


For some reason I can't quote your attachment.

But I looked at one random commit:
	bbc094b3052647c188d6
and that obviously is not for stable inclusion.  So while keywords are
nice to search on, doing a pass "manually" is needed as well as
sometimes those keywords aren't bringing up what you think they are :)

thanks,

greg k-h

