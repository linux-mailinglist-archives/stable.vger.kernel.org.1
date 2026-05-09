Return-Path: <stable+bounces-244944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COEwNrYt/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA184FFAC1
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F7833062609
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829AC32B989;
	Sat,  9 May 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE9ikWkB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DA2388E6F
	for <stable@vger.kernel.org>; Sat,  9 May 2026 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330851; cv=none; b=QQzW4JC4mFyIEytPiXWfj1cZ1XT3qfmwH49MbKo8VPGBhXrcENVQJV/UuGBh23dNCPmcEfZGHg9XenDBsKVKLuL4s277P5PANSbpSEeX/cZJUo8nFvA4e1lks4OzOC9/8+3CXbbukwRmbuQC4sXj0jmBqBF73ajxJAU3FbC1DyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330851; c=relaxed/simple;
	bh=O7iekvJjtH+NFA/pDwYcWWOvuW0nxGC88Qp5kgpm6TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGVrcBnmp0IuUSCJLCXtSUAUda8+qZgiv98Op/p5AdhWS5zT7RI5NZbIlx20QN1EoTpiLuBWMLavDzAT99RqE+cWEzTqyqvlVyDwOCtdySrLbZtYCbdc+ql9zWTp3dqaB/B04468zBEsQxs+/XlJBYL6qSTwRPYeTXnJ8+cH0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE9ikWkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DBEC2BCC7;
	Sat,  9 May 2026 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330850;
	bh=O7iekvJjtH+NFA/pDwYcWWOvuW0nxGC88Qp5kgpm6TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YE9ikWkBl0Cal9k9PIk3seyn3jvgrfaJifg4BJsQkIPxmT2wc1JqIh4UfC/0OP+BN
	 CbH41NxiMsa8V/znhLkLWPAxwf4fYF8AYsxvHnJ+p/GgpfaGMMYMh8egOwgy3YT9Fh
	 Lne7PjaofYi4A75h82D5JQj6OdFndZfmF4x+sVLfreDTCqL/hORNP/ZFvNtpGNRhvV
	 XiAi700aYCHU2f3Rcq9EcxMYYFeE5zuRN/waY9aJhWUlTksW/usTd0kAUdDuQcs9w9
	 bZD+637UUnoPbkX18KauloniYrW3QW3dMTUgb+iQ1bYOD8wTsTGDr13gs2KL3vdIBO
	 /Vu0pEDY8J3dA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y] net: Fix icmp host relookup triggering ip_rt_bug
Date: Sat,  9 May 2026 08:46:53 -0400
Message-ID: <20260509122858.d7ff4b84645b.re-net-icmp-relookup-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506012115.286204-1-jiayuan.chen@linux.dev>
References: <20260506012115.286204-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DA184FFAC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244944-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 6.6.y] net: Fix icmp host relookup triggering ip_rt_bug

Queued for 6.6.y, thanks.

--
Sasha

