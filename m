Return-Path: <stable+bounces-260216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id egDWEO3CIGqv7gAAu9opvQ
	(envelope-from <stable+bounces-260216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:12:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEEE63C02E
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:12:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j6Ncll3Y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260216-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260216-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DFC43087949
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB105E571;
	Thu,  4 Jun 2026 00:05:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80FA8462
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531551; cv=none; b=njpgMqDneIWMDCIs48QVoq4rogRurNMFzb7LXpSiPCExVOxQPpe3ahHp1eXA2Ok0ZXvSvXTCrLoGBdtoXVws7QIv/ATG+bQebjI+IiQIdPG1HSwnoNg6xWXnPIfEcDHZ59f4m/3vGugqp2WzL38kUlFz7x1kxP5Pjb8iDKKPdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531551; c=relaxed/simple;
	bh=l9PFath+liIYfdRq9UBMC/9bi/+mnaPL/9aYDRA9Bmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beSQ1nazaf2u8U5PGzu5I1UTcunf7E6gJjDrJ7Hm4cuX9yMgz0kmt8pX8ykLVUz+IwssegjlrpBkoEv3Twiw99FNHGDoVkZzHHn4mC9kOBROezBFR3EFfZAX2NyqfYd/bKN0vGyXamSTgcltE2YPc5DJeMDR5DHvFnETCUIQLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6Ncll3Y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2771F00893;
	Thu,  4 Jun 2026 00:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531550;
	bh=NrVOiw+1se7mMUbShZpRXB1hUvmQ385ArgMq0tw7HDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j6Ncll3YPTDsMbOVjnc6GhgAhjhWeN5FR0jVkde0dUDpYKnL1Fkr/HFHdc5DeLamI
	 +QvXyLiStaVE7dht1oV4nMyFoeMX4ZGpG/jUHTLe9dcM5WR820HGmXf/V08A9xwmO8
	 aLNZIGN3dPjRpDk1KVdrEX1TyqVedliafvhg0KQG/Mr3tdU7SZNa8rwbbpqUrjKhtD
	 QB/g/VmK5wyZXJLzdyM4qoyLHrIALRbbU/Of4Mal65SfYhe+dPIK2xkwb++m+jg7kL
	 8WGLv592w9TdWy6VWUTXMDA6mH/gWy26n4PveLxL4w1iAYZ8GXmmXavcLQwxwpK2mZ
	 PBFCL/oX0gSLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Huzaifa Sidhpurwala <huzaifas@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Please apply commit 4db79a322db8 ("net: gro: don't merge zcopy skbs") to 6.1.y
Date: Wed,  3 Jun 2026 20:05:36 -0400
Message-ID: <20260603210831.item002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ah8-6irgXpRvuZ8T@eldamar.lan>
References: <ah8-6irgXpRvuZ8T@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260216-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:sd@queasysnail.net,m:huzaifas@redhat.com,m:willemb@google.com,m:kuba@kernel.org,m:ben@decadent.org.uk,m:carnil@debian.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAEEE63C02E

> Please apply commit 4db79a322db8 ("net: gro: don't merge zcopy skbs")
> to 6.1.y. The mainline commit does not apply cleanly there, so a
> hand-crafted backport is inlined below.

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha

