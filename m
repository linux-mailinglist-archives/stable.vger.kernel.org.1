Return-Path: <stable+bounces-151836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7125AD0E06
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BEC16C968
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B211D7984;
	Sat,  7 Jun 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="jtmJ8Zwj"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB1BBA3D;
	Sat,  7 Jun 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749309325; cv=none; b=IDhdFv2Sokb9yVYknKWiPgRvAACOMXQaoJhwghIiyHkyJIur82d6pTztPXEEqJY2gNh2grbeHhempcLXUGyVkkYznUFXgx73v5nPanxMJoM7B8DcoYEut7735wgWTMLMztuN4Tl0t/ye7EAI4BK9H5UdRgJOqO3MlFnXsinJeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749309325; c=relaxed/simple;
	bh=BfKfPjoc8094vK7L5LYRsIt3PAX9CUdvDIFNAXgkWYY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5A5RhhrT2Qj9joPKbDu1qPgM9DjYfK29/3FDKHUDG8tubeAd3q9qS28iHazjJbg8RTAnNFeI2Kw1QY6HKxEQDC7bbFyzTLoExp5Rgf7Pv+5CKUPFo9vLc0quHaANujoJhKc3lPBotKIp6kY8w3HmT7enJzqUg+JRBMiuHDTvwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=jtmJ8Zwj; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Sat, 7 Jun 2025 17:07:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1749308840;
	bh=BfKfPjoc8094vK7L5LYRsIt3PAX9CUdvDIFNAXgkWYY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=jtmJ8ZwjZjKtqvBXm2MsgYiNx39N7A7XL+NputD6eCNsj6wJ2K4KwO1f2AhX1lvE2
	 fuL7stb9GsBBjM6sb3a9neTpv1h7EnOhGCUmMST/NbLqZ5l52me75d7I8VZH8HrJbm
	 6xqHQvJfVvZIZIfhNwN1HKAgE6aCaB0ikkjQbNuz7OGtWWJ5CelAl1lPH5yqH7ur3M
	 zvu4g8EnhFOkbEGjqPt5C/v52LmbZUOZidQqztOikdRyKnJLih+J7evkhFKgLst48z
	 esQyk6gzmiVGEA6V3NR6MYbgxO8X2T4boqXAr+svCY8YuhUBt4Y/C+9SKmfIA7v6Gf
	 sRIZ2fo6w7Njw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 00/24] 6.12.33-rc1 review
Message-ID: <20250607150719.GA8693@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250607100717.910797456@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607100717.910797456@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.33 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.33-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current),
no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

