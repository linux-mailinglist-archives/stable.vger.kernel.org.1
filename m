Return-Path: <stable+bounces-238873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEkBO5ct5mliswEAu9opvQ
	(envelope-from <stable+bounces-238873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:43:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D6F42C2FB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8AE0304242C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B73AB281;
	Mon, 20 Apr 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXWwGDws"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E73AB26E;
	Mon, 20 Apr 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691286; cv=none; b=Y/5F4OGAn5Z1hM7cYbREwh2JNsCCXdI96CUPN+qLX5fKqHWfD82hUF0n4q+gcTXcCZaH1R/xUSjE9+mFEtxmDsDRJvNLZg5vHZY4ZpmhO4VGeWF2xM851sf5Ol95NlIjB2kqI3GXu7QhsUMb1Fi09Kl4KCDyGjQJ5TUAgcg6uQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691286; c=relaxed/simple;
	bh=DtaC9BBV2mp7K+i9tmB1F+t3t/28nMoUYoKHx1gzvVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCYz9WsxXCoi3nfvEqwY1ybDN26hQwbMjWXkOp6YKRWmKTVD6d5pEq8bfs0o/cuYqsijM/Ch3min7qnE18MW/KWzGlefVJwouCd74ONekwLqwC1IIL2QNHcZszhAG8YEyr8eZtfZSYOe7ZZw1S9ySL90eVjABB11YLR+Vqfps9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXWwGDws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC881C19425;
	Mon, 20 Apr 2026 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691286;
	bh=DtaC9BBV2mp7K+i9tmB1F+t3t/28nMoUYoKHx1gzvVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXWwGDws9FGBIM0pev0J+EvLpF2Cf5/DpYq1ITR/dU61DebMq8pnBrcgT9risoSE1
	 yEUP8iADMS4aW+XUd1e+T46JffkKdcFNpCJAhYNxzRUB+mnKqOZxwKAszjYmGYfcaD
	 738OChq17okKIC0tqgk6U8Fg6R/jX3AEcdfBHDoO/s1OsiPrdgp0Yx3paL8XwA5QFw
	 Hm+MVbGMTHIgUwWEFCCXg+mEXLpiRbuycSOr2E5VCSMHu4w+sKC6GIWPvXZ5OHGy/1
	 HgTXSHynFQW+G1pEIe5+9j6aiNr/OumjmNNIDLGKzBZ64ZClYO6N/sdk8YqaOCm3Y0
	 rQM43Q9xJG7SQ==
From: Sasha Levin <sashal@kernel.org>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 6.12.y/6.6.y/6.1.y] net: sched: fix TCF_LAYER_TRANSPORT handling in tcf_get_base_ptr()
Date: Mon, 20 Apr 2026 09:21:07 -0400
Message-ID: <20260420-stable-reply-net-sched-tcf-layer@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415214348.850171-1-chelsyratnawat2001@gmail.com>
References: <20260415214348.850171-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,mojatatu.com,gmail.com,resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238873-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1D6F42C2FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026, Chelsy Ratnawat wrote:
> Backport of 4fe5a00ec707 ("net: sched: fix TCF_LAYER_TRANSPORT
> handling in tcf_get_base_ptr()") to 6.12.y/6.6.y/6.1.y.

Queued for 6.12, 6.6, and 6.1, thanks.

--
Thanks,
Sasha

