Return-Path: <stable+bounces-244829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIwpKqVR/ml/pAAAu9opvQ
	(envelope-from <stable+bounces-244829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 505734FBCBE
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A784C3019E48
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 21:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E417423179;
	Fri,  8 May 2026 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB9qb3Lm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD7421F1A
	for <stable@vger.kernel.org>; Fri,  8 May 2026 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274717; cv=none; b=kURQNcj70D54yZs8bMM02yvfXAA77sYptBhLH36E+oawurqNKlFTB+lg5aL/vMLDiR0Xl6TjrJrXCBObyvTXsM2N6SpoXUlyxUqLzgK/qhXLRyD3mNd40sKUR7a+7D8YUzSfeX1cRLhf9glcFNh66vyhIfw6mlHuUwKlhjyBuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274717; c=relaxed/simple;
	bh=ggm2YxIovqaNX28gzeaVqZVZw5ASrBvJ2S6vXbs491c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcF26wOFh4pIJfNjWJZ0DJmLzWUGoDPm6fJmT942UTirYCQvGoeonOh2uzozw7psKawbzTpZILcnObezpp/X2EOOnSvrqZl91lNmAuYABj7uFLhFJASlxcYRVAjgC200yyZDKjFNZT/ImY+aBgDglqeJUUGH8eYeWRoZCCe/AWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB9qb3Lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF285C2BCB0;
	Fri,  8 May 2026 21:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778274717;
	bh=ggm2YxIovqaNX28gzeaVqZVZw5ASrBvJ2S6vXbs491c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bB9qb3Lm2XEMB1H+vGRz425Fk0gSlaZgkEAoEVtzzACXtGU+NCBmlQn57/XOBeZpx
	 nGCWSqoeLQCJHC8lYRG9oKpHUUNsbekH/HB+QfhsGCSdNZ+Nd2H7MdE9j5e/HzoLBe
	 BDG2b9IiVXWYp0JbDvLA73HLrj1XyKfH6WzmdtuTFCABbGN/YqFCBTtKZFyPEgXfgs
	 xM6ynimpEj5KrrVKlaPGIK/vqhP3PMoFvIMDiti65QDivjjz51vkkm2YpoOklhSgzE
	 o+FJFQNu0oK5rvhYQffet+O85DQjrKKDZc3ZewI6V1yAfHCKGxV6P0MXvO+aM0KMyE
	 QFazin7gh89NQ==
From: Sasha Levin <sashal@kernel.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	dhowells@redhat.com,
	horms@kernel.org,
	jaltman@auristor.com,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RFC 6.6] rxrpc: Fix potential UAF after skb_unshare() failure
Date: Fri,  8 May 2026 17:11:43 -0400
Message-ID: <939b8e49da80ebac-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508083142.1752208-1-guanwentao@uniontech.com>
References: <20260508083142.1752208-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 505734FBCBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244829-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Subject: [PATCH RFC 6.6] rxrpc: Fix potential UAF after skb_unshare() failure
>
> [ Upstream commit 1f2740150f904bfa60e4bad74d65add3ccb5e7f8 ]
>
> [ Readd rxrpc_skb_put_response_copy() or will cause a build fail with commit
>   24481a7f5733 ("rxrpc: Fix conn-level packet handling to unshare RESPONSE
>   packets") ]

Queued for 6.6, thanks.

I also took the mainline follow-up 55b2984c96c37 ("rxrpc: Fix
rxrpc_input_call_event() to only unshare DATA packets", a Fixes:
of 1f2740150f90) on top, so 6.6 ends up with the same pair that
6.12 already shipped (bf20f46d94f1d + 016725807ce3). Without it
the unconditional skb_copy() of every cloned ACK/ABORT/ACKALL
would re-introduce exactly the regression that follow-up commit
fixed.

--
Thanks,
Sasha

