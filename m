Return-Path: <stable+bounces-60643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AC093825D
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 19:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFFB1F21FD3
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39491487CD;
	Sat, 20 Jul 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p2mNVAL7"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB683CBA;
	Sat, 20 Jul 2024 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721498163; cv=none; b=I7EBURVfRBcFCpC8TQXSwVoRiY3nmIWYHVBouHeJV9aNbPiQ+pTz8vWzz8roszs34bNDfPA1s4UNKXCtZBBkebQOVHCNrbStFlKv/Tl2yIGVDfKqFC08eUrPWUqA7EU/eN3BgrlIlWmIPBww4IfAyuDkLa4XVCojPhOpXLZLogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721498163; c=relaxed/simple;
	bh=DBMgTy9mbSOAli1I3NFfg8FnMlmaVNiB33nufHR0N/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EizW596ZnJsrPveVR4zoPtLg1D5I6TVgme2Djra7z8581WtAp4nMRej3YR3vA00ExsyQQoklOxRJ9nFlhRF1TKjnIIr3eMFylvtpLePKZK4AErEQH7GKeLqhuX7kgt0DEMaEpPAsmri+Q5cFxF2rfOYhQ2krlFnygKpQEyuedOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p2mNVAL7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DBMgTy9mbSOAli1I3NFfg8FnMlmaVNiB33nufHR0N/c=; b=p2mNVAL73keW3tdLNVG728TkRq
	AKznIy5QznNNkVnr+8wBH5jh7wKerbIKJ9ujCYJ4lSvo3fHnCidaQowR2VlKCAT09wzKs1W1C4jCS
	F2T9zMgKg3VWOG2wGlOPBBAN4Ki03BWeujShXkHOK3jKEApjHgrpjK9IpevoqAS6CRBgnbDKXnlgI
	kQPEYNK/kXszr+HDHPhdYCVk3vgdxBDua0BKPsxDPzRwwTGgc2DeqzLM2Nry4HUQC61IngsotpxLV
	qEE2XlwGoMPaqdNqxZqyjPlO3upCQJnOZ1ojybeJTQS+JcqVDi1YbDwLKWDmxAjwfraYxTn9yfxo3
	5ng5kvog==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVEJE-00000004AFK-41uc;
	Sat, 20 Jul 2024 17:55:52 +0000
Date: Sat, 20 Jul 2024 18:55:52 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jerome Glisse <jglisse@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix maxnode for mbind(), set_mempolicy() and
 migrate_pages()
Message-ID: <Zpv6KNYjZcBuQfEk@casper.infradead.org>
References: <20240720173543.897972-1-jglisse@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720173543.897972-1-jglisse@google.com>

On Sat, Jul 20, 2024 at 10:35:43AM -0700, Jerome Glisse wrote:
> You can tested with any of the three program below:

Do we really need three programs in the commit message, for a total of
287 lines for a one-line change?

