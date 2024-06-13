Return-Path: <stable+bounces-52108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5957D907D5D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 22:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1373285562
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 20:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4ED13BC18;
	Thu, 13 Jun 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bf5/YajK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594513C9CF;
	Thu, 13 Jun 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309935; cv=none; b=AAlbo2O/B0l4rtp0nN0pfK6vey/s8O2iMYMM8P0WDv7Wk+Kvsp9W+vZO8u1XD01S94cvzz7FcdJFmrkJI7+40rynJjSf+hQFm7GyfUny6w6lZDYghEq+mPcqO7CQly6Qzay+LHnpeyoEfem1c7HlvkNKYc/gvbO4LTv7zNiiFSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309935; c=relaxed/simple;
	bh=tZkWlPzsEIJD0w2s0YudkX0DW+VefZKFhtp6mC0r2IU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bH1KIwVsF6aM7kLlToKsks7wolV3AbQJlljAUG2hY+rYlyzO5jZ6WUb74YacGL/Jh3WX9DFII66EtQ+CNJWDlKZnmjNoQdwPr0dGeX2AfGk8R85UGjL4El2/ZCFu+C3Uk/z2pXoO+cJq8aL9QpNDLFyzRmhnERwE9+d7eUIir6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Bf5/YajK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D924C32786;
	Thu, 13 Jun 2024 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718309935;
	bh=tZkWlPzsEIJD0w2s0YudkX0DW+VefZKFhtp6mC0r2IU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bf5/YajKc4bfbaMnNBJtRIpnDJlNphOAbPvgJhaNCxXLBU5O1cF2Vv2cdDksmwZ8t
	 24wyy/nVoSssXL2C+IQDaESgQcRd2hVNQwRF4vQZqJDdiaf4+wuo3rN8uEqqqzl1Et
	 OW0XOY8HY+vtdqMwTvzMuRNA1pMauFSPHlAQ5qao=
Date: Thu, 13 Jun 2024 13:18:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Christoph Hellwig
 <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He
 <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, hailong liu
 <hailong.liu@oppo.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 steve.kang@unisoc.com
Subject: Re: [Resend PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-Id: <20240613131853.814a40233d36d57f868f9a39@linux-foundation.org>
In-Reply-To: <ZmstXFYq6iSHYdtR@pc636>
References: <20240607023116.1720640-1-zhaoyang.huang@unisoc.com>
	<ZmstXFYq6iSHYdtR@pc636>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 19:33:16 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:

> > 2.25.1
> > 
> Yes there is a mess with holding wrong vbq->lock and vmap_blocks xarray.
> 
> The patch looks good to me. One small nit from my side is a commit
> message. To me it is vague and it should be improved.
> 
> Could you please use Hailong.Liu <hailong.liu@oppo.com> explanation
> of the issue and resend the patch?
> 
> See it here: https://lkml.org/lkml/2024/6/2/2
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks, I'll queue this (with a cc:stable) for testing and shall await
the updated changelog.

