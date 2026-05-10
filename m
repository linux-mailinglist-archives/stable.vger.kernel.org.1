Return-Path: <stable+bounces-245045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE5tLE6wAGqlLgEAu9opvQ
	(envelope-from <stable+bounces-245045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:20:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E1B50513E
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D65EB3009CDB
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7739EF1B;
	Sun, 10 May 2026 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ja5o61KN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677DC19E968
	for <stable@vger.kernel.org>; Sun, 10 May 2026 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778430027; cv=none; b=XhVFhta5EmejPrbgEkzP4zVWPwGcPk0o9MEK+DIx23m0HqLri9Jce4kj7dQg+jwnadW/haPLqiEBC1+gKQI5XeQYX2ZFbOAY/IcISOXDpcBwqXq7Zd6u89pt+dpP8TUGO9nMoqrTzEO9A4EynOcqJgIBcmcKEun50+PMUnh08+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778430027; c=relaxed/simple;
	bh=8gFRMkezAYTRP2RwR0g/HvwSo+83z/+8bBJDrsy1Ejs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jthoHaUPkDTwuN6MSqauj/BN2+YGQBX70WtAnTSfe/hfPdP3Z5KzlE67Iw1Q+ZSIJqwhKnZTRGBV7LvZplrX0Dp9DPw58Blkqo4a7KnHkAoIe3lwFQgRD7LdkeogvPgBsglx5vzF5gkB7ZayGUsxrwAKuEzCnOY71JS6VKBxbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ja5o61KN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C96C2BCB8;
	Sun, 10 May 2026 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778430027;
	bh=8gFRMkezAYTRP2RwR0g/HvwSo+83z/+8bBJDrsy1Ejs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ja5o61KNfuapEgDia3kD2lBiHVMXYdpowI83wv5fGd83w9yx6u9hHRzbgMEnm2X4t
	 e7DIvNDKjtjqFbq+li9UPsiQC245BpfWrSwQYG8yIlLPJaI33djLuWBbauqxO4oefY
	 +D2XTvy1r9L4w1QykTr8VEEx9oTQOzoR97eQ2EQM=
Date: Sun, 10 May 2026 18:19:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: security@kernel.org, lains@riseup.net, hadess@hadess.net,
	jikos@kernel.org, bentiss@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: fix slab-out-of-bounds write in
 HIDPP_FF_DESTROY_EFFECT
Message-ID: <2026051043-spender-immovable-f9db@gregkh>
References: <20260510132917.335796-1-jinmo44.yang@gmail.com>
 <20260510133118.337026-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510133118.337026-1-jinmo44.yang@gmail.com>
X-Rspamd-Queue-Id: 34E1B50513E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245045-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 10:31:18PM +0900, Jinmo Yang wrote:
> Add a missing bounds check in hidpp_ff_work_handler() for the
> HIDPP_FF_DESTROY_EFFECT case.

As you sent this to a public list, there is no need to cc: the security
list.

Also, what about the patch series that was recently sent to the HID list
for adding bounds checking to some of the apis?  Is your patch still
needed with that series applied?

thanks,

greg k-h

