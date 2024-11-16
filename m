Return-Path: <stable+bounces-93647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E39CFF30
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 14:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B50D1F22C77
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C9EAF1;
	Sat, 16 Nov 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0I6ncQyh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C432F29
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731765122; cv=none; b=JUEmtKyXi/ROp5h3WySi6jlA426KoZKeLvSyk9chhQCx6cGTmqZFsPRp/5GNpajWeThZfM688PC8rcSSDehif+2PU8FQAkcP2L8ZiYPPOok+ZBcNSyYHchJxZATlumKO3RcVHparwE+ZD7IFIXMTANTfwudG3F3RUtNJPpDUMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731765122; c=relaxed/simple;
	bh=+MV9fjjbksOBZSnlOMZlrpihtZFHrBtLWfELr5G6WCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYCPs7d1S3oH+maSkPsSnZkoTiROTgfsskIF6OB7RxrChNAOgbDdr+q0tBNdkXOUZXPAFLeSx3G78M2AbFqdTCaYdIqztlBy4vFC8bEpUk0t799RHvtub/7jFTolFq4PoLQG4pIkq8ATsrcTab9mOKzlcZtKuZujj9k5xC0ulJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0I6ncQyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB00CC4CEC3;
	Sat, 16 Nov 2024 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731765122;
	bh=+MV9fjjbksOBZSnlOMZlrpihtZFHrBtLWfELr5G6WCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0I6ncQyhGwop9hyzb5fRr9DAipGld2SYK7MFcq3z6OhtYuiXxSR2O7pTEmShJXALq
	 tXWYTpF7LfdaRMcfaiew/pk28hTuO1H9DNyMSsB+lpe4cAvLg4SM82OP8Y9MVmbjQO
	 uiu9aoVv8ZBRwU3o050ZHmxTqDvH6l5qKVZ52/ZM=
Date: Sat, 16 Nov 2024 14:51:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Backport request
Message-ID: <2024111659-scheme-online-d5d5@gregkh>
References: <E15AA884-690F-495C-BFFA-612DD4177952@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15AA884-690F-495C-BFFA-612DD4177952@amazon.de>

On Sat, Nov 16, 2024 at 11:08:00AM +0000, Hemdan, Hagar Gamal Halim wrote:
> Hi,
> 
> Please backport commit:
> 
> 0faf84caee63 ("cpufreq: Replace deprecated strncpy() with strscpy()")
> 
> to stable trees 5.10.y, 5.15.y, 6.1.y and 6.6.y. This commit fixes possible
> Buffer not null terminated of "policy->last_governor" and "default_governor"
> in __cpufreq_offline() and cpufreq_core_init().

Are any in-kernel users actually affected by this?  At a quick glance, I
can't see any, so why would it need to be backported?

thanks,

greg k-h

