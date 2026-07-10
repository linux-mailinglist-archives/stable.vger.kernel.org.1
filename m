Return-Path: <stable+bounces-273320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WXUiGR5eUWolDQMAu9opvQ
	(envelope-from <stable+bounces-273320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:03:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59DF73E953
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:03:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=E7DTBjDq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273320-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273320-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C093009B1A
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9172701D9;
	Fri, 10 Jul 2026 21:03:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F59913DDAE
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717404; cv=none; b=ltuwRFlHtYA1UYqZZFf6jAp7uklDiTEq9aYegFD7kA6vmod9VrjDLtCei5U7ZnND5UER81SGON356YWOoLLEtp56LZ76V3vXgm6yqertD+yR0xanvIcHlFU7nu4tGlceI6BqTud6rNiXX/0ciU7yxC+zrJ634lFG/PVlDFovzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717404; c=relaxed/simple;
	bh=lIJnxvlIwgA6sqRomiMmwK8h8P780UosP8RqSpcBBWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDQH9iOouLZiEHDMzIDNZBRGvZ9HD9I9ztahVqOYLjaJ34LGF/yglXdyqQGI/X0H/loYGzR8BQA520udyfsCDwMpIHZTjUNzvryuNB9JhZK6C2O8ZcmYsvYmsDHAm6/T6G4NcQWqziMUkn1fw9naLv+b/KZaafskgifUHeWdaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7DTBjDq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5080B1F000E9;
	Fri, 10 Jul 2026 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717402;
	bh=axEB03ikE3WNOka1h6u7EXJ7M1J/GFCH9nwucBuKQwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E7DTBjDqyTDPoSydQO666jxqcCZgb6W9T63RlG+QUEdq6RST3yTBG6RnzaRa0KWdP
	 ElrzYWLXdthcxhKyN00x8DiWtcavLG17vrUd3fW26c0dNnSzBQ2doegBhq6Q2kzHKj
	 HxDuYVO0aomipl/uV8Z6l/FX4d1dtTH7WIbRv4d93axBUsd6usfb3CHfPj/FAcSPtr
	 tqEw1dwV+7FZn9+JSeXAp/INZrHnsMwRCRctvRMg5ifaGkKWTAV2pb7aStogHic2sU
	 ZCX5p7csCFrfO33dGs2054r3p9Z+GbSFY0/Tt3//oeF1mGMXV8DQCnP4bn77s9lbTJ
	 xP9qaG+u3JXjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Taeyang Lee <0wn@theori.io>
Subject: Re: [stable] Please apply 037a3c43edfb: perf/core: Detach event groups during remove_on_exec
Date: Fri, 10 Jul 2026 17:02:57 -0400
Message-ID: <20260710163023.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAH-2Xv+SPOO=O1kiBzra1_+KD9snB6eEUCHkhROMN+Txco5S4g@mail.gmail.com>
References: <CAH-2Xv+SPOO=O1kiBzra1_+KD9snB6eEUCHkhROMN+Txco5S4g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273320-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:0wn@theori.io,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D59DF73E953

On Thu, Jul 09, 2026 at 11:40:03PM +0900, Taeyang Lee wrote:
> Please apply the following upstream commit to the supported stable trees:
>
> 037a3c43edfb597665dd34457cd22b14692f2ba3
> ("perf/core: Detach event groups during remove_on_exec")
>
> I checked that the upstream commit cherry-picks cleanly onto the following
> stable branches:
>
> linux-7.1.y
> linux-6.18.y
>
> For older supported branches, I sent adjusted backports separately.

Queued for 7.1, 6.18, 6.12, 6.6, 6.1, and 5.15, thanks.

-- 
Thanks,
Sasha

