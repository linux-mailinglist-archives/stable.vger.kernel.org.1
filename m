Return-Path: <stable+bounces-147969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEC4AC6C4B
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 16:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26271882DFB
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E9528B4E3;
	Wed, 28 May 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="rt8Tt4Vh"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4D286D72;
	Wed, 28 May 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748443966; cv=none; b=PCgIOKn46r3U17VG4wpps8gY4UVr6CsgVpjeZ8IwTGExNCmn8v3g7wUVY1MtxJkM6A4bgv4MAB/omNEBw3b7HC4iyUKdCeUqIjUUC6B/AadzKsfFM/nHbgnIcChZ4rr9OqJiZAKt7Tn++s01vgIs8FZomX6u7uBOdnrR5+/ysNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748443966; c=relaxed/simple;
	bh=nqPK46BepQdOlhO7fZO9M00tPuMAWJbU5yRyRms7cFo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kicfmkZmlekRRx0PlCAtMcodAmHpZdR/pdSuJ57nenImqHmY8dGpMZx55AyFvM9623Q+S36GmeUzbV/UsAHWueacfwxbV43pw4829YTJfdxmeT+89ElaN6yAZOwwJI81GERazqaQz/U9jcyjs/P0MCdZOAIJikbNkg+QmQp8a5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=rt8Tt4Vh; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 28 May 2025 16:52:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1748443957;
	bh=nqPK46BepQdOlhO7fZO9M00tPuMAWJbU5yRyRms7cFo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=rt8Tt4VhiAfTC+u3WNjVoykIPhX/1L9R5QU6ALUT2jh9rrXIeAo8Zn8+Flr2Rv7sc
	 SAfyASZdtuEFTzqp54w0RRE/hsGDH75OA7Bo002Wdexh9a4NyaUxMtwz1YPV5S24uI
	 2pTkZd98VIM3AJYSF2xaG0cUJJxHAInZQaGr3PXYFlTDNOZtxrLGxvStmFAXzYSQJx
	 cNLX5bKkev/H4QRWKx2erMLIJXjti1wOfZ6E/Lf7OIqTN+KSsoAE5TXBkkcLFG9UQP
	 ht3H0FYUdH9nxgGmelpxehMHfCglumigKE1hLl4icX4Uh7uv+qAAof8kHIPE/h9btY
	 IbbUzM9A/IS+w==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
Message-ID: <20250528145236.GA24108@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527162513.035720581@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.14.9 release.
> There are 783 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.

Hi Greg

6.14.9-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

