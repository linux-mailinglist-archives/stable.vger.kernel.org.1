Return-Path: <stable+bounces-269440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V8F7Fy6WQGrJgQkAu9opvQ
	(envelope-from <stable+bounces-269440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D06D305F
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CyhuiDvH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269440-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269440-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C304A30095C5
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DD724BBF4;
	Sun, 28 Jun 2026 03:33:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26751175A6B
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617626; cv=none; b=lEnq+1Y8MRUC/rBBLzb0z+kLOpexboDAlG2rGGdQd3oXkObfSVO56dbd50hkZmPOyw0QRqrmFmTmzDES1dKqFMcXqGahR8APNNgSZemDZnZJHRMTbVU5iXzO2RZ2itUsiouD4A4MUcdpGKzWMr+GIDUEVJwf+LHy86t0UNGY5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617626; c=relaxed/simple;
	bh=hP7w0RKjGVbkExDO6sJtZqWhwFo4d9OVUD3xtdQQ7Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKYYq0MKwnSxEKxzqG/A6YTZt6gcWupoLYkwk+8pBzYpvBgfArJRUHYHsH1ySlSbRnbLJCSwKng66RoWgSZxk6ZsDz2cQ8Ti5fkGXJ/r8G1DlsUKSvsiSlJq9cZQNHyh36B3pLxJNs/ju/C9dFDyw0zp7Ii728HhkgnaMNQZOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyhuiDvH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875461F00A3E;
	Sun, 28 Jun 2026 03:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617625;
	bh=hP7w0RKjGVbkExDO6sJtZqWhwFo4d9OVUD3xtdQQ7Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CyhuiDvHMZ4AWebh8yOKHyOqTXoAzm0wPp+R/3fbdOSJi3PzbKuXyNj/EabhxkK4C
	 WQX2fLc2jIByQ0ugLoz/6OjS5frvOkGVoJ6DZH4T9ClPzJK9BGUfvTMFUVIhgN/bIP
	 dwwPuiweAFc5x6RaXi/E0APmQ+s5ovXE8mgbnPHspByZMv0m1sU+dfUzxiWtoxzvWQ
	 UAJWrEl7XfGMXNAF/SOS7tsextc4Ac6eZju+mOUtxpZ+YIiU4VZN335HU/psBmw6ir
	 5sgqOrMKb1blToJGUk4WtVnavK8BojfWRoHRSYE6pWybHFxQrU6Peb/nhLIcm6IMD2
	 zLnUfRdnM3x4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 7.1 00/26] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:32 -0400
Message-ID: <20260628032401.0002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269440-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA8D06D305F

On Fri, Jun 26, 2026 at 06:12:15PM +0200, Sven Eckelmann wrote:
> [PATCH 7.1 00/26] batman-adv: 7.2 merge window fixes backports

All 26 patches are queued for 7.1, thanks.

I just fixed up the backport on patch 10 (and for all other trees).

--
Thanks,
Sasha

