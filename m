Return-Path: <stable+bounces-269405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I9HSLzX8P2oDbAkAu9opvQ
	(envelope-from <stable+bounces-269405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:37:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5256D24CD
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:37:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YJ0CwFGr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269405-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269405-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CCC2303D138
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02053191D6;
	Sat, 27 Jun 2026 16:35:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5FD2701DC;
	Sat, 27 Jun 2026 16:35:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578145; cv=none; b=Emp8fA6Q40bon+QgvrWpmyRPO28PQHAJIr687ac9GExx78iDF3XEAJp8jV6xMOkqCiRWFvnhYevjvjBB5resEVBw89KdkT70D3Rz7VpU1RZZr4vPKK7DOYXLTjqpuxKupt2QJC0oHSHNwO6n03DARJsoW2PnpNSKvQOC8blTJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578145; c=relaxed/simple;
	bh=BI0aVFVn2gPFp+jQXi9c0CU/fJ9YlsafViDvbp2j2tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBlhdCs8oWGiCKJD+wqFSt3B8ss/xNry5vFthzIGArTyhO1CTExxp3lei67qbT9u7sfUcuUgyK0pAXnWVlQZbrXc2E+2M8Cokh3bzSCZuGi7Bm8oNTkLk/SVGhwng6m/k4Ub9KLbQNbYXg7OFYJgMga6muvxGsloZfDlmd9R7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ0CwFGr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CEB1F00A3E;
	Sat, 27 Jun 2026 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578144;
	bh=SOW2A9X67pJiFypuasGaNCH5S7wfwdO9WUzAegDlmvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJ0CwFGrY75wg3xZLjVyVQhxHTkb3fhfKRct0ivNmrNFrYyyQvNf5riwxB6wwH2Ue
	 W72naKrfmuEgZdFDNE9Vk0of5zYsV7BL/Ny6v1oakUHd2hClfVC2V/xG/NTEn0cw5s
	 5bVyvEhZH2vX7y+6mxKeKWS7zPoP+pB4SYDlN0a7NFGXytC2LNEql+4I8bNj7dCg9K
	 DjaQyIe0FDVG66MWQ1yNBBhLlpevkDtXFwjdrBAVtlGj+ciJmKPjzM6wbMoma2PhDp
	 qscKxgBwkE8hRgwC74qfR66X/xsx9gTJNnuvq3YCR/3xRO1WFpnY2YK7J6M60KQ5jT
	 GeGPRbDPGHF0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	andre.przywara@arm.com,
	linux-kernel@vger.kernel.org,
	cristian.marussi@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Yijia Wang <wangyijia.yeah@bytedance.com>
Subject: Re: [PATCH v2 5.15.y] kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported
Date: Sat, 27 Jun 2026 12:35:31 -0400
Message-ID: <stable-reply-item016-arm64-sve-515-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260627032259.2086191-1-wangyijia.yeah@bytedance.com>
References: <20260627032259.2086191-1-wangyijia.yeah@bytedance.com>
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:andre.przywara@arm.com,m:linux-kernel@vger.kernel.org,m:cristian.marussi@arm.com,m:will@kernel.org,m:catalin.marinas@arm.com,m:broonie@kernel.org,m:shuah@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kselftest@vger.kernel.org,m:wangyijia.yeah@bytedance.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269405-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C5256D24CD

On Sat, 27 Jun 2026 11:22 +0800, Yijia Wang <wangyijia.yeah@bytedance.com> wrote:
> [PATCH v2 5.15.y] kselftest/arm64: signal: Skip SVE signal test if not enough VLs supported

Queued for 5.15.

-- 
Thanks,
Sasha

