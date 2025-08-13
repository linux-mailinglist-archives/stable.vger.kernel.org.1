Return-Path: <stable+bounces-169360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD4B246AD
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B171AA5D01
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A92D2390;
	Wed, 13 Aug 2025 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="jPzTOxwL";
	dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b="i57PXeS6"
X-Original-To: stable@vger.kernel.org
Received: from tengu.nordisch.org (tengu.nordisch.org [138.201.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB4D212559;
	Wed, 13 Aug 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.201.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755079521; cv=none; b=TA/TAH0rZ5Cr6T4V0vGJklGR9A11Ckt+oVUflnKLKNRnAXHAxcI0uVP8BonQ3mBh9d3EuvYm7Oo/LlIGTb2RzWthKJmtIF6MZH1MuX5fGsSFYAikVqN7M7wCdM2/QniNE2M+fay9daMhPFflfcqqBgd2ykQ48V+KQM+HnYMTY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755079521; c=relaxed/simple;
	bh=R+t/k4qhvgxrWpaSwg3//EQLBy7FkVy9BEYt/qNBRFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZslwLfwD8pcS4u7NV3gDqUoXwdzPPEXteZ1NXfsZRTUSqKwWSn5CUOpVJDaEGauFI3YqmYdUHkhBOa/02ltYpsgEwR7XpzeYvfLuzR6+8ZGgarwodpACLNvx+c2FuFptdRzXpK+IufStHtfFQDKXmnd1OiaEvEl/pNioPxGwbq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org; spf=pass smtp.mailfrom=nordisch.org; dkim=permerror (0-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=jPzTOxwL; dkim=pass (1024-bit key) header.d=nordisch.org header.i=@nordisch.org header.b=i57PXeS6; arc=none smtp.client-ip=138.201.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nordisch.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nordisch.org
Received: from [192.168.3.6] (fortress.wg.nordisch.org [192.168.3.6])
	by tengu.nordisch.org (Postfix) with ESMTPSA id 99B927B5174;
	Wed, 13 Aug 2025 12:05:16 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_ed25519; t=1755079516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+eIAA4OYkCg54VkoggBe1LYnd9NYvp9x/J64g5PC3Y=;
	b=jPzTOxwL1TwPhrP+YGa2S8Ebw47jdATYAFuen758+mHq9UIVGr3wnVGLKp3qXTqQGVgnjo
	X9Mmhg6x/FbsuFCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nordisch.org;
	s=tengu_rsa; t=1755079516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+eIAA4OYkCg54VkoggBe1LYnd9NYvp9x/J64g5PC3Y=;
	b=i57PXeS6T1hAmpDtxQiu77BRIhIltPQMtuEXC0Lq9QffOxXaLbuBgKPIZYhTi9DbABqlh4
	XawL05quz9wZPv0FBTXUko1sXqeu8ywvVx+tMy6Pxh44csiu0NNxca2UQCPrRk9c/H+jK+
	9W9Iw9uDCeBtdsnTkJva0yvi5P6lfNQ=
Message-ID: <3566d1a04de7f61da46a11c7f1ec467e8b55e121.camel@nordisch.org>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
From: Marcus =?ISO-8859-1?Q?R=FCckert?= <kernel@nordisch.org>
To: =?UTF-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Jiri Slaby	
 <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, 	stern@rowland.harvard.edu,
 stable@vger.kernel.org, =?UTF-8?Q?=C5=81ukasz?= Bartosik
 <ukaszb@chromium.org>, Oliver Neukum <oneukum@suse.com>
Date: Wed, 13 Aug 2025 12:05:16 +0200
In-Reply-To: <20250813114848.71a3ad70@foxbook>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
		<fc3e5cf5-a346-4329-a66e-5d28cb4fe763@kernel.org>
		<5b039333-fc97-43b0-9d7a-287a9b313c34@linux.intel.com>
		<4fd2765f5454cbf57fbc3c2fe798999d1c4adccb.camel@nordisch.org>
		<20250813000248.36d9689e@foxbook>
		<bea9aa71d198ba7def318e6701612dfe7358b693.camel@nordisch.org>
		<20250813084252.4dcd1dc5@foxbook>
		<746fdb857648d048fd210fb9dc3b27067da71dff.camel@nordisch.org>
	 <20250813114848.71a3ad70@foxbook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-13 at 11:48 +0200, Micha=C5=82 Pecio wrote:
> OK, three reset loops and three HC died in the last month, both at
> the same time, about once a week. Possibly not a coincidence ;)
>
> Not sure if we can confidently say that reverting this patch helped,
> because a week is just passing today. But the same hardware worked
> fine for weeks/months/years? before a recent kernel upgrade, correct?

From 2024-07 until end of July this year (when I upgraded to kernel
6.15.7) everything was working fine. Also since I run with the kernel
where the patch is reverted the issue has not shown up again.

> Random idea: would anything happen if you run 'usbreset' to manually
> reset this device? Maybe a few times.

How do I do that?

   darix

--=20
Always remember:
  Never accept the world as it appears to be.
    Dare to see it for what it could be.
      The world can always use more heroes.



