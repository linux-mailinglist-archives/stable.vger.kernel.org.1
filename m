Return-Path: <stable+bounces-259867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oO2/NXIfH2q/gwAAu9opvQ
	(envelope-from <stable+bounces-259867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:22:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D643663107B
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:22:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MivB+XLK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259867-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259867-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BADC53018AF1
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74503955C5;
	Tue,  2 Jun 2026 18:21:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF2C39184C;
	Tue,  2 Jun 2026 18:21:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424504; cv=none; b=aTnoQu6t+zxRhsPMfiump0Z/IrR7rL1Qa3RvfatUL0GNVunA2mCQVhJ8fdZTlxDx1VskG3pvuiMvhEKnU4uilGdPa74bw8y64ohJzQ00ia81zVi+9znmFjPneeQooE+Y1TIIm2QJZhhcvk7Rweyob644hPZ0Rr8LF4MYco4hm6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424504; c=relaxed/simple;
	bh=8ytOHlLqGjw8D/71xahC8oDz2wv2y5Lsxg55xpfbd6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sn1aVK2RyfrXRJ2RC1HGHF1tPYEKMP9ZndSOv0rtWEIZpELupztSOphc40dODR1yUE7dduGqzM39sP6NvjsyP/MFu4y0AKA5OCLigYuCb9sY4pzNEoi/Mwgbu4jPqgUAaqoeVccXxwIxb8Mlf+Sj4BQB4el8L4HhYDzzwCBlXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MivB+XLK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30DD1F00899;
	Tue,  2 Jun 2026 18:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424502;
	bh=b+ThjlcJjpLxxMSne/TmFnpLJdJaPgKpkVosByRLWi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MivB+XLK5N4S55oTvZt5EaXMm2e2lVGBQFrevRgbEvHxpRHKSFNSZ1EdrD1tCxfnR
	 Ih0YZ0VmdFC3gn6eJ2OdrAkJB5G/j54Ecw0QmhROAiAd2KQeVwSc/zwmAI0x+hX9Ta
	 y5f+KocjaygiPBuwXRT58S+u1EsWR0P7QlCJ6Tm5CvgVHlL+dFOM7CVCalVVrNCSrB
	 hYitwVNDbKAtQMvrEHZBB3jDd2j+IE5800akRhjjoVQoz2paI+HeEB2poZCLYeIDLb
	 N0/IWiA7JzbOloauZSoc12CGcK3Iyl0K/BuVSFKsuWrW95CPakjdqVQx+ofcOyvsHI
	 eInCIM7xwCkiw==
From: Sasha Levin <sashal@kernel.org>
To: Nick <nick@kousu.ca>,
	John Veness <john-linux@pelago.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-acpi@vger.kernel.org,
	johannes.goede@oss.qualcomm.com,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
Date: Tue,  2 Jun 2026 14:21:20 -0400
Message-ID: <20260602180900.acpi-toshiba-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJZ5v0hR2b81+0FWAn3s_HJNWwweRSVk35KczPBKNabb-H91kg@mail.gmail.com>
References: <E2OXET.4X5GTP37VTNC3@kousu.ca> <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com> <bc9d5258-d4df-46a1-bba9-de3486f722ab@pelago.org.uk> <8503d297-68ca-4bfe-bbdf-537a85890d86@oss.qualcomm.com> <75398536-2ca8-4205-9205-18afc5227397@pelago.org.uk> <eddc6acd74abcea6131f3cfc606bc596@kousu.ca> <CAJZ5v0hR2b81+0FWAn3s_HJNWwweRSVk35KczPBKNabb-H91kg@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-259867-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nick@kousu.ca,m:john-linux@pelago.org.uk,m:rafael@kernel.org,m:sashal@kernel.org,m:linux-acpi@vger.kernel.org,m:johannes.goede@oss.qualcomm.com,m:rafael.j.wysocki@intel.com,m:regressions@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:platform-driver-x86@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D643663107B

On Mon, Jun 01, 2026 at 02:12:50PM +0200, Rafael J. Wysocki wrote:
> The patch is there in 7.1-rc6, so it should propagate to -stable kernels
> over time.

I've queued the fix for 7.0.y now rather than waiting:

  a004b8f0d3bc5d ("ACPI: button: Enable wakeup GPEs for ACPI buttons at probe time")

along with its prerequisite:

  fe80251152fed5 ("ACPI: button: Fix ACPI GPE handler leak during removal")

--
Thanks,
Sasha

