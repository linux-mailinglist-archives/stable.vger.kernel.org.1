Return-Path: <stable+bounces-249703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKwgEenZDGrhoQUAu9opvQ
	(envelope-from <stable+bounces-249703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:45:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31A558547A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 23:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A29930151F8
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 21:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA21D26E165;
	Tue, 19 May 2026 21:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQeJNqp6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745C382F39
	for <stable@vger.kernel.org>; Tue, 19 May 2026 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227110; cv=none; b=qFUb1eclsY5hBsSU8GAj0GT5ECnB+DDQbjVhHlkUW87TAnQNkMDm12A/jgwDCvGUOOpWkMSuYzN7V4a9/qZXxBV/CS9PKWl9Dcds6VRs4PxOxVhX9MfDXbMunfGXOeOX90faZDKRBHoxzQjaL022ecS+3cKNZiX52dmHZjMblwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227110; c=relaxed/simple;
	bh=7kokTyk71LzE1A4AqSCZob4mFW1/ZtmAHEM9Po10Jms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNOlnI87h8b3sBhcycSjpKG9tKF0beP0+O9kYU/d7HuYolBPQ+SXtIszNyYluYuUHWvVTlI30HnAyq4GQa9P+moLQmgdwy25KVmCD/FR03c4u6P8WGETSnPxkFUf/QaxuN3O3dbyaeqtbqvs2B+eFsO9z8KbIiwUC0I5GXFJQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQeJNqp6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44a5174670eso2309160f8f.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779227108; x=1779831908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kokTyk71LzE1A4AqSCZob4mFW1/ZtmAHEM9Po10Jms=;
        b=LQeJNqp6SzxQtaMeXvKzzFM2mXmq8XMlTjX8VyyzftynRtfDL2kxh38Eb1M94iegsg
         gz4JYgpPJJyMiy1Zi2yxPv6Y0GoeYc6wUgQnGF9d0x0+P7IuPmC459fnNp4JWIHZ36ME
         W4IMLQbwnWVacwlbJoY1wFRwQBPkdtcbjPjVSb+msJ4t8Ub7abmIKoj0RTz6fR62GXCD
         CJd/+Gsmce/Q2STXX1AVXbgPTsE/uFuQWVmqRbs/ZYzrt9juD/usFznNBGpW+TY/myk2
         xylJFHLe2QRZ4RWsUuHPAFJI2IBZOHbcE04+X14B/kRLv936fehe5sJV1g6c8zEyeVv/
         rUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227108; x=1779831908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7kokTyk71LzE1A4AqSCZob4mFW1/ZtmAHEM9Po10Jms=;
        b=aaUL/0IXGAXEyvgQdjxHnTtvI6shzHBlr9f1WYBWNzFABOfLXaH1HMYhgyntwAUj73
         5Wq04bejSXm6NED6r2C52lPhfrlPcAYqfWomOPtnF1gwM9fAdM/x+RPnreOmUpelBbLK
         3yxyKUrsRpD4HuGXqpjpZ4lUVRV4xKq0Ep0LqHG8DkHmPw6Bv7/y5pRCwOwFTmEwpcFJ
         3NBUHrP5gTQClmVmhsdxo7VSxzOYglXO0mD+yt6TD3dm7I/lMnJe/DLNFvSJMcEbzJJU
         LaVZejp74M51q/f8VrKLPDrrGpGm1XH0ki1t/7P65cCZYXdWBtefL0+cb+v2fNWpyvXq
         hWtg==
X-Forwarded-Encrypted: i=1; AFNElJ+5XE6SbasPzlEU1VW4T/5VHR0pG+kcogh2go+5vjBmSMMogxcTbS5kEBfTHZh0pRWwxe/i+3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRLMAGFlJS3jrAoqAJJzLpRlQpwN+jkbRl3VTwINInT1hKWU9r
	lnJUewLbPMitYbEpZPwLmHAcjB5iVO1HbKyXTGBUM1uqbr1JzKbKPyTg
X-Gm-Gg: Acq92OE27tW1oLV5OnlNS5+Pn6ocw7EC/MOW4DMoFxvg5ktGRRbFeRMKYprs38sR+K9
	agWWwXSRWaKAW3qIlohtQvt3gkBz5M+CRf2d6FSyLLYmQZ2UjzgdXenqsrmPTKO5e/5dexG67Ui
	4oiZH64+CNp4t8HLzzS9glTvn5fpXv4M7uBQEk3FO+fQfvV7l8hD07JlujJQ9ZV2lLjavwaCQcT
	usJ4DxLCIq2tSuQeXnOKkhD14zyQiBgcDMMC5IKgdl6IUa04NDAZzanzdaxcwzCxGzTYWr8jkJK
	JWwNqM41R8tcNEBkWCVs1sCB2HQ7t+C2DEJ3RSPZMjwzKIOpidx0xO8F5EAjfpYgFCBW9Ko4Q9f
	OMScTH3tBktGVTSKcauqFSpAFq+o3OwQyYmzC4U2yltjH5prgF0wOIWD39tpb9JXtqYY2Ygvq4U
	C+EEgHPyVCs8R+niXGeRKoPwN63N+aZA7FRx76/47rnI2pyHPkZ6Z8brHmaPSPdnTbNphism1mB
	SYQ86zERfNK9RdRNBMZpoQ=
X-Received: by 2002:a05:6000:2f83:b0:452:8286:86bf with SMTP id ffacd0b85a97d-45e5c58fe4fmr34127660f8f.1.1779227107783;
        Tue, 19 May 2026 14:45:07 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e6a135f0csm29797283f8f.27.2026.05.19.14.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:45:07 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: Re: [PATCH] netfilter: nf_conntrack_irc: fix parse_dcc() off-by-one OOB read
Date: Tue, 19 May 2026 17:43:51 -0400
Message-ID: <20260519214351.29908-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <agzWUpDy-32yvBcB@chamomile>
References: <20260519212328.28290-1-meatuni001@gmail.com> <agzWUpDy-32yvBcB@chamomile>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[strlen.de,nwl.cc,vger.kernel.org,netfilter.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249703-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A31A558547A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 05:29:54PM +0200, Pablo Neira Ayuso wrote:
> Other helpers replaced simple_stroul() already which is probably the
> way to go.

I can send a follow-up patch replacing simple_strtoul() in parse_dcc()
once this lands in nf-next, if that works for you.

> This is nf-next material.

Understood.

