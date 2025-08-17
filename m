Return-Path: <stable+bounces-169890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F4B2935F
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 15:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BDA7B0F97
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 13:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5AA28F926;
	Sun, 17 Aug 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="4XGFcS5C"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E5D28ECF9
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755438705; cv=none; b=SZ/LiRNhjxNOVKMdu1sApT1QnJIp3SjZPT9idmUTthaIeNaj53R6sYgtSG+fSejUIw7yP2vtloYVKmRIirjI6jHHOfhYL0ieRYFYUHC4BxiMhn3fmArJUHk6TnGg2DSCKh0tCmvPSr2nvZhzozKfjcZv5Nmys4KyqvkRmlhYHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755438705; c=relaxed/simple;
	bh=feWHy78qqy75OBeuOjieGO1A9f7fwIfKtnGaqY08BjI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9GiimBo/RMqbd2NKvlTZ9J3DrZ25Mhs5Im67VUKbgmliDNC9fjCSb48rAIzbmw/2tjnF7MKCbfy27hm/QOlyjpSd55mMinxYXP8HWmbs5w+5/8OmY3t9DE9E8kPu8lu2QKwBhNuyWRNcol7XW5Hj69W4RAKAkQe5UV9RCmanRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=4XGFcS5C; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Sun, 17 Aug 2025 15:43:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1755438208;
	bh=feWHy78qqy75OBeuOjieGO1A9f7fwIfKtnGaqY08BjI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=4XGFcS5Cp5FSBnVHjLsrexVxTgLSj71eD8HmsbommiX9kd/S7gvGwvcTE/R4Pn4TJ
	 bAU066vvAaXgsxOlAH6SYR1wcEyC3BkVdScU0VIdz7y9cO8dR6Q90B1ZbPIxSk0n85
	 n56tK1zC0a3Jc38JSziebJV6Fg8LmcwlyLjLbn9X0x3ZA8q4vFQ6QSCar4e5UysPXO
	 Rvau0YE0pj8bb+4Pyov+uM5zNPppPxjirngHGEMIUmaWuvuwIH9IqwUVY2orr3LNB3
	 53+PuGksdvyplKWqRbbe5CEk9opzwdjOCM1MiueRMYf96k8QwNawSljHMQ0egYpJQH
	 jWH7NHv1BRguw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [REGRESSION] [BISECTED] linux-6.6.y and linux-6.12.y: proc: use
 the same treatment to check proc_lseek as ones for proc_read_iter et.al
Message-ID: <20250817134329.GC2771@pc21.mareichelt.com>
Mail-Followup-To: "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250815195616.64497967@chagall.paradoxon.rec>
 <2025081615-anew-willpower-adca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081615-anew-willpower-adca@gregkh>

* Greg KH <gregkh@linuxfoundation.org> wrote:

> > I have bisected the issue to the commits
> > 33c778ea0bd0fa62ff590497e72562ff90f82b13 in 6.6.102 and
> > fc1072d934f687e1221d685cf1a49a5068318f34 in 6.12.42 which are both the
> > same change code-wise (upstream commit
> > ff7ec8dc1b646296f8d94c39339e8d3833d16c05).
> > 
> > Reverting these commits makes xosview and gkrellm "work" again as in
> > they both show network traffic again.
> 
> Is this also an issue in 6.16.1 and 6.17-rc1?

I can confirm the issue with gkrellm on 6.16.1 (and 6.15.10 fwiw).

