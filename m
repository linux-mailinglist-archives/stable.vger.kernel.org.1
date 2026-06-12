Return-Path: <stable+bounces-262934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ILAeDrcaLGrzLQQAu9opvQ
	(envelope-from <stable+bounces-262934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 16:41:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB61767A488
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 16:41:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QipHgQ5X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262934-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262934-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E983161106
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0E238AC91;
	Fri, 12 Jun 2026 14:41:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93A3644DB
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 14:41:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275287; cv=none; b=T1UtmErORHqHnqmDFgIDVlFSgCNjpBtDw0C1Jnkua0nywrbOoMGaOeEzrRxge82sNPSwi+eEWfp1YxPQHV58T3rdIDuM25QmdLTxqBYbi43H3gjss2FN7Sh4iorgrF6BnB/MZa92JF+ut8g4wsSGuGZT2o6Sp8vgasRit4EPtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275287; c=relaxed/simple;
	bh=w3g1VhNc3n/LCB2xfAbuWd51fsn1THMiYIqmouajrsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jX3lysw1lAiBCDN4djqTHtQbuAE2s9jkoXVNS0P/w2bF6mYn2V/B19kNKVpWkb54yjUKqH1rwz51JE8Sijvb8n9M89aGPSFoS8mO7RmO9tHC5pAcrBlkYI27muGAf9epuqJwTLwZZf6e2AH6do4U1wHlf5p3kTU5D1n32nlGn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QipHgQ5X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572C51F00A3D;
	Fri, 12 Jun 2026 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781275285;
	bh=w3g1VhNc3n/LCB2xfAbuWd51fsn1THMiYIqmouajrsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QipHgQ5X4uVKiXTroRYPj+UaVOqSL5ReGWVVKsFjmdrLrTqJJrPN2qSR7fIjWAynK
	 q+ZMcTrHcUULH8rU6YfQnpPi1Hck0CW22dSdwwkc78r8WayVJb+C9m8mkDAyDR8M40
	 JHiJcG3hwPUG8jHwltds0q/ObCbwYlM4AkMhYw8tCujRuwGc7D/m+ZT5PZ3f+NlLD7
	 fJRZbDy90GVnsplhTxRX3WIOgutFkt+ytfjDTB7agReAxqX5iRZR3p8zPmCS+e3JZA
	 SZGKg3b8t1gdht1bTdvq+o95ba+fAhED8XnnTudWBVh6WlOW1uPsXMQMqEzP3W+ccx
	 hGYEHzeMM54Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: Re: [PATCH 6.12.y] reiserfs: validate tail item bounds before conversion
Date: Fri, 12 Jun 2026 10:41:19 -0400
Message-ID: <20260612-stable-reply-reiserfs-tail-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611224027.74281-1-kylebot@openai.com>
References: <20260611224027.74281-1-kylebot@openai.com>
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
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262934-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:outbounddisclosures@openai.com,m:kylebot@openai.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB61767A488

On Thu, Jun 11, 2026 at 03:40:27PM -0700, Kyle Zeng wrote:
> Validate the per-item page copy and aggregate tail length before calling
> reiserfs_delete_item(), and reject corrupt metadata with -EIO after
> reporting a filesystem error.

Thanks for the fix. Same as your other reiserfs patch: no upstream
commit (reiserfs was removed in 6.13) and no maintainer ack, so I can't
queue a stable-only change for a removed subsystem on my own.

If you can get subsystem review/ack, I'll reconsider. As before,
exploitation requires mounting a crafted image.

--
Thanks,
Sasha

