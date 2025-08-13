Return-Path: <stable+bounces-169306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D7BB23E15
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 04:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456ED1A25FD1
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 02:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637251DB12E;
	Wed, 13 Aug 2025 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="FeRDA7gI";
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="xuKmch0D"
X-Original-To: stable@vger.kernel.org
Received: from tengu.nordisch.org (tengu.nordisch.org [138.201.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96F717332C;
	Wed, 13 Aug 2025 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.201.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051123; cv=none; b=lPQe3fzkJeDpjb2ydk97t8dbqYrRsEvEfYSYmkIFgJirX2litCTOMl/d8XcNXaGDVeSghraPW4Xe1kbahj9+K82nYfH1VxEA392w7qOp7ABS+vQ9AoqAApbRFaPCQcA3ID8Vodo6dx3RSn+00fBHaVmr2RCG97+CT4oFNriaOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051123; c=relaxed/simple;
	bh=tjLfle/1dyoLXgjc17yo70DRYEcEp1R5SNYnBjMFVGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ij1KLwlLqUVIOV+oimBx77u51SSGu5jB9LUNDhTG4HfZVlWS2nkx0gT3yVbaKde+m7KfPWerN+Kw0dqfG+hWngrG3SaXGRxPqA86SZ2xNtoSAA6nqC+S9Cy+BjWMACKyjyYS6sz61yO1CTG9WU4ojO6UZuTyqpITAW1zY4Ci19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org; spf=pass smtp.mailfrom=nordisch.org; dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=FeRDA7gI; dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=xuKmch0D; arc=none smtp.client-ip=138.201.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nordisch.org
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
	by tengu.nordisch.org (Postfix) with ESMTPSA id 5EEE17B5174;
	Wed, 13 Aug 2025 04:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_rsa; t=1755051118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iShI/B9gu8SEMilJsfXUAIGd3MlQqWqBrYrDQJBS92g=;
	b=FeRDA7gIsptIkk7al6CJr+eqLHUvsDWAWaljSK+KCjZh2f/vHqX3rC8Q6HuLciqobXH1fv
	SeFQzWCf/AfHgdKwOGE1sIbnNUTb8mrmR9h/Yxn0PJBgvkQadphGmcfYGmuilvYuYy8nAp
	1L92PSB0p1qUfijurenMUXT37Sp3Dso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_ed25519; t=1755051118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iShI/B9gu8SEMilJsfXUAIGd3MlQqWqBrYrDQJBS92g=;
	b=xuKmch0DqAhYKzvbLarMIzmR1OMzlwOujisnm96bBA71xh+dW+XjMemXMthHtXs6WtMiKI
	dWL+qKtcGm4qVRCQ==
Message-ID: <1c1d1ab611921be10bfccb7fdbb54ae1a77bf50a.camel@nordisch.org>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <kernel@nordisch.org>
To: =?UTF-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Jiri Slaby	
 <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, 	stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz?= Bartosik
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
Date: Wed, 13 Aug 2025 04:11:57 +0200
In-Reply-To: <20250813000248.36d9689e@foxbook>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
		<fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
		<5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
		<4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
	 <20250813000248.36d9689e@foxbook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 00:02 +0200, Micha=C5=82 Pecio wrote:
> It would make sense to figure out what was this device on port 2 of
> bus 1 which triggered the failure. Your lsusb output shows no such
> device, so it was either disconnected, connected to another port or
> it malfunctioned and failed to enumerate at the time. Do you know?

I forgot to answer this part: I am only using that keyboard for gaming.
so it goes into power save mode at some point. maybe it doesnt properly
unregister for that?

--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.



