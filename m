Return-Path: <stable+bounces-273665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1b2EN63VVGo8fgAAu9opvQ
	(envelope-from <stable+bounces-273665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 14:10:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A5D74AC1B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 14:10:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=o2+YTzZL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273665-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273665-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F29563047541
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 12:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947603FFFAD;
	Mon, 13 Jul 2026 12:05:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42F358378
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:05:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944333; cv=none; b=Xrn4S8H1jKkDYmjf+jDJz2w8FDvuP+coLp1SMbzJEbx4zXoHJ49ug5dcEep4juocizx1C6TjUUD8evbk22vmbj7UsDJ6axIFVaTqXrHjvyszx5k4HBQmXOVJyXl52lCdOXavxTKZ3ONWdVxRynam1qr5X4EFbtxeH7hSTIy3h/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944333; c=relaxed/simple;
	bh=X+1tYe84z4bb7EWTIstk0X/C27YSYRtRGCsSNLnVKB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpLSzLWdF+LKunCAXrFhrWsbc4diDDjTa+nOMkRrhDzbSxzEDu6zP8w//p9GvWDv+fh0H3A0B+WUUP35V5gylJMJUrCkogglf17aqX6EtsGVdwrXml0fwLDR+pYoR+QwdjTtyzhzdGZm2jjC2EjkKYSH1bzQQgTY9D8x/pND89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o2+YTzZL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4331F000E9;
	Mon, 13 Jul 2026 12:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783944332;
	bh=VXIw5C47Y22gfHwOkzKTmAgBRcyUToRxJ17pDgxRo1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o2+YTzZLGFNz4pdzjKYRSmjPqVf4tTLVHsi4eijIaUxI2sa0H2jO8eqiAJWc6Z/r1
	 CDVKEAeOeBfe+Bb2h/pL8Pa2zKUkMff2G7RgNhEUrn+ncnWPib59B4AT9bU9tDbO71
	 aJYrStSdchiIPR3fWJiGgqXptYBYoin/+LUS0vjc=
Date: Mon, 13 Jul 2026 14:05:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: David Timber <dxdt@dev.snart.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>, Andy Wu <Andy.Wu@sony.com>,
	Aoyama Wataru <wataru.aoyama@sony.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1] exfat: bail prematurely from
 exfat_extend_valid_size() upon fatal signal
Message-ID: <2026071359-overstep-gambling-73b9@gregkh>
References: <20260713061954.19557-1-dxdt@dev.snart.me>
 <2026071352-bunkmate-anymore-0962@gregkh>
 <59343a70-1d74-4f37-a6a8-5a65fd585b90@dev.snart.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59343a70-1d74-4f37-a6a8-5a65fd585b90@dev.snart.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273665-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dxdt@dev.snart.me,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:yuezhang.mo@sony.com,m:Andy.Wu@sony.com,m:wataru.aoyama@sony.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8A5D74AC1B

On Mon, Jul 13, 2026 at 04:55:34PM +0900, David Timber wrote:
> GKH,

Please don't top-post.

> Just a quick question: the
> handbook(Documentation/process/stable-kernel-rules.rst) really insists
> on putting an upstream commit, but this is an interesting issue that
> goes away with the iomap patchset set for release in v7.2. There isn't
> really an upstream that explicitly fixes it. I don't think it falls
> under any of Options 1, 2 or 3. Should I just remove that line?

If this is not a problem in Linus's tree, and this needs to be fixed in
a stable kernel, you need to document it really really really well why
we can't just take the same commits that are in Linus's tree for the
issue.

And even then I'll push back hard for why this is needed.  Be warned :)

> Also, in the last patch I submitted to you(SEEK_DATA/SEEK_HOLE on
> /dev/null), you were against the idea of using switch...case for
> inaction rather than action on a value. If you ACK, should I just use an
> if statement like so?
> 
> + if (ret < 0 && ret != -ENOSPC && ret != -EINTR)  {

I have no context here at all, sorry.  I'm not a exfat developer, and I
get 1000+ emails a day...

thanks,

greg k-h

