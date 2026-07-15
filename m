Return-Path: <stable+bounces-274626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 91YwOrzQVmoNBgEAu9opvQ
	(envelope-from <stable+bounces-274626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D4E7599E8
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Yat/kOHb";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274626-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274626-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63E54311CA67
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9EC35966;
	Wed, 15 Jul 2026 00:12:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1238742BC48
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074373; cv=none; b=KgwQB8izqT4OnjWkmd+gZPlbIxATq0vixK1BkpZj66QhaROTXQNyEByC9mWGi7/6FxYGofDFpBexVe8WxT9qkWyMbdGdIpdrxapTAtZN9bYDJ55lTokakVKuUM/4s3O12wr1TB9WUNHWinXALcX3FB9KTfwD8ybDj4WOTPusYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074373; c=relaxed/simple;
	bh=n4Ekerv6SdJQbYQSuW0KmBkOOZ37I8x/SFXdKhsEdHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7vOqo0mgm5RW9aEDDMmoRg6VT7urynxXJHRmCPAOV8tpNp9HhrCLnTBGkuT/MvJ6roWmblUOMoHys/dG0JG9EnrPe9ipD0/HLHgeyoIXVoxMqBrOl4Ihrw1Gm8CyrcniUOD6Yz2sBhQO//OJHFypSj4k+Igbii2RNLXfoZdI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yat/kOHb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732381F00A3E;
	Wed, 15 Jul 2026 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074372;
	bh=Hsw4LO4/Ge7HJDdrhIGWxxwGd+XcFY0tj4W0k18Cayc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yat/kOHb+jO9VhSkyFY3UpFvAzW8VsKSke5eRb6jIRp0ZY99D6wvCDW3ekOYBFh8Q
	 8LHTAu5c6XEbp+LuHqTbzQ4gmFh8T/VNuTuikCxWgHZXNcht+dUXnDm1dck3Wtu9ig
	 iy9D2kl5KCwaC9z3wHEohfiCwWCDQomaTHYq5/i7ckI/BZHGvnMER8HfYW4eIZ2/fw
	 dN+HBppbZV5wHYCQuEcL82oEeJeEPRWAYzYLDVsCO9qnLnGTLWXdEtXSvrVYgJwApQ
	 akKDPN/v2LkMh6H62JLwAUJ/fwn8flHmrKI50RgeTksH9RDq5vf8ElVV+/wYDQu/IE
	 LbYytD5inws9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5.10.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Tue, 14 Jul 2026 20:12:36 -0400
Message-ID: <20260714200600.stable0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713151613.93022-1-liviu.stan@analog.com>
References: <20260713151613.93022-1-liviu.stan@analog.com>
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
	TAGGED_FROM(0.00)[bounces-274626-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:liviu.stan@analog.com,m:jic23@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73D4E7599E8

> Initialize n_wires = 2 to match the binding default and ensure the
> rotation check fires correctly when the property is absent.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

