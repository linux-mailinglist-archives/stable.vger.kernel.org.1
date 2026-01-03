Return-Path: <stable+bounces-204535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74045CF0349
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 18:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC2C30181B5
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 17:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141F022A4EB;
	Sat,  3 Jan 2026 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rKn0f2nv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5420E005;
	Sat,  3 Jan 2026 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767460896; cv=none; b=E+S5bbONX+MvlSMFmMpVRRQF+5iMIOsqXEVQz0SVr6KOHlxkhnD+uNaayGzMrHi6Jnu6Jdhizi9P+eHHQ7mtrzeqEWmz2Ewer89jU5G52bCaIUovHvPEKEg3FXlkJHJRu2qHbClSaG/hXeuAv7zkWDWoTAzCsfUinMCGXjbRe2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767460896; c=relaxed/simple;
	bh=8g2Dw6uIOtsfBv1nVx2Z8gU4bkanGwDnGDrdnU55rzw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bsSAU2W+888MKW/qcwa3CQ7imzfBZXH1OXgfNhqpCTg2NQ5Uf98z89wIDVmX5azaL7P0XOnfXdU1XbVTvwn6amm0goambyWN8iD6+jeJnZ9Btw0jSeE+k2FxHf4XwNfOZ8Y8pMIpuz30vYCTl4KnXd9fxPTqcM2ydR62beqASxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rKn0f2nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE4BC113D0;
	Sat,  3 Jan 2026 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1767460895;
	bh=8g2Dw6uIOtsfBv1nVx2Z8gU4bkanGwDnGDrdnU55rzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rKn0f2nv/4eptbWKIhMpbZZH0epCG2kCFONoX4QJ6cafcoutg/m81j36MFfouCBvt
	 PJQW9M4kZWdgj7v6OUvVONOZKXpFTi5MebCmzPSnNwnmOAyCLBJi89PsEq1WPAZ2eG
	 oBnpFl7qdqq+9OF41dzv/hWg/MwHafUfn7douioQ=
Date: Sat, 3 Jan 2026 09:21:35 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: "# 5 . 18 . x" <stable@vger.kernel.org>, Jiapeng Chong
 <jiapeng.chong@linux.alibaba.com>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/4] mm/damon/sysfs: free setup failures generated
 zombie sub-sub dirs
Message-Id: <20260103092135.103f1c29166ccb801133e6b0@linux-foundation.org>
In-Reply-To: <20260103002139.66559-1-sj@kernel.org>
References: <20251225023043.18579-1-sj@kernel.org>
	<20260103002139.66559-1-sj@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Jan 2026 16:21:37 -0800 SeongJae Park <sj@kernel.org> wrote:

> > Also, the setup operations are quite simple.  The certain failures would
> > hence only rarely happen, and are difficult to artificially trigger.
> 
> The user impact of the bugs is limited as explained above, but the bugs exist
> in the code for real world usages.  I therefore expected this series would be
> added to mm-hotfixes-unstable.
> 
> Do you have any concern at treating this series as hotfixes?  If not, could you
> please move this series into mm-hotfixes-unstable?

Sure, I have made that change.

