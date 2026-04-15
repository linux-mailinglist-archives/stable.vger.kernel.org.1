Return-Path: <stable+bounces-238137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OQfDWOZ32nXWQAAu9opvQ
	(envelope-from <stable+bounces-238137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:57:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE53D405123
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBF973093027
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C753CF049;
	Wed, 15 Apr 2026 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBKjw9P0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A03CF023
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261443; cv=none; b=tKZEkwK9wYxVHU1yuUQbZvYpTkSjpCF40y/gZM08c5oByJf4b6TsigDQMDBtA5Bc7/MuigJyABbPJgbc5b69+vT6JC30NLRNTtDS8okCtF/FiW5HVWHPMqqmyFWfnAwraJLfOIhF5cGHutr3NqRr3P19HACs0NXBJ1kj2Be1Fxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261443; c=relaxed/simple;
	bh=kR6XaPPhqk7/FZfm+7Lrh4cNqr8IqR1rG7bYGB+SH4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmpqN+ZJp6YGWiP6/xmxVtAUOFcIy/VGn9/cfrmXwWeGp6GCrPshQHtAVSTjkEcqq2njGnTV6/3o/lguQ21JvQYwv+2AukMEPxtKdZgDW3/jw3hyj06NLqNIdr2LqHVgrCTQR9RrvchWKnUkL4jozxI2cehnrJ4yg5tSpFDt7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBKjw9P0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7BAC19424;
	Wed, 15 Apr 2026 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776261443;
	bh=kR6XaPPhqk7/FZfm+7Lrh4cNqr8IqR1rG7bYGB+SH4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBKjw9P0D3Yo/nvGtf4WPYh6j4CqXiH23IeCOLT8wT2v5u4Q8AGdq4gtZmceZXadL
	 N/B2dEu2nMt9Rag30PV5wCS5baXGwo6bLrBblELe/O42JVr2f6mv5U3DFoTeHknvNZ
	 s0czrxN5B5T31B34SOOz+qSblmPOsKvKc7hMR8JgwAQlWviIJvKL8OqNYuTqZhK3lN
	 Eq+ZTWw4PU9M9FwKtpLXDoIjmGJ4eoUmdqbJkcOxHABlGV2nZuP2K91h3NVKS9mWXX
	 FK74QosMC4K60dVKxSi04qHe6V6xnnlMrP2G2sucO1qjdkxK8eB2XMf7a19tl5mI4a
	 7xackfAJwx67w==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5.10 191/491] can: gs_usb: gs_can_open(): always configure bitrates before starting device
Date: Wed, 15 Apr 2026 09:57:21 -0400
Message-ID: <20260415160001.gs-usb-keep@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9e1d8d13f872acab49ac25ccf6d18b3a2698d421.camel@decadent.org.uk>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155826.219285216@linuxfoundation.org> <9e1d8d13f872acab49ac25ccf6d18b3a2698d421.camel@decadent.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238137-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE53D405123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> This error path leaks the URBs allocated above (but the upstream version
> does not have this problem).
>
> I think it would make sense to backport commit 2603be9e8167 ("can:
> gs_usb: gs_can_open(): improve error handling") before this one.

Good catch. Since this is a small leak on a rare failure path, and the
pre-existing error paths in gs_can_open() already had similar issues, I'll keep
it in the 5.10 queue for this release. I'll plan to backport 2603be9e8167 for
the next cycle, which will fix all the error paths properly.

