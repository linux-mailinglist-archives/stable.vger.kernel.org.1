Return-Path: <stable+bounces-259866-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LI54JmsfH2q6gwAAu9opvQ
	(envelope-from <stable+bounces-259866-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:22:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B412631076
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:22:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QvkizhFI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259866-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259866-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CC273017C0C
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97BB394492;
	Tue,  2 Jun 2026 18:21:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79EF390C8C
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424502; cv=none; b=HFueSIW1U1s6eyZGq8tI3jaRpgEVVn6e+d7bJC2VQqTrNrEiivKcQxhZg4f4GbU3+uk9AXxo2g5XfFsmR29ziXxxxJEFT+OXmLRoQJfSwyrPaOnp2L4uaEmJ+kE3b37oEYlXOLGNP+ak35Hz7bECKGcTi4YPZcowNUXQWxGeVZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424502; c=relaxed/simple;
	bh=bLNk4YQ7V0aWh/ltmKyQ1PTzjeephg1z5nvy8HsGpmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYu5K7aCzdpHFzy/mDwTw+g5cU4NWZxADkhEgpGT5+CkZRNHxpgnlgu6HiwukMiM/4R42qN6zSFZnWo261QPXV00EDT34Im8bbXf/6QImE4aF+c+cfYypMCbdgkt43bwmerjqh4AgIM8n6wsusQ+OxRSSEYR2ia6hs+aEJbhTRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvkizhFI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1495E1F00898;
	Tue,  2 Jun 2026 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424500;
	bh=6s7r+T0XeSz8PrDRUBCZyebkpWeWHzvIPR+oIDL9M6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvkizhFI/c4HbC/P//4+C3AfdSyFJUaYFlYl4t8Yrmd+u0aTdb7F+IEFwsE0rZPMU
	 xqr5KJ9py+3WdkYvPDf0/cvRGxIiCJMW9wlLdIw/gPqpY/46mFbLwgwI5hgOlbSEr4
	 vRRsdN/UxiWuBzTSGeB7rsDq8Sm/bRYTWo4szfRNCwXc3hjgK5VPgdCmpkLwPIYjLH
	 jhtCKnqZn64XG37fn8A8RPsOTrE2jTFxU/TARRXaizC9xChHsfU1r4891vsncFSCNx
	 a75p1jwLQL4YxHHUHXwOx242kgwvBHPNTh09cXGRRJcw5+3u0jAiNxhI9hlwJrvusx
	 a/fXxcNaRBaXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: Re: [PATCH 6.1.y 00/11] Fix BPF selftests
Date: Tue,  2 Jun 2026 14:21:19 -0400
Message-ID: <20260602180500.bpf-selftests-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780392092.git.paul.chaignon@gmail.com>
References: <cover.1780392092.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259866-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:shung-hsi.yu@suse.com,m:daniel@iogearbox.net,m:ast@kernel.org,m:eddyz87@gmail.com,m:andrii@kernel.org,m:martin.lau@kernel.org,m:sdf@google.com,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:paul.chaignon@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,suse.com,iogearbox.net,gmail.com,google.com,linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B412631076

On Tue, Jun 02, 2026 at 11:28:43AM +0200, Paul Chaignon wrote:
> [PATCH 6.1.y 00/11] Fix BPF selftests

Thanks for the series. Patch 1/11 doesn't apply to current 6.1.y: its Makefile
hunk context references json_writer.c in TRUNNER_EXTRA_SOURCES, but 6.1.y only
has cap_helpers.c there.

-- 
Thanks,
Sasha

