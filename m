Return-Path: <stable+bounces-244699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILnfBRSe/WmwgQAAu9opvQ
	(envelope-from <stable+bounces-244699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:25:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8157E4F3AFE
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 10:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D67C3075BC8
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 08:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1679374185;
	Fri,  8 May 2026 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="XgESBBAY"
X-Original-To: stable@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150E371CE2;
	Fri,  8 May 2026 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228608; cv=none; b=OLwGMNDrrx/Ruc/GX5zIr2twOrQP2CtUZN/PEISzB/uFXonxak8dQHyKocynP/cb2yONlKpAcalEwAylDZsPveB6lqgNkyk2iAUsW/2AG7ADm8onNHcckJcMz0T2iDhy9ZXovr6eHpBUNxZHWzMPLh+lqhQZh5Grr2vZpsHFli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228608; c=relaxed/simple;
	bh=qmQCGhxD2d45GlJNeGUGcQeexU8pWgH3Uz0YQ0hoAGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l0TafCNX2zfqjXyExVBJ0Yc3U5sOEy56b7pf0b7iuRGUbUwx7scsMQdV/0s4Xza/q8yKRfKHPt965qNcDEigebROefoXiwyLxq1mDxhIuMDvyZAkdq1twjdc8nKTHa1rEFQmEln5zonTcVpTTgmsjwo/z0Ry/wBHpFFJ3LZqExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=XgESBBAY; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86E39285A54;
	Fri,  8 May 2026 10:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1778228117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=+qzVSlC+NAOy9HeepktBPUAdXIQtI7RMSQOMY3m8/pg=;
	b=XgESBBAYdd/ccLjtahGug+vhb/+JWOh5OPYCkw0HTr66TIJn4/lEgeu29sYJBF0B9IsBh0
	maI2vPj7HDZSNzZjNkFiUHFYKS5HOsjugbpAwsCUXsvG3kjap3oY+zY4A9JTad4x46mvkP
	N2YMfyhKfTHchXGhc043h6cwW5W5X0H7xxFZ5AjK//A5KXPzQ72ieQFu4lPwdTH8HbIEwX
	AhhWJfs/fvv0T2vJ1gdvTNiq38th5uZRwNUk9EoE4Jn/pc+Yck+4V93sl7EZwxnlttCEu5
	zpaAgqxzKXzV1/EAJrxXeooZ7ZqOlet5G4wGq41+osuoD8u6vIC3zfgCDPXTnA==
Message-ID: <c4934dad-1bc3-4fd8-86a3-5073ad47e041@cachyos.org>
Date: Fri, 8 May 2026 10:15:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 7.0.5
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, jslaby@suse.cz
References: <2026050851-iron-hurdle-6421@gregkh>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <2026050851-iron-hurdle-6421@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8157E4F3AFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cachyos.org,quarantine];
	R_DKIM_ALLOW(-0.20)[cachyos.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244699-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cachyos.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptr1337@cachyos.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cachyos.org:mid,cachyos.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,almalinux.org:url]
X-Rspamd-Action: no action

On 5/8/26 09:24, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 7.0.5 kernel.
> 
> All users of the 7.0 kernel series must upgrade.
> 
> The updated 7.0.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.0.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
> ------------
> 
>   Makefile              |    2 +-
>   net/ipv4/esp4.c       |    3 ++-
>   net/ipv4/ip_output.c  |    2 ++
>   net/ipv6/esp6.c       |    3 ++-
>   net/ipv6/ip6_output.c |    2 ++
>   5 files changed, 9 insertions(+), 3 deletions(-)
> 
> Greg Kroah-Hartman (1):
>        Linux 7.0.5
> 
> Kuan-Ting Chen (1):
>        xfrm: esp: avoid in-place decrypt on shared skb frags
> 

Hi Gregh,

Thank you for pushing so fat out a release.
In the Alma Linux post its mentioned a second, not merged commit is also 
needed: https://almalinux.org/blog/2026-05-07-dirty-frag/

https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/

Is this one not included yet, because it was not merged into mainline yet?

Thanks in advance

Peter


