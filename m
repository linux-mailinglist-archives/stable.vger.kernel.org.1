Return-Path: <stable+bounces-235376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPT6OiOI12mwPQgAu9opvQ
	(envelope-from <stable+bounces-235376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:06:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2733C97F6
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BE803025D01
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8487E3BE64F;
	Thu,  9 Apr 2026 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eTF2u6EX"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296D26A1AF
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775732688; cv=none; b=ifc15DLGS4EBag4ftSOgXm1WXphh5POcsn5tjVsz3+NwsbPvaxqkcGKqtRlw5zGHy1lZf/MhnbSovbdHwoOCX6MJmMg8OLrLKdXO3SjfswmWpVKL4ClUVLsz9UfuAsfiYjGJFXw201sZwvWDZCBc/S4DYe9KM/hAeceOVZ/busc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775732688; c=relaxed/simple;
	bh=ZrtVyQUSl1Vkkss/YEluHGFstFbA0FqBERkViJ95LkM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ORAZ5743iqegRM/oB8Qw5ScrriYm25XeFfJf1r88E8LAE95gqnekCxjdylJ+lp6ORAtgqm8GWiR2PPnU+c9IlxZK7Q4Dc5lV8eZTdqZcVNT707YA8VdkS6foEvk89d5GUqXJc3EC8Ttdc9HUwJIZGQPW2oWdGzv+a8gG/xygAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eTF2u6EX; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775732675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrtVyQUSl1Vkkss/YEluHGFstFbA0FqBERkViJ95LkM=;
	b=eTF2u6EX+3el+2pBg+jrigA4m47nOHc+sErjD/Lp4eWVN1BQFVb58zyw/90hVUnGUDTlto
	Skw/OYZy0h1LR77kVhv2XJjNXYeoWh3LGI2Xy/0C9VQOzyH6cXLmP+z+A+XZVYsdBkqzw9
	Eji71oWiTUGeskUtlKX1gmRrGTPPmG4=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] mm/hugetlb: fix early boot crash on parameters without
 '=' separator
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260409105437.108686-4-thorsten.blum@linux.dev>
Date: Thu, 9 Apr 2026 19:03:41 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Frank van der Linden <fvdl@google.com>,
 stable@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <518E33D5-81E7-4119-8168-6E31ED743930@linux.dev>
References: <20260409105437.108686-4-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235376-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 5C2733C97F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On Apr 9, 2026, at 18:54, Thorsten Blum <thorsten.blum@linux.dev> =
wrote:
>=20
> If hugepages, hugepagesz, or default_hugepagesz are specified on the
> kernel command line without the '=3D' separator, early parameter =
parsing
> passes NULL to hugetlb_add_param(), which dereferences it in strlen()
> and can crash the system during early boot.
>=20
> Reject NULL values in hugetlb_add_param() and return -EINVAL instead.
>=20
> Fixes: 5b47c02967ab ("mm/hugetlb: convert cmdline parameters from =
setup to early")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


