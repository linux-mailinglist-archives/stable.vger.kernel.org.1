Return-Path: <stable+bounces-244266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDuIG39W+mmNMgMAu9opvQ
	(envelope-from <stable+bounces-244266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 22:43:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E564D3C08
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 22:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC143058B8C
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D113D8116;
	Tue,  5 May 2026 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqt5A5Ne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BFB30DECE;
	Tue,  5 May 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778013677; cv=none; b=jx7Z7mveHk75PeB/2Xn21tn9n+EiJtPinI3A3qknc8pHgQTtJnWNIymYgNH6wSPQngnSfdx/2A+3iYE5QmGKGQ/j3QzOh8XjQcr35MMpW4RLiZtsDwwQh1IF61gl9mqLEILbPIZVXGWPvd7BmYuSZmlZDtkhWn/NNq4s5XhWLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778013677; c=relaxed/simple;
	bh=tXi/7g8m/ysWUdm1p0NQQETGqmM6FhhWlXa9/YPvUm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9mdLzlPdHDv/FTNA661LfpATB2theVG56Xd1ykksb8K89J4kKQCyYUyZJj3Id/VKShqp1EpqpzV0k+W51sBgLkWdX2TwI99DJfga4UACJ2KnhVBZv+rv09mn6PuO/4ZZ0pzjzfJGcNrjRBZ2aZKq0aRQsXFUUGe4OarHYjH7ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqt5A5Ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9367C2BCB4;
	Tue,  5 May 2026 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778013677;
	bh=tXi/7g8m/ysWUdm1p0NQQETGqmM6FhhWlXa9/YPvUm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oqt5A5NebI8mEoO2P4M/HE0oYDFPjHBmoZbohzpyf28JOUwlBdFgagEhXGH+kKqus
	 Gic2mXjLKmpiqI2TOxVLEPjqmTgRZPEbBNcWvUI8MpGRADjQ2zXDi1OhJ4K9f9klNN
	 hf0/jW7tjyEOfOkrLegUCLfITEMjPp5Ia+6g9/4qHjo3goG3UWtt7vWwTWwEioCXzK
	 k+tRRfryl9QciqWABaK6pF29883oOiDSmZdcoiuAtFXCc7DZlvzl2LN/HbJ3s7+JjX
	 /BQfQwCLw1FQoBydTYNRNv9/RICSjpgY9Ge559FZNI9JGj0QoCR3M6vI66+e24Vk4d
	 FQDXk4UnNLi9Q==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gang Yan <yangang@kylinos.cn>
Cc: patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org,
	MPTCP Linux <mptcp@lists.linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH 6.18 214/275] mptcp: sync the msk->sndbuf at accept() time
Date: Tue,  5 May 2026 16:41:13 -0400
Message-ID: <20260505202943.6c1e41dadafd42d4b296c806f9ddd561@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <68c8f2a7-6149-4b65-bb1b-0ab4cd4067cf@kernel.org>
References: <20260504135142.929052779@linuxfoundation.org> <20260504135151.022829547@linuxfoundation.org> <1bbeee9b-b69b-4be9-84ee-ddadda4793ef@kernel.org> <68c8f2a7-6149-4b65-bb1b-0ab4cd4067cf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E0E564D3C08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-244266-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	BLOCKLISTDE_FAIL(0.00)[172.234.253.10:server fail,100.90.174.1:server fail,10.30.226.201:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 07:50:47PM +0200, Matthieu Baerts wrote:
> FYI, I quickly checked, and I noticed that 'subflow' is different on
> v6.18 due to the "mptcp_for_each_subflow(msk, subflow)" removed in
> 68c7c3867145 ("mptcp: fix memcg accounting for passive sockets").
>
> Moving __mptcp_propagate_sndbuf() a couple of lines above, before the
> for-loop, should fix the issue. I can eventually look at sending a patch
> with the fix.

Dropped from the 6.18 queue, thanks.

Happy to take a corrected 6.18-specific backport whenever you have one.

--
Thanks,
Sasha

