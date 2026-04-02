Return-Path: <stable+bounces-232928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FF4LW0lzmnElAYAu9opvQ
	(envelope-from <stable+bounces-232928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:14:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C1385BC6
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 10:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30A463009E16
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE51B38C2C6;
	Thu,  2 Apr 2026 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="G7DOCLSR"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D237BE92;
	Thu,  2 Apr 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116580; cv=none; b=HXcffCFKHX5gryBmp9SGSXTQekuZKNxKfS2dqTy8UvY7Ot48hYtkjcosWq5b7ONRDSYcTpsKWJOMJGjZsanOrhMW/t3OX+taBk1N4RT7+tQm4RBNGNl/wOPw71dYnz9oaOj5Ylpvby24t3Btvt2V7UQoa/NTmI+gab1BkjUHjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116580; c=relaxed/simple;
	bh=92lZlpDcf+q54tOTzaAC1ytByoAQWefcCYm3E5ygqv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCiFbJcD8P2NJcvXSSEWjNohN4xJqUI+h+0lceF6zZ9gWlZe8bnsS6LtB+J2f4MNcg4Oic4txthau6B+ftSCdsOQrZTpp5wrg83OoiKrYJ/RlRHKVlyQflBYsgalf+y8zWROYi5YtS+a0W8+iHadDgdSdQqmrtv79GMDyWzUTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=G7DOCLSR; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fmZ1545lfz88Gj;
	Thu,  2 Apr 2026 09:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1775116569;
	bh=92lZlpDcf+q54tOTzaAC1ytByoAQWefcCYm3E5ygqv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G7DOCLSRE/s2PWou4ny+45PPV/6BuJJWZ3pZi0sakebLv2aFDWKvmVLKOiGMoUeiC
	 7JxrQx/CMdeiQdYQ6HlWT9XW725vdnd+ICfOAXmQRJkKaSzoZUDrfNFiBdAVRIYozi
	 VJ7TgsKfR8fPusWHbAhHKsjqH6kD/09XHl7VnCvCUPZHVT48zo3RL7T4ZEXByqc4Hm
	 EEY98kQHRGTmZmXRMimk4+VJkDFJy0LmJMRLhI3lHyjRqpJakM5t5StgmfeJ154K1u
	 NQjxrbNd34GCh3cyG7OmKQGn/sc0jOHOAILPSmXKuWoFwN0oEoWl8R1+7cYO5R8YIs
	 /PSSXOXzaHbVA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4fmZ153Ps5z88D6;
	Thu,  2 Apr 2026 09:56:09 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fmZ150C5zz8sZw;
	Thu,  2 Apr 2026 09:56:09 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 6CB8A633BD;
	Thu,  2 Apr 2026 09:56:08 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <b9661a06-cdb6-4086-a247-fdc1a34336c1@leemhuis.info>
Date: Thu, 2 Apr 2026 09:56:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
To: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260331161758.909578033@linuxfoundation.org>
 <0ab3e776-1462-46cb-996c-f4406c84756c@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <0ab3e776-1462-46cb-996c-f4406c84756c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177511656866.968866.8162258355241139106@mxe9fb.netcup.net>
X-NC-CID: xdwe5ZOkJNpIcq75fcWiYmohFzKpyj+21bUyT242XopoW/yF2R0=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232928-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,vger.kernel.org];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,leemhuis.info:dkim,leemhuis.info:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.903];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0E0C1385BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 23:18, François Valenduc wrote:
> Le 31/03/26 à 18:17, Greg Kroah-Hartman a écrit :
>> This is the start of the stable review cycle for the 6.19.11 release.
>> There are 342 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
> [...]
>>   349 files changed, 3991 insertions(+), 1331 deletions(-)

Side note: please trim replies.

> For me it does not work. systemd fail to start the virtual console
> setup. I am using luks to encrypt the root partition. When I type the
> password, it is always rejected almost I am 99,9% I type the correct
> password. I will try to bisect it tomorrow.

Shot in the dark: Does it work with 6.19.10? If not, I wonder if it
might be this issue:

https://lore.kernel.org/lkml/20260327160050.31631-1-liavmordouch@gmail.com/

Ciao, Thorsten

