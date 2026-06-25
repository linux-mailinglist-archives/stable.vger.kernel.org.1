Return-Path: <stable+bounces-268339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qbD/ML0GPWoGwAgAu9opvQ
	(envelope-from <stable+bounces-268339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:45:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE936C4C8E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:45:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lnxrSACr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268339-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268339-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 381D930EA3CA
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F583D6CCE;
	Thu, 25 Jun 2026 10:42:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65AF3D669E;
	Thu, 25 Jun 2026 10:42:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384138; cv=none; b=iNarc3WxfP6T7AyZtW1WYnpnVFZkVdZv66+/B9JgroNK9BUF+XgFVeqNtkLMRNAPEckn+iRhIMzWInwy8w0ruSJJKmOTwg9n4IGoobFSo+rZgTcVgx26UR/qxGdzu/Iig0c7MdrB9CxBPWCLTPJuOMRPXjGPSKxi3yTXIT/5tuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384138; c=relaxed/simple;
	bh=33PZMhYYbFnkBPykKf1X/fZreJUQR4QzCZTieEJFAuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAboM6rORWdVsMtOxwbu0qpDvLabpcR0kYeAIx9x7A3FK4A6qpyqwyPnmML9KUt1OAZhfxcF+WZbi74b8bEp8LCYCeSg4hDY6jsCcl3HFj0dFMRIaaYRiViWyG4sRvmd6FjcCCOk9tYki1YwWq0iPNglmhG+Q5PjTrciLH5iLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnxrSACr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9411F00A3A;
	Thu, 25 Jun 2026 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384137;
	bh=33PZMhYYbFnkBPykKf1X/fZreJUQR4QzCZTieEJFAuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lnxrSACrk2fZyouCs3exkdo19+krTSEwTL5lmWj2/tABGZtDS2x97ASTfwa3uoqcT
	 oUdnu1jdbBzNcC1TBYjEKeBswsFvxxg0fHvaccvCy/MsbvKgqAB0eZY7iXUsMnPJWQ
	 4Fm0OKnxpv0r2cp8MMBcoqxgUxsSJ+Dz21kvpQqi8w2LsPSKk0V9c16+JREf7eqqsd
	 N9TDFaUtK/oYHwi5B1Ocewd+daJC+DSfF+JEjGjJofrg65M9sLl6h6q9X4tiSb87kW
	 4KwsDB2RONlWRqj3fvOZzfiVRs5QX7LUvwhs2oG4Jz247lBLyxDqhdWwhFE+TMWCNo
	 NYXyDd53Qh+Zw==
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
Subject: Re: [PATCH 6.1.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Thu, 25 Jun 2026 06:41:57 -0400
Message-ID: <20260625054005.0013.ringbuf-61@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624122328.2477272-1-doebel@amazon.de>
References: <20260624122328.2477272-1-doebel@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268339-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:doebel@amazon.de,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:linux-trace-kernel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mathieu.desnoyers@efficios.com,m:dhowells@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 6CE936C4C8E

> [PATCH 6.1.y] ring-buffer: Remove ring_buffer_read_prepare_sync()

Queued for 6.1, thanks! (6.6 is queued too; 5.15/5.10 need a respin -
see those threads.)

--
Thanks,
Sasha

