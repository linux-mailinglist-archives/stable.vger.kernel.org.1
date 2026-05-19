Return-Path: <stable+bounces-249674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH0SAR+5DGrdlQUAu9opvQ
	(envelope-from <stable+bounces-249674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:25:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF945841FD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76756304F775
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D433AEF55;
	Tue, 19 May 2026 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2MIEoR/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D433E36A
	for <stable@vger.kernel.org>; Tue, 19 May 2026 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218716; cv=none; b=jkBwgyF74lOAca7jld/uCWsVKzGCRVtzLdbhfNqCA6TIfG7+ti4dF5AK5trnk/kGD2i6sXuO4aY6zy8u2tLrppi66ElvoPlq+mKvWFQBy9wCzjAj0oP41KVMy+B5hVGa0wlsMulOOx9G5Vqsea1XpmzC/uJB/zI7Z2hL0en16Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218716; c=relaxed/simple;
	bh=xsrvhhDknERo6S7C6NIj0jmj4YwVpnGTtkhN1Q4alLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l12AyHnbF4D0fw7yVp9ErBaaqQhyuuJqhZY+JkXD+Nlo2rSGLO5cmLNuJAEzAOCKm0VidV34kRrvNWcsrcXBlwygdmXSv9ChLTSoFOY4t4w4poIcewMiKUemeA82DJxte5yJsf/oaJgBJ/AGM/74dv7PGWO1sWNoOoXKQU0y3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2MIEoR/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71D51F000E9;
	Tue, 19 May 2026 19:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779218715;
	bh=xsrvhhDknERo6S7C6NIj0jmj4YwVpnGTtkhN1Q4alLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e2MIEoR/Zu2b0aLPCoZbrf/slelR0GHBLkO1T1Je7nX9XetCBx298CVTfQ3cwZ3ZR
	 XAHqBisOPKM0BM7yySPMxLP7+EF/9aPPddRlvq6SI8XxN8H1ig7Ac7tCp/nyzCdBQJ
	 cuik5U6pb5MZ/p2HamJvbKQLdyAOXHaxjY8MJ0AG57Y7s8++TPk+YUoXv4emmLGpL2
	 LJF/P7xK0kN6iY91beFQS+abiNohMea9i960QJ05ZrWTGKw0ZHxiIN6+Bl3iH5kkIy
	 l+gS9iAqRZbZWWTYuvv3LluMYA0wbdoIoirnbyj5pp+RdYbzZDUs/pk2TruiGWMcpg
	 AitYCaV1FY/5A==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [patch backport 7.0.y 0/3] rseq: Regression fixes for legacy/tcmalloc behaviour
Date: Tue, 19 May 2026 15:25:11 -0400
Message-ID: <stable-reply-20260519-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516160138.835556923@kernel.org>
References: <20260516160138.835556923@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249674-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9AF945841FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 16, 2026 at 06:03:45PM +0200, Thomas Gleixner wrote:
> The following three patches are the stable backports for the rseq patches
> which rejected against 7.0.y

Queued all three for 7.0.y, thanks.

--
Thanks,
Sasha

