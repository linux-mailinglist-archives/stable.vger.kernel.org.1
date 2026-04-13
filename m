Return-Path: <stable+bounces-235891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CWdL6Vw3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:27:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9E3E7466
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF67630616CE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B4B38F938;
	Mon, 13 Apr 2026 04:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIElmOhP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727238F63F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053626; cv=none; b=ZOt/uwNMGQjgWquNmzhc4/9uuiJ+faiCqxpbT4qUAdVRQZQn6qlhluU8/z8zG4C8s91WyWg+LRu7c0d8BnFD4Jt9gWBbJJiPMGfSTKz6DenMUIu4t9eziaDJnwlFW5bmr5uF2vZZypi23ciGLvfgF3xGdiEIwnGynRTziJHBTF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053626; c=relaxed/simple;
	bh=pxagk5yV+DY99nTPoAEvTDDP5aILBrVm7mLdYn+29SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xig47G3hIKEUue+BEk0dZ4vyPdNc8mmGVavg/WaX5dybg8aorD+gQFhk1fZ6QRC6lizHZ7W3nP66DwE8OcTfDUmdQt80OsYN5i25PGgfqXuYdT3OhnMJqO5QMaJ1x6UP0di1USZvW+8NWgZwVxEYiQ4dy29C7bzctFyfH5tylCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIElmOhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BCAC116C6;
	Mon, 13 Apr 2026 04:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053626;
	bh=pxagk5yV+DY99nTPoAEvTDDP5aILBrVm7mLdYn+29SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIElmOhPtiYdaYlipoOO12YViXUR0/D+KBdmUJlEbsqt580oD98NKdsvHG/Z+umoU
	 1GSBqMKuCmjvy0IUIHOQgSVXIvjPAxGyVgxeIvim/MDoeugBIvfQ54oFYagWiAI957
	 qxpuJPqpxZ48gKYQxWcBmlAnOiK09F+iDwz6WdyozV9RlYkUXL0wTPdabJ9HSyRUjd
	 us87qKQPHHJPvlpx9I318RO/xdR2pkX+pGD0UD4XBai5Zi/k9VwNFZjg7+nGdswNhQ
	 CjNP/Y9bu6nv1R3oa2MBS61RqI99cyVoN1vkulvbgNqxBcGPcs9cTF6WhntWeUryWO
	 z1AMyCabRy8IQ==
From: Sasha Levin <sashal@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 5.10.y 1-5/5] MIPS: mm: kmalloc tlb_vpn array to avoid stack overflow
Date: Mon, 13 Apr 2026 00:13:44 -0400
Message-ID: <20260412120103.mips-tlb-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410005546.49873-1-macro@orcam.me.uk>
References: <20260410005546.49873-1-macro@orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-235891-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 47F9E3E7466
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 5.10.y 1-5/5] MIPS: mm: kmalloc tlb_vpn array to avoid
> stack overflow

NAK -- this series fails to build on 5.10:

  arch/mips/mm/tlb-r4k.c:765:31: error: passing argument 1 of
  'memblock_free' makes integer from pointer without a cast

The memblock_free() API on 5.10 takes phys_addr_t, not a pointer. The
series needs to be adapted for the older memblock API.

