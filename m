Return-Path: <stable+bounces-269272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4WivFEi+PmpMLAkAu9opvQ
	(envelope-from <stable+bounces-269272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 20:00:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7006CF90C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 20:00:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hnv6DS5V;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269272-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269272-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 358953108133
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945233B2D0D;
	Fri, 26 Jun 2026 17:55:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445F3AEF21;
	Fri, 26 Jun 2026 17:55:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496513; cv=none; b=HmpodTtkwUDHpPoAfeyzDnlbm/zjqRGxb6U6ONFqofHeo+wee6FFKlCFuHwBrM9348O6uZ68Yq3TjkW+BzfMyX/bBQ1Z8GaZxsYRSqpqUC58PEkmhZ4MRaCWJp/AYagzLZaqOaz8+5r9ZroXY0H0wBbC9cECvhz9h5NENbT2Wok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496513; c=relaxed/simple;
	bh=IUhNWIgpjRgv1iTrQJwpKyLWt/jk18U4zmaqfR7xr20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re90B2/tb9MbFNO6XdGwssZ530L9HRNqxaPNcovld8u7WjSBMJu5M3MwFf+i4+EB6wYJ/1t8J5x9jLfp2VwaFQS4+/IxyWQCq+urfvVdL+M9Zy/A7iXvOhCOp9+AKr26C/5ihehFOR8IfexWOla1RsaVJH/EXLIuoP/8s2HWbc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hnv6DS5V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30351F00A3A;
	Fri, 26 Jun 2026 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496511;
	bh=vYlgsN9Z4AbjSHyymQFtlqN19ZbyPZhF2fYXASOTKeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hnv6DS5V3l7VxROMr6+6TE9utD8/wVjwlubrWA/K+8Bsyx5L3pfTWw+WzGxmTL7/a
	 dyXDE+kI5y3o6imS7Nk2s894HMRpbSHRus8RD1/CbFBgmE/Ky+lRMRML/Lc6U4wj6p
	 ZRDkW4tCRWqXAn7V8EELCUacRYF5VFjzu6UcAV40jeN8PTPc1kxdUNzjAHDyU65nbX
	 5/0kihAiyUUXRC2IK2/5LJ1woUwwuMsg+cZnYLNdfQ86iTYl99nDy8qpzaTcdLPKcZ
	 95q7izOkwRSdwkimsz2E/4Fm+ilciL8tFOmpG5H2WaIYoXR0aqRqVxiyfbZ4w3EFka
	 VDQoeZnYDkrng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	cristian.marussi@arm.com,
	Yijia Wang <wangyijia.yeah@bytedance.com>
Subject: Re: [PATCH 5.15.y] selftests: arm64: signal: skip SVE VL change test with single VL
Date: Fri, 26 Jun 2026 13:54:36 -0400
Message-ID: <stable-reply-item017-arm64-sve-resend-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626-b4-arm64-515-preview-clean-v1-1-ad19e286e322@bytedance.com>
References: <20260626-b4-arm64-515-preview-clean-v1-1-ad19e286e322@bytedance.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:will@kernel.org,m:catalin.marinas@arm.com,m:broonie@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kselftest@vger.kernel.org,m:cristian.marussi@arm.com,m:wangyijia.yeah@bytedance.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269272-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D7006CF90C

> [PATCH 5.15.y] selftests: arm64: signal: skip SVE VL change test with single VL

Can we keep the commit message the same as upstream? Is there a reason to
rewrite it?

-- 
Thanks,
Sasha

