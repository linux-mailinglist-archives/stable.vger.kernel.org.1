Return-Path: <stable+bounces-267574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TcVqBwk3OGqOZwcAu9opvQ
	(envelope-from <stable+bounces-267574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 21:10:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A36AB7D1
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 21:10:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IbYjSYmF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267574-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267574-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BB523009FB9
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0CA370AEB;
	Sun, 21 Jun 2026 19:09:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9470305684;
	Sun, 21 Jun 2026 19:09:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782068998; cv=none; b=I5Av6N7hBIzcrYnAkVxBC3bB5XuvNgQISYG5vH5pcJ1PzWQGvOaH7QYGRcMZHbR4M4MQdwRkX7fmz8kGbGwJMJi3Ivna7iTnD1fP4wGFf06lQ2nVuKYNbS/7hlJAeXAI7/B7uPoJVHI6xLv7R7MITT5ESN5tVd744/RZ4PABJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782068998; c=relaxed/simple;
	bh=9M6/EZhFjrvseSERQnNrl2Rxu8Gt16x54QL3zfQ3CR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0NXBhCR9v3M+vP45/xx8l5wh+7x0glLfaogwOeaJs8/Z6bMKbXDnmoisnJGXxNCV4YIHoB3hlEbN2IYNzYEXu0Y4pGSTITwn5d5THKKc0izRDacQ5yUhCGeELT9LzGfTRbbNR9Nni24DFkGuiHF8APICjYR2ojv0vw8++p1oD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbYjSYmF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5361F000E9;
	Sun, 21 Jun 2026 19:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782068996;
	bh=8EjJuiCle17v1bI761iV9pQg/1bmN0Ic6hAHb2LFFUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbYjSYmFBrG9aUZAS0/FpdFFMCRtw6MpQe8XKwe6xj9YhOVTYsO+/ITfK684lQaoI
	 +FsPrTqFRd3MPkXPLCoqKN+VmZqOf6xuJbPm9V1SqL8QUcNdr0dzT6b/5oJumgfy/h
	 vVt4ITM4aj1jn9uEL92LAy8DyGitHLwKsIpHU9Xsz1s0aPusmTrE4iSbZnVPe6VcfW
	 4Sho7jDJoymqlfNZZ5Bg9lK+X7VxCS5mriDKIlhgEQQW1qwOCbJT8o639VTLSw0oqV
	 0spk4CWm1kP//yk5GJXSVTG4MepLhgPkHfFoIytOrkuuB60ap7l/dxUI5b7q1KKYTw
	 6jOfNyfUPR7kw==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.1 208/522] net: Annotate sk->sk_write_space() for UDP SOCKMAP.
Date: Sun, 21 Jun 2026 15:09:53 -0400
Message-ID: <20260621190954.367456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621133722.0008.sashal@kernel.org>
References: <20260616145125.307082728@linuxfoundation.org> <20260616145135.793184452@linuxfoundation.org> <6f805abf1f8b058c1b1241e8568d7539185145df.camel@decadent.org.uk> <2026061944-vaseline-essence-0008@gregkh> <20260621133722.0008.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267574-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben@decadent.org.uk,m:sashal@kernel.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:kuniyu@google.com,m:jakub@cloudflare.com,m:kuba@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F8A36AB7D1

> I'll either prepare a minimal hand-crafted backport of just the
> WRITE_ONCE() annotation [...], or we can leave the read-side
> annotation unpaired for now. Leaning towards the minimal hand-crafted
> version; will follow up.

I've queued a backport of 2ef2b20cf4e0 ("net: annotate data-races around
sk->sk_{data_ready,write_space}") for 6.1.

-- 
Thanks,
Sasha

