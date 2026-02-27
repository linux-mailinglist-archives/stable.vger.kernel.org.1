Return-Path: <stable+bounces-219912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zv0zDFEroWkpqwQAu9opvQ
	(envelope-from <stable+bounces-219912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:27:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D01B2D92
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F38630FCA05
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 05:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD353803D1;
	Fri, 27 Feb 2026 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="d036tyTZ";
	dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b="D33zxi28"
X-Original-To: stable@vger.kernel.org
Received: from hua.moonlit-rail.com (hua.moonlit-rail.com [45.79.167.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376EC37C102;
	Fri, 27 Feb 2026 05:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.167.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170059; cv=none; b=BsRLG518vAEywUY6S5zr69vZZNs1TfTBjYfOAxGrRbbcNkd7WdvKRKZAgSR2tL6Gm2gguihvNtR4axs2pz29+vOPKx1baTMY7wYc96E518tfWT7PkSexe5UKNwasZXS82O5+HGZa972ftRN6FEz74nKn2xY5/vKggd+5ko2WC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170059; c=relaxed/simple;
	bh=sxnMeHZCwiNs2BgjRyP06r8Gb279XFuNovUg/2DLA8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1rwjGjuODlm53eQ/P1tzGOCAPBj+wk1JrKI+M3sSNysw7uraw5XgCHmlU5HhcmcA1Vbo2EBcNZUflkSfdgIp26ywbDCbGsF1Cw1LsfjByDxPSyVM0VxgMmKHQooinemwTsutVUbWdNbudLNnZ5ixdki64pWXrudSVizD74QkAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com; spf=pass smtp.mailfrom=moonlit-rail.com; dkim=pass (2048-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b=d036tyTZ; dkim=permerror (0-bit key) header.d=moonlit-rail.com header.i=@moonlit-rail.com header.b=D33zxi28; arc=none smtp.client-ip=45.79.167.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonlit-rail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonlit-rail.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=rsa2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YIVNhD/+poBRWeiED5OoPo7UFbNSXHdfz39AgFgAGzA=; t=1772170054; x=1774762054; 
	b=d036tyTZ/RsuBZM/2JK/Zpegahge2i1Q/F1szxvZiRPH/MC5MvVVDZu6OltoAs/6ZrdNWLixwPi
	5DntY125yRhhYVCIOWSznOheBUS5RhbWmnZ/IaEtg7TcmEdUrY1sp7Fy6L7ol6taHY0LwL97qyetr
	J8vNqsdDfr0UPlKCNSzQXFBZeIQaeZeJM2L+a1+bRtLaM1nFM3J+GcWYcvws9c0Tnbkph5zufhZaS
	Kb7/KZ8aoilpoaqq5sbPSzbyja1AVdJlsCTTvXaKqzMEySFSOs4CyOJHZvPNN9fjB6dXlZrWzyScX
	lOIUuZOrwAgGQyNLcbLLcW/pQ26vWZwbw2Fw==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=moonlit-rail.com; s=edd2021a; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YIVNhD/+poBRWeiED5OoPo7UFbNSXHdfz39AgFgAGzA=; t=1772170054; x=1774762054; 
	b=D33zxi28BRk6KqKHwHR4jbVqcpIcd9bSpxCM7mSvZprc7c4L3ysJgtgg7NruYjxaTs2lXSW3rTQ
	84lEiosKCCg==;
Message-ID: <0237b8ad-79e4-4181-82ac-b2d176e304e3@moonlit-rail.com>
Date: Fri, 27 Feb 2026 00:27:33 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.19.4 - Oops, regression
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org,
 lwn@lwn.net, stable@vger.kernel.org, torvalds@linux-foundation.org
References: <2026022657-clambake-mountable-8175@gregkh>
 <eb2d1da9-0b4b-4887-83a4-0e2a65e703aa@moonlit-rail.com>
 <2026022612-buckskin-surfacing-d854@gregkh>
From: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Content-Language: en-US, en-GB
In-Reply-To: <2026022612-buckskin-surfacing-d854@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[moonlit-rail.com:s=rsa2021a,moonlit-rail.com:s=edd2021a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[moonlit-rail.com : SPF not aligned (strict),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219912-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[moonlit-rail.com:-];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bugs-a21@moonlit-rail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[moonlit-rail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 820D01B2D92
X-Rspamd-Action: no action

Greg KH wrote:
> Kris Karas (Bug Reporting) wrote:
>> Just tried 6.19.4 (and 6.18.14) and am getting a repeatable Oops...
> 
> Ick, not good.  Can you do 'git bisect' to find the problem commit?  As
> you have a pretty reliable reproducer it should go pretty fast.

Sure, I'll start a bisect.  In the meantime...

> But first, does 7.0-rc1 work or also crash the same way?

Appears OK.  I'm typing this on the affected system, running 7.0-rc1, 
and even with a couple manual network restarts, it seems fine.  Likely 
it's an issue with the backport to 6.x.

Kris

