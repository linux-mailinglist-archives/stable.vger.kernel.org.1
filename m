Return-Path: <stable+bounces-260888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B/dcIrohJGoF3gEAu9opvQ
	(envelope-from <stable+bounces-260888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:33:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB064DA4A
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:33:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gXUvG9gS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260888-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260888-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079A6301F5FA
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286333AFD09;
	Sat,  6 Jun 2026 13:31:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D223183F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752685; cv=none; b=pNAuuLkBTlsxdtMG5zD2oUxv95EZCQydv5QytA+bScLAlXZYFHYd8dpXaOtFLmPguY5amdytn8uSbi0k56AIoyDLuMIaSIccChwQVArtmXY4rSkY2CutcmK+rvS13YFXxdTYbK4Jyu4l585hnMBq281CODnM2NBTaVnRdCpoLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752685; c=relaxed/simple;
	bh=Hl9QoSe9XJTLFSgazDj1a8o5f+32uOFaFnhjfznZRGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQjcU5ARhUgT+FAnr0O6rpSSNYEvzPaGnleE+zxfE18veO+yAMRISfa4l/fnU8kjgVhO/OZiZRB110l/Z4PGPlvVgRDj3oCBF/HYIbfO6tAXwYk2E8P2zCZg9NmxEwhRaidQJ55q1wvAXHUovLS236ZtWR71esRy86xcINtEL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXUvG9gS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805351F00899;
	Sat,  6 Jun 2026 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752685;
	bh=J9BXVb3slJU1Eu9UJPNqqVJ94Fcdm0PgUFuFxcsE4Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gXUvG9gSvMUgCcETEEJQde+jcP830quZtEEcbE4sKTgnQHe4maJsI2HZj245JCPP0
	 w6yzf+ZcxeheZt6j2sfOxOSBQdurcc3ZZuq7Ovd2T9eliv0tfPOcX2un+IoEyqyEEC
	 IXeza25vgx7nr8+v3yT6iOUDICfMktWHxRaKft9/cDp3zaJPYEhezIt1JA4jwhxHHa
	 VeZWx10nKUEznoYUX0EuTBxDKFvh6jyr6gsgnWvf2VkOHg4Rzhk9Nw1JVUL4aJTL61
	 7ERaCenB0Em4qEJt19DQSOq/AbKkyuLPi5MQ0+YxiAfD7sB16dhEEhpz/1TV1n34G0
	 XxpFps7CkgTKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6.y] serial: dz: Convert to use a platform device
Date: Sat,  6 Jun 2026 09:31:12 -0400
Message-ID: <20260606-stable-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605030420.6321-1-macro@orcam.me.uk>
References: <20260605030420.6321-1-macro@orcam.me.uk>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260888-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:macro@orcam.me.uk,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16AB064DA4A

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

