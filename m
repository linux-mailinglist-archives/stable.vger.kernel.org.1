Return-Path: <stable+bounces-270060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vOPDGkVCRGodrgoAu9opvQ
	(envelope-from <stable+bounces-270060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:25:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76D46E8644
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:25:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K9HRfHYO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270060-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270060-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F9D930FF8B4
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B423290D5;
	Tue, 30 Jun 2026 22:23:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF22332637;
	Tue, 30 Jun 2026 22:23:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858204; cv=none; b=JkYBz0hgMIfR1QyICdQarsz2hgc2gWIMSExC4ZEamG5lAtx7AXPCKHiFUCKlhTncPoBEGtjI0JrGpcyBgKjFhdPT21P0tTKziYFtHp16tppB8+n8jSXBWbsJxh8Y+6dmfSeOpRMNsTKg56/YjuhGPRWUwQz83QWfdd8vqVcD/dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858204; c=relaxed/simple;
	bh=zKfguz4lcFr+3KOsdj/LrnWXbUA+NghHWZNldyGXDOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJPOJ2vz0be5LnccUhbjbvPhSKMY4f678fss5AXLapXE3lLq7Rfw5Tu2Zh6WCTmA5CLGYGV5p47iQ1pjKqgRgx6/ZJFxFAYrB1ZkWLZXoCM8tLgHXjAIl2zCjIF3OYw3fuDV8Q7lB7usUTaNaIJbdeE9onAvjHvkAaYfzQDqaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9HRfHYO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427591F00A3E;
	Tue, 30 Jun 2026 22:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858202;
	bh=zKfguz4lcFr+3KOsdj/LrnWXbUA+NghHWZNldyGXDOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9HRfHYOY1HGLnS2ddRqZLksAs3+VwPA3DDldc+Cvu94qbUIL/T75Z/uN11ZSBjnl
	 kQJ/LDFJJrBwrh2GIbz87iMJ70yNO09ogtc8Q+5jlfYaotlEHN5hhH583FU9N22U17
	 UizAk7pXoD84ICjdkssVgqrYGIdarlz7+vtBB9+6UHjbLGxlo/VeDo7pt07kel8gh5
	 bZzQJ8v/fwe8OdgntHHY05Veb5aIg3/xq5toTfcd7t0I2zuUIXk+VYfTMVhQ58uI0g
	 S0+yovvcZhC9vAiD8Dmrk4Cx+vAyG/gd1QnnsW7r28AreUQDQbqpsBvoL/oyUeISxe
	 lV1yMdmo3RHaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: Re: [PATCH 6.6.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Tue, 30 Jun 2026 18:23:13 -0400
Message-ID: <stable-reply-item009-af-unix-gc-20260630181642@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629093954.195016-1-sysroot314@gmail.com>
References: <20260629093954.195016-1-sysroot314@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270060-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,davemloft.net,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:netdev@vger.kernel.org,m:sysroot314@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B76D46E8644

> [ move WRITE_ONCE(gc_in_progress, true) into the __unix_gc() work function and drop it from unix_gc(). ]

Dropping the set from unix_gc() and doing it in the work function is fine
upstream, but only because later refactors made wait_for_unix_gc() gate
flush_work() on unix_graph_cyclic_sccs. On these trees it still gates on
gc_in_progress, so this brings back a window where the over-limit throttle
stops waiting for GC.

Can you respin keeping gc_in_progress set in unix_gc() before queue_work()?
The code is identical across all three, so one version covers them.

--
Thanks,
Sasha

