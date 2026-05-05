Return-Path: <stable+bounces-244192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKvOKMQI+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:12:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A54D004F
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF88B3067C78
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1A480DCB;
	Tue,  5 May 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uE32fe3z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3kiH1zys"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE92356C6;
	Tue,  5 May 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993425; cv=none; b=WlMT+Anz1Ne5/IEafF4BQ+7N52Fh+SAhFAIwVRxMY2c7zBemt83ZUQyt2FtdVKP/N+NGDVaQ2arKIY4UI4h09st7nx45VKUuW9PkS0Hq9Y4hF4dSyiov6c1/dgMB/9ZbdfXaR2Nmq56Sv7nrZJsAVYGGJU/qxZeofG09tlyAVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993425; c=relaxed/simple;
	bh=EQ9EXE/Ffr+wV6+CRqHxSfRAY/71wYjgxoE+F7UDlrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIO+l1J/X2hU36S3eZDUk/YxC27j1NGFqRlYw47vGexeuCgK7U2Z4IsGk8Q5Ycyl6zkzQBy79jVJefbaMBV4+ZxAaajq3sX8yfVV7kLy/Cx4XNagoi//JjfUAmUKNcbSesYem9PIaOPzE779X7CyYm5ueX6NciROlX9g0aHdqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uE32fe3z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3kiH1zys; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 5 May 2026 17:03:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777993423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jeObJ50rpgkfNuNh4GvqKDfd9XAxKCOQpO9eF+O9Zc=;
	b=uE32fe3zS9u8zUQ+VD6DHLGJnQqN25MaOZf6EeWN5O+hfwFht28WkZJjotpt+VN0tR+fx+
	Aw9AX3IG8iWPtkV9UHiR60ZeAuzq9i0pw148HONcDOPbxQJL6fsNUovq3UDQk+Z1lCFdO8
	aVFCCWhpCq7iLsq4LjAl9oH7USjvEEA9np057ewJoAdB57YIufBI+2YoyfhhyjiuB6UPrR
	nYABPBc+kQhKhExXpuyd2icMzDjDTpowaQN7XHFR+p0sfx8ppK8kbb6dbFu1AmMT/e5Pkf
	MQZFpRxde56OfzdTDF74c7vGLXMUtG8c/WsmiLEzBw2lgjHDqgy9Jt9Nt7U7AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777993423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jeObJ50rpgkfNuNh4GvqKDfd9XAxKCOQpO9eF+O9Zc=;
	b=3kiH1zysGnF3cWBWGrygXcD5AFxrZDRJznIst3RYw/o8Q7s6unc6jNgXDt4P0xN4tHXXpT
	DvzFZ3FLjIdJMhCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org, clrkwllms@kernel.org, rostedt@goodmis.org,
	ming.lei@redhat.com, muchun.song@linux.dev,
	mkhalfella@purestorage.com, chris.friesen@windriver.com,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
	ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: Re: [PATCH v5 0/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
Message-ID: <20260505150341.me97WNAn@linutronix.de>
References: <20260303073744.20585-1-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303073744.20585-1-ionut.nechita@windriver.com>
X-Rspamd-Queue-Id: 175A54D004F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244192-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,goodmis.org,redhat.com,linux.dev,purestorage.com,windriver.com,lists.linux.dev,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]

On 2026-03-03 09:37:43 [+0200], Ionut Nechita (Wind River) wrote:
> Hi Jens,

Hi Jens,

> This is v5 of the fix for the RT kernel performance regression caused by
> commit 6bda857bcbb86 ("block: fix ordering between checking
> QUEUE_FLAG_QUIESCED request adding").
> 
> Changes since v4 (Feb 13):
> - Rebased on top of linux-next (20260302)
> - No code changes

Anything wrong with this?

Sebastian

