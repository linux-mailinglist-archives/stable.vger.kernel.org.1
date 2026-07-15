Return-Path: <stable+bounces-274728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yUTDL7cQV2o5EwEAu9opvQ
	(envelope-from <stable+bounces-274728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:46:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6588375A82F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:46:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=gwNwi5ZO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274728-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274728-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E0AD300C0E7
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B81A352009;
	Wed, 15 Jul 2026 04:46:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F303603DB
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 04:46:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090804; cv=none; b=Xiv/BHU8zFvZ10CO977NB5Aj3K+a9EljmRTHTA4T2fxGV1G4dCL6pPRAe97XOgalRCtSEFtkH9j/hA0zSqQNi7Ez3vsPw8NhlYN4xG/Ucb8UUa6kbHZJop1RDRtXsrK+GTMEz7m7xPat+3sIMBGmxfggzwaUhjsfyKGhWYqyEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090804; c=relaxed/simple;
	bh=jY/BeOxBb5fV1kgcjRS/xmlBjYHJVOAXMwEIqs1IT1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuF3IZNJSkXj0nHIg2QmDG3oK4SYLCAHFuNxLR8Eym6DDsn/0O33sGQDps69R3MzK2IMN268uPgeCX7gwLerkWAtJRx/bj1KoAc+qLpoJXvI+HLBEgt4LqhDDg+CaXAkAlrw4lhzfJJO/Vw/3m9R8kzoGLN65sLhGHzVaZ2ijtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gwNwi5ZO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD191F000E9;
	Wed, 15 Jul 2026 04:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784090802;
	bh=ocsijGN9KEQMu0zf8iIykb37wYZKngOKg+5mySAYPRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gwNwi5ZOJEKv69QGQFsdGb877trzzGolYUwEYrdPromBpnGlzUa3ghlqSlkrZo8d9
	 gcreS1/zhgGFMzOU8yM2ZYwwa4lgN0zAjl2Zh4Zz2kkoiG9BHFOBw8nsKAcLcCJr1h
	 IaIW6D8K9KH7bz99n3sgPe3h4MWUX0rw9bAPYYAg=
Date: Wed, 15 Jul 2026 06:46:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Cc: linkinjeon@kernel.org, stfrench@microsoft.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] smb/server: do not require delete access
 for non-replacing" failed to apply to 6.1-stable tree
Message-ID: <2026071515-dutiful-anthem-39fb@gregkh>
References: <2026071409-clamp-reminder-aacc@gregkh>
 <b5901dc2-0d5c-45ac-a817-81e2a3934131@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5901dc2-0d5c-45ac-a817-81e2a3934131@chenxiaosong.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274728-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chenxiaosong@chenxiaosong.com,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6588375A82F

On Wed, Jul 15, 2026 at 09:58:10AM +0800, ChenXiaoSong wrote:
> linux-6.1.y linux-6.6.y linux-6.12.y linux-6.18.y does not include the
> bug-introducing patch: 13f3942f2bf4 ("ksmbd: add per-handle permission check
> to FILE_LINK_INFORMATION").

Ok, so what does that mean?  Can you provide backported patches for
these branches?

thanks,

greg k-h

