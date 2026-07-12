Return-Path: <stable+bounces-273522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3uKNBGr6U2olggMAu9opvQ
	(envelope-from <stable+bounces-273522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 22:34:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52619745D7E
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 22:34:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=drtMqrls;
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273522-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273522-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84D44300D71B
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B23B42EE;
	Sun, 12 Jul 2026 20:34:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40719367F2F;
	Sun, 12 Jul 2026 20:34:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888484; cv=none; b=esiEB7Rjf/emVBOiRD5kJAlY0qSwG7nvSpGIrNFFx5IAnnC1Eb37FLoLNNHPpsK53+R/PZ+wCek5A+dlj382DtEu4T8QtqrgFFGAVZ5UNOdJHtLUx1aGsX9U4MFRLGl981mA4cLpDbC9UebXHDa0/7UWBNx/G8lBAw6ecldsMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888484; c=relaxed/simple;
	bh=LQ5qnMAyqyImi61w94qWvB5yljc6lYL/VDkUQYzT5xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qn+ria2mKrXuGlEwpwoW+oZVxemCmrLz8QMx1GufZ19jeRRUNX0QWk8WXchU/YaxpjwWsz4K0D2z89UhRk5Ha7qTxNan80PSlBz81eYPQvsPvu8AkIDFLKsC09Q6EznEDk8oVaVj1Rb8UEY5UPtWBHRVV4kY3lrGIPk4O6w7AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=drtMqrls; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=51X5ACPiybVecl/egLVDpzxmSGAC3FWqg15+e0vfnfE=; b=drtMqrlse0CCYqM1gqVb3oNwOB
	1rm2ACUG03nC4BVS03Ff9HOF9kZJQvy2g2PzuX4W9gVc9sOtjb7315m4xPDCC9/Bj/ULbninyWKzo
	/MDZhS+UFBbB9lovaegH5ytHNM60wofsEs9/LFZN12ulRNGv944rgVJVgRaCylOZRB72DTAEPxoS2
	aRwPuxUsCC9LJW2RvPZ7RHRKMZxpDwIPsxzWYUzQlXOA6xSzHPg1sV6sauXd3WPUY0haxO2c+qOAu
	CSQsFGbELMJYs0zr5CcRwJC7i5drPNO/5/mb0WViQfo5ExuA05RYsxOSsMvD4AubsKi4FnOZfUyXO
	qTV8YCRQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: Oren Klopfer <oklopfer37@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peter Robinson <pbrobinson@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinephone Pro"
Date: Sun, 12 Jul 2026 22:34:00 +0200
Message-ID: <178388833983.1396294.14906370206839721571.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703201010.67311-1-oklopfer37@gmail.com>
References: <20260703201010.67311-1-oklopfer37@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273522-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:oklopfer37@gmail.com,m:heiko@sntech.de,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:pbrobinson@gmail.com,m:regressions@leemhuis.info,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sntech.de,lists.infradead.org,vger.kernel.org,gmail.com,leemhuis.info];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sntech.de:from_mime,sntech.de:email,sntech.de:mid,sntech.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52619745D7E


On Fri, 03 Jul 2026 16:10:10 -0400, Oren Klopfer wrote:
> This reverts commit 096bd8c679185f898cae9933c6a68650fa26ea4f.
> 
> Just as with the Pinebook Pro, there are multiple chipset variants for
> the Pinephone Pro, and multiple firmware binaries for different
> distributions. The change causes issues with some of these combinations,
> and reverting it resolves the issues. See the Closes below for the full
> report.
> 
> [...]

Applied, thanks!

[1/1] Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinephone Pro"
      commit: ee7d67291fd95554dd24e9db8d8983a27739eadc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

