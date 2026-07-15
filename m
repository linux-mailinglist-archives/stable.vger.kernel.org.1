Return-Path: <stable+bounces-274624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8vQZD7XQVmoKBgEAu9opvQ
	(envelope-from <stable+bounces-274624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D0B7599DB
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GitoFxqB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274624-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274624-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65ACB3115775
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2A113777E;
	Wed, 15 Jul 2026 00:12:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2382F84F
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074371; cv=none; b=sER9UPFtZc231CV97Atfe9xOzWjQKrCne5bkBxsRHbYXzt4oEVA/i7id1fDcqajqMHRDMx9BO4GXPNWwfADjYrWNg1oiLkG/VIcDYWi9zuxS0aXlNUgTRUU46aWXA3gaM/O4lHk3ghd2euIo/EbLxAC5dqOEwsRnktgm2t+Oabs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074371; c=relaxed/simple;
	bh=E4ckGSUBWZZiDLmwDnBQhdPjjePVogARFR/YPGdVz2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/XlgaMW9wgKhTMh0+sUZI4KTlbGnXEXgzvBvjTGtwENmvpH4nljAYz5GZ1C+oQhlqRPOmI2HU7vRglq0f1isDXkGn3teBHSwvE+PI+N0ocbGTEX5SPVZ2ZIzPaQz2wuhJXd63uyw7j+aKynM42mGtGLhoalA+F3Q79eb4L11hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GitoFxqB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC3F1F00A3F;
	Wed, 15 Jul 2026 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074369;
	bh=SAYXCPd7iA+PG/fQJYnEpZFYA7O1U4l4G1a7vLhLvUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GitoFxqBmykiOK4vNfLOyorB4CpRm4Fun+6sh9z2TQ47KZ7kVVbJLMxjJZSDTJkd1
	 Pc2Bi7MT38Xgm6EKDSKDYgYgcGSAM45chzcehY/qYHyqD8J/e6BtFXRvGMl8VTHSn2
	 /SLBw3N5xSVUTWWZ/ylOJN2hPAHGqw+mXZaZ6bRY6pX3a8G/7ZpMAN+A1QCsTYkNhK
	 a2hedyFLLQ2CngI3DSTvSpq4is9YHX80bj1TITXTbdYnL6CpmEFJTe4sl4dFdDLa0/
	 WRwb3iNZ9CfAyJMx6ijzgiwGArNtsOq/QYo1k7uO387Xdd2/VuXkOt5BdTvkOkvwDP
	 37Siaubq5O2uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6.6.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Tue, 14 Jul 2026 20:12:33 -0400
Message-ID: <20260714200600.stable0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713154526.100997-1-liviu.stan@analog.com>
References: <20260713154526.100997-1-liviu.stan@analog.com>
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274624-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:liviu.stan@analog.com,m:jic23@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04D0B7599DB

> Initialize n_wires = 2 to match the binding default and ensure the
> rotation check fires correctly when the property is absent.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

