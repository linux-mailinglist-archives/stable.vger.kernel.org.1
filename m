Return-Path: <stable+bounces-271898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OFY5LNhqSGpRqAAAu9opvQ
	(envelope-from <stable+bounces-271898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3981C70672D
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=leUcpbIC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271898-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271898-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A8513045B35
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4660C37475D;
	Sat,  4 Jul 2026 02:05:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E89371D11;
	Sat,  4 Jul 2026 02:05:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130744; cv=none; b=m6Z0TXg2W57SjNh3Z4j/OdJkzyA+4maKVmG/xg43PlJQW5UBCFiOLRDcSxERmSigpQcd96Ps2XJg7T8xX7Lxvrdb5NviFcXrjK3x1zYYnD2E/aZxiMcf/6TOTocivKEnjTIKqnlynLOuXY5WIhqFgs3pGw45UviUfk4ytiPO33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130744; c=relaxed/simple;
	bh=Qt4Xp09dL773RVreQY8Jqawj3O/gz/+3BRcJ8dIWvxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmdOqIFhC8ZPOxUg784J4mNSaDo3QMkE7zhya2kHYOL8jms/DRh5e4WtPO0GEe/gax8tWN4XYBo0zfozOAclRjcGaQ9HpzfrEwVNhdN+ws4ThNoeXH2P0eCpsdjo5pMt61SDAo6p8KZz8uSxgMhPXum1ydACU3r8Rk/8m3gfvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leUcpbIC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC61F00A3E;
	Sat,  4 Jul 2026 02:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130743;
	bh=8rXstIs9JnkJhpz7D60JzTKXc0uvzlaqrZCNA0Eg4S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=leUcpbICIQSM/cHBd5Uy1T6rCRTCLleR710ZBMycSUikbvxq+QefqKinMEWA5okf7
	 22SCRazRdm2GfWopujCUKAJTaYZSCn3ckN3xsS5ujNyDHHNgwy2GFQDmZyPdysC+LT
	 z+OKoRO47hgWmSAUbQYPe2nVrzE/v+J+1gZwIB7ROb+D26KKWfj9vkvswC43zBGbGm
	 CFrPOYAI3JxyoJeyZV6pVQs/ms/pxkDmmRr0qP41AKrS7fxaXmM0dprwODNLPzESWD
	 n2LrBC7L9V2PblvQJMC/1MqVHHe64885Rkz9m1qSUlImtUtVT1Yo6sDKQYxMTQRVB0
	 pf4FBjGOlKNLw==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.18 044/108] block: invalidate cached plug timestamp after task switch
Date: Fri,  3 Jul 2026 22:05:09 -0400
Message-ID: <2026070315-stable-reply-0015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703123236.3139759-1-usama.arif@linux.dev>
References: <20260703123236.3139759-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:usama.arif@linux.dev,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:axboe@kernel.dk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271898-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3981C70672D

On Thu, Jul 03, 2026 at 05:32:35AM -0700, Usama Arif wrote:
> It looks like this patch was backported, but the preceding patch [1]
> in the series was not bacported to the stable branches. Both this and its
> prerequisite have the same Fixes tag.
> Not having the prerequisite will result in a NULL derefernce.
> Could we please add [1] to the stable branches?

Now queued the prerequisite fd38b75c4b43 ("kernel/fork: clear PF_BLOCK_TS
in copy_process()") for 7.1.y, 6.18.y, and 6.12.y, thanks!

-- 
Thanks,
Sasha

