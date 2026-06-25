Return-Path: <stable+bounces-268338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N6b6E6YGPWr9vwgAu9opvQ
	(envelope-from <stable+bounces-268338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:44:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B746C4C72
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:44:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XkO2uEe2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268338-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268338-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C277C30D17D3
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588D3D6CB4;
	Thu, 25 Jun 2026 10:42:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69F3D5679;
	Thu, 25 Jun 2026 10:42:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384137; cv=none; b=Uqf5ecdc1vnN0SduFNEuW04Jt0I+YWOfrtoZDpA4CO3Kko+oNkNS9V/q+nSEgSOncRaP9R5ISCFcR4PvMq0FvYlMzK8r+7bLctvN8BdxCuIe2pBDhraBGXw65ZYLAbYl6SC5MBIZZkvy/gjo7Qwg3p34PaMCfTjxzoGuO4h92Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384137; c=relaxed/simple;
	bh=XTP4gLnNhtDwujnIHswNuY1jeQ6uQQxBay4IFYapLRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6kDpLx6chrtqU1MPAWrDx+CDC+RqTAlPWxY8/483wg/aCzcH5+1qercbF1DF4ayYTp/V95u6Rj0O1HgiqDScOIClejNHkEnHeO9rhhW89fiogy4v5zMQVOnRPjh6rL4tzsHKoxKwN1muvjMsPqZAnT2CxVIAUkahu8w/t73TUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkO2uEe2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0591F00A3F;
	Thu, 25 Jun 2026 10:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384136;
	bh=XTP4gLnNhtDwujnIHswNuY1jeQ6uQQxBay4IFYapLRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XkO2uEe2UUQykS+6FGu247cEpZCpoRMM7M47wFT4XZwunLPANh89Ow4tNA5Rxe53i
	 Dw0jV2r5l7cColFOH/+KTN7PihMAiLedMY4FzBUKI0gDiVpr7+W98zGZQkLWgvMmDG
	 ZMjVJYgSS8ZybbnNnedxLR4VjV08Zsg00sYPyJoMQOiRez9VE7/TgVokEUhwUqN7o4
	 ex9qRD1OQ1YLYL7lQj6xrkf66Rv3o8Y/mdyojzviBzaaKYgfEB25aQX6Xucs9XXSUj
	 z9mFR7WQBv/D7JRfoVbHa/N2WNcp9qPQcjBu85chtVNMnymAeOfNDbWZAO1D+WwEB6
	 R6b2pzl2PoD2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bjoern Doebel <doebel@amazon.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 6.6.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Thu, 25 Jun 2026 06:41:56 -0400
Message-ID: <20260625054005.0012.ringbuf-66@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624122258.2476991-1-doebel@amazon.de>
References: <20260624122258.2476991-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268338-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:doebel@amazon.de,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:linux-trace-kernel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mathieu.desnoyers@efficios.com,m:dhowells@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1B746C4C72

> [PATCH 6.6.y] ring-buffer: Remove ring_buffer_read_prepare_sync()

Queued for 6.6, thanks! 6.1 is queued too; the 5.15 and 5.10 versions
need a respin - see my replies on those threads.

--
Thanks,
Sasha

