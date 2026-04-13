Return-Path: <stable+bounces-235897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD+AJspv3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4163E741F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87D8D30377B1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE4D38F64A;
	Mon, 13 Apr 2026 04:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGAwD66c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D848383C61
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053638; cv=none; b=A8ACI1BdNSORwcyrKoy9Yao85e+BRIC4tD/mPvEE47Oi6P39V1JXPLpNYLhd4Eg72PAZkb02nVIcfzW1b0fMj0jdPXrw6uS6h4XCUg05adW9HEjv3JqnvhKbSUMpmFE9Cke5aVi1vkhcMiv6OI87am5XQCcMziBnY13j28E/rbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053638; c=relaxed/simple;
	bh=P21f8x6AkxmLoIbZzhk6HO4q1YVvb/i3N0zJUr7tWeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exYPM/dzLjimyXsP4ydD5cOG2avQOo6vD1xY4wP+OLmTABXBXzzUQCnp5HBuxmVXMsv6Ubw79Y2noXrDtApgDNs7LRcDs/UBDvvgodKaZq/Hl9LM6KU0UXGkuaZiyEjquZSyJYojuDTgLz48z0hOkXORLklKxZD+TzXWfd2qL9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGAwD66c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44509C116C6;
	Mon, 13 Apr 2026 04:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053637;
	bh=P21f8x6AkxmLoIbZzhk6HO4q1YVvb/i3N0zJUr7tWeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGAwD66cY4atyP5h8mVx6y6wRvm80IEIKNftlYFpAsts+eYqs0iBcYOsfWkVVkeM8
	 Xz10L58USob2tl1kgDAiYjfcKWkbgpzNi+400faFgiK7udhN8+/f76E8cJ/O+zKS2q
	 kTpeMXM6d5jlWNKCqh0UbKDB6EZBRlyyyJrKlKJDPl2qmcrb0H+2ixHY2Sa924/fXu
	 ShgTqSNZBjEnm337d1xkdsh0/LrBOcCA4anlAxv3nHjvga6mpT34www2phk+oQ3zf8
	 vek5qe4R3f6goyR92+ViV3tFIA5VTkCZ7XKByaDxOoBdy2MBj1Cya2+dVsmag52+Tw
	 UT1k2nGd1j04w==
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.12.y] blktrace: fix __this_cpu_read/write in preemptible context
Date: Mon, 13 Apr 2026 00:13:56 -0400
Message-ID: <20260412120103.blktrace-preemptible@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410075528.1996-1-681739313@139.com>
References: <20260410075528.1996-1-681739313@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235897-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F4163E741F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 6.12.y] blktrace: fix __this_cpu_read/write in preemptible
> context

Queued for 6.12, thanks.

