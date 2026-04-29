Return-Path: <stable+bounces-241878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKDwJpP88WmElwEAu9opvQ
	(envelope-from <stable+bounces-241878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 14:41:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195B949430B
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 14:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48C030EC287
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB738D693;
	Wed, 29 Apr 2026 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kRO0H9/q"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F929BD95;
	Wed, 29 Apr 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466214; cv=none; b=EMHuTFgtNUiOLghuXKch9WDyuNgtsuc9EsUSDcPHeDpusKHOYopsBtDt/lfelJNSUuAKYV6N3fbYnqU2gnxUVHmzcnZ6rYhA2+ssicVK8hzR8A09uiOlvkGFYAOkEZrcVN4aTtRUNKO5e3GRCniFy0eR6OS3bDJyjXMyh5g8IJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466214; c=relaxed/simple;
	bh=0AiiLv1Nenp+t6rSfigFWH/SNDVGs2T0BC7RcNFcbiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTBiArZqA+99mKk5UMJg3I87ZXB3Y1YZiCcde6UHmuUJhOAlI4knv94qhA9zJTHUimVl8fYSB48xpFiRK7z9McjIPB2mOtSiJ7iplxCkIEtGONgzIXfXC+UQ5XTb0mpwDfzosYdiyzNnsDZtTrLMgtbWfBXjLXZgHxGWepT06UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kRO0H9/q; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Apr 2026 14:36:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777466201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w30PbnAEhiTyBhwB/vr+gqiUgiFw0Yl0Fre0bR3ABzE=;
	b=kRO0H9/qf8nG5hVeHsQZziJgazi4ovT60hckLqP71ZkvIugYh9YnmYKE0EBfSBzJ7wmTWv
	kAsc7Pzt1GhDUq9m0wxp4Wyd0CtIq7mW5x4QUKHyhJBsZjesgGks9BMHZoYNEzk4yowFF7
	GZP+Tpa6j5wiU3eiBGekTKu8zstGy4k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Olaf Hering <olaf@aepfle.de>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	stable@vger.kernel.org, Ky Srinivasan <ksrinivasan@novell.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv: utils: handle and propagate errors in kvp_register
Message-ID: <afH7VELGgh8eGBUC@linux.dev>
References: <20260414111008.307220-2-thorsten.blum@linux.dev>
 <20260429142724.4d74641a.olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429142724.4d74641a.olaf@aepfle.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 195B949430B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241878-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid]

On Wed, Apr 29, 2026 at 02:27:24PM +0200, Olaf Hering wrote:
> Tue, 14 Apr 2026 13:10:08 +0200 Thorsten Blum <thorsten.blum@linux.dev>:
> 
> > Fixes: 245ba56a52a3 ("Staging: hv: Implement key/value pair (KVP)")
> 
> Please do not abuse the Fixes tag when it fact this change is "cosmetics".

What makes you think this is just "cosmetics"?

