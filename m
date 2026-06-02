Return-Path: <stable+bounces-259868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MSj3AoUfH2rXgwAAu9opvQ
	(envelope-from <stable+bounces-259868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:23:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F2E631081
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:23:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gqZJnlZv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259868-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259868-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39B39301D314
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8621E3939C9;
	Tue,  2 Jun 2026 18:21:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF73939C2
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424506; cv=none; b=mh6IH79CySbwJ940WONKdZtRXh74SQdm0ehOyJ4RqO3ETIu4w/MS+pA5CfqkIECF2GpAGWK70uT+Py0ML3TrVIoIkqjf8k1vj/8+oOg0D5RzaHyV3naIljFfJq6QgRH8D0tKg3+oiCSPBQMQSq92He9q3uRg3qDsrq0hvkfAy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424506; c=relaxed/simple;
	bh=MVvTyIxkIW8kafkuyeT5yHAst+40KPSzQdu4O/gvC9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNEjt7iUkoAqXatGgp3ownelVlIW5DcKF8MtU6q2nngeARmAhhKRULyW6U31oRxg37uEuINysAyD+lMfH6U/i31bPeYVKvjlRLOLahCvwDSlPdkkbkInEgvTR2GNKl+OcK4TPlf8o27QIIX+/1SBthZY83fo0tjT+idtmv8vBPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqZJnlZv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462CB1F00893;
	Tue,  2 Jun 2026 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424503;
	bh=MVvTyIxkIW8kafkuyeT5yHAst+40KPSzQdu4O/gvC9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gqZJnlZv3bckkg9Dt92RNiAfLTrHP3vWDQ2z8n8uMzGWhVzcaOrCgFKgeldrisGyl
	 H+BGMAnNdB56CSpfdrB89jw8W2kyBE1/nmSK/6rTUUuX6IYaW0YTus0Ph2juxASq1d
	 7nKkTodDvc8woZAM17rA7InkP0WZ+agGVL9N1OAFfK8Rw10qW0sVijwUILh4y8A0E3
	 mS4mNFuvtJrnzAjiLH9QEnTMfoHwhwvMo/imuzmzcqv8BjcOT6JXtpsT3d0p9Yh8O5
	 pV5YZUi5RtIcMMfrg7iPYfd84KeGFgH5Bu/+M6v5ydJCb4FD4dONntx9K+6otGVPjc
	 jm4Z03LFXbNMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 5.10.y] ALSA: usb-audio: fix null pointer dereference on pointer cs_desc
Date: Tue,  2 Jun 2026 14:21:21 -0400
Message-ID: <20260602180900.alsa-cs-desc-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531152950.191924-1-kovalev@altlinux.org>
References: <20260531152950.191924-1-kovalev@altlinux.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259868-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:kovalev@altlinux.org,m:sashal@kernel.org,m:ben@decadent.org.uk,m:tiwai@suse.com,m:alsa-devel@alsa-project.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0F2E631081

On Sat, May 31, 2026 at 06:29:50PM +0300, Vasiliy Kovalev wrote:
> [PATCH v2 5.10.y] ALSA: usb-audio: fix null pointer dereference on pointer cs_desc

Now applied to 5.10.y.

Thanks,
Sasha

