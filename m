Return-Path: <stable+bounces-191769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2FEC22775
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 22:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85F574F08E8
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 21:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47188335553;
	Thu, 30 Oct 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pOSA1FaZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9F2620C3;
	Thu, 30 Oct 2025 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860911; cv=none; b=r/ILy+zgDLuIssmHsSRf42cB+j7O0sjj165UNJWWlcmEckIMNb42F2F6C0WRk+RAdmkAXRso3dRQIV8iM0owB0HJNqkmTLarrDdsJJuM9pztZRqQAfGmBk7vIVGo511Wc7iRXzSVCvBAhZDj4C/+lBX9teuVN3nfm94m7gfOsWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860911; c=relaxed/simple;
	bh=MrEUNw0rC/8xJkbocE72y4TZTuipPWYvQskSq91sXtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caAdZLjq1UZnDZJhe7P0OOSSlPSqT4w5QTP3ObWJgP34s4lGVl4HSluA+FG4Q/qdKwChWKdnhyqWFWtKKqVfDYGIInX4z3MTm7us8c30RaL7vbwZz+LWphFm/fDKnVi4BeJfBuwA1sjaHxIS25Pt11uld5T0jfshkxjCcUvrWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pOSA1FaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B30C4CEF8;
	Thu, 30 Oct 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pOSA1FaZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1761860907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gq8buwbNlbv4V8lRHUM6v67ESSUFXs3Eg4uiJhrxCMU=;
	b=pOSA1FaZVVk3TtKHg5zesoT1590M/qeoZqKGagsalepHkls1hijheElOJvHUkTQZSMJGlC
	W8KVXQYx/6+3OfLU3fRUNZyAtPEmV330Gxa6xbCyfJVLNgcKSsccsrP3CCwUeyA+4dCyTC
	UyW2RQnup76HVTk0O8P4cHaC3TuhQIw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 264264bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Oct 2025 21:48:26 +0000 (UTC)
Date: Thu, 30 Oct 2025 22:48:23 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, stable@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/CPU/AMD: Add RDSEED fix for Zen5
Message-ID: <aQPdJ7CbIRI6dj0Q@zx2c4.com>
References: <176165291198.2601451.3074910014537130674.tip-bot2@tip-bot2>
 <aQOo3LcsdU23q1i2@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQOo3LcsdU23q1i2@zx2c4.com>

On Thu, Oct 30, 2025 at 07:05:16PM +0100, Jason A. Donenfeld wrote:
> I didn't see this on LKML or any mailing list before this appeared in
> tip. Did I miss something?

Also, by the way,

Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-7055.html
> Until the microcode patch is deployed, the following software
> workaround options could be used: 
>
> [...]
>
> - Software can treat RDSEED returning 0 equivalent to when CF=0. Retry
>   RDSEED later until a non-zero value is returned with CF=1

You sure that's such a good idea?

Jason

