Return-Path: <stable+bounces-237710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHG+JoW13WlRiAkAu9opvQ
	(envelope-from <stable+bounces-237710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:33:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 080483F546A
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6569301184F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D352F1FE3;
	Tue, 14 Apr 2026 03:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="nbJUaWan"
X-Original-To: stable@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D432DAFAF;
	Tue, 14 Apr 2026 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776137309; cv=none; b=DFtw2gjZsaH2P0rqz7Nu/zDMXJwfhtA9ab/4E5LpwJ+MJ1fhxn56qNEX5WNJRSPwJsdzzAQZETJiUTIeGP2afW7D3vp6+o0xjW80QurNaF5T1K4A/JSa2g8W5JqGlvyAmecjzTcbqUBjM2KOKEIKjARZMmplFqwCjx2MHuZ2lt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776137309; c=relaxed/simple;
	bh=WzhR8ac3yEOp2zMvKKyzvfq8XePXKu+s53T0x3Lpx6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtWSVhwJ6DNSi5zwDnSpNtbL7eEsAKSumLH/VqEunMonqybbGdjvamcHh1w61MxKjKMiAavq2bIU4SNjT77LjAP4bhD42j/vzRQlYK1tIhF49J40GV7pVq66xF5Hg0V45ZTIdyGBjHg/5HaXSqAsizZY2zNO3P5aRZAu06+jkws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=nbJUaWan; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CE632856E4;
	Tue, 14 Apr 2026 05:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1776137305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+D5nLW1GDhAKo/Bk9OvKuvEeFOedb91kQLUeJlpesFI=;
	b=nbJUaWanKFfPKbjWVcWEEGzfDtxCeSrdUY0fhdxkDgImTFHacmCJG6aA13d7zfIEUY2XZJ
	jHCK6i72RiTdgZBL+9sPb/HDjrPjcV758yO/EfvwE8WqRVG4qvlZw2vlcxdXULCL/fqnwv
	gsRQVLbUVY6SB9rgdIZUr+26SnacS7Oj9KppZCbs5YLu+50AyQqePI9p2lZIe1T9j1yPEn
	w9BpausCnQBgB0rmgAPuZmjwbXA2awKz7zPXoG+AWL2rreP3Ha/U2mS92lpJYmAdfTtlVe
	ZCAdnp2Tcpq32uihQuBEMJnzW1l5L0eGoNfzE7jxOm/WfIP5XxjWW964pUdaaQ==
Message-ID: <ed4dae33-7c4e-4ccc-82c1-fa1aee137bcd@cachyos.org>
Date: Tue, 14 Apr 2026 03:28:00 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Legion S7 15IMH
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 stable@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260413154818.351597-1-dnaim@cachyos.org>
 <87ik9uua4a.wl-tiwai@suse.de>
From: Eric Naim <dnaim@cachyos.org>
In-Reply-To: <87ik9uua4a.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cachyos.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[cachyos.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237710-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cachyos.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnaim@cachyos.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cachyos.org:dkim,cachyos.org:email,cachyos.org:mid]
X-Rspamd-Queue-Id: 080483F546A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 11:56 PM, Takashi Iwai wrote:
> On Mon, 13 Apr 2026 17:48:17 +0200,
> Eric Naim wrote:
>>
>> Fix speaker output on the Lenovo Legion S7 15IMH05.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Eric Naim <dnaim@cachyos.org>
> 
> Thanks, applied now.
> 
> 
> Takashi

Sorry Takashi, can you remove this from your tree? I seem to have gotten the
PID wrong for this device. I'll follow up with a v2 or fixup once I've
confirmed I got the correct PID. Let me know which of the two resolutions you
prefer.

-- 
Regards,
  Eric

