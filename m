Return-Path: <stable+bounces-93078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1340A9CD67C
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68567B23C9A
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 05:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41811632E4;
	Fri, 15 Nov 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iXnKXNFq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C12F26
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731647430; cv=none; b=E0ZKdRtWMczKgr56O7D8ZlJZc5F2COhXeTNUuAZ5ok8qQ7Gv6mBZjHPvYh6Oq0JxtFdBUPzufGd7FyjAZdp7No6fVaqX33gS151gyZ3Jnp5QFZ18vAS5tvlr/+H/0bjWK3fAQRpHR941L0ipinqsAPwruECI3zpi9SS7bqpELpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731647430; c=relaxed/simple;
	bh=yHobQhJ6p5k/iTrVJX1lY859oiSqaPZhziA77hGJ+U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crD+yoXJ3tUwzFXDUAEeFSpF7KnJLwPw36QTktQjlhQ9XheFVsRN5kvzTcE229OGnHIzVhJn4iv4/0TKtmZtK3mFKgw39oSyKLRyn//soXZpebNKgZfgcco0ymsiWe1C33FmiyzWNW6Jmbvu/jipAEQWIQ0b2ztj/Y9Q48K3pCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iXnKXNFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE4EC4CECF;
	Fri, 15 Nov 2024 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731647429;
	bh=yHobQhJ6p5k/iTrVJX1lY859oiSqaPZhziA77hGJ+U4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXnKXNFqVkElKwXmHsfJmFOvi081hbbeXQrN2wScxOQZN8z2PpXANy4oRK7T3b4Tg
	 0CYBJQv83jyFyiXOeb6sKQuptlOz8w4eg1hyFQmNYNZqO50RyI+J7OkkpOcX0XjEHR
	 7sdy/8V2KCUSZduD7UFGjQz0ZpIKhYpyCKgEpMxg=
Date: Fri, 15 Nov 2024 06:10:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Backport request
Message-ID: <2024111518-glove-sports-a349@gregkh>
References: <F7DEAB0E-AFE7-487E-9472-7675D9A75747@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F7DEAB0E-AFE7-487E-9472-7675D9A75747@amazon.de>

On Tue, Nov 12, 2024 at 10:31:12AM +0000, Hemdan, Hagar Gamal Halim wrote:
>  Hi,
> 
> Please backport commit:
> 
> 59f8f0b54c8f ("md/raid10: improve code of mrdev in raid10_sync_request")
> 
> to stable trees 5.4.y, 5.10.y, 5.15.y, 6.1.y. This commit fixes Dereference after
> null check of "&mrdev->nr_pending" in raid10_sync_request().
> 
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
> 
> 
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597

Now queued up, thanks.

greg k-h

