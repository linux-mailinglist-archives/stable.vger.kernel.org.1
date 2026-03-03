Return-Path: <stable+bounces-222905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMjsJtgLp2kDcgAAu9opvQ
	(envelope-from <stable+bounces-222905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:27:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC831F3C42
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53250312D1BB
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179734DB549;
	Tue,  3 Mar 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="EP9cpmpX"
X-Original-To: stable@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF94DA535;
	Tue,  3 Mar 2026 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554990; cv=none; b=SeDVd1c0TmhfoLBdVz7c3j9Hqs3XHdmI2LuhfXJySR+ggiMnpiMuU9zRC4yxK4/U19UsHPXuff+7ra7n3bPd9veArEZfP0sBe0pXSRTMzV4uyp3YY2JVF8qtiT7CKJf2xfiSR+N9SDnV7fClqAdWIfaC5kwS6aN9uZkVupUF3es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554990; c=relaxed/simple;
	bh=c387aLCQdXYFSYbwsR4Veo4DFnlWEejCosFk7YnqKM4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=jSj3Se1xkJenlbQPXfqLwVeAbAFIY1q5bxHIgruGCCN+zvPaSatNeZZdDRi7ExUrfrHlyTZJQKucziXaB/hIlyBLGla8i+fVd3fdnz5LRulah+7wjMuIZl2tILAOPPjP9TMkFIR+LK39fWmzEH6XVUP3Nlp9NuHKxo5UH4+rMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=EP9cpmpX; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3XU0kehnvWrcKYHKgel0/xHOmH34b+yFHPZHUnnR7DU=; b=EP9cpmpXUdqoEKJjhaJAscQj+q
	ERr2YdHhoZa3uZ+fkZ4HC5sqjhusS1J05lLX1QVygyQk9gXco7ygJmsDcPOfLklWdUR9OIW5MU6r3
	GxIw66iS1OFhLrsJN0V3CpeKsQhPn0T8aroY8jr6LzMvP3ZZs/XDldL4FKAY62KZGPLV0Ojomd2d6
	pyvMg3SrOUe8gfsOjAOKkmuI8SZ5tIun0XDD/lkU6RBaTYwaVoMyVUhKwzAvPkWjTpxTCKGzq9EQ4
	twg25N4c/0RthJ/McjBur6DWeGMLKBBzs5ZDg9IrFiytBdvfpVWQ46r7Xan+Nc/b2GuIoGacQ8OM+
	sVgb0O6Q==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1vxSWS-00000000Ae6-2bOc;
	Tue, 03 Mar 2026 13:23:00 -0300
Message-ID: <b3b9f12347367ea4f0ab1f255e79cf35@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Eric Biggers <ebiggers@kernel.org>, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org, linux-crypto@vger.kernel.org, Ronnie
 Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N
 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM
 <bharathsm@microsoft.com>, Eric Biggers <ebiggers@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH] smb: client: Compare MACs in constant time
In-Reply-To: <20260218042702.67907-1-ebiggers@kernel.org>
References: <20260218042702.67907-1-ebiggers@kernel.org>
Date: Tue, 03 Mar 2026 13:23:00 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: ECC831F3C42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.samba.org,vger.kernel.org,gmail.com,microsoft.com,talpey.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222905-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[manguebit.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Eric Biggers <ebiggers@kernel.org> writes:

> To prevent timing attacks, MAC comparisons need to be constant-time.
> Replace the memcmp() with the correct function, crypto_memneq().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  fs/smb/client/smb1encrypt.c   | 3 ++-
>  fs/smb/client/smb2transport.c | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)

Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

