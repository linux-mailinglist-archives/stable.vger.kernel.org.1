Return-Path: <stable+bounces-127313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF89A77904
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DC4188C477
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 10:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86231F09A7;
	Tue,  1 Apr 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NrU3pk4X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623321E1C22;
	Tue,  1 Apr 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504010; cv=none; b=SMt70zj8/hOuXlx5IsJsFyyPmRyEeOgZH16pgkmQou7IWotdcezieGCWS9AMNe1ARRM+LM/btDxb/R4BlFHrWFa0q58etvCF4gRvC+cdcOxEAODdEmhzyiyf4DlVqnKqej7vmApCE+hoKsBex57htNZ52DDp86eVwohQcciDKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504010; c=relaxed/simple;
	bh=F7jdrqifXum1k0pehFxF7PrfNecUCSbDZ+j9WXbcHa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtWuamNXLF7av+gx0ipdMklLyBnO0nEny4giqaVoVZmPAoLZsx1FqV+FK0tRqT5nTPJXne1hQgSAGbZuazIUu3STNbNXw84win01SN4w8AitX70cwXGW+uWPw4qLpO03v6pH4lHACkHQ3XOSqQsYIbPlpIlva9Rjs9FzxSKFgyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NrU3pk4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89244C4CEE4;
	Tue,  1 Apr 2025 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743504009;
	bh=F7jdrqifXum1k0pehFxF7PrfNecUCSbDZ+j9WXbcHa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrU3pk4XyMKEvhwPPdSVdDQNNBZ9tO5rr5qFeOGA/Mo6p5Rn5c1kCeXoRWQemQ+LS
	 f0m2fiGyW/cVaTz4nMMPOyyennZiVNienEKLCH4vfmpWWAheUno4yuIWNk6Clc7CCr
	 paCjXOcUf3e3v+pgWlDEzzQhnoLioWeRn5iJmhJk=
Date: Tue, 1 Apr 2025 11:38:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [for v6.12 LTS] nfsd: fix legacy client tracking intialization
Message-ID: <2025040119-avoid-roast-01ca@gregkh>
References: <e51834a5-2f11-4783-9065-e19a150283b2@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e51834a5-2f11-4783-9065-e19a150283b2@oracle.com>

On Tue, Mar 25, 2025 at 09:21:10AM -0400, Chuck Lever wrote:
> Hi -
> 
> Commit de71d4e211ed ("nfsd: fix legacy client tracking initialization")
> should have included a "Cc: stable" tag. Please include it in the next
> release of v6.12 LTS.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=219911
> 

Also added it to 6.13.y as you don't want someone upgrading and having
bugs.

thanks,

greg k-h

