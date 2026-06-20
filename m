Return-Path: <stable+bounces-267488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qdrAD8F/NmosAgcAu9opvQ
	(envelope-from <stable+bounces-267488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:55:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6C56A8D47
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lQNIlhM7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267488-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267488-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69BBF300C0C1
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 11:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735AA39478F;
	Sat, 20 Jun 2026 11:55:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F110390CBA
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 11:55:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956513; cv=none; b=UwfDdJo0iAwAbRM01MFpF6XmdIDPvt0O222jPLG7tnH2APR0R3FsWyziAAIAl/5nmRppdR7fOkdDBg3zSZJG/KuUTPtncndLeSl32+plrJpy4rmGZg5c4xfzBHjpj87ge+uUD2dCahuwKFUwAhdVqQfDc1enuxsQAv+BBLZBGJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956513; c=relaxed/simple;
	bh=ACIM8gGhjDQ4fawfyBNgUhRTNNeQf8IMvcoE2JeAr4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCLTf9Jh/VUOB4b0ml34Vg0N+yfuQ1SfBgc0xGEl1a0J+hGqeg3VJFv8qLrzc1i6BOBxT6DSBxcddq54CT3d/PR2QHg/p5CsBiftU+up58IGvte5KpJk/A94l/3mOczOS5UVJbtQVIay25sIUSt/Cj9+zq3agZwSy3U+vNrK3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQNIlhM7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D276C1F000E9;
	Sat, 20 Jun 2026 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956512;
	bh=n9U074eutp+M/DunrtZnUDCzS+yBtCfoAlOQxoPKIa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lQNIlhM7ZaNBx4stevgrtGTLp0qualX9UAIgo5H7BjuCiYHRKivAX5N4oAwOMFJng
	 Af8a0VFikHKpNQ6Bf/GtCsFFmIceonkJnoj4FN+zXm2Mc5b65y7yQf+PrA+V1rnlVf
	 7WxEikSK9Ky+Lnh5+8UhXs1trXV6cErdyti2Da+KWvGE6Mmfhwg7PvJlYbLL/EA2zl
	 NDGNEs/rNF5UDpoHrNJblUV6YX1aF+kCwn1BBsBDi39JCfynaI/zTt+b0n9FV7XQ0J
	 EkdFXwZM/KY7soDBzMyCV9YAOdC2Rsmbbn7ViwokGZZPWyZhhZbl6H/SQqxqs7vUDi
	 pChlI0shtlWww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: [PATCH stable 6.1 v2 0/2] Fix perf_link failure
Date: Sat, 20 Jun 2026 07:54:58 -0400
Message-ID: <20260619.0010.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619045949.14013-1-shung-hsi.yu@suse.com>
References: <20260619045949.14013-1-shung-hsi.yu@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267488-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:shung-hsi.yu@suse.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE6C56A8D47

> [PATCH stable 6.1 v2 0/2] Fix perf_link failure

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha

