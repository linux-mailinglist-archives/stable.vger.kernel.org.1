Return-Path: <stable+bounces-262148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WXLzBU1kJ2phvwIAu9opvQ
	(envelope-from <stable+bounces-262148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:54:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C539F65B779
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:54:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kfAUNGBf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262148-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262148-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90D3030C0EAD
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56FB282F38;
	Tue,  9 Jun 2026 00:52:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7026F46F;
	Tue,  9 Jun 2026 00:52:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966338; cv=none; b=aIfJEHjHyiWwr6vBsVVvH+gvNYqlGHW1aunLlgMhdYyMmrI9VOFvE/bTuCYoTb/SgI6au/d/5wdGvEprA9zlqITVRAc7Qz7pgYG9pc/BAhlsu3ts3XrwIOuCRuof2j8KOWJBsO4Q+SOIt9gTF74BfA0Pg89/bOJVMcAe0eaXyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966338; c=relaxed/simple;
	bh=EaCXpZJILm4cfpXaAzmZW8LL48t67vN6PqHnFFDqmHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdny52V9MP8ZdLnXzH66SqNRCR9ezzVPObgKF+PkbGfef+SHzAoPzHGKIxcfXCTMI7tSJJxm3Anv5yrFutn1FDGaB8lvYYHZ3mEQXACsCatWQ6aVVzFyI3g+tikWcTuPhU0j4Vr7SPLPK8+sIGuGG9r2bCuXrt77dhszMvMY23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfAUNGBf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD15D1F00893;
	Tue,  9 Jun 2026 00:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966337;
	bh=EaCXpZJILm4cfpXaAzmZW8LL48t67vN6PqHnFFDqmHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kfAUNGBfER+OWuikEbn/Cp4JHx8OQguO6zXqm4OrpjJS93l52zZp8LQpGfEQ0+HLg
	 C1lZjnUuLicxKEcqgXlrpaqAQjHrmIq3vsZ0tAsNXrGC33g0umQR80Lw2oZlmvqave
	 k+nNRLugCDT0ry1QLjnLm6Eo84gpMYqItj4R+3g8EJdxEN03DK9BRLMIfAiF17jufS
	 NUlM14RolgZh0GBbBwqiGE6SDuaEGnPo0tvhO1AfUmFbeNNYch1GcSZsH5RWAenKxp
	 mBwRg9XXGBKyRgb28mIkmRRGFQ+B4gCfKpN4esnuCXsjqnAiWRfqwCoJAsvwuGG3eq
	 yDa57fhQmO4nA==
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
Date: Mon,  8 Jun 2026 20:51:55 -0400
Message-ID: <20260608-stable-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <e03a6f5d-1f90-44ba-b000-925c43faa9a8@leroy-agon.com>
References: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com> <20260603105137.lan8814-qsgmii@kernel.org> <f27cff89-b439-42b4-b29d-2a54e4efd3b6@leroy-agon.com> <20260605-stable-reply-0003@kernel.org> <e03a6f5d-1f90-44ba-b000-925c43faa9a8@leroy-agon.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262148-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:netdev@vger.kernel.org,m:robert.marko@sartura.hr,m:kuba@kernel.org,m:horatiu.vultur@microchip.com,m:joel.esponde@leroy-agon.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C539F65B779

> Re: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset

Queued for 6.12, thanks.

--
Thanks,
Sasha

