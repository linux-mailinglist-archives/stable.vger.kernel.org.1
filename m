Return-Path: <stable+bounces-260106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qJVBEG1QIGpt0wAAu9opvQ
	(envelope-from <stable+bounces-260106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:03:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9756F639891
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:03:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="V3/Fc7aG";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260106-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260106-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3D40307559D
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C783CCFCA;
	Wed,  3 Jun 2026 15:14:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458BA3AB27D;
	Wed,  3 Jun 2026 15:14:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499672; cv=none; b=fKbnjTwbub7H4vxZsY/Cni6Ui2jhrdE8X6+yZWoAkOQbMyaMvV7T9wW4XEN29Th3FfOE7O4LqAr0RvcThY7Km1GfurLnUd12psn8j70/AkX/EKc2YjTYCfOdeuTRRieMCoQQ24pFx4/h6ZfAVnE0lmLsJnEfZ5kTnXCqhYX1NFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499672; c=relaxed/simple;
	bh=9dx/cPeeS3EZyWVUhZm9JNLLMe4HXCD0yvK9G8YhFxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoVp9RbUWm+dBO/DtZ19dELUc+IaGstcCBHxFcM03yuqYVdvPupg+ttQt0ZAqM3eXu3z08Y4pJ+lEF2E5SBNqPJSEWI9P6PHPV2IR4uLuh93nZIfmfknNxjoDPNi15g456u2n6AFpGbBk92bAVSEfPlFt6wLMBeDnqhldWzH/kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3/Fc7aG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337851F0089E;
	Wed,  3 Jun 2026 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499671;
	bh=BnZk5HC+TBlXGYAKvZD89rVJdXlgoZdSOfldLPIJKAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3/Fc7aGm9iTl9uSs6ODzNOGMCPDzXlhJkq7xv0LXjQ61T2qttWEBu8IFFIAwemDr
	 2jnM6ow2EiXNqNK18/K7Amk46TIzH8t93us8Ny7hH01THglO1fpKRM1In21AMB4Id1
	 7jrTGtr1b1TPZcmDk4p3cRGeISJoSnGSUVUTLKjcIHr9mW+6hiOxtCgbJQTSChtzdV
	 sMhhCf5Wr6A06Sn3C1kftXKJoK6t4025ice1WChfwgtqnr38nnR75DnJKI4RSI/rA2
	 Px7QdZdeHo48Kq1xrRwQCsN5BkTLjmC9fzDh57LMrsR5g/i0FNUJLsi6/hcF7ymp87
	 sYR0/e6OA0rQg==
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
Date: Wed,  3 Jun 2026 11:13:56 -0400
Message-ID: <20260603105137.lan8814-qsgmii@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com>
References: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260106-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:netdev@vger.kernel.org,m:robert.marko@sartura.hr,m:kuba@kernel.org,m:horatiu.vultur@microchip.com,m:joel.esponde@leroy-agon.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9756F639891

> [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
> [ Upstream commit e027c218c482c6a0ae1948129ccda3b0a2033368 ]

Thanks. This doesn't apply to 6.12.y as submitted: the hunk depends on
feature commit 19f1d6c7230b7d, which isn't present in 6.12.y.

-- 
Thanks,
Sasha

