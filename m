Return-Path: <stable+bounces-179415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E449B55EDE
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 08:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB453B9F59
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 06:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99DA2E6CBC;
	Sat, 13 Sep 2025 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="dLk/m294"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08B1A9FA8
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757743852; cv=none; b=L6Sg/h0tL36265acaXZMEnJnH0ytxjr4qFzg3XKzS1mwy6frTnj88EvaZMxostE1yuh6DeWZO3vFqA37pIoc7OIzxjBbAbkaGRSKxRBq5cGsFRH7Wxxuwf48UXx/Wy5+WpKaP0/OsVH8Rxo1BFms4gIq91k6BXHP84xMt9EMms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757743852; c=relaxed/simple;
	bh=+wvFGS6uqzkckuB2AHW2uu89uyY0X7k6QNEhSYv9PuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi6QfY63mNbu6XRJxmUhPIE9yVkqiiuJd1m5G+3z34AgIfIB8DvkzWz3wIPOG4Re+wvnWL3enAivAqsffAgK+7lGImCGwF4QJc4twX2bDCzGzGM6FRfTTwXK/hGnllUe6tv1ZvQOR9zTadeoFflEMRjX/cCIZrIftFLZ3+fzYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=dLk/m294; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3E9F650666;
	Sat, 13 Sep 2025 08:10:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757743848;
	bh=+wvFGS6uqzkckuB2AHW2uu89uyY0X7k6QNEhSYv9PuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLk/m294COsltbcegL91FhTeiyIPMhux6X3wolTYRCeY7QJ+ulDEODnQFoWPtl2BQ
	 VlncaRWLWE+pn/R6isQaMDY5xPT0Z+1GEX7+a4Ym+rjE3+FIbHIvd8ZWgl0OHMgxYP
	 caiLksSbEQN2qvlEXbEtyExe6veLbft/OSv5skQXJI7/+M20xac+4SYnBNbnROEVnK
	 9ku6rCvOB0gq0tkN4GZ0YoKcWYuTY+MiD7TuOBrEJHngRcUp5uhKriIHfzvDNsnb4O
	 6WXdVVtE7zuP6atIQxwGBiCwxLaoqFEeQRXhPTfFaHCWaiG+YSn6fefeyUVjMDGxLB
	 iJwgUPyh8CCZg==
Date: Sat, 13 Sep 2025 08:10:47 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	stable@vger.kernel.org, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH] iommu/amd/pgtbl: Fix possible race while increase page
 table level
Message-ID: <sizw3br3mzal4o5vej7njvnjxsd5ego37zw6ejsh5fufxdr36n@ubrpt7sxsn3d>
References: <20250911121416.633216-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911121416.633216-1-vasant.hegde@amd.com>

Hey Vasant,

On Thu, Sep 11, 2025 at 12:14:15PM +0000, Vasant Hegde wrote:
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Cc: stable@vger.kernel.org
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Can you please send again with a Fixes tag?


	Joerg

