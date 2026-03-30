Return-Path: <stable+bounces-231224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL4UHiV/ymnX9QUAu9opvQ
	(envelope-from <stable+bounces-231224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:48:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB39C35C470
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB7BD311ED1D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2553CD8C5;
	Mon, 30 Mar 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFFqSrAn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596793BBA0E;
	Mon, 30 Mar 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877567; cv=none; b=EOEPY5gi6pIj6+d/zXkz+IRB6Hv+cY6F76Bfrwp4PwV/5p3e8+NzXwBX6REn8hqUlzFq7cKY/2PscwaC555g8WqJV0yuXhaggho5y8lip6Kv8h4ayEwrBWgaJnXtWlSbkvXGu96vB5Y9lP0pajTl4Wf0uwXlTxTqj5+UXOO+4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877567; c=relaxed/simple;
	bh=ra43UpYFfhWwinth+UXzN3p/HvOi7/4hhAxRnpd3qlY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YCxWfxkyS4DF1o3+GNe+TLCQw18DtZ7EE7rUW5Gz5vYNoO6aAgCKfJ9X1QuqseR2MkvG+R8OC2ZMkeU4JwMmNpQsc7ZlnjmzGoz0T8VApxn45Wa4gBiC1ZX8lc/mVjzfjP+5KQlQ99YkzqHgH80FZzTsY57rRywl1mOmed3mBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFFqSrAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61623C2BCB0;
	Mon, 30 Mar 2026 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877566;
	bh=ra43UpYFfhWwinth+UXzN3p/HvOi7/4hhAxRnpd3qlY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uFFqSrAn/moPMfUielMllyht0STk5LMZtYedahR79dGOMxBLs2Ccckm3u5KZGUInM
	 r9JSfsihLVewrdt70No1LY+l2OPLYSP2tHK7OpMktCUzQdeNxajwIdIupiZYDHgckQ
	 2ezuThyRhN602HsHyJB99SKfIql8E6kNC0Ho4qPHICuK7JFIt4YcYbEIX0YcVQ2/q1
	 m9PfA4LJKkfMDFsm7BsMHUNLrsOm/7myXUvbEXHjS3HBgq3TgVpDDODLJMCf/N2DWv
	 vMD6B7wMbbjJndUqifatdZG2M+F2kFg5ZQOixVLoPuCHal94kJMWrZ2r6Co//uM9i+
	 3qZfVz3FhKOjg==
Date: Mon, 30 Mar 2026 15:32:44 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
cc: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev, 
    stable@vger.kernel.org, Lee Jones <lee@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, honjow <honjow311@gmail.com>
Subject: Re: [PATCH AUTOSEL 6.19-6.18] HID: core: Mitigate potential OOB by
 removing bogus memset()
In-Reply-To: <695caa61-20f9-4932-9ff9-431be7615c43@leemhuis.info>
Message-ID: <q6311n5r-p656-1rr1-n757-2o4sn8p041r1@xreary.bet>
References: <20260324111931.3257972-1-sashal@kernel.org> <20260324111931.3257972-18-sashal@kernel.org> <695caa61-20f9-4932-9ff9-431be7615c43@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231224-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xreary.bet:mid]
X-Rspamd-Queue-Id: DB39C35C470
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026, Thorsten Leemhuis wrote:

> > From: Lee Jones <lee@kernel.org>
> >=20
> > [ Upstream commit 0a3fe972a7cb1404f693d6f1711f32bc1d244b1c ]
>=20
> TWIMC, honjow (now CCed) reported a regression (GPD Win5 handhelds
> stopped working) caused by this change =E2=80=93 and provided a patch (wh=
ich
> misses a Fixes tag) to resolve it:
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221271
> https://lore.kernel.org/all/20260324013847.68024-1-honjow311@gmail.com/

Thanks for pointing out the missing Fixes: tag, I'll add it manually when=
=20
applying.

--=20
Jiri Kosina
SUSE Labs


