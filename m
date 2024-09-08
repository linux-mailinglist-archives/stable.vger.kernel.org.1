Return-Path: <stable+bounces-73924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38CE970834
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 16:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7CA281F74
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE04171099;
	Sun,  8 Sep 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ejHhZXTY"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A756167296
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725806645; cv=none; b=X92dQRUgabRzjKWPP0levo6xL9IhdyL+mi1L1Gi1udFIZgGloB/DABzo+ivkt4uUwYFA8eaZsq9ILDrDn81DXijPvYqvo2jq2fBArbRwv1YgU87GG5ybE6RnEczHvjNvhg5nAIb4/zRPpm1Jaz5aR0Ks57dcbAPBz00AdmN3RqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725806645; c=relaxed/simple;
	bh=N1Hro8V3wXSWs2p1oR8dw+lq2prsli+Y6hwGbLra7U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7nCW9jla04C8sFm00PyR/6otriovGqZeg5iLeJ/kBczxIxOLdN4liZcyGfyG1yNGifxF5ROHy9PNLoIwEASOrwNpBshWojIdZwo8M38MUIBxTbqC4ijbyQnmE9f9T6F0dMkc6rl3Z+ApmcYveOdpLVvcq6QQjQMMW+J0vCVN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ejHhZXTY; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 8 Sep 2024 10:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725806638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jvUKlw8Sv/Jt+tRqefd+arkePbOLnyN0Bb7XEA14Tr4=;
	b=ejHhZXTY+IRQIb48B2mriAwhKnka4R4gFmELgUArQv7AeYRGPDKewuwC+qIPOii/4IuRTp
	h/uo2H5hZQIqd/+R454nxcOk7LvdgHCn734tZvnaN6wZdgnJ7vdGUdA7wWTrKwPKLE1yRn
	yE01XvRkPjOBZi5Tvd1oQvglwVFiVS4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, tahbertschinger@gmail.com
Subject: Re: Patch "bcachefs: Add error code to defer option parsing" has
 been added to the 6.10-stable tree
Message-ID: <nhhb74exmbeut37exka6s3sfajnn544x2lnz6xzbspntdchgmq@hxfe3b76e4p6>
References: <20240908132559.1643581-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908132559.1643581-1-sashal@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sun, Sep 08, 2024 at 09:25:58AM GMT, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     bcachefs: Add error code to defer option parsing

???

Sasha, this and the other patch aren't bugfixes at all, they're prep
work for the new mount API, i.e. feature work.

Please just drop the bcachefs patches from stable entirely; the lockless
IO patch revert is a fix but I'll be sending that with a couple other
fixes in a day or so.

