Return-Path: <stable+bounces-241935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMwRGr1a8mlYqAEAu9opvQ
	(envelope-from <stable+bounces-241935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:23:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1027C499BB0
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 21:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25AE330E26A1
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 19:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14F3246EC;
	Wed, 29 Apr 2026 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYSnVTNF"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84BA301471
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490354; cv=none; b=QQepYjrBdcz5iEPEDDHPiBDP15xsKr+qifqyKMxuErrk6v/IJDSPv53fWI+5WF4Qh2bKgMSNG1rlj11F5fOyBfprA3gb9AAg8UL8me+A5AEY95dcHBNpOfTsT/GSqzNZYKvGoHLcGyvMireFn5YGV+05nXdeSt4H0b5nid1fCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490354; c=relaxed/simple;
	bh=kE6z6ho481l3cRMIBg1rjaXuPr/oIN2dimR6vL3X4OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXBiY9UtvC6KjGQom/VsTNGfC3DGpLLwY2OYPHA3uApTablCsnh9DL/wEHeHcqiqAI8vbvaz8J8APd4QgRfxEqgNVuSlpHB8wSQBLsYxrH+bFDFCKjc1dBEQtREvHgOpb6LOXQq1P7Mpkz5sOfRhAjH/6Kt5XQF3vinm+gLYOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYSnVTNF; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12de530cbf1so353940c88.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777490353; x=1778095153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01rquaTt7d61QtrEpYATFjqsbMMGQjEoJs+Y2dcPj8w=;
        b=JYSnVTNFLCdlQ763sQtm2Wly08DJv6/hbybz83UsID4Jm5UOVq18R8wjWxg/RRMNEZ
         4si19zKAJqBM4dKxIX+zGIHF+DHBRFSRwDyfDbqL6UvTvnG/SIGdCiGu0g1zuOmIJ3mW
         PWFwuoGLxmIzspyAx7vkpKW3PfrL319H/BrD8wcmvJc3NVn1+UmTbyCTiKfwbZLkgoAa
         CnVN/Nna8CYct1fwo9GIqkqb57n1g7sADA15x41Kguxay3l7Borf+ZtdLN0TFAF4u2Vv
         rHO/7tSrD/x2RMoaE2nN7vKdtH4syZpfT+qMJkU5iHYn5/0vE1B8Knn9Ahhr7HIL2ZcN
         bMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777490353; x=1778095153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01rquaTt7d61QtrEpYATFjqsbMMGQjEoJs+Y2dcPj8w=;
        b=de+jpI+kN3EbJtwcifW4bFvnp4UZBLmfiFdotIlwgeTPuh8yAMiXXtZobWkJJTKZGO
         YxJkYOn+xW0JFtU9CVKjyYJNlU8fcJ2ZZxH4ickID5htake2M7w/voz15kuj4Cj/VmGm
         rYk/Iqqz7PA0cPmLRtJ0n8pJFEpZ50r2zZSlbvxF3NW6S9fczYHEYh737YCPBekFQXLk
         h+R1EmvL65GUJwwV6+d7fuGHOBGwc9EhwcxEeZ0K1lX0SLqfPuVZxxPwlTaaJpUU6T+J
         gk1LTY+xh/7R8O6IL8cITkZSZeu571CDBZhOj8U9oFqzhi5d08GVYF6oxJWuxzif+/Ox
         0OuA==
X-Forwarded-Encrypted: i=1; AFNElJ8iy7miVziA+uZUPqxki0bRfbQoX/U1s8u4yjuGpHgpB1d0mAdm0OACswarZHZwU1seb35MW6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWAGS7ppJPkFuHbXXGIoARGiVETySZ8nwFhwW22EZAzupNskR
	AyrdV5XUl1YyMVrydRsae7FZsJwhnoWTnEFDZCH4jP7TY2fGFGuLGqgh
X-Gm-Gg: AeBDietSYei42W6dm5iEsYS53JjmrA7CsP7oAvd4mIYCrGohIRi5nVNNQ+0VpkFJEYR
	pFo6WeSryk7adKsvW4EGxibSd4OMLPQQ6ORIl8UhHX0mFLYdbDA6pwrmqNxZkJgZwWStpi2mBeb
	RtsWMxLAWW5SLyfsLDVIMBkT+PZxp2iyUhglIPI3rPJVsoG4QzPjAchUg3VfNePg2atn2vnyBya
	W7GCOcukv34ZRoF9o7GDNKZPkaTagRiHTsTABXGoOe3tb3L9969h1evKtt49Th1W1XG68so4RTF
	P7JSTIAcVrXpS9OqnQlgWRWckr2vzQV5qUJWCQJmwd/Cypb0BVGzfq8Fc+jL50saRIO+Ky7UvY/
	A7TtbiTfkEBTyKYNYnQTTh/KEimSXWx4q4ls3W2lwOswD7SZLOVll0fxpywk5Rwu5Ar9jz3lBpV
	PRVyw37/33otrbMOUW8XtvsXTde0Rxx8GUKPVxG4M1MYnJQq1QFgt/AZXpRGrlgZI06gApqZbif
	oWK0pxrLExt
X-Received: by 2002:a05:7022:23a8:b0:12a:b3c4:c3b6 with SMTP id a92af1059eb24-12ddd984e39mr4038307c88.21.1777490352727;
        Wed, 29 Apr 2026 12:19:12 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54e3:5ca2:4f82:c61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12de32173acsm4929916c88.5.2026.04.29.12.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 12:19:12 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:19:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kris Bahnsen <kris@embeddedts.com>
Cc: Marek Vasut <marex@denx.de>, stable@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: ads7846 - don't use scratch for tx_buf when
 clearing register
Message-ID: <afJZSCXeoSO502o1@google.com>
References: <20260427174657.691272-1-kris@embeddedTS.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427174657.691272-1-kris@embeddedTS.com>
X-Rspamd-Queue-Id: 1027C499BB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241935-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 05:46:57PM +0000, Kris Bahnsen wrote:
> The workaround for XPT2046 clears the command register, giving the
> touchscreen controller a NOP. The change incorrectly re-uses the
> req->scratch variable which is used as rx_buf for xfer[5], so by
> the time xfer[6] occurs, the contents of req->scratch may not be
> 0. It was found that the touchscreen controller can end up in
> a completely unresponsive state due to it being given a command
> the driver does not expect.
> 
> Instead, rely on the spi_transfer behavior of tx_buf being NULL to
> transmit all 0 bits. Also set rx_buf to NULL because the value
> returned does not matter. Thus moving the 3 byte pattern to clear
> the command register to a single message.

Unfortunately my suggestion was flawed: I think this will flood the logs
with "Bufferless transfer has length %3". We need to have either tx or
rx buffer :(

Thanks.

-- 
Dmitry

