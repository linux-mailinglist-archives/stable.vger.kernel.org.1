Return-Path: <stable+bounces-273670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UEXwJJXaVGqCfwAAu9opvQ
	(envelope-from <stable+bounces-273670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 14:31:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE04674AF40
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 14:31:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="JfRMoYe/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273670-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273670-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01F75301AAAC
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3837DEA4;
	Mon, 13 Jul 2026 12:31:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465438A720
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 12:31:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945872; cv=none; b=I/uterG2y33E/f+SlyOWtAiNZGTTVE/ETCIOZa255NJvqomj2eS7SQPmqGjaCe8Xz/QizD8bdOnnIEx/tv788vcueG+2syuk5MOD6t8/Vwo+SbHRBWlwW/pddpM/elhN4s2phcfXHZD2IS+USSlMq6EVJvtH+1WMPSEDAVpSqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945872; c=relaxed/simple;
	bh=JI+/o9g62QcrTsdBJA8Y9yefEkfCO4FlJVcAJIAYH+A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h0gpgTRDZ1n5DKF9fl76uNGcqJlQY0dZEmg+5wltTTir4l9iS5zgMhgE6qwdr0PtjOuyfRXkmH/HoTTHbM4kT55vgrYLRrhE2Wzz2O3dKKc4ZLfAW/iX1zIxTekHZOqDAfRq8S7CYuce9xtrHjlKD+sFFSiWR7Wt7nY5AleZ1/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JfRMoYe/; arc=none smtp.client-ip=91.218.175.185
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783945869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JI+/o9g62QcrTsdBJA8Y9yefEkfCO4FlJVcAJIAYH+A=;
	b=JfRMoYe/osc67xC5UABSw/Jid07sqLX65BD/x+9RL9hscga8kjPX1PdLGZ8PW0DzBQwJRO
	pH+MmCQrpYIYZwFKQCfjkAF0s5YR+BnX3cAxQIfMUrcSSoCrV9DdPJpof+re3Sdwlwsxbz
	NHLsfxHkgMFEqPjPJnO7Ywt7bSI0IBc=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] mm: memcg-v1: account vmpressure event allocations
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260713085520.2953121-1-guopeng.zhang@linux.dev>
Date: Mon, 13 Jul 2026 20:30:31 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Stanislav Fort <stanislav.fort@aisle.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <523274F8-9DE3-406A-80BF-00AF0610D033@linux.dev>
References: <20260713085520.2953121-1-guopeng.zhang@linux.dev>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:stanislav.fort@aisle.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273670-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE04674AF40



> On Jul 13, 2026, at 16:55, Guopeng Zhang <guopeng.zhang@linux.dev> =
wrote:
>=20
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
>=20
> Commit 72797d218b43 ("mm/memcg: v1: account event registrations and =
drop
> world-writable cgroup.event_control") accounted cgroup v1 event
> registration allocations with GFP_KERNEL_ACCOUNT, but missed struct
> vmpressure_event.
>=20
> Use GFP_KERNEL_ACCOUNT for this allocation as well.
>=20
> Fixes: 72797d218b43 ("mm/memcg: v1: account event registrations and =
drop world-writable cgroup.event_control")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>

Reviewed-by: Muchun Song <muchun.song@linux.dev>



