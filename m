Return-Path: <stable+bounces-268022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HmLNF7LoOmoULAgAu9opvQ
	(envelope-from <stable+bounces-268022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:12:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 096186B9E1E
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 22:12:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=weissschuh.net header.s=mail header.b=bqG7eLnX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268022-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268022-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=weissschuh.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27DE93046143
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B99395AF4;
	Tue, 23 Jun 2026 20:12:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E293B38A706;
	Tue, 23 Jun 2026 20:12:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245530; cv=none; b=p/VLRgCXhRaViK+XIzsbFYLtXrXWTCbn2xa5XDtXaPYT95nGNWewgFGwEtfc3yYLr0qxWWEB1kf8aswCu57cm2ZUrmSLvFdp472DN2AXOC36GlUFoFf9UK0TLMs1M1BEpBD+d9XJq47wAKRSoAn5OTX+wFhjRVDEAgArYwEPNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245530; c=relaxed/simple;
	bh=0aYE8V2ddvHAtdN10ig/fQ5kc92xxxdTh7YuD8roANI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5FdnDV5mXgcC1LKj9FdkwkVR1zHEuTaCWGBQaaeEFu73HIFAqHPf91CScBKd/D96pd0sUjNEDVVWfFAd46GP4/JOIdI434NOSGA7zKS49FiZosN8GFjrPO6cWTc21EXV43JTA+C18eIiz7q8U2cYH3dFNZqMbEDvgrlrsIDDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bqG7eLnX; arc=none smtp.client-ip=159.69.126.157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1782245526;
	bh=0aYE8V2ddvHAtdN10ig/fQ5kc92xxxdTh7YuD8roANI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bqG7eLnXI4+zc89af7lM062lTb+E492oK/otZGyQFJzl9fgzAXUQxfQLHmto4g7T2
	 IIDGgocDhwyl4EOD8jVnN9+oaNxE9dJHR8H2tEBFHCG5jAUxFpEVeKmQ/3tcrtkDfb
	 KYgaWuXc646aLkQC+n/s02lvbIJmkv8mjfzRD+Ds=
Date: Tue, 23 Jun 2026 22:12:06 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH] driver core: add missing kernel-doc for union members
Message-ID: <f37b38b3-8c50-4fdb-b99d-ccd7d518857f@t-8ch.de>
References: <20260623190023.407781-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623190023.407781-1-rdunlap@infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268022-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:linux-kernel@vger.kernel.org,m:rafael@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[linux@weissschuh.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:email,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 096186B9E1E

On 2026-06-23 12:00:22-0700, Randy Dunlap wrote:
> The use of __SYSFS_FUNCTION_ALTERNATIVE() adds an anonymous union (or
> struct if CONFIG_CFI=y).*
> 
> Describe the additional struct/union members to avoid docs build
> warnings.
> 
> Warning: include/linux/device.h:117 struct member 'show_const' not described in 'device_attribute'
> Warning: include/linux/device.h:117 struct member 'store_const' not described in 'device_attribute'
> 
> *: kernel-doc ignores CONFIG_ symbols in source files; it is using the
> first definition of __SYSFS_FUNCTION_ALTERNATIVE(), which is struct
> instead of union.
> 
> Fixes: 434506b86a6c ("driver core: Allow the constification of device attributes")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> ---
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: driver-core@lists.linux.dev
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org
> 
>  include/linux/device.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- linux-next-20260619.orig/include/linux/device.h
> +++ linux-next-20260619/include/linux/device.h
> @@ -99,7 +99,9 @@ struct device_type {
>   * struct device_attribute - Interface for exporting device attributes.
>   * @attr: sysfs attribute definition.
>   * @show: Show handler.
> + * @show_const: Show handler (read-only).

Not a big fan of the wording, but I won't bikeshed.

The subject could also be a bit more specific.

>   * @store: Store handler.
> + * @store_const: Store handler (read-only).
>   */
>  struct device_attribute {
>  	struct attribute	attr;

