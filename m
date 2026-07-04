Return-Path: <stable+bounces-271910-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zkr9HNNqSGpPqAAAu9opvQ
	(envelope-from <stable+bounces-271910-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 33878706728
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:07:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="e/jGLAtj";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271910-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271910-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0F9D304C963
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0D5372EEC;
	Sat,  4 Jul 2026 02:06:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4F1A9F87;
	Sat,  4 Jul 2026 02:06:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130763; cv=none; b=qVQPOryw3dP6agi3xSUkF5cVJzFunU9d3AyCFlLaUIiOYkBHYnME6/vAdU4nYc7rvH5H9ndy2tSPtgyx2HBp8jb5XmRbCo/INzbKx9JmgwthdVA5WMg76h763jBepBgm3zN7UhPH9+1g0amvRJdyJ/+MgHgTt1s51PntiV1zCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130763; c=relaxed/simple;
	bh=LNEFIcb0iddPidiCi+zZWra8FypN/nyLlcS5xbGiQRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhjPcQ+FCyGH38005z4noJEC7w/GOWrq1GtMYkl7WzhZ/VTrvV4ZUbJMNywwbeMy5EJAmQl6nU5t9nvrfZOSnFZQoX+QQFY/Fni68PzdHkLzB+hm9xSnK4bHdXr3NHwlDpTlsTwNrvYpfU3jGOz36RmR25Z0i50rgmk3E9ns1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/jGLAtj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340AE1F00A3D;
	Sat,  4 Jul 2026 02:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783130762;
	bh=4bFJ2uCAO0WhYuHtM+uOHbBKgJpNFRs1TkziH5BCUtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e/jGLAtj9WP2cMasXO5porPO+JXJElAUbUiUDCc06Af921z4rm6tibKXinJazO1ta
	 voHtsRrSVSVLJYXphAGxN9z7rAiT1SzX2t/NDHTIfA5ifMYdVz5Cc1EOSpgBIuEz+5
	 NJfqebjeYwshAp+d07XXQZkr9UOCq4aw6nde6Y7nkDnxcTgi9/PvR8em30SDXBj9+2
	 up3bz6qomjg5itSdi4k13kLpLfXzKXKckhQHzOpXsISfTY9MJ4Ode864URo5jwK8CX
	 W8ojyI8B+ic3YVq3F3tMaXNd5Iob4Mv3VsA75Hse8L8Ug20nmA6Z2/7LA1Zono/5L5
	 lhNLdJi2maiXg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	00107082@163.com,
	guanwentao@uniontech.com,
	iklatzco@gmail.com,
	patches@lists.linux.dev,
	peterz@infradead.org,
	stable@vger.kernel.org,
	yeoreum.yun@arm.com
Subject: Re: [PATCH 6.12.y] perf: Fix dangling cgroup pointer in cpuctx backport
Date: Fri,  3 Jul 2026 22:05:21 -0400
Message-ID: <2026070315-stable-reply-0027@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702164824.498942-1-guanwentao@uniontech.com>
References: <20260702164824.498942-1-guanwentao@uniontech.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271910-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,163.com,uniontech.com,gmail.com,lists.linux.dev,infradead.org,vger.kernel.org,arm.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:00107082@163.com,m:guanwentao@uniontech.com,m:iklatzco@gmail.com,m:patches@lists.linux.dev,m:peterz@infradead.org,m:stable@vger.kernel.org,m:yeoreum.yun@arm.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33878706728

On Fri, Jul 03, 2026 at 12:48:25AM +0800, Wentao Guan wrote:
> recently backport of ("perf: Fix dangling cgroup pointer in cpuctx")
> use a middle version, so aligned with the upstream commit:
> commit 3b7a34aebbdf ("perf: Fix dangling cgroup pointer in cpuctx")

Queued for 6.12.y, thanks!

-- 
Thanks,
Sasha

