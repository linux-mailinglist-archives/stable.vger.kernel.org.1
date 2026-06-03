Return-Path: <stable+bounces-260105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KJG3HiVJIGrK0AAAu9opvQ
	(envelope-from <stable+bounces-260105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:32:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CD96393A6
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:32:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bDctzG1L;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260105-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260105-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FC27301048B
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB703B585D;
	Wed,  3 Jun 2026 15:14:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F003A3E96;
	Wed,  3 Jun 2026 15:14:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499671; cv=none; b=BqLdWPXfLWc6ij7G61EdVQ8ohxTcORNWga+kwOkEB5gmechyRbugF6FSL38xJJBvroltRFvL+xIY7kB6dBGOz8OUXN10O64qwSmCO1izuDj2lBl1ZT+gpZw8lwdjfyP/LTeJ4DIvPbJdTR04bwQdNSgY/GeoEXalLLCDWYrU7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499671; c=relaxed/simple;
	bh=LWpoh2wA/btNiWpzg94x5uh5gldlcM9LK50m3PbINfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WW/dWFPFsLaH++15OGoj9YKqno7Ma1r5D+EpQ6ussjBfLReoz1H9Xrr17Rug8UKbM4oxfFv38D6YsxuyGPG00QtSVgtldwJHZHulkrfZifBfwUidAcJeDEo57AZJ2P42O0VYscvKbw/P9yOLfO29RfsmWclZuaPhOULrftl8zoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDctzG1L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC8A1F0089A;
	Wed,  3 Jun 2026 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499669;
	bh=+wuwf2ftrisBFINYpRD8z316BLkLaL0eaknsbJEFTTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDctzG1L3Iiw/XTSEeMbRNzsejtZ6wApKhlG/qZ43gDcrDSsTn4pY2PIvZMFNSi1i
	 8EwBdei4/zgktkOcmZkmLTPn86JmWWGa6RtHUyY7INHAewrC3/r15YSVyogdOYZ7og
	 DHWMhuUZr5Bphu++nSYOsSyfSmlFWmezJWOxeJcQ/ezow7qByWb1WUMvSs0mucLF9o
	 Jq4Ygr4B5Jw0IzSSi92OxxrlTlnVjjdm8EjytzzFRa3m6oTNCi/b2NV8wjScaYqcEW
	 GYllxAJjS19yaKt8NWE0kIfEEt4pYlYMM4N/2H0C7XtfA0rceb8sNN9B1aX0lI90uX
	 AQd6suJP0CLyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Wei Wang <weiwan@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Robert Garcia <rob_garcia@163.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] ipv4: start using dst_dev_rcu()
Date: Wed,  3 Jun 2026 11:13:55 -0400
Message-ID: <20260603105137.ipv4-dst-dev-rcu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528030554.3147155-1-rob_garcia@163.com>
References: <20260528030554.3147155-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-260105-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:edumazet@google.com,m:sashal@kernel.org,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:kafai@fb.com,m:weiwan@google.com,m:davem@davemloft.net,m:rob_garcia@163.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,fb.com,google.com,davemloft.net,163.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14CD96393A6

> [PATCH 6.6.y] ipv4: start using dst_dev_rcu()
> [ Upstream commit 6ad8de3cefdb6ffa6708b21c567df0dbf82c43a8 ]
> [ Minor modifications made to adapt current code. ]

Thanks for the backport. I think as proposed this introduces a bug: in 6.6.y
the predecessor a74fc62eec155c (which adds dst_dev_rcu()) is missing, so
skb_dst_dev_rcu() / dst_dev_rcu() ends up being called outside an RCU read-side
section here.

-- 
Thanks,
Sasha

