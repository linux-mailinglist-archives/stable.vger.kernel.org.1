Return-Path: <stable+bounces-272697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uq4TEJZ4TmrCNQIAu9opvQ
	(envelope-from <stable+bounces-272697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:19:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 025867289CF
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:19:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=m1FyK8ff;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272697-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272697-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E678530230FE
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2699430796;
	Wed,  8 Jul 2026 16:18:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2942DA34
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 16:18:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527498; cv=none; b=Dbt0qQaMSwCMsTCO237VXwbhXJSAO8RUXT89nIfWE/15f8tJbid1/j4RjNNhp4AXpcljFC+nyfdVH1Ytu8a4NoSRm4A6nvKgdK9ThPM6kYu4JjiiBOtkxcrJKGAY/p5QcZz75bZgGt6XLI3/8UazOy01kJYMyPv1TVcYrFtFTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527498; c=relaxed/simple;
	bh=Z77oCevfIR3pbeHzvsilpG3udijYIYRdK3NhZwtFVXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=At6eJom5S1DDO1I5bDMZd7pfyCnTwHmIXuS6n7zE8SRiFYJ+zseItEbR27J3lrSFvpbzpNcVVY1ufb+qr0zykxbZXyxMRtW2QVcIfGpixEuUBTAR4Pk9gPk4bcfZB+4yDgRPeFuqRY2K7+sCjUye09+MZbXfjaoeRzE/cqRkxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1FyK8ff; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765921F00A3E;
	Wed,  8 Jul 2026 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527497;
	bh=w6IGAxOVKX4I1hYiIVaYJNqmTwuBpnsL0vfvPP0k9JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m1FyK8ffIlqgV+O78YzwLse1C3CvQ9E081TPnCrU3HYNvLqUJLV1xv763v73KRp5A
	 cGA2dEqJldOh9/uEOdWVizqSou2fzPHEh8vycYsArol8LL+1fScKkcCJ5ilNZU0Twm
	 xxLi7+h19VAAIRBUc5IRCFfwBLORO4WbxyUtoVyczHF0NHG/j+vOsY7+7z3x6ojfgB
	 TYbPyXH2M815Lg9CWBJzbtTqrtlQvEp8Wle/GEwbZxDdmrQdHALKcbS49rVwrK7pkV
	 zKsykznZyXv7Ke/pNQSch/Ams39QCz00ZcRVNBmrm7fmmmLnOGG5mg1Z+fDIJhREUS
	 y96VLQsgILXZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	wsa+renesas <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH linux-5.10.y-stable] mmc: renesas_sdhi: Add quirk entry for RZ/G2H SoC
Date: Wed,  8 Jul 2026 12:18:04 -0400
Message-ID: <20260708120506.agent5-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707104417.105834-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260707104417.105834-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272697-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,sang-engineering.com,glider.be,gmail.com,bp.renesas.com,renesas.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:wsa+renesas@sang-engineering.com,m:geert+renesas@glider.be,m:prabhakar.csengg+renesas@gmail.com,m:biju.das.jz@bp.renesas.com,m:fabrizio.castro.jz@renesas.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:prabhakar.csengg@gmail.com,m:wsa@sang-engineering.com,m:geert@glider.be,m:prabhakarcsengg@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 025867289CF

On Tue, Jul 07, 2026 at 11:44:17AM +0100, Lad Prabhakar wrote:
> As requested [0], here is a patch to add the missing quirk entry
> for RZ/G2H SoC.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

