Return-Path: <stable+bounces-28217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D7787C5B7
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 00:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75C41F21BB6
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 23:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A9DDDA;
	Thu, 14 Mar 2024 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PaXIdn3k"
X-Original-To: stable@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8711210A03
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710457373; cv=none; b=KMPfXitAsLrwY/41MIup/0+R4CgXbfytiAJmoLcnhOuq3IiEm06A+n4vtklNAx0ypOZ/a7JLh5o7LRCrK1+jD9x65cvZ3ICBjjBv6PFawQocyZQmTY4mQWY9rJLJZkIpdn9/oAoC8IayXSAbcRxR3RLRSyE8BLyFGrLA5nHYHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710457373; c=relaxed/simple;
	bh=Y+hwKt+p7wrdQVUooqaorwbmSycTNttYNZ3UpgVA3d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/sf4IbCj7b9h79C3cxEqjgsbOecglde/0S691+UouJUd2oFzR4Frza33+UHh+K0ah304vVfkgfsa7E3xrbFqdLbpWd9J5caHggogwDKZr5PwJOYuYALdsYpw5+OaUnssVAmNYn7nnhZ9We6pKiB3LU6ivRDb/2rwtpxzV+AarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PaXIdn3k; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Mar 2024 19:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710457369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htdAeQJNVioT8HXOw5XCTGAiruSICMwXMVbkV89aJE8=;
	b=PaXIdn3kZQGJhbGgDOJ+nppDkeHzRqC/dV7E6eyrPlp1lhCshUUEbhqYjmMY8tsEuBosqS
	ftPB/Aq89IOOdn6ZG3Qgg0hALszia78o+0UyQPk9Qd3uwdTNMXYcJ1MbXrVpBP5LV4+JuK
	BNQfhgIwMYkMNZh7HRh7OdI3QhA8S44=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: Helge Deller <deller@kernel.org>, stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: dddd
Message-ID: <7g5wb7rf3xxn5gz4dnqevbee7ba6zd4kllzb5lbj2i6capxppv@blm5renpmaiz>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
 <ZfN8WxMrgQBUfjGo@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfN8WxMrgQBUfjGo@sashalap>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 06:38:19PM -0400, Sasha Levin wrote:
> On Thu, Mar 14, 2024 at 05:46:35AM -0400, Kent Overstreet wrote:
> > On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
> > > Dear Greg & stable team,
> > > 
> > > could you please queue up the patch below for the stable-6.7 kernel?
> > > This is upstream commit:
> > > 	eba38cc7578bef94865341c73608bdf49193a51d
> > > 
> > > Thanks,
> > > Helge
> > 
> > I've already sent Greg a pull request with this patch - _twice_.
> 
> I'll point out, again, that if you read the docs it clearly points out
> that pull requests aren't a way to submit patches into stable.

Sasha, Greg and I already discussed and agreed that this would be the
plan for fs/bcachefs/.

