Return-Path: <stable+bounces-268234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bp7wCnp6PGoMoggAu9opvQ
	(envelope-from <stable+bounces-268234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 02:46:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A09276C2071
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 02:46:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=OIPuJwZO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268234-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268234-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12272303F05E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 00:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8D35F199;
	Thu, 25 Jun 2026 00:46:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34C35E940;
	Thu, 25 Jun 2026 00:46:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782348405; cv=none; b=iiWeLUtW2Adsrqx3G3zFqfZgPTSwrvIooUdhGoagvek5kIxVm8zdlpyz8VAZmDVbwFK7jqgTd3RGOfTPkmi2n/vQ5kmFYYcHI3doI2+QJzEipYYwYS4oA3MFhVr6/0FMSw30TF8KK/nte4nMG0UJ0zLWCR9vGdnOEjAwJ8TYnYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782348405; c=relaxed/simple;
	bh=67MthuxU73U1xA9VK2d01iwIZdi+ncVNZ2vKuf5Yl3o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MU8KS0ZOEBUKb3/h/F1edUoE+ZwQ2FaPh/3ELiEnpbY/eoFZDP3r0vYdIQDJVgJFRmqj++bVwgvvliKLiLKJP1QtmtzPrIApaGV1xNktGAqBnKg3bjxFoojPKrmhoJt3uTX2ssbn8BmTHE0RFlYV5nQPq7zu08taBWasGDPy+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OIPuJwZO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078D81F000E9;
	Thu, 25 Jun 2026 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782348403;
	bh=OHXgIzAq1ABZ6fiQ3NfXaitG1aotS7Mupzd1wlwLSx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OIPuJwZOZapWq1v3vaakOmLIHv9zLawflrgUu9yGeNcys6oKU01XztCJgiOKCD+ye
	 8427eZwz1ae8baJy+pTm5IR7lM6NSwusqV6hOZpMMWrh2HDKqPzcK4TkVqv5TiaN0t
	 YnL9sy6YRlrNCp4FRJ6rYxqNiuUMnaKO98w3VQHg=
Date: Wed, 24 Jun 2026 17:46:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Kees Cook <kees@kernel.org>, Matteo Croce <mcroce@microsoft.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] reboot: keep parsed reboot CPU in range
Message-Id: <20260624174642.da2cc6912a9b19accd378538@linux-foundation.org>
In-Reply-To: <20260622154216.10064-1-include@grrlz.net>
References: <20260622154216.10064-1-include@grrlz.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:kees@kernel.org,m:mcroce@microsoft.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268234-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:mid,linux-foundation.org:from_mime,grrlz.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A09276C2071

On Mon, 22 Jun 2026 15:42:16 +0000 Bradley Morgan <include@grrlz.net> wrote:

> reboot=s... parses the CPU number with simple_strtoul(), but stores
> it in an int before checking it against num_possible_cpus(). Very
> large values can wrap negative and bypass the range check, leaving
> reboot_cpu invalid for migrate_to_reboot_cpu().

Thanks.  kstrtoXX() is the modern way.

> Keep the parsed value unsigned until after the range check.
> 
> Fixes: f9a90501faac ("reboot: refactor and comment the cpu selection code")
> Cc: stable@vger.kernel.org

I don't think this is serious enough to warrant backporting.



