Return-Path: <stable+bounces-77078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B284C985314
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 08:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5405F1F2175C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 06:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B14155385;
	Wed, 25 Sep 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IaWassz3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F14C91;
	Wed, 25 Sep 2024 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246617; cv=none; b=D4kptBZpRL2ApWCq6grznG3HYVj+odRDjHlApL/I7jKTcTwxz4lA+tY0NMEt/z3kIwSmpAlOTj18UN3pFZLXoJfG0gNygJq2ezpc25+kac12RUYS65pf6f4FUur/j9RhynXPHqlhX0iqySRZuEAraFsK416VJ8Uej+Td1Yh86vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246617; c=relaxed/simple;
	bh=gg8K0lKkwpEQ+IR9p1o5doJ/7nt9zyDJTGn8t7oZjwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PraTOwnbiX049TGsSxlZQtz+w1iYRSBOxgo/theE/gVlyIJGtg3fLR71u4eE2YLgIcPPEzh5Y24xCWqMC1LkCcAW9KX5MVdbmAKxM15Wj4XBB02E1xBvQTo7gIkyCRflnBPhQQGSzI2nGMzg1HPL++GA8JB8n89lbnDb7a4TbA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IaWassz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341EAC4CEC3;
	Wed, 25 Sep 2024 06:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727246616;
	bh=gg8K0lKkwpEQ+IR9p1o5doJ/7nt9zyDJTGn8t7oZjwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaWassz3flVg8qeWKmsZCdq8emfCoLa2ExYoUW8pwuDu7sqTxhorkhRQ5n63i41py
	 N3+WdMRNXfrnOUjgBIWO7N6JSdU8dceklJxl7+Wtn3Y+m2/4T/YTHqBRWGxv54hBMN
	 vU1TyPXGPjhiw94f7URbbqBHE+KbzORG0WrdtGKI=
Date: Wed, 25 Sep 2024 08:43:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, yangge <yangge1116@126.com>,
	Yu Zhao <yuzhao@google.com>, David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>, baolin.wang@linux.alibaba.com,
	Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmscan.c: fix OOM on swap stress test
Message-ID: <2024092527-fresh-lying-1847@gregkh>
References: <20240905-lru-flag-v2-1-8a2d9046c594@kernel.org>
 <CACePvbV6mqi7A0AhCYP1umejz6QBR91ueTSH_enJZoLe=N_pWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbV6mqi7A0AhCYP1umejz6QBR91ueTSH_enJZoLe=N_pWw@mail.gmail.com>

On Tue, Sep 24, 2024 at 02:23:51PM -0700, Chris Li wrote:
> I forgot to CC stable on this fix.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

