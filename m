Return-Path: <stable+bounces-151431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C892ACE09A
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CF2188AF1C
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA010290DA8;
	Wed,  4 Jun 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z9VDzhNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681C92820A3
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048285; cv=none; b=Uju0APs4lpjM/tKju3OMorZzOgZTu9LTqlxsMf+K6PtGtJaKH51Cazwj3PQu/j1BkLXDjPCOy9xsbveLvMWGrOhpbY33fa9W7uRso+tfMch/GlfQpND4x0ZKo2AtBeyUDnPdWtyfIK0zKIiRGc/RBUeZwPgftpRFaSCV/QpUdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048285; c=relaxed/simple;
	bh=so6jQasQL8pZv25cPRI0mgmO4eBodOpMZY86jLff504=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZXoM588eNVwISPFcyVF6h/Ot9VivM1l4rsAdAiPRR/w7VNjFG3ex4Silbp0XZuKriSktOOPADEzZkoFc/t028pQkJfXO2fWpeuYlk8O/jaDL0E+hw2esX938hhFpnntAq72/2vfMLaiVd1QAGoBaMEjNcirk2lnmtYZevhidXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z9VDzhNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CADC4CEE4;
	Wed,  4 Jun 2025 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749048284;
	bh=so6jQasQL8pZv25cPRI0mgmO4eBodOpMZY86jLff504=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z9VDzhNrtZJFOikl8BN55vXog0qvL7TfMSQZItSC1G7IFAWGvZuphZBPejSnSJqNp
	 kDfMGj4BUoTXrQlGJun/O19Kvp/AEkzipUaWmbFs/w2Kz75tyOBMMbz23gyn1wkx9Y
	 ytsGw9UOjQQyinkOXV2no6jS9mDrZAYbI5WBTmLY=
Date: Wed, 4 Jun 2025 16:44:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hubcap@kernel.org
Cc: stable@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
	hubcapsc@gmail.com
Subject: Re: [PATCH 6.14] orangefs: adjust counting code to recover from
 665575cf
Message-ID: <2025060401-symphony-boasting-8d5e@gregkh>
References: <20250604143414.213477-1-hubcap@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604143414.213477-1-hubcap@kernel.org>

On Wed, Jun 04, 2025 at 10:34:02AM -0400, hubcap@kernel.org wrote:
> From: Mike Marshall <hubcap@omnibond.com>
> 
> A late commit to 6.14-rc7 (665575cf) broke orangefs. I made a patch that
> fixes orangefs in 6.15, but some pagecache/folio code got pulled into
> 6.15 that causes my 6.15 patch not to apply to 6.14. Here is a tested
> 6.14 flavored patch that was never upstream that I hope can get applied
> to 6.14-stable...

Can you make a real changelog saying what this is, AND provide a
signed-off-by line like a normal patch?  As is, I can't take this (nor
would you want me to...)

thanks,

greg k-h

