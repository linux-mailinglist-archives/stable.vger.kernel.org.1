Return-Path: <stable+bounces-155209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967DBAE27F8
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F79179C97
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B018DB26;
	Sat, 21 Jun 2025 08:21:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442F746B8;
	Sat, 21 Jun 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750494105; cv=none; b=lgKfHWrT2EZUcCc0stYGsmTFBJ7b+PLs4vT5Zv1j9aBYN52uhIALfMAkj9GDv4JxdYihjcKMFMX/Ki2PmYvHubnfPSOMMSIzKxgMpZgSLsMR5NjebifqnRwT5YWVzX8H2IvveGJ5uB54jd34jOXwtR3u5TBmEL2RM9SNihPaick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750494105; c=relaxed/simple;
	bh=XGZPQKXJ/IbPA0hftCA+UdAtk+DnOTmNocVXSTjGxpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6Z3u0PntCV2CZA753eZBW+o1V4xxG84VN5l5jhW8BAWXkq/Dmlo1K07K3MRDn+eSr1NhcXuh/oUxGNW5jx8nv/jzcTxn2aGNoBZCKE7lawn3ZLwPHrJq+18fdrQIjMwUpzF8GhumO3B1mGcsYsVC6Kd68rgENX1Hgcrb9cj2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 55L8LY4C026922;
	Sat, 21 Jun 2025 10:21:34 +0200
Date: Sat, 21 Jun 2025 10:21:34 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: fix spelling of FD_SETBITMASK in FD_*
 macros
Message-ID: <20250621082133.GA26919@1wt.eu>
References: <20250620083325.24390-1-w@1wt.eu>
 <e5561bc6-8220-4088-8bc0-0aba62c2cec3@t-8ch.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5561bc6-8220-4088-8bc0-0aba62c2cec3@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Jun 21, 2025 at 10:19:52AM +0200, Thomas Weiﬂschuh wrote:
> On 2025-06-20 10:33:25+0200, Willy Tarreau wrote:
> > While nolibc-test does test syscalls, it doesn't test as much the rest
> > of the macros, and a wrong spelling of FD_SETBITMASK in commit
> > feaf75658783a broke programs using either FD_SET() or FD_CLR() without
> > being noticed. Let's fix these macros.
> > 
> > Fixes: feaf75658783a ("nolibc: fix fd_set type")
> > Cc: stable@vger.kernel.org # v6.2+
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
> 
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> 
> Let me know if I should apply it.

As you prefer, given that you already have other ones in flight, maybe
you want to order them as desired. Otherwise I'll push it.

Thanks!
Willy

