Return-Path: <stable+bounces-273385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q09CHiYZUmrsLwMAu9opvQ
	(envelope-from <stable+bounces-273385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 12:21:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C07741352
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 12:21:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qg4UaXiL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273385-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273385-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584B2300A121
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF83AB5AC;
	Sat, 11 Jul 2026 10:21:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF133A9D90
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 10:21:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765262; cv=none; b=h8R04C4TY54w4f6LRhwvLX3zjY8g4z9FV7fgZnjTRK9wJZCbFTg2rLqbb5xuZhYru1V9+v97It1qg++qjeXFXnkB5hqW8Md5urDTVFtoAdQiJi/5Hs+aCC+TH45qt2ydV9sKPoPOB+Af3Q+grgHZz6pKjvDcr0PRSiCRpC3Uu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765262; c=relaxed/simple;
	bh=xR8ynoCxEWhOAOUflzBK1B0mn6ud3lqJ2p7N81/a23E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHP2DQrsJ/FFCQdh6hrKNn96Iefr9rFWnmSsEMf8fh9O901HaIn5LAyflng9bMEbpE6Wa35SE1N7eIrOQ3Fa8o8fU3POZAcqPGdAzy3HIwzuvR86XyiYhkeJEvHLtyo0sg4CDHtsioppWhp1uZC65OIDLIHEMArqpxAaJMepO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg4UaXiL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8591F000E9;
	Sat, 11 Jul 2026 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783765260;
	bh=90bufOZJD2eNeipq2T0CjdC+A8+i9udmsuErCstDj/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qg4UaXiLZ6lrlPt5/ZTWj0osKvAuzkAXODn9hUUCBY5rUmTmdCnQlCn84SSze8+zO
	 0MjWQ0Zk9zQa9FIU0E0gmrNcIRTi8uZrMPdkfdwy3D+V/34meJM/ejy1nSQglQal1E
	 qm+ZnmFMFKRJdeAU0Ws6JK3EGo+WVu0wjaRNX1WfaapO8GCRasQa9SY+G0rgXfCLDi
	 bOHbJlAdOGU4Ni0glLJI3EL01TVwJa2GXFytQvxd7wuU0TuDH92JczK9NXBuc6hy+B
	 OLcbD6NUlImNoKxLHUdghr2VH4Do4tHIommMqX/rzuzeyICuf7rttpQo+C4ZiHGjNN
	 vSCCeY9CZ6qOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Michal Kosiorek <mkosiorek121@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH 5.10.y] xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
Date: Sat, 11 Jul 2026 06:20:55 -0400
Message-ID: <20260711061631.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710223015.3831465-1-mkbund@amazon.com>
References: <20260710223015.3831465-1-mkbund@amazon.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273385-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:mkosiorek121@gmail.com,m:steffen.klassert@secunet.com,m:mkbund@amazon.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,secunet.com,amazon.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5C07741352

> From: Michal Kosiorek <mkosiorek121@gmail.com>
>
> [ Upstream commit 14acf9652e5690de3c7486c6db5fb8dafd0a32a3 ]
>
> KASAN reproduces a slab-use-after-free in __xfrm_state_delete()'s
> hlist_del_rcu calls under syzkaller load on linux-6.12.y stable

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

