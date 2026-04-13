Return-Path: <stable+bounces-235890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HQtFzNx3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2133E7485
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 372C030915CD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C6337FF61;
	Mon, 13 Apr 2026 04:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHeHDOeg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B9382F1A
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053624; cv=none; b=BuFcslHRVZ89A8SVJjz22MoRw1zpjzhnXhmV1+6y5L1wWotxlcclKVrqX15M2dXGL8Zt+pagumrr/qDCmP7KHddTCG/f3SA3FjQPAwjCONdbmHNCneENmXmypIgUmHMY75bVL8MNUXUIzKoN0ln/BC4gtETS9hw6aPXRjW+uNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053624; c=relaxed/simple;
	bh=/VT9cOl1i2h0wum/gqsSmUk/LSeFn6uPFs7tIOlk4KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvvsjZyC2+QDVhKTwPIP6Ss6INwD63bw2HDLnhKuKQbL7VDYS3zyVT/2jpcYnoyvWAwbuUKoj4pLVo8BPTtJP8fN18Hhanq5hVloAU11s2sYpZN1BZhmxCJVpxjk5yvKURh3+bqSc1g1Zo5eo1a9E2lLPVRT5hjODw6ynkkgzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHeHDOeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA63C116C6;
	Mon, 13 Apr 2026 04:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053624;
	bh=/VT9cOl1i2h0wum/gqsSmUk/LSeFn6uPFs7tIOlk4KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GHeHDOeghuywJv1+PVlcwDrUmE/vN/ughXgxCh7aOtGqd2DpqsdgbfStcDrsSogzM
	 zVyI4TFiUx8ODQUuzroqN+v85yGf6Rfg528+WpZC/zIBvDAduJMUtndBOeBCBep89a
	 jmA0x8NR9npC5zBeFUZf72DtjamxE6h0wYWhgu+t0AsyBAPIp6GWM1Q1hYkFjxrnf9
	 BNDhvV5YCliLeiSn6UUplT+NTs7XFecbr5yc9a/5X21daLGdKDGSpOAkvtLqptaOAD
	 CRdVbfr987h2uoRHW6Ur1aYyE08VGlOkHdkQKfV4Gvlx8KRx73KdFGndu+gDfKUYzb
	 jNaxqSzZ68BVg==
From: Sasha Levin <sashal@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 5.15.y 1-5/5] MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow
Date: Mon, 13 Apr 2026 00:13:42 -0400
Message-ID: <20260412120103.mips-tlb-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410005452.49666-1-macro@orcam.me.uk>
References: <20260410005452.49666-1-macro@orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235890-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D2133E7485
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 5.15.y 1-5/5] MIPS: mm: kmalloc tlb_vpn array to avoid
> stack overflow

NAK -- this series fails to build on 5.15:

  arch/mips/mm/tlb-r4k.c:765:31: error: passing argument 1 of
  'memblock_free' makes integer from pointer without a cast

The memblock_free() API on 5.15 takes phys_addr_t, not a pointer. The
series needs to be adapted for the older memblock API.

