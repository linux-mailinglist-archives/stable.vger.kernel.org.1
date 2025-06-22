Return-Path: <stable+bounces-155240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83297AE2EDE
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 10:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEE43B476A
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7219342F;
	Sun, 22 Jun 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A60qfb/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADBC3597E
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750581694; cv=none; b=NRd+MzpFteMPIa6QD1e2ZY8NC+ZaF2buFpW/RNoGOL4kem9nRyoHdCtXY5nIM5tNZJErbA3mgalnWKaCXXPvlMu/uECi2bWRRNSFIQYQlKLSyQMR2QHSPU6k+Omg/Dc907JQTxfOr0vEsRcz2Zn8NTPKQbX83TkyalsHdECBCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750581694; c=relaxed/simple;
	bh=Qb5dswjC43DBQAOwRk1pKhWv15EZUsWBC8stU40Pyp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZA1fwV5BYW4S56bzDDLf9iGIl/FubqKYPJpJSaw33GOia+wmQchWGZw59zm6OoggRM+h4KQE285rHcRXoilYjnyXdSZIjsUF0LQU3umysV5I0VepcxAPFHvBGeDQXPziZ2ehizQm1svWUPRDqW2FW7ghzERgFwtcBJb4l4kWHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A60qfb/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB7BC4CEE3;
	Sun, 22 Jun 2025 08:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750581693;
	bh=Qb5dswjC43DBQAOwRk1pKhWv15EZUsWBC8stU40Pyp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A60qfb/JkzdjXbfixJvqo9JxsxwKllPUX0eqEpsJi8ynPmxs9Vvtv7fMrzy6jzN4P
	 3PdMmoSTgtitOyjDnACtT4I/Jof2CvPMw1yTnEndL3h6sLPGki6DPeo7jOxcVke+7h
	 QmK4ug9dDwDFwKKoPQH0GilC8evrVhTdB02dhX2Q=
Date: Sun, 22 Jun 2025 10:41:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gavin Guo <gavinguo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>,
	Gavin Shan <gshan@redhat.com>, Florent Revest <revest@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] mm/huge_memory: fix dereferencing invalid pmd
 migration entry
Message-ID: <2025062255-turkey-pureblood-72f6@gregkh>
References: <2025051202-nutrient-upswing-4a86@gregkh>
 <20250619052842.3294731-1-gavinguo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619052842.3294731-1-gavinguo@igalia.com>

On Thu, Jun 19, 2025 at 01:28:42PM +0800, Gavin Guo wrote:
> [ Upstream commit be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7 ]

<snip>

In the future, please version your backport attempts.  Trying to dig out
which version is, and is not, the correct one was a non-trivial exercise
on my part :(

thanks,

greg k-h

