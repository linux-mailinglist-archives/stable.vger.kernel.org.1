Return-Path: <stable+bounces-260530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id axhgDdOcIWrrJwEAu9opvQ
	(envelope-from <stable+bounces-260530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:42:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA35B641889
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:42:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iEGNhuJg;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260530-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260530-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB955303585A
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA1733BBC0;
	Thu,  4 Jun 2026 15:34:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4F631352B;
	Thu,  4 Jun 2026 15:34:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587273; cv=none; b=q29sjSkWtHIE1ma0HJ+H2Ma09zimkiN9KS+h16ULxMPKHwLhOnslAyRF0qHhUfuMz0Rdy3ZCpmQk9R+iTymD4VWf4GTVnMju881TLyd3/gKURHLhwpnNXgcA4ualca4TyUw9H+DouoT2zO6KKhpLDIjKXXllEKwTV1Ztr0HewuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587273; c=relaxed/simple;
	bh=TWwOjx0K0gU9/TmSaGF/mv8oHJmUUoMB7/HlJ/Idu8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zckt8mgkUFUdFI9tH5fH4SH5jeRBQ7b4BSR45d+oi2fBiEz3hP9bAF94FmTW4G1ZCH3TlX8uSVTQKbd4VwAdtP3Y60KDhUJXJpWx6fqSCqKfQU+tLVrSaeleOc9QSExbwFx3xtVxLEFp6YE1mTj7JDDUdmubG4Rm9EQA5M54Nsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEGNhuJg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747CF1F00893;
	Thu,  4 Jun 2026 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587271;
	bh=1dvuixTk0NgEAYJVb7G+lPIi4lajpXkweOWZGnVwtCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iEGNhuJgVEn3hwtSz0BqWJuhNm+TnGPN6MW2/+MQzPHc0GtuwgNkoPRNmhO0Tovtw
	 NpDL/iX05KagLsIo5OkrYZM5Avmm1d0D3XFzrMSp8chLtyDRXEXoC5cUdcsViK86Vr
	 pAl6qFq5PKyKRcowFWiqkZ70QCrhgy3K1O2usSXDr6vwabgOq0VoFZT5kZR5ZapHd5
	 QcURKV2gbNw2AxsgBG1ZNxidwxPtwz+TJFUVU38xsyMtOkISmg/V/Bu8LSeWluotp6
	 /Tnw0CravyGE8Iv9ToKoJUDAB3vPAoMvB1MsogPrrydIADw+TSCWCEu/LbA3hNtpcB
	 2yawGIaKglWsQ==
Date: Thu, 4 Jun 2026 08:34:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH RESEND net] net: mv643xx: fix OF node refcount
Message-ID: <20260604083430.2b61c2c3@kernel.org>
In-Reply-To: <20260602073414.22500-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260602073414.22500-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260530-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bartosz.golaszewski@oss.qualcomm.com,m:sebastian.hesselbarth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:brgl@kernel.org,m:stable@vger.kernel.org,m:sebastianhesselbarth@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA35B641889

On Tue,  2 Jun 2026 09:34:14 +0200 Bartosz Golaszewski wrote:
> Platform devices created with platform_device_alloc() call
> platform_device_release() when the last reference to the device's
> kobject is dropped. This function calls of_node_put() unconditionally.
> This works fine for devices created with platform_device_register_full()
> but users of the split approach (platform_device_alloc() +
> platform_device_add()) must bump the reference of the of_node they
> assign manually. Add the missing call to of_node_get().

Where is it released? I think it's important to note, I can amend
the commit message if needed..

