Return-Path: <stable+bounces-66545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D394EF6F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39BF1C2166A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5BE17C206;
	Mon, 12 Aug 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iWrxsp7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3CC174EEB
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472583; cv=none; b=UV0anKqX5cJHNIeg0EPoBXIuc+f0pGir2NSYAM7cvA74VgxV0FilU0WtSwbTBANtUBBvWX2sum4Q3z1BOcKIhkhY0HxI9GR8JzLxp/Xkijz7VNGDU7mrh2u1jqfpFGHne2oT/ePBOOCb1LtaIgAfm8xSFXjMnF+5OR5WJkKyBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472583; c=relaxed/simple;
	bh=6Lvx9XD8a/k1YoxGYGp3/H8ItSYXB7tDa1ZTj1Gmbdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXqe1mp8p64Y1q29WdREutL9yz5ewdlEbnfrVKNRAPkCdvWqbsE3eg80V6n5x5luPQLy6RKGXQW1uCGrVoJWBNIt/IcyahVZ/zab6tmwsZnsWGCA9zxfkKbVJnvtJ7eLayjdxndyjkFqKFWg8fDMxb5dkxpPV+Gp550vPhevbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iWrxsp7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE637C32782;
	Mon, 12 Aug 2024 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723472582;
	bh=6Lvx9XD8a/k1YoxGYGp3/H8ItSYXB7tDa1ZTj1Gmbdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWrxsp7FTMezZ2G0yrKJgJhFyjsRjjGLuEOpQMyi0W2aUMDkW5LOXTqZztNk/+hXB
	 VsivDmpEcgcmip/RZ87CSvqASxP6w0TiE66d6t/LYXleVHpcRYSv4tz6Ted4tWJ34O
	 repSeWRjv+zLrdCTh8zZcbpCPNN82/8P2efUdFpw=
Date: Mon, 12 Aug 2024 16:22:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.9.y] mm/hugetlb: fix potential race in
 __update_and_free_hugetlb_folio()
Message-ID: <2024081244-epidermal-prepay-3f8c@gregkh>
References: <2024071558-unbundle-resize-a6d4@gregkh>
 <20240807034949.1407040-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807034949.1407040-1-linmiaohe@huawei.com>

On Wed, Aug 07, 2024 at 11:49:49AM +0800, Miaohe Lin wrote:
> There is a potential race between __update_and_free_hugetlb_folio() and
> try_memory_failure_hugetlb():
> 

6.9.y is end-of-life now, sorry.

greg k-h

