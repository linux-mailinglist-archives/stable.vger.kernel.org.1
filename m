Return-Path: <stable+bounces-23590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B652D862C89
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 19:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5661F21452
	for <lists+stable@lfdr.de>; Sun, 25 Feb 2024 18:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4043412E47;
	Sun, 25 Feb 2024 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3IM3DLXW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rfhqanPd"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAA78C05
	for <stable@vger.kernel.org>; Sun, 25 Feb 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708887257; cv=none; b=O7Phr+ix0z649gUbmSbo8RfH5M0Kp6PnbuRKaQ1GDvXGeH2pLcLixZp2UPwDprZk9hQTZ4lEoVlo2cGECcSY6aclNj3bmMVXAgFZBLVMRfuHCNblyQIMmhxq2j4AntY/aHvILT7SmiblsxBlkZwc+Rlh9cKrTJezonMu2I3zt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708887257; c=relaxed/simple;
	bh=iCjni3fC3LjowVFjuFFoVwSAhgr69zxlBq9viG+TEFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwtbHvbbuRkm7byIE70Pd+XrohyYBYSWVaWONpILd9vDyQoPPN7zgjdhLkdvuclOTA+VTWGXu8nFjWRY91c0ji+8MSxcq8+zxMu8ZH7aJ/UhZ4hwSMWe8gxjssbdGLcopcSsD2FB/4R929VIxSVb1J8IxgLOImMuBWq4zyWEoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3IM3DLXW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rfhqanPd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708887253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6i28l4ZxXSrdEMsihYIbK7sj02rvP5cqkz85Pn85zFI=;
	b=3IM3DLXWSyZwmevOxR+9H59tnhp7wNN9KG0Uam95Vju+WtME8Xfv5mZj86vXl76GBehyAj
	ulLW+F5RsWcZnWK4+f4ShYZmfbh+mOdi+W+A545pqkbMnF2YYYm25SXpVKqzG2vP/PmT7c
	n1TKseo0sPbhemstRWCGQrdwBT2s2fGXgdC+HGjbBiFTNYxGsogiQ/gFzCKQcJtrbYzI7m
	jN2GfKDDiCkm+DhPBW4iREFsgZeJYpSxfGAS1u9oCD3TMSWtPa7jf+HYqWemsvDeiKmZQQ
	S2gTW1msJpz9VbpEkGf9LoNFzeRIooA5k+5y7KhG80HjkEbeYyLYsqfKblo4Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708887253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6i28l4ZxXSrdEMsihYIbK7sj02rvP5cqkz85Pn85zFI=;
	b=rfhqanPdIQQf4gx3vayKcJQgiE/bbX9LBPIE1/AoZpdd2uleMHDUlAknGMfCvbGkPoukcG
	MzAwROLJ5h3YixCw==
To: Greg KH <gregkh@linuxfoundation.org>
Cc: avagin@google.com, bogomolov@google.com, dave.hansen@linux.intel.com,
 stable@vger.kernel.org
Subject: Re: [PATCH linux-5.15.y] x86/fpu: Stop relying on userspace for
 info to fault in xsave
In-Reply-To: <2024022312-bulginess-contend-ac94@gregkh>
References: <2024021941-reprimand-grudge-7734@gregkh> <87msrtftnv.ffs@tglx>
 <2024022312-bulginess-contend-ac94@gregkh>
Date: Sun, 25 Feb 2024 19:54:12 +0100
Message-ID: <8734tgcr3f.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 23 2024 at 17:04, Greg KH wrote:
> Nit, you forgot to give me a hint what the git id was :(

Ooops. Sorry.

> I figured it out, now queued up, thanks.

Thank you!

      Thomas

