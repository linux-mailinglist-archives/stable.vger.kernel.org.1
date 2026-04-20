Return-Path: <stable+bounces-238874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE/gH+Y05mkGtgEAu9opvQ
	(envelope-from <stable+bounces-238874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F8D42CCCD
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C13DB31FC742
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD063A3E93;
	Mon, 20 Apr 2026 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d80q3QCo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD853AB28E;
	Mon, 20 Apr 2026 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691287; cv=none; b=fRf9+0PPDTJdFn5Sj/7AN7P1ej5MHxXAnAQnGp8GNRgl0IUasy0dhTZdSrpYl91gJsJ/PKf28KYxQRUoUnlgxnVPCwLCw/Y+hcj5ASq2aws4n/Eew+2MPEakM+P1iIovr8wlIsjHLD2/GW2IadjpzQJnK9ioEUUwr8Fo6iodkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691287; c=relaxed/simple;
	bh=1129FrYe8MzwETr4Sn9ncOSEEtYqcA4fDE4HHL0JYRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEER+s7wxy3Yh3FSB44kuZ5v7gObkvVntv+N5ntCUTqSV0ipYas81wJ7zz/2ooKBE3SKcwYpiWPE8bCaYeAwTb2zra/A5j7smS4FoEMl61uV+FWKcyxmGd8eSr+ZupHBliIimM5Q9wNcTE9NRL7js6W0GbQOq2Vtk6OL8HYAk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d80q3QCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D420DC19425;
	Mon, 20 Apr 2026 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691287;
	bh=1129FrYe8MzwETr4Sn9ncOSEEtYqcA4fDE4HHL0JYRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d80q3QComHDDOuM5vzpZETjsbsDDI1xpm1OQ1yN8NmxPOFcTWfwrMcEU7dn4kA8a/
	 son+wlJNsylIC7yzui23RdwQneURTr2lo/BkQa00Fu0aqv7v2GM6aKb8V67fbnB8T/
	 yd2vkVK/ySGNFlXufd4bXy5nPo28Ga3aq7zWQMcgc6s1lY1btKB4YpfMorcvoKiWlx
	 GaoKwXBDI8pNLfBOadVEwFHqxJfa8rv9N6OIfxmuWf7sQANOhOsaRzmQKVIa5t6hZi
	 5FMxyxmbqrKizHmMXuivT0FhnwzSq4+YGrZGIFyeavcL5jrJ9m0sGJBTz1JskpQd5t
	 GPTV6DaFb2YTg==
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH 6.1.y 0/2] Backport 2 commits to 6.1.y to fix bond issue
Date: Mon, 20 Apr 2026 09:21:08 -0400
Message-ID: <20260420-stable-reply-bonding-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415091232.3244-1-681739313@139.com>
References: <20260415091232.3244-1-681739313@139.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238874-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[139.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47F8D42CCCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026, Rajani Kantha wrote:
> Backport of 22ccb684c1ca ("bonding: return detailed error when
> loading native XDP fails") and 094ee6017ea0 ("bonding: check xdp
> prog when set bond mode") to 6.1.y.

Queued for 6.1, thanks.

--
Thanks,
Sasha

