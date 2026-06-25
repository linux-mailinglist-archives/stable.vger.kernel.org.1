Return-Path: <stable+bounces-268340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bm15HeMGPWoOwAgAu9opvQ
	(envelope-from <stable+bounces-268340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:45:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB036C4CA4
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:45:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="o1//s2ej";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268340-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268340-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4CB93106E63
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815C3CEBA9;
	Thu, 25 Jun 2026 10:42:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065583D6CDD;
	Thu, 25 Jun 2026 10:42:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384140; cv=none; b=no0U9SFPFJ/2qN7X0UFp5NAtsbqpyGlBEHXWi9518z67QaZ01xuuTTlwGvrz74YHU+nGb7YQOANBr6AeznykSjIlN7msSkCcqxI4UhDO/2nhT6TIxTghu12KRjTotyOjJhRCpduLYoMSsVPXGzr6CCIM0J5AECkJgOAMdnFpv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384140; c=relaxed/simple;
	bh=ZR+GjtvoecijEwle9P5G2tsWGiYXO5hOiJ2OdmIXkAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw59OEV9BJPHR81Bpj4KHiGo4h97821dc0kfseltjp/ljADMiIUqpfK8CSi0eGFOZptfjkDBFPTX1GABqvmbTf28Xj/1kmSDzGd819P65+xGWXwJWKIR+ik+SvyDrieALnbPLRYuL9yxjSKZ5DcPDEA//qHi2K5FNEKwZ5LyXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1//s2ej; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCD81F000E9;
	Thu, 25 Jun 2026 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384138;
	bh=5YwpA7XGSLdzMcQ+7rmuij24ME/LFoEBRrd3cnJs/9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o1//s2ej90chSy1MgNMUcb5IjtctWLJ3jD/0lBj+E5XaAQkCqBmM5YXRWUjYs/9nO
	 Q2I26+0rJIIwFbyGO4kOLSRIiw84zbSWitIjMsGyQl3+PshFe+nvOyFtdXRq9MA95J
	 H/m77yMASDKn8ocFcS9jTuoa/K2ur7DIwHxKSJx0mTBlpkMgqvLPNpXALxQWr4UR4M
	 2oVFehqpUgfA0XfdcXMeLBs28hNjiewNBuj6p06opaOqUNhLmkZ5umwG0ihgkl0ZPu
	 eiB3Ic1/DY47/dc90BknhKbv1deQp5a6yKpTUVjbga4+KVBprnA14pc3OzgfJaFkHQ
	 Mv2o0phNuHK8g==
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
Subject: Re: [PATCH 5.15.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Thu, 25 Jun 2026 06:41:58 -0400
Message-ID: <20260625054005.0014.ringbuf-515@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624122351.2477592-1-doebel@amazon.de>
References: <20260624122351.2477592-1-doebel@amazon.de>
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
	TAGGED_FROM(0.00)[bounces-268340-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:doebel@amazon.de,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:linux-trace-kernel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mathieu.desnoyers@efficios.com,m:dhowells@redhat.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: CBB036C4CA4

> [PATCH 5.15.y] ring-buffer: Remove ring_buffer_read_prepare_sync()

I had to drop this one for 5.15. The upstream guard(raw_spinlock_irqsave)
conversion in ring_buffer_read_start() introduces a new
-Wdeclaration-after-statement warning on 5.15 (the guard variable ends up after
a statement), which the build flags as an
error there.

Could you respin a warning-free version for 5.15 (and 5.10, which has the same
problem)? E.g. hoisting the declaration or keeping the explicit
raw_spin_lock/unlock instead of guard() on these older trees.  6.6 and 6.1 are
already queued.

--
Thanks,
Sasha

