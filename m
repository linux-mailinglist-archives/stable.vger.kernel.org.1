Return-Path: <stable+bounces-40569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEF88AE396
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED831C224C3
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 11:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D2E7C6DF;
	Tue, 23 Apr 2024 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TukaK27Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F027CF25
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870698; cv=none; b=bDmH++AvG0oMs/euoyWBUjGF7bDsa+BHz81ALH0QEcG0MoSeep/qQeMpZXg7ydoYV+ud5VOcGacHHJgy+6eukFQIZMjqiU3XbQuNRPOpI8IXND191tLNYcTRbGmOEyrV7zteJ1StoEp5D6ktdjepQxhxUPI2TiOPjxwXYlI3sxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870698; c=relaxed/simple;
	bh=gThAD2Q+u0Hmny1E2Q9m0P8qdPTR0otQANlYGWIrVBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwAiX4NTPkqHKfYy0RouDQRsBFJ/JBiF+wkzFosBx4GYsXZ1QwPu4ucD1R7tV0kN1IFXAGIHsC6S4mU/XQLUi6y6ue4gPP2vPNIJZbTrkYFFWakO7L59I+0CU7PGBzWGZLAn1gCv56SM7AU9P66weCwRlB8U9m/CBPsw3PuhZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TukaK27Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE26C116B1;
	Tue, 23 Apr 2024 11:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713870698;
	bh=gThAD2Q+u0Hmny1E2Q9m0P8qdPTR0otQANlYGWIrVBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TukaK27ZYyCqerilrUMSBbIDyLzB1kiFxlxPChhz0qK3GSaQ1xKAweBLw0rp7D/mY
	 WOJvUxyNUIruczfjC3v07vHEpROEpM2fvKW3hIgkMzJQ9iFqUVITgKsxRt8d4jGw94
	 zfQ6VsLZ5KiVT7MxGnsOK50FQRQE6CCmBy2W5CTA=
Date: Tue, 23 Apr 2024 13:11:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhulei <zhulei_szu@163.com>
Cc: ap420073@gmail.com, davem@davemloft.net, jbenc@redhat.com,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: 4.19 stable kernel crash caused by vxlan testing
Message-ID: <2024042356-launch-recapture-4bb1@gregkh>
References: <715eaf46.7523.18f098372d3.Coremail.zhulei_szu@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <715eaf46.7523.18f098372d3.Coremail.zhulei_szu@163.com>

On Tue, Apr 23, 2024 at 01:52:40PM +0800, zhulei wrote:
> Hey all,
> 
> I recently used a testing program to test the 4.19 stable branch kernel and found that a crash occurred immediately. The test source code link is:
> https://github.com/Backmyheart/src0358/blob/master/vxlan_fdb_destroy.c
> 
> The test command is as follows:
> gcc vxlan_fdb_destroy.c -o vxlan_fdb_destroy -lpthread
> 
> According to its stack, upstream has relevant repair patch, the commit id is 7c31e54aeee517d1318dfc0bde9fa7de75893dc6.
> 
> May i ask if the 4.19 kernel will port this patch ?

Have you tested to verify that it does work?  If so, please provide the
working patch because as-is, it does not apply to 4.19.y at all.

thansk,

greg k-h

