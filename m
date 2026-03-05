Return-Path: <stable+bounces-223165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHCmNBjpqGmfygAAu9opvQ
	(envelope-from <stable+bounces-223165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 03:23:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDA20A2A6
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 03:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40A283061E12
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 02:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD82571B0;
	Thu,  5 Mar 2026 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip73y1/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC05221FD4;
	Thu,  5 Mar 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677395; cv=none; b=MgK1v5QETIftAULckK9kMizxqNtPkYO8OFTmkWcunxlcsV3VhSp4vO+rr+JqFArQnSLQ/IZ6cGic4EllJ2qPiBQW80wdUR9RsX2VEMBKWJl1LkERmIE+K8g643aenp/JNj02rOxJQ7aZ/hSg5ahzUapV9KwpdQ1DqLAfV2fFiaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677395; c=relaxed/simple;
	bh=VX+eCtM+j4ulLaEbWvFmeQFhD1V7oDErGE+R9/sXrx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdupnigUsJVqvvnb3OjMk3Bm1b4dHQnaxb0UByrpbgsZriRNpnggBh56QZV7oRkxF0HQcEN4uA6udHRRwL9buc0zG2HpnUwJmV90kAwB0NtdVeZI3+pI4ikSDqYVDx+Ohia+gGLhSln0J9WMeVdNxDF4SI/qWdAvVtRvFW+cH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip73y1/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8083EC4CEF7;
	Thu,  5 Mar 2026 02:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772677394;
	bh=VX+eCtM+j4ulLaEbWvFmeQFhD1V7oDErGE+R9/sXrx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ip73y1/MRTv2mghlmN8r9NZVL6IYQVqF385YXC7syuB3LHOeWqg0hE11UOKILI8Tn
	 PECQ0w4Ds8EZymKwVOgiC2xrmm+RDTJOs1ZmC1m173U5zr+apUBwURWNdr55AfPljp
	 jwJvl3n9yKsrVvR/TeTZEQHsauMv7PxGLH932ziEEymRhs8N9x8A7sNxQ/+iBLskfd
	 LgOfdQ1SHiZBj7xGmHKhnVn4LHoOnCIradR7Dccnta8NVRPvzhud6yAmoZ7RG1iWRk
	 97z9oiuwgt5XURcpHtta2+h7KuMzI+YdHJ0EjTpsBVbfsa9ZZzdmHmtqHF7HR4BXmu
	 hm2DlDoSmhmjg==
Date: Wed, 4 Mar 2026 21:23:13 -0500
From: Sasha Levin <sashal@kernel.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org,
	lwn@lwn.net, jslaby@suse.cz, gregkh@linuxfoundation.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: Linux 6.1.165
Message-ID: <aajpEdVsMnl61S_O@laps>
References: <20260304131525.84627-1-sashal@kernel.org>
 <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com>
X-Rspamd-Queue-Id: 36FDA20A2A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223165-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[googlemail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 06:27:00PM +0100, Peter Schneider wrote:
>Hi Sasha,
>
>
>Am 04.03.2026 um 14:15 schrieb Sasha Levin:
>>I'm announcing the release of the 6.1.165 kernel.
>>
>>All users of the 6.1 kernel series must upgrade.
>>
>>The updated 6.1.y git tree can be found at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
>>and can be browsed at the normal kernel.org git web browser:
>>         https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
>>
>>
>>Thanks,
>>Sasha
>
>
>In the now released 6.1.165, I get the same build error as I have reported in the 1st incarnation of 6.1.165-rc2 (see [1])
>
>  CC      arch/x86/kernel/setup.o
>arch/x86/kernel/setup.c: In function ‘ima_get_kexec_buffer’:
>arch/x86/kernel/setup.c:385:15: error: implicit declaration of 
>function ‘ima_validate_range’ [-Wimplicit-function-declaration]
>  385 |         ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
>      |               ^~~~~~~~~~~~~~~~~~
>make[3]: *** [scripts/Makefile.build:250: arch/x86/kernel/setup.o] Fehler 1
>make[2]: *** [scripts/Makefile.build:503: arch/x86/kernel] Fehler 2
>make[1]: *** [scripts/Makefile.build:503: arch/x86] Fehler 2
>make: *** [Makefile:2025: .] Fehler 2
>root@linus:/usr/src/linux-stable# git status
>HEAD losgelöst bei v6.1.165
>
>
>So the offending patch seems to be still in, although in the 2nd 
>incarnation of -rc2 which you force pushed over the 1st one of -rc2, 
>it was then reverted after my report [2]. When i git blame 
>arch/x86/kernel/setup.c and look at the offending line I see:

Yup, sorry. I don't have as much automation as Greg does, so many of the steps
were manual...

-- 
Thanks,
Sasha

