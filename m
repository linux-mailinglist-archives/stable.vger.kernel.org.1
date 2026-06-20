Return-Path: <stable+bounces-267490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A+XzECqANmpMAgcAu9opvQ
	(envelope-from <stable+bounces-267490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:57:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E96A8D74
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:57:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X2Z4IMjX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267490-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267490-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1FC3304C762
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C315395AE3;
	Sat, 20 Jun 2026 11:55:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C298395ACC;
	Sat, 20 Jun 2026 11:55:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956517; cv=none; b=hdr/3lRIbepaCtHQAdYXesrrzdl7RDC/GNnflpLjG4HXTnrhJOpRaGA8fm5t1R4Zgl54cE8D9rl1tgydlujMLgv8gdvF3MGN5E5zzy+ZvHrZuTJwjZGet/llScZfU5Lp9cuhuSlaRrBNz9Jbn+sz45Sgeu1OvweVgL4WHSGktHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956517; c=relaxed/simple;
	bh=uRk0++eKwDhDzKQf9uz3GT6QBL8eNuwDW6TYxdUbAfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHAtfkrFTN3RJmshTG1EEgxMs2AavBmKaJtrqS3wIF54QP8MXxTn61NfGext6fSU73ISDUkREZVjn79Ic7DpgFCnEiJvAu60IpSvTxLGeekQuHl1yrkZM1YtMhfi+gb/SpGvwhcFN72Yxyt9m5tArJ2VR8PGU/sfA0Mscj8pxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2Z4IMjX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F801F000E9;
	Sat, 20 Jun 2026 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956516;
	bh=5vuHXXZtiRg+9Qwm1NqbLzohm1WwmOSwd2xrCTaBhww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2Z4IMjXIe7oGwWbr62/hHOmKSBWqBSYNl8EdmUW5zjUO88FVJtrIQCKM1GriYvr9
	 vb5RdD1zRTOtOonY1LoLCjVEyIpqPjfu36yhSWRqDMxNxTzIN8dl8mZ9fV6VhRQDwg
	 kjzgZLHHjPVMsmkff2LzoJj0c4n73k6DXVnjbfOQ5+XH14RzY1Sc2TDhfxALFaMAEt
	 W1S6TaC2xDZGwYD/kQ8ZuqaE6/eFeCR2SUFEMnRhUgwrD4OIV0Egld4+9QP90z6FZG
	 d85l7e26Z2lCj0s8UK/+znFsNVOL+6kLa/jHu1uVATx5zCU6y8Qx9OxJoQxV4Mv+pQ
	 P3dY+cpBTuKUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	lvc-project@linuxtesting.org,
	Wang Yufen <wangyufen@huawei.com>
Subject: Re: [PATCH 5.10] netdevsim: Fix memory leak of nsim_dev->fa_cookie
Date: Sat, 20 Jun 2026 07:55:00 -0400
Message-ID: <20260619.0012.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619091507.95142-1-mdmitrichenko@astralinux.ru>
References: <20260619091507.95142-1-mdmitrichenko@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267490-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:mdmitrichenko@astralinux.ru,m:kuba@kernel.org,m:davem@davemloft.net,m:jiri@mellanox.com,m:idosch@mellanox.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:lvc-project@linuxtesting.org,m:wangyufen@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C12E96A8D74

> [PATCH 5.10] netdevsim: Fix memory leak of nsim_dev->fa_cookie

Queued for 5.10, thanks.

-- 
Thanks,
Sasha

