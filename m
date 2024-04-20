Return-Path: <stable+bounces-40331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE28ABB4D
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B211C20BF6
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23829417;
	Sat, 20 Apr 2024 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="DqtIX+HW"
X-Original-To: stable@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D505179A8
	for <stable@vger.kernel.org>; Sat, 20 Apr 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611999; cv=none; b=KtoQgEhaFGEXMZ38VWsXiVHQoY8xBWcMiqrRzXmk/DznX/X5cnb2nodjXFcgKUa/90P3YjtAbCgYyobUC4PfpdYqZQ9v+GL6lcoiowaWzRDUGRDUe8P3N5Shx3mlJIL/QLw9+yE+y0/vlZNO/UuMefA7nZ3x8j+zCgHNF8ygImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611999; c=relaxed/simple;
	bh=jDkQY9iimEQod6utZrUZUhldajJA19rOn2DYbebTQuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGtIx5w4zRfBcRVEG/H1f0SmU3ya9ZvgjSnc4ukoLF7lyu2DyEdxeskukHMQ9r9s5JCexcPgGklbzK2z3qmNeFJbrMZcV5KjQJvou1HGFwz0k7/KhxJOdlc2v3OiG2XMhys35av6oL6bHehIq4C23swywuEcFpxBTA1oU4uoJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=DqtIX+HW; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D6B91C0007;
	Sat, 20 Apr 2024 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1713611989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnlQyxFt1cjC4p0mAPDuZw5h9bX3BKj8elDKWk8IcfA=;
	b=DqtIX+HWSNpziENPj5+8AKU1gQwaKGWVjsOqRNia+wv2KdXLqdfVLyhc1kO4RqYcQMwnQO
	0xoJjGvXyaz7FLs2TuDCxP349jreN3n2vpS5y/Ov1XA7sQk62tbmNKCXNdHrfEWzdwc3Z0
	m38FMERvVVY6rSqEnkLM1YDIORCWbl3Skp2CKZfPGlGiV/C6qUHBa4GKShVGN/u4gUim2T
	oXKv6vMoO1DTWR0sBCGBqwUruEEz9UBueXHPp7hQHnRcX8P8XugnCysFAOTHbe0LfMuSdR
	Swc2+zzt8ZEtNebKRteliH47x0ijDxz4bgKVzBAV4HjRzPwkYXiX07y6wVLuVA==
Message-ID: <ff6e71e3-9c76-4ac1-bf34-4803c4ef48f6@arinc9.com>
Date: Sat, 20 Apr 2024 14:19:46 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Please apply these MT7530 DSA subdriver patches to
 6.8
To: stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>, Paolo Abeni <pabeni@redhat.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240420-for-stable-6-8-backports-v1-0-4dafb598aa3b@arinc9.com>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240420-for-stable-6-8-backports-v1-0-4dafb598aa3b@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 20/04/2024 13:51, Arınç ÜNAL via B4 Relay wrote:
> Hello.
> 
> These are the remaining bugfix patches for the MT7530 DSA subdriver.
> They didn't apply as is to the 6.8 stable tree so I have submitted the
> adjusted versions in this thread. Please apply them in the order
> they were submitted.

Please apply these adjusted versions to 6.6 as well.

Arınç

