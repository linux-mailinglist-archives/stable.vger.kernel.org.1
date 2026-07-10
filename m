Return-Path: <stable+bounces-273249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uRJbMA//UGr59gIAu9opvQ
	(envelope-from <stable+bounces-273249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 16:17:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB0D73BAF4
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 16:17:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L+OsDlam;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273249-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273249-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BD5B300B471
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61645345CBE;
	Fri, 10 Jul 2026 14:17:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1700343889;
	Fri, 10 Jul 2026 14:17:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693069; cv=none; b=eYC8/nHOgYFCwp6reDgzvHlcqbvKa/CJB+mn1ywuGeJHcXIesrzmwSp8nsuefnL9x6mQF4lpImy3KwtyOA8j6Z3oeYlIxcve//+ydlfJDzN30IHVgqkQjG2+UFetdTd2x3wIbZccOt1xCeaCPT4eahGld0SlaNKfVC09T0+x7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693069; c=relaxed/simple;
	bh=N0/uJz0mDfJ4I8JENAbrd128kz3c7Kerpt46zN9J8yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pShqQXHrZY7nYiGQhiYIZJo5koU+pKc6pTK87rF1b7HqQpKyTKWoGOkGQljsEnNmH6IGEU7r6RRj5lbb78IhCIBHInr68d6ZiOxZqqdjt8DoZIfncEaxpumlGlyNVhm9ZN+T+joHiWyQNr3caERpiB2FhS9VwBc+tO0YxkW9Scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+OsDlam; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848931F000E9;
	Fri, 10 Jul 2026 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693065;
	bh=mAXWGA6OSF8O0XuZXZOdAP4iu1AOJgDdR8iw//XVK6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+OsDlamhtkR0me8N7dd05YqGELnbUe4ClnnZxkAISGzo/elcnuewm+CSAYcZIJNA
	 rDaDEs7adbIqaX15SOzaJ4pQCa8mDW8gKUA1USxMyrQ24Lo2pZnqyCpzmNB34zx2iy
	 rt04l2tYAj+Q84fz0ltXNBIobBgt7ZBuWhxDiS8RA71YAp8I/hVWBkDdYyJLk0/cbw
	 Zt7lrjwSsdkJle0ajimIznpxkzqo6Kc84YIx56V7W9LdygqPOoyUMaleqHO69kCEuD
	 ae6Lk6vqlNCVDkMtALt+egaBDOgJ5ugRypWMDtRgJiP40oazpU9ORmWd16C0Pfh9Lm
	 pONQo3alOp9Gg==
From: SJ Park <sj@kernel.org>
To: Song Hu <husong@kylinos.cn>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] Docs/ABI/damon: fix typo in intervals_goal sysfs path
Date: Fri, 10 Jul 2026 07:17:37 -0700
Message-ID: <20260710141738.24789-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710044737.561102-2-husong@kylinos.cn>
References: 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:husong@kylinos.cn,m:sj@kernel.org,m:damon@lists.linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273249-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAB0D73BAF4

On Fri, 10 Jul 2026 12:47:34 +0800 Song Hu <husong@kylinos.cn> wrote:

> The ABI document spells the DAMON sysfs directory as "intrvals_goal"
> (missing 'e') in four What: entries, but the kernel creates it as
> "intervals_goal" (mm/damon/sysfs.c).  Following the documented path
> therefore yields a non-existent directory.

Nice catch!

> 
> Fixes: e2b23dc62369 ("Docs/ABI/damon: document intervals auto-tuning ABI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Song Hu <husong@kylinos.cn>

Reviewed-by: SJ  Park <sj@kernel.org>


Thanks,
SJ

[...]

