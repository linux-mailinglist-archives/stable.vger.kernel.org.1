Return-Path: <stable+bounces-246741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKLTIvwDBGoHCQIAu9opvQ
	(envelope-from <stable+bounces-246741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:54:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F0952D56F
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0980D30B1E66
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 04:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79456388E57;
	Wed, 13 May 2026 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpxwIUTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FC2D5436;
	Wed, 13 May 2026 04:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778647871; cv=none; b=UUQ5R+lQbniVLDKkPVYJ45wXFPWy68du5d80WNK08UALC1kWhFYggPVwaEgr631hKixHVfmZ6MrrPMMUJ7x5CV6H7r56ukG/lUGWBFCld9KIDY43DZ5NHJK6UuOlGgagsLd0DLiuErGhbp2ZBhKMkG1lGyVV8oChIj7cdy+ADIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778647871; c=relaxed/simple;
	bh=9Tbss+22L66mb/2fdV6MWgqXfYkdw8ChYubl+Qc9BbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAIhHV4K1zFTMQG745NxACrjdVziUZZrW4lRKbHHRCSMCL08qjVObxuAoMgLKwBUhhltppiELxeNmTMVqo+G3XBXhPd8ztavmoM5VAmNpVhWcsxWVpDQBPW7ZuPRYnFBb9z+/0tOt33kPkwQeMjG1/NAgsopn3RnuulCBt1wakk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpxwIUTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0557FC2BCB7;
	Wed, 13 May 2026 04:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778647870;
	bh=9Tbss+22L66mb/2fdV6MWgqXfYkdw8ChYubl+Qc9BbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpxwIUTjpbhtckPk4FTGHuz8EAzpVS0ZSQ3+Z/uDp0gPNOgmn2pM9q9zlrXILKBEx
	 jN/9v64u/QFOZTiqONFGJQfCrvT3gsokTbi7CP35RS8hCh92bH7q7scQzMrNhBqfwi
	 meT3whhkIUIxHB+9c+qSqRZK00vzye2xT5OQ/DReyzzETeWUdjRH9sX0Zo/Mmg4GHQ
	 LM3ndNw6Jzlsn4A+S8N4lgzaQT6B0CNInELAIPP4gYp/ZRWxX1PxhvMnz2WbiiyXez
	 KpfCIbDkmHyGwRbTABKdrrcr67cPOjaspr0QxWwkQ25TFnM0tHDR2qiosoAdWgK1BP
	 QCeqe0+0ZBqlA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	damon@lists.linux.dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Tue, 12 May 2026 21:51:06 -0700
Message-ID: <20260513045107.194019-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513044700.193786-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 22F0952D56F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246741-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 12 May 2026 21:46:58 -0700 SeongJae Park <sj@kernel.org> wrote:

This is a wrong patch that mistakenly sent.  Please ignore.


Thanks,
SJ

[...]

