Return-Path: <stable+bounces-217652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id haV2ATYNmmmqYAMAu9opvQ
	(envelope-from <stable+bounces-217652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:53:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B15716DBE4
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 20:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1AD0301AF77
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C6B33EB09;
	Sat, 21 Feb 2026 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="XHthcOUV"
X-Original-To: stable@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F12212564
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703602; cv=none; b=Sr3C6Y1Czc9dtdw1EF6HB62qDc02VLeC7dQ/OOvUNmPNSezC9ogv7/Vzj8eytDKjm7QNq2MZkPecrpMUt1c6n59q52Jyrytz4G2kBFzZ8RLez6sb5D7e57TU1Br/5YsMYx/tbkohVRxETIO1rojFSuB2/pdKBm/urtsnrx5rH3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703602; c=relaxed/simple;
	bh=2cH/jP8PR65zntl1Pn74rr5Xd5vT9vGJDk5z+nQ0ypM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ItyhQHq9lFjFn3WD/9taJvWQxbThekIAmot+xFZbZyr+SZwqNe7OlDYe4X7waTmp62oIcEE2W+Uz9XOCIjsF4q2BXXUTDhDY1hcIRgdVt9g9RyRpsSgCv24VrDOgxwMx0924L6f0f8emGVB87c+rRIQHLE+zw0GtVCip7pUpLv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=XHthcOUV; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DD31E240103
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 20:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1771703599; bh=2cH/jP8PR65zntl1Pn74rr5Xd5vT9vGJDk5z+nQ0ypM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=XHthcOUV/z1qsuIflLLnrCMiPBJz8PYj+yF/o23JG5oAsA+nzW5bSUpCtifdCHhbr
	 1beQtGD4CE6aJ23CYT+iiVvi2LdVmwLr8LHq/KE4cikMwL8zSU31KeGANzDiuhSzH0
	 hMe9wkJk1m7XtC3MYEj2rgDiWcD5SLlwznjgr07d7/rXFFqXpgJ177vssgXVvARna4
	 oytePjpkRfem9cHLKmxhMi/42EUfZfmdfLdK9+7gEwdn71++1ol2WC+BHeTYNIDtfq
	 s7n+Cd9Hsmga5fyB52/PVgrZEJZ6qvxwyNUPTG5VuCAXRiMkFvSIZtNUrvF7lhhtCT
	 urgPOCZiAGxEQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fJHq30dQsz9rxD;
	Sat, 21 Feb 2026 20:53:19 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Panagiotis Foliadis <pfoliadis@posteo.net>
Cc: Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai <tiwai@suse.com>,
  linux-sound@vger.kernel.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Acer Aspire V3-572G
In-Reply-To: <20260221-fix-detect-mic-v1-1-b6e427b5275d@posteo.net>
References: <20260221-fix-detect-mic-v1-1-b6e427b5275d@posteo.net>
Date: Sat, 21 Feb 2026 19:53:19 +0000
Message-ID: <87wm057u1d.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217652-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[posteo.net:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[charmitro@posteo.net,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B15716DBE4
X-Rspamd-Action: no action

Panagiotis Foliadis <pfoliadis@posteo.net> writes:

> The Acer Aspire V3-572G has a combo jack (ALC283) but the BIOS
> sets pin 0x19 to 0x411111f0 (not connected), so the headset mic
> is not detected.
>
> Add a quirk to override pin 0x19 as a headset mic and enable
> headset mode.
>
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221075
> Suggested-by: Charalampos Mitrodimas <charmitro@posteo.net>
> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
> ---

Thanks for taking care of this Panagiotis.

Reviewed-by: Charalampos Mitrodimas <charmitro@posteo.net>

Cheers,
C. Mitrodimas

