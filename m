Return-Path: <stable+bounces-267549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SD2lDxvsN2quVgcAu9opvQ
	(envelope-from <stable+bounces-267549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:50:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8546AAF99
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aFNv91O2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267549-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267549-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37D993033FB7
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F335028D;
	Sun, 21 Jun 2026 13:48:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35202184540
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 13:47:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049681; cv=none; b=HtdiKFBjyPAmjnNLFqsLU9RrxDwy313TfEExEKSWli3yWPzlJXiL90/bY/rv49A8/YTBgaffH513nGCVkMVXO0lH+XkqTyC0n+bsao3Ma93ktjzXMgdPvTC16/iqMRC+KVFo+JPGeGS3iG2UmVc8Xs5MLy4eVG2FloAurXkwgZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049681; c=relaxed/simple;
	bh=Zbm2Di0rsdxXFf2bTuiT+YPbai0Fib/fqqZI07eYrnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9tY+CMd/nMKqPVA7rqJmQ7ulkYkO6jY0zcqSs/gar9G1A0RYrkQlxMKE+BBaqrnHYNpnySQgolh+Y7aAxSi/vhGA+AxPhEps5ohkztHdYp29zlgorR5i7XGDjMXx6ZLXrJVBl6bWyyCBWqEJabYXEfs85pQ0Yv8LVT490TG1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFNv91O2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999771F00A3A;
	Sun, 21 Jun 2026 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049678;
	bh=txM1EMZdcsl4i9R1s1vwl8uZKZ7KBYlXqAc5zWVGZ2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aFNv91O2CC8MjV01G6t7PvV28TjV2JEcnaiO+30LCk7P/ttpxfB0ArIjvzgd4xuG1
	 QXkqiMpcGxKlHzsJ8ZctA7+X51iWSov6Zymy05AKiip/WpWzyitrHU0zUE2w69Pp9c
	 Rdo46gaVWyiJp/52UKcc0eSmQXTRHbE1po5MMxcXZgvBi/DgSy0S0zDEMdE8ngfaI2
	 9I7mBRkoJtq43DYov4aGk3VhvfPwxrP7eFz1zLP5ZIrBYi1wy/TxL1fobwoCYNP1E8
	 blTFdx3yYfL+tnjCKDa73pVxRxpK1YOe+zaPKXJWSehVN+NsV/ww2IHVJx/qCK35Nl
	 ladCAV1d/Hngg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 6.12.y] net: Drop the lock in skb_may_tx_timestamp()
Date: Sun, 21 Jun 2026 09:47:44 -0400
Message-ID: <20260621133722.0006.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619152012.2016837-1-heiko@sntech.de>
References: <20260619152012.2016837-1-heiko@sntech.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267549-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,sntech.de,cherry.de,linutronix.de,google.com,gmail.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:heiko@sntech.de,m:quentin.schulz@cherry.de,m:bigeasy@linutronix.de,m:willemb@google.com,m:kerneljasonxing@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:heiko.stuebner@cherry.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF8546AAF99

> [ Upstream commit 983512f3a87fd8dc4c94dfa6b596b6e57df5aad7 ]
>
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. [...]

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

