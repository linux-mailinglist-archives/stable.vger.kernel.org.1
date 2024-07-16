Return-Path: <stable+bounces-60352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1C89331B7
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 21:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990D8282B87
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4551A0702;
	Tue, 16 Jul 2024 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="vrQOfBwM"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAF1A01CD;
	Tue, 16 Jul 2024 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721157119; cv=none; b=IwnJPLiqZvqQzLnAeCSNi0OXcaApE+rc3OPaPOKOERSqt5b/GGMkHvHoMQgAtJWSbr0Ag5Dwm7O6/Y3d8bmDlwLFPtspvl5T0Y77xA7CWAhH2djiYeSUGGlXFpdpghnH3r8PZYr/gURWJnQGCpt7pTbM6pLKawBsVsBy3DLjOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721157119; c=relaxed/simple;
	bh=eD+szWeVRX7fN+TEDsvAIa1f1bT5LvJxKW+51Ka5dpk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk9yjMBADgI3+t/BBvuzyZVIsHQCCqe3ZHYVoKU0KW7bd1u3sD9WenfowQSuKGxktloQD2FBxi697O24ySyoQZqdH5JESLQOhpmMizwts0O3MErMm1JyT/6eo6pLh69J82LezNspI4YfYkIzGqVCBl5vzCbdPkZl0v3s479iyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=vrQOfBwM; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 16 Jul 2024 21:11:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1721157109;
	bh=eD+szWeVRX7fN+TEDsvAIa1f1bT5LvJxKW+51Ka5dpk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=vrQOfBwM9Usilw0NmYXsPUstMmpH1l81I3RqeOrt0yAq0DyUfVOw93Pr7qZhy3cLD
	 E478HEYIhrwVIwUr7nkyjmZtntMqEtQpP+l6QJ1+byoFYFMzh2l9kAuHOwIyTej7ou
	 vEHUJiLh1ERsKg48vBx/524GvMuo4rwXMDgfOuJsVs43AiGn80alk9fQH7nLiJ0Gqf
	 02peCr6L1RjvBBVoS/wdHhLHBBxt0nGpWfpU511FcPv/qpDhH0GMXbs6SpMmG71EG8
	 xA7qKr3r2Ph2NR79q8aU5RN6J5Ai3JFrL/xa0kuFz1ED8dUH5Ze082IfzWP5EZ49go
	 A9z5RfzCoaPzA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.9 000/143] 6.9.10-rc1 review
Message-ID: <20240716191148.GA3657@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240716152755.980289992@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.9.10 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.

Hi Greg

6.9.10-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

