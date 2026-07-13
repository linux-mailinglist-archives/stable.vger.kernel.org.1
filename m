Return-Path: <stable+bounces-273996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pRNhKMpLVWoSmgAAu9opvQ
	(envelope-from <stable+bounces-273996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 22:34:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BA774F115
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 22:34:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eymL7HLt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273996-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273996-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D49F43024516
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C97B35CBC3;
	Mon, 13 Jul 2026 20:34:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25B34DB74;
	Mon, 13 Jul 2026 20:34:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974850; cv=none; b=S8aLaVbrmEYqSli0i/gfds+W6Jt3Zd8JNb3k+s/xBbatZJXdX/L45u7kQMSvELJXPXu4uMLsEjdbCB5Gg8P8c0xI5APqIV/cSb6eKHLhMxnPxb0cf8VE4X0TVxCSprC08PWfOCDrH9vTsDpYCGlqiwHmSA+d8Pry+bcVNmxyRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974850; c=relaxed/simple;
	bh=oOgV4qEv9cggQjeWpFuU9KxELdOGDtVFI917rmWV0YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHdErIrn4e59ZooiNvyeIThNUAuMHUYL14Rmf94+VYFKkFeU6Pgr+lMa+gM03YSDw++3yitns+fcWn8vkOPT5JdiDGZ+aBesmXZx2xjc2EaOOKA8cGK/paXvLX44zT6AZkGVTOWvEC8OoWl7aTVlA6YExb2Jh5qhNFhbjZdZeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eymL7HLt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28811F00A3D;
	Mon, 13 Jul 2026 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783974849;
	bh=Ug4hhpkSS8x4vJqG0UAL5u06DZYYJLZF26nVUBBT7mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eymL7HLtHfcq0lK9a1DOz/HVHrJowOGxkPlLRCAhTQymPYEda9vyCwcpNurxMaJcJ
	 7wRXLOsx9ev8j1dwr0le4Isy+zsyzD43UBGdYXGdg93BBescFBjfNhAPTNDgq2fr/J
	 xnB03JFdDtCUGGwxkfBcDDcGz/foVml9rCGf2zViIUWkjOJhX2zCbBT0mcIEaeHaKH
	 NhjbcLKhz/Anv1GI1w3x2EFAPqjlH3PwOuKV9oYZpcfLMRS7gM0ikFDDdmES9SHlHj
	 vOnjDv4l9BVC/gT5Cmf9OTIM7NgMPm0mpy9Yg8v5qkp7Fc+phnxQfbhkiG2OXjr7j9
	 ZK7YH5z3ETFkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bigeasy@linutronix.de,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	lulie@linux.alibaba.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dust.li@linux.alibaba.com,
	heiko.stuebner@cherry.de
Subject: Re: [PATCH 6.1.y] net: Drop the lock in skb_may_tx_timestamp()
Date: Mon, 13 Jul 2026 16:34:02 -0400
Message-ID: <20260713131907.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713024912.36991-1-lulie@linux.alibaba.com>
References: <20260713024912.36991-1-lulie@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273996-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:bigeasy@linutronix.de,m:willemb@google.com,m:kerneljasonxing@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:lulie@linux.alibaba.com,m:davem@davemloft.net,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dust.li@linux.alibaba.com,m:heiko.stuebner@cherry.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linutronix.de,google.com,gmail.com,redhat.com,linux.alibaba.com,davemloft.net,vger.kernel.org,cherry.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25BA774F115

> commit 983512f3a87fd8dc4c94dfa6b596b6e57df5aad7 upstream.
>
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha

