Return-Path: <stable+bounces-197098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7002AC8E668
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BE7E34DB86
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F682192F9;
	Thu, 27 Nov 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ECLtzA3r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423E13A244
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764249467; cv=none; b=JQ2m2tUaaZO8WGx28aQTcB+xJvlD2JF1RYsJyv/K9Yi+Q7SmqrCwQD/zyiK97CSYy5Fl0iyNiOcgFB8v/zhwnyYeEoYwbLBiVa+iDJ8v6rZVphwhhml9OU9We4oQkNTgR4pP7MkM5qNgDFLnPWuUqStbkdhDNKD2kqsevKNJluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764249467; c=relaxed/simple;
	bh=zpFGDCcqNPoErL6n7HG6llHltF+hmLw2B4HPwmSZd6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuL5wpRmugTxFgjfzGK4mWr3TTBQuPVn3whvQM5E1V2eRwYeJAyt5uv3N6/2WfOIlJAXBu7EPuGWnGjg9zWieWPSTBauxAXH7CVKn3hCVHzXiRRgbJEjzfnqNQOXuyzXfIL/ASPKgUPLiX8L6I2IVu0IAQlJQVdCC0qpLVqxi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ECLtzA3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E30C4CEF8;
	Thu, 27 Nov 2025 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764249466;
	bh=zpFGDCcqNPoErL6n7HG6llHltF+hmLw2B4HPwmSZd6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECLtzA3rDgcVAIRJDRpDK39e3hGzFNU01f+AVECS0jlWpKXHdyXzDM7RtMQA50A24
	 sP3BkcYPC4S4fI/dQv7hD9st8QWf8niXOTp9oGRhRmPW0ysQ47ok7/yq9Qf5Itt6+K
	 IM+mn+FX8roI4nPAuLH1Z4IZnLa5GFbvrFIfE03E=
Date: Thu, 27 Nov 2025 14:17:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Christian Brauner <brauner@kernel.org>,
	David Matlack <dmatlack@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samiullah Khawaja <skhawaja@google.com>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.17.y 2/4] kho: warn and fail on metadata or preserved
 memory in scratch area
Message-ID: <2025112728-shredding-amendment-79de@gregkh>
References: <2025112149-ahoy-manliness-1554@gregkh>
 <20251122045222.2798582-1-sashal@kernel.org>
 <20251122045222.2798582-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122045222.2798582-2-sashal@kernel.org>

On Fri, Nov 21, 2025 at 11:52:20PM -0500, Sasha Levin wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> [ Upstream commit e38f65d317df1fd2dcafe614d9c537475ecf9992 ]

Oops, it's this one really that breaks the build, not patch 1/4.

thanks,

greg k-h

