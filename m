Return-Path: <stable+bounces-205254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9F1CFA5FB
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3CFD340E3C3
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F534EF0F;
	Tue,  6 Jan 2026 17:21:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799EF34EEFC;
	Tue,  6 Jan 2026 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720087; cv=none; b=HS8kZeb1v2X+Er/fPQstsrZ5Oapye/oJV0H6XAbeg1uuB0fRYC2Q8wnkGFhw855P9PY+7deapjnnG51tNwBTp/R+s97hLJuy79H+muqhflQa/muDkJMYOnr1S/jk8L6NGg11kU4kv7X64bmTvi5weXK6GYXzyDGwCxm0dHz+d2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720087; c=relaxed/simple;
	bh=Gfi25kQf2oeXUXW5YRgBHXP10a0G48W+88AW833xfKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VysPrUzg9C9tW7YwwOTcKaBG1MLmxFHeck/z6AxYV+qMGHlDkKkSigKEnR5Dtr4/t37rqXy7glIJKRJsgqpsR8Qdv0Z/lQqPf4zkJlR32BFx8J9H6B51hjelFJbrRZ/auVwBhJMRzwt3Hc/7dd2vKvV1f2vEn7A8U8slqeZmKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 265198C11C;
	Tue,  6 Jan 2026 17:21:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 6B09F6000F;
	Tue,  6 Jan 2026 17:21:21 +0000 (UTC)
Date: Tue, 6 Jan 2026 12:21:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sahil Gupta <s.gupta@arista.com>
Cc: linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
 Kevin Mitchell <kevmitch@arista.com>, stable@vger.kernel.org
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
Message-ID: <20260106122145.42e4ec09@gandalf.local.home>
In-Reply-To: <CABEuK16m+msavH79AZxTRSqOsS5MQmOnsZZ8tZuKY5WWwz3bFw@mail.gmail.com>
References: <CABEuK16m+msavH79AZxTRSqOsS5MQmOnsZZ8tZuKY5WWwz3bFw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6B09F6000F
X-Stat-Signature: 67mhoxg1wszrth1tye4hd6yh8e3n3dpe
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+PhE6QeNkzxh+qsVKtgzYA6SdxjXHXrHE=
X-HE-Tag: 1767720081-314175
X-HE-Meta: U2FsdGVkX18MB6/yUeUq9GR1/vfsEPXOGlQZJsH3zor6b0Q1rZ4CPgFetRf8UpSkaB/GD+eHFH246v6ikprzURrmVWYFKnNEdsL7uLWPn32jrc52YO5MxV25Yfl2+wwv6Gx6IfMjtwTwnjy0Ir6W0ptuzeF0fsyVfUDGbTTBF2P6MqBwEbIUWDfLJvdMWXVI2da8MPW8Ipett/i6Iy0S8Gvt0lHzOhQsXrxKIm7zCwF+jOpU5tfcpclwNbkfH7jF8vRYvFRg28+5edf+Tsg0OPmnXtchnFO4qIkt5DagwmnuVY3ykTHwjumemtjbDixzUjBOviF0OGyZfvbz7uN9VU54eKBb9xDPt+8MjV7fpVZ4DL6gSKE+1VZxb6yY7gWH

On Thu, 20 Mar 2025 17:02:06 -0500
Sahil Gupta <s.gupta@arista.com> wrote:

> Hi Steven,

Hi,

Sorry for the really late reply. I'm cleaning out my inbox and just noticed
this email.

> 
> On 6.12.0, sorttable is unable to sort 64-bit ELFs on 32-bit hosts
> because of the parsing of the start_mcount_loc and stop_mcount_loc
> values in get_mcount_loc():
> 
>   *_start = strtoul(start_buff, NULL, 16);
> 
> and
> 
>  *_stop = strtoul(stop_buff, NULL, 16);
> 
> This code makes the (often correct) assumption that the host and the
> target have the same architecture, however it runs into issues when
> compiling for a 64-bit target on a 32-bit host, as unsigned long is
> shorter than the pointer width. As a result, I've noticed that both
> start and stop max out at 2^32 - 1.
> 
> It seems that commit 4acda8ed fixes this issue inadvertently by
> directly extracting them from the ELF using the correct width. I'm
> wondering if it is possible to backport this as well as the other
> sorttable refactors to 6.12.0 since they fix this issue.

I think this is a good reason to mark that commit as stable and backport it
to 6.12.

-- Steve

