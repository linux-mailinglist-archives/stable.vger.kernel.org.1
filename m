Return-Path: <stable+bounces-260784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xwnMIvIlI2rLjQEAu9opvQ
	(envelope-from <stable+bounces-260784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:39:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F14664AFF9
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:39:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=m03bP+BN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260784-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260784-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988373024521
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09043E9D2;
	Fri,  5 Jun 2026 19:37:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70F449ED7;
	Fri,  5 Jun 2026 19:37:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688258; cv=none; b=ifMUysgRf9hbNIXs1pXEp6ErtGMP4epn0VuniP/50IpD1mGb7P6wHZzveC8PaiQSXIVND5VbwZRi3dgT5JoP86qr+t8CxhzzyjzxFPoBRhFx3xfm87zUViFawob549bWNTez7owdmWVB2/yV8daEBCCZwTewhdcVjZ51TQ0bePw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688258; c=relaxed/simple;
	bh=vajbh2a8ARcjcB4UbmKOraBoCf98tXDz6WaYnAYzQ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEpBRClXrTSlIZeWTU+2w8wH/14iDWsobJD3BMJFgSQ+80t0eiUfbO0koUGmzKxyKkQQVuNKkVyBlbgU7bbxDHXX6WpCo4c37gFd+/itOZuz8/DCyJfhTsmlXszpz0Ggw7H3TfLWunzxegb8FHTvwi5Jh3amLAqr7tDSaT2EUpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m03bP+BN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395C81F00893;
	Fri,  5 Jun 2026 19:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688257;
	bh=pwAs13+6p+iVKzqsXGtBA9YQth/QB4Sdj4TBtCESWbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m03bP+BN1adDvMK/nls1WGKHZNHTXPYLzS9gXuP3G3dfxlmGAkunNGppkJcAvkFOh
	 K+uWiylcfyC2zjkU5hu44WBA5DS7JLjfz4De1lCqPzk1kvRBfHVGvPVLjmzpgYoyAz
	 SY/jhLgAyUw4WZ7FMwz9o1wnhcuzrqZCqhPoWPCqlFbFJQDoZJ5aDpZq1BGgGvYAEx
	 ppM6Vuj4Hl2zB9AK808V/WRl4CiS6Y2Do51Fj3vpQ1vz7u1NOBUlmzDKuaDVn9kau5
	 lb5qJ/JHilQ34ViRD2nCxBj0HIyP4fP+uqwfPejpsKVCC53eWyurIhQ3i0B2RCCfMM
	 8rPmnsmWVxyfg==
From: Sasha Levin <sashal@kernel.org>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	Jakub Kicinski <kuba@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	=?UTF-8?q?Jo=C3=ABl=20ESPONDE?= <joel.esponde@leroy-agon.com>
Subject: Re: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Date: Fri,  5 Jun 2026 15:37:10 -0400
Message-ID: <20260605-stable-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f27cff89-b439-42b4-b29d-2a54e4efd3b6@leroy-agon.com>
References: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com> <20260603105137.lan8814-qsgmii@kernel.org> <f27cff89-b439-42b4-b29d-2a54e4efd3b6@leroy-agon.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260784-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:netdev@vger.kernel.org,m:robert.marko@sartura.hr,m:kuba@kernel.org,m:horatiu.vultur@microchip.com,m:joel.esponde@leroy-agon.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F14664AFF9

> [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset

I've queued the upstream fix for 7.0.y and 6.18.y.

For 6.12.y I'd like to use your hand-adapted backport, but the copy on
the list is whitespace-mangled (the hunk header got line-wrapped) and
git am rejects it as a corrupt patch. Could you resend it with
git send-email (or attach the raw patch)? It looks correct otherwise,
and I'll queue it for 6.12.y once it applies cleanly.

-- 
Thanks,
Sasha

