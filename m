Return-Path: <stable+bounces-27512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B42879BC6
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9DA1C21AE6
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22053141995;
	Tue, 12 Mar 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="IvxOvlVC"
X-Original-To: stable@vger.kernel.org
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB479DD4
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.217.248.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268969; cv=none; b=VLvO+yzwuttNm6LpIQ+CYH10g0MxnwllvFqZmo4MUO5+WiswxegyXU6OR+eyknfbzvboY/duuTGu1EHHk+AVuCcZNxjo5UQV/TaCL+YGOpWBdHZ3Jagg4Ibg6O26UcsLW8KOUtFLWEnpVN0cdz82tO8x2WhcpiiTTIeF89g11YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268969; c=relaxed/simple;
	bh=l4dlNYc4tBoZ2E4xUmmIf+GLxBScNZeT6o1fKTSwhDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jD5YTkfHq6io9VHfUisg+7BxOrjy/3boQAXI1etmY5FzVgCxQs7ExXni3gRU2rSjAqSg5PpJDg+hk7ypLQU6HwEudVhyiVM7usJm7urlTvkvGA1HhsjIox0AmEdHU0CFjssGks4Vp29n5QmFCE+tDpYmb39h0jmRpvJKg4giQy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=IvxOvlVC; arc=none smtp.client-ip=144.217.248.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 8B7123E88F;
	Tue, 12 Mar 2024 18:42:41 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id BE87E400B6;
	Tue, 12 Mar 2024 18:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1710268959;
	bh=l4dlNYc4tBoZ2E4xUmmIf+GLxBScNZeT6o1fKTSwhDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IvxOvlVCNc2JxyLm71Xa/F/g975rghU5038soitpXQYsW67BjhuSMb3IZf/EKFUjm
	 f2pBAERjFa0Jwlqhc8OliqLSiAmbOPUEShWQV/60heaL1sQ0M+SgSvaEpxw0gJemlq
	 whaO/20ihke/sAI62BlGcyv4h8S5Hzu+Hv0w4TtI=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 2321A4104A;
	Tue, 12 Mar 2024 18:42:33 +0000 (UTC)
Message-ID: <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
Date: Wed, 13 Mar 2024 00:12:31 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
To: Steve Wahl <steve.wahl@hpe.com>, Eric Hagberg <ehagberg@gmail.com>
Cc: dave.hansen@linux.intel.com, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com>
 <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
Content-Language: en-US
From: Pavin Joseph <me@pavinjoseph.com>
In-Reply-To: <ZfBxIykq3LwPq34M@swahl-home.5wahls.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[hpe.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BE87E400B6

On 3/12/24 20:43, Steve Wahl wrote:
> But I don't want to introduce a new command line parameter if the
> actual problem can be understood and fixed.  The question is how much
> time do I have to persue a direct fix before some other action needs
> to be taken?

Perhaps the kexec maintainers [0] can be made aware of this and you 
could coordinate with them on a potential fix?

Currently maintained by
P:      Simon Horman
M:      horms@verge.net.au
L:      kexec@lists.infradead.org

I hope the root cause can be fixed instead of patching it over with a 
flag to suppress the problem, but I don't know how regressions are 
handled here.

[0]: 
https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/AUTHORS

Pavin.

