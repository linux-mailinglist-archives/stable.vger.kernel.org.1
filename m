Return-Path: <stable+bounces-235888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBUkFK9v3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 050923E73F4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 827333027DA9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7449538E5E1;
	Mon, 13 Apr 2026 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS/mSG0e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61C38C43A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053621; cv=none; b=d+BcKXbkOIx0FOsIQyYPOvAowtN2LH7YRetZOMpNq/VwZAIJtBz1cZQsxaSUomfEuMocuCesOFu2udSplrJBu0KSkJl89fHMZKZAS0saheRtXrJx2Qkk9w6aYKR1WsgLeacwU3JMMQsxJyzaB0Oe8GbIuTucZsmNr5b1kJtUyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053621; c=relaxed/simple;
	bh=EsetBtR084X/y8AV7tLWDX0KbHsT04uYzoJkiYaoepw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2Kw6TvsHCyyWIVn1El2byLTiSxxvFDY/MrhKkzy8kWzONg97R90kZZ8END0SMKtM3zmbdvvWOqNz+jrHnY1fpkBNnngC/UoBF1JGQ0NMnAKt04GunU4vSWvVB+pWYH1gwhupzjVXIyinkJBqb5bz58uZpRV3hxRalpIlGgk+FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS/mSG0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A276C2BCB0;
	Mon, 13 Apr 2026 04:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053620;
	bh=EsetBtR084X/y8AV7tLWDX0KbHsT04uYzoJkiYaoepw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aS/mSG0epoWTGD7ri1gDLs6GJ1UKz6PCaRzy7EI+BDFtmano74xk9/QjNf132Wx8k
	 mZXsqziG44qZFo3aJP2RgE0u+AfNG+MDmOnOOJD5LyD/TJ9RQSYUjqfEYMnCd1njz1
	 L3VyG44OvLvpZuw3lW/xWlfZXHBV5znsZGC/Xv2qJ9edftWSiTT4qe1RW7fQIPWbSn
	 5FgPJmstSAmOOEcKiB6Mh3yyAJPEVqLX1kzKEv35xCHxQCEvVWs9LAfQ9ZWliQRx33
	 TvNcOSkvl/0snKDb5JFeoGuNa3+ewPlamdVOb3U4cjHPelFtpQyaTecDUwf1TvyUaB
	 Lrv3qhOzCagLg==
From: Sasha Levin <sashal@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 6.12.y/6.19.y 1-3/3] MIPS: mm: Rewrite TLB uniquification for the hidden bit feature (+ prerequisites)
Date: Mon, 13 Apr 2026 00:13:39 -0400
Message-ID: <20260412120103.mips-tlb-6.19-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410005057.49091-1-macro@orcam.me.uk>
References: <20260410005057.49091-1-macro@orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235888-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 050923E73F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 6.12.y/6.19.y 1-3/3] MIPS: mm: Rewrite TLB uniquification
> for the hidden bit feature (+ prerequisites)

Queued for 6.19 and 6.12, thanks.

Also queued the corresponding series for 6.18, 6.6, and 6.1.

