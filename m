Return-Path: <stable+bounces-77901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 201F2988372
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 13:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AAB1C2289C
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177B3187869;
	Fri, 27 Sep 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L1iYMhVT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01B134B6;
	Fri, 27 Sep 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727437596; cv=none; b=nbKd/kEbqC7KxSyJYIitZF1FEQnmG9NhzxByRMwl6GrkGinquwyjDEB9/+MH0GSbXcFAD4+aM3mXGzj+BO92nl90aSZvBc2pJJxN3fslolZ8YvnFNjjFE+LGgf+AbQizdlt1uhmRsPr+Z1JH/HTwJ6qqtjIDjj87kZkEEbJWisg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727437596; c=relaxed/simple;
	bh=dStRcOI3wRHGwyPOMAjhcXhP+7MbUeEwmd89EjykG3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AatBpcPVjUUXWlE2KCee7OwzM/F7JR9/E6+Xyjx2C5eVdnq5tnnsiz1Uw/oEpcSUu6/UZw+2k5P2i48HAVGomr0SRHicb59pi8VR33Z8MHb4HEji6TpGeUtu1qB8JF9Fwr2OuPuIig6hKuq0+W50T7F2LEw21duQbQ7LoFyEyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L1iYMhVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B5C4CEC4;
	Fri, 27 Sep 2024 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727437596;
	bh=dStRcOI3wRHGwyPOMAjhcXhP+7MbUeEwmd89EjykG3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1iYMhVTsVsFAVRObZoQwFFyAkbLZSsAPY47XLzojb2uD0JyIKmbeT5jLwQfaxszo
	 weXCeJ6QpV9PkpwsWbuL11FjIJfoA64ErU5i7sT4wtth0L/FyIApV5fdCR3Y4Q7Gen
	 odtMoQxUpaa0MmmHb1jHR5+/MLos4DUOQxI0FxSc=
Date: Fri, 27 Sep 2024 13:46:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shivani Agarwal <shivani.agarwal@broadcom.com>
Cc: stable@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, jpoimboe@redhat.com, sashal@kernel.org,
	Shivani Agarwal <shivania2@vmware.com>
Subject: Re: [PATCH 0/2 v5.10] Fix CVE-2024-38588
Message-ID: <2024092727-kinetic-syndrome-fca3@gregkh>
References: <20240925065324.121176-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925065324.121176-1-shivani.agarwal@broadcom.com>

On Tue, Sep 24, 2024 at 11:53:22PM -0700, Shivani Agarwal wrote:
> From: Shivani Agarwal <shivania2@vmware.com>
> 
> Hi,
> 
>  To Fix CVE-2024-38588 e60b613df8b6 is required, but it has a dependency
>  on aebfd12521d9. Therefore backported both patches for v5.10.

All queued up, thanks.

greg k-h

