Return-Path: <stable+bounces-269443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DPn+CUWWQGrPgQkAu9opvQ
	(envelope-from <stable+bounces-269443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C75046D3075
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="ornF/Gqx";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269443-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269443-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6A6C3022F42
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377122773DE;
	Sun, 28 Jun 2026 03:33:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F9B271471
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617628; cv=none; b=ERpzIv7hx4KuD2Dh9dbbK+ehIdfAbIfQWiDLESd2Sj0Zw6ljt3JxN1sz0npgoAz7paPzcDvQmLfgDtQjDi1riG1PlUuIk0QQ2Dk5V6FYCs1lFRa3JLy3hbA4jaEOIP/QiXOLa9npgK3hqvkctqMjjQFUZiNDOu3U2z11eCucYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617628; c=relaxed/simple;
	bh=T9eX0HoxMQTegFtqEjtBtcRKf2ITUsBnNuu9jlNcLTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X70jvGo4l903wBazyZKMhJSlLi6NRVZrQjuunx74Lg5XESMZen+6+pri62dDghBn28wEvHuDedF5Oxm75AcDkl2Q7GLvHA3CyYSwrfLqf0I5r2/ZECjGFfMTKfkrokJKUY5bAQDqHPOqBg9vGgz7vZ6V6fXz14KkfvJLwjMQWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ornF/Gqx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D541F00A3E;
	Sun, 28 Jun 2026 03:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617627;
	bh=T9eX0HoxMQTegFtqEjtBtcRKf2ITUsBnNuu9jlNcLTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ornF/GqxO3uKVQoouCrfc4fpDJYOU3KR4m3JbLZr4BzK629HakolNggJHCx+9nZpt
	 rGnctcmdAQj4/KUBkffwCFJuVcOSEnfvFy2GwiVZC2LhjM4QRJErZ3YHgb6aXqtz6B
	 qskzV8+/2rp7fWDx0qRTI4GAY3tVg5qn35ZfRFjeDUjFfrH2Vf7a7l6r3Tj7aa1ZcJ
	 ikArhYbaok0OSZRmYBYdJsL7G6dTOWfvI+SNB2hotVoL5WERju99d80B83gQ4yz3pU
	 m4iYGo4NClEDmv3zA4DreT0v7iEePWP9xRZZkjIDzept56r5TmsgOPAVj/CEE9LxoY
	 m2Sq8GoH1JwWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.6 00/25] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:35 -0400
Message-ID: <20260628032401.0005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161139.124425-1-sven@narfation.org>
References: <20260626161139.124425-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269443-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C75046D3075

On Fri, Jun 26, 2026 at 06:11:14PM +0200, Sven Eckelmann wrote:
> [PATCH 6.6 00/25] batman-adv: 7.2 merge window fixes backports

All 25 patches are queued for 6.6, thanks.

--
Thanks,
Sasha

