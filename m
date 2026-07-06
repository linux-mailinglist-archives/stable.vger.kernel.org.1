Return-Path: <stable+bounces-272167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MU9wIs16S2qDSAEAu9opvQ
	(envelope-from <stable+bounces-272167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 11:52:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D92070ECB0
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 11:52:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=do2eLCyc;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=TZLAGWVG;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272167-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272167-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF4E130B0CDD
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746E366806;
	Mon,  6 Jul 2026 09:30:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416933F588
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 09:30:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330221; cv=none; b=RRB2HfzRFr9oer/pV14x5sEdlRZFSGZHKR3+J7x4jrvv+i0tz9uiJy8WK7lAIWtZNLhzn4IjCY9TVJNjp+hTIgPjAzS0BOl9rJewD/Rseznq6/wDHrOfBmrMcjpL8hWwCC8i8JNpBwZIkBx1hZWtSVkaRZWuS/N3cc4xqjPLZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330221; c=relaxed/simple;
	bh=KP+uKZiu8rS+uPOHNzCRU28Ii/xFlt5AO5k9H93CzXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+HWRZWRtRUon2sw/GmXDCKiG6x32yPfoy9qwX6YbPIsDCM55LWs7myS3s2VyvJJ4iDcC4sz/cNRL3cG+HM+8WN2uIrGFrXXnqe8MrE0jj5UhS3CjBaB9DCv9IkiDe45Idy9Te5x3eWgDSYEy+5CZj0gKPfI2CAODDQE6HwqmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=do2eLCyc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TZLAGWVG; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 6 Jul 2026 11:30:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783330216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/sP+9IJHiTcPvRDofoirdvmhhmP1Ud1uACSRGWuNwE=;
	b=do2eLCyc8Yc9kH+7qI4ohRE03/OYiwp7JkQljGX/+wvDB/QlU6YXBbGLUkuPRtR+YKmnnj
	rGYq1hCKMic6rpHh/7DvJeIc/ZTqQ89BObOScjLGDYWiSGvfHmUrYDqi0JnU3aP6XVduv2
	vmVwWPMO4Mbod1SKn+GwJN2grz6556rhW7aOsT7XBDzHCFhAVlanF8SRwCtfRR0peyV7D4
	LuwNeHjJGAAf+Btj7t1d7jtxGXa1TztzBcE0y0ZtK3unbhJxsuQ8rN8Axn6OnFrDt63aVA
	pr1hP7gDV/F56N27HuNi8m0JuRf0yuTHhCsQGdwi7pCAVyhkVWtJeu/nNiviww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783330216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/sP+9IJHiTcPvRDofoirdvmhhmP1Ud1uACSRGWuNwE=;
	b=TZLAGWVGbLpXn1gVLa8SwjDFIkbX9ofsHFWOf/DMKjeVAXwhYmcYLxz5OitfGWyW3qSYd2
	ypot6E0K3Ip8gLAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v6.18 0/3] ARM: PREEMPT_RT backports
Message-ID: <20260706093015.YFRtVKDu@linutronix.de>
References: <20260629144131.788576-1-bigeasy@linutronix.de>
 <2026070229-rendering-plus-be9d@gregkh>
 <20260706085940.3lUHUu8z@linutronix.de>
 <2026070604-washday-tightrope-dcee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026070604-washday-tightrope-dcee@gregkh>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272167-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:jan.kiszka@siemens.com,m:j-humphreys@ti.com,m:rmk+kernel@armlinux.org.uk,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linutronix.de:from_mime,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D92070ECB0

On 2026-07-06 11:27:33 [+0200], Greg KH wrote:
> Please let's have new features stick to feature-patchsets like the -rt
> kernel is, and not put that burden on us stable maintainers for
> something that we don't use :)

Understood.

> thanks,
> 
> greg k-h

Sebastian

