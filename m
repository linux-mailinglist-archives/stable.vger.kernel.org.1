Return-Path: <stable+bounces-238875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNu7H+w05mmOtQEAu9opvQ
	(envelope-from <stable+bounces-238875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB1A42CCDB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48FD431FE1F9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44B3AC0C5;
	Mon, 20 Apr 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUSKQCb5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43E3AB273
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691288; cv=none; b=Tz4e/PrMJ0n8cwboDwrYvjLh4lmszZ2TrpcxNseRX92QMsP5cSK+wuQcRvnYFLlhLVKWcnbvkTLHZuPiRJxUsGq+3YLdnavZCEEwicvxeftwA8WCs5iNNzmF3nAG9P/gwixtNDQh41lHk8QrKGQXbX7WrFyngZxaCzk6JxeBycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691288; c=relaxed/simple;
	bh=P0HK7frwjARxKhVL8GqaPdpDlZEZUSrYdIdZd63/Aus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms0/4aTdJsjZkQVPuLko3e7ftI+w2vfrDfT79wmn2F1tv3kVm/rt5Ln5MgUyAX2eH5wq8ECVn/FVGLfYRXeVXMOGGg9t9rG6KA/HgcBmmfvrDiDpfOhTpWBRjWfy6zjxmII1BhIOlagR4CZDUHjuMugRQj5fkXQjxgs5MYyelNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUSKQCb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C624CC19425;
	Mon, 20 Apr 2026 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691288;
	bh=P0HK7frwjARxKhVL8GqaPdpDlZEZUSrYdIdZd63/Aus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUSKQCb5lzYnc5y9bqT1KdajP7aocbNePFf2Rubb/EhLLP/zYRibCoKU1Z+URFKbr
	 yYK8uAtOa2Zfsc0aIqb6mS9Ing7BVgUtdlNoIWhnT08JPiJ+FKM5vrcOGR3q0bzc6h
	 W4hCSFm1rClWBOD0hWSUED19kmU5WgJZhN19/8QPxCisPJihlWfrqs82r42Spw3Rs2
	 QOmizNrn/o/inREltCzUBPypHsUhPghM+PHkINe7bZcb4nSc3aB9oSoRzsAV2gr9D8
	 wTWQ1u4HnMgXuDlF5HKEwC/gFzKXDv95AK+rrDuXiSxoqxuWn7JhC7+BfHSwFrmlW0
	 py+WGwfZLMVgQ==
From: Sasha Levin <sashal@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	Oleg Nesterov <oleg@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 6.12.y] kernel: be more careful about dup_mmap() failures and uprobe registering
Date: Mon, 20 Apr 2026 09:21:09 -0400
Message-ID: <20260420-stable-reply-dup-mmap-uprobe-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415180623.199818-1-heiko@sntech.de>
References: <20260415180623.199818-1-heiko@sntech.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238875-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AB1A42CCDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026, Heiko Stuebner wrote:
> Backport of 64c37e134b12 ("kernel: be more careful about dup_mmap()
> failures and uprobe registering") to 6.12.y.

Queued for 6.12, thanks.

--
Thanks,
Sasha

