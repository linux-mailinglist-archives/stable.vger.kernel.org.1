Return-Path: <stable+bounces-88255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CB99B219C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D581F2124B
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227A664C6;
	Mon, 28 Oct 2024 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A6qICg1J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBB57CB6
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730076828; cv=none; b=T+VI8kkzbAbOQzPiBNm3CnAmWbA9ibwVdANKvGgaibN9GvtfiS/y0orZA6VEx9erLD511F7WQ1ZpC9pNI1Ymg2i4NmHr/8ukm6hVkQTmBqSDAkYJEN9Oz1MSfFkiDYGovAgbP0bOxUH/opxtDS5/UFcItbjOUaP97nHvIRfEEHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730076828; c=relaxed/simple;
	bh=CH91t1nwZod1AQvGkBhSnoMv4jweZ+uWR14f+TMhc4o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EAnSS7JHGGMYafsno9fLar9Ysuvde/uxI9BA9Bp3232s1/gpQ06tNmUp/Rl8bQSp2x9C4y25f8Qpf24lZuDKaMoBpiiHqurNgujR1Jw/PLUjGrbDlneVzdRPJceJyiREZOFzNoEnfbM8Q9s/tsQjaQZN5G1J4oE5Zx/equ3rG6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=A6qICg1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F264EC4CEC3;
	Mon, 28 Oct 2024 00:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730076828;
	bh=CH91t1nwZod1AQvGkBhSnoMv4jweZ+uWR14f+TMhc4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A6qICg1JiO6ZaQXnyQwSnCwGbR89tbeKSQAgeyxKTkp36a0Rp2VJGUFxWKwo3GRZT
	 RggiAZOBt559LsZyxa3nqc5mgpuaT+w2Och7nILlzQuEurbO22yaJeoVz/jWPbHIKY
	 mRjVHWVYTY4rYC3mWtO1DD8XKtvsLvCtebOO1lsw=
Date: Sun, 27 Oct 2024 17:53:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: vbabka@suse.cz, lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 "Liam R . Howlett" <Liam.Howlett@Oracle.com>, Jann Horn <jannh@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH hotfix 6.12 v2] mm/mlock: set the correct prev on
 failure
Message-Id: <20241027175347.af0faeac9fdfc2fc8ae051e9@linux-foundation.org>
In-Reply-To: <20241027123321.19511-1-richard.weiyang@gmail.com>
References: <20241027123321.19511-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 27 Oct 2024 12:33:21 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> After commit 94d7d9233951 ("mm: abstract the vma_merge()/split_vma()
> pattern for mprotect() et al."), if vma_modify_flags() return error, the
> vma is set to an error code. This will lead to an invalid prev be
> returned.
> 
> Generally this shouldn't matter as the caller should treat an error as
> indicating state is now invalidated, however unfortunately
> apply_mlockall_flags() does not check for errors and assumes that
> mlock_fixup() correctly maintains prev even if an error were to occur.

And what is the userspace-visible effect when this occurs?



