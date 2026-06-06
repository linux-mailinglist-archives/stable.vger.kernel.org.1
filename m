Return-Path: <stable+bounces-260895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4SEoHS0iJGod3gEAu9opvQ
	(envelope-from <stable+bounces-260895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:35:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FC064DA7A
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Cb8qMDq7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260895-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260895-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28DCB3047428
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3C43B3890;
	Sat,  6 Jun 2026 13:31:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A03B2FF1;
	Sat,  6 Jun 2026 13:31:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752697; cv=none; b=HLlRPqG0X+k55xldb+5duwT+3SFumegp/7nkrgOHlSpXNZS28x1Ou7HBrR/Fka0/YgEnCPFF7O/n9ZaGFcRO5ziPv3ws7YHyiSRzKPqEw+VJCqzaOAOx8Zc9WOyrPpcCWkxDqFYtQlH3b8aUYVMUgFHZkaVKLx6CQ45aukY9k+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752697; c=relaxed/simple;
	bh=iqdBp1SBe9s5B8xK7xryHGkN3EFOsiyJRhWFfYHWwXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTOhKgGg7Jida1r7J8gdhsMZS0ht8zt/ZTlrtrhVYScppLOSbcKpqA+fq7c9yUjXHx/W/uKD1AQAg1pqzaNSb6kjxdYFg2XRg8vAq4iWAy5dYt53TRnoU/PleAgIC4aq2KBH89TnvQ7opsPFi9/iQ/dCk8LXeyZnzMUmUrRXc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb8qMDq7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B91F00899;
	Sat,  6 Jun 2026 13:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752693;
	bh=JzucgvGDuY3nnjHaY/HehPAaXtFO2Zl/ImV4s57IpW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cb8qMDq7EkDP5+UtGVouj9wv6ricBE4nwU36/63nVZRa0HgEFXFFVDj+IaweH324M
	 pFX4vH4lUMX3lMX/jKz2TZuFzH86UcU+lv87pPeVEz2TPK29kZpd2WfFoJf6OF56L7
	 nTqumVUNJz4MzcuNoW318jRzY4yJAs+rKSz6XjxbX8Jv7bp6mP901pQhvhSWdQ/3MR
	 fIMRXF+80DaPl8LPPT7WQufjolOoUjCC4NUj0RgixqjaQN9yqBDMSQ5F0D8IBiIjGN
	 Yzu1li6pAkydqCTyNaWbzSylOjwlipmljMVEhynLDMObIv2A+SyvJa31MMQyRc8wls
	 iiJbB8lstVOAA==
From: Sasha Levin <sashal@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Liebold <lieboldsimonpaul@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.12.y] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Sat,  6 Jun 2026 09:31:19 -0400
Message-ID: <20260606-stable-reply-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605141254.1177152-1-simonlie@amazon.de>
References: <20260605141254.1177152-1-simonlie@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-260895-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lieboldsimonpaul@gmail.com,m:sashal@kernel.org,m:tpluszz77@gmail.com,m:fw@strlen.de,m:simonlie@amazon.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,strlen.de,amazon.de];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42FC064DA7A

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

