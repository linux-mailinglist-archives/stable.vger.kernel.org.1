Return-Path: <stable+bounces-262594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vnAECf4FKmqrhQMAu9opvQ
	(envelope-from <stable+bounces-262594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:49:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD1F66D8E2
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:49:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kvnQoi7X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262594-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262594-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8735530C460D
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 00:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957631F7916;
	Thu, 11 Jun 2026 00:45:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD726ACC;
	Thu, 11 Jun 2026 00:45:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138746; cv=none; b=cUsU0Cr3pcL7nnX8M1fcrmdfWPZl0h0qWga2v7ou5EyqjHzN/GAz8QYEqd+ZVAHKJFXMHaLQ1FvTvySag4sNHIbXZkCUDjbfrZu3q73TexAK6UnfYfPfCzLi+uwQ5uvj8tMPKs6YoisebDM4GIXw0CCh4NZ4gSwD1+Y3A35BWsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138746; c=relaxed/simple;
	bh=9uZbnvCSonpXGXR9vVuWodMYLgOTp+M2HsRiZcKEBSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EISaCz4/LOSmzGjH4E8R1R7ToFsarQ6UEbYre5IbEZgR9XhfeSggWLN1dm4vUDGxa73jW0r+CvBrEczM0osGhqUzClHpS3AH0n04dvNtu72gWSm4q0JmVrMnw0zpvj3UmCKi/WSiFhKd1ESLbfrpNEec4okBoLpBh9Du29tuY9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvnQoi7X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805811F00893;
	Thu, 11 Jun 2026 00:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138743;
	bh=9uZbnvCSonpXGXR9vVuWodMYLgOTp+M2HsRiZcKEBSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kvnQoi7XFldjN2BdBn0zt4ODPTH0Rziyc+P/OqBnV5fubj/PIn/MW96wZ1XZ+33iq
	 UJABwOpTLlgPcAux0C319hfvOJEhVks0l+CoOxSRnfhEIIoipa8ABb7DGQ3lHDrk5X
	 52wsqSD1JeyRcRk5WRFB5HIrvYCkkd0Xk87q5ph5KCuduNCe8NwvKsRvxZQtShLl0t
	 mX8yXPS1yZhl/bCm7Q5SfpEAUY1YBBNBDKTN7gEMXQYo3tNrvult/UVwwCfNgmxPqh
	 W13hzPkgteSo2H25Q8iZ2oSmRqbdJ/1/4AyyTIkujL7MfmMoUfpO/YADyWSoySokOu
	 vCgvknRSsOrXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Mark Brown <broonie@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dongliang Mu <mudongliangabcd@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	lvc-project@linuxtesting.org,
	Felix Gu <ustc.gu@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 5.10] spi: meson-spicc: Fix double-put in remove path
Date: Wed, 10 Jun 2026 20:45:24 -0400
Message-ID: <20260610-stable-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610161129.7612-1-apanov@astralinux.ru>
References: <20260610161129.7612-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:apanov@astralinux.ru,m:broonie@kernel.org,m:khilman@baylibre.com,m:narmstrong@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:mudongliangabcd@gmail.com,m:linux-spi@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-amlogic@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:neil.armstrong@linaro.org,m:lvc-project@linuxtesting.org,m:ustc.gu@gmail.com,m:johan@kernel.org,m:martinblumenstingl@gmail.com,m:ustcgu@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262594-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,astralinux.ru,baylibre.com,googlemail.com,gmail.com,vger.kernel.org,lists.infradead.org,linaro.org,linuxtesting.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DD1F66D8E2

On Tue, Jun 10, 2026 at 07:11:29PM +0300, Alexey Panov wrote:
> [PATCH 5.10] spi: meson-spicc: Fix double-put in remove path

Queued for 5.10, thanks.

--
Thanks,
Sasha

