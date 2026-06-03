Return-Path: <stable+bounces-260132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OY6UDHFPIGom0wAAu9opvQ
	(envelope-from <stable+bounces-260132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:59:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2FD6397E6
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:59:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oqaTe9LR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260132-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260132-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9484314083A
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E73B38AC;
	Wed,  3 Jun 2026 15:14:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8B3AD52B
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499697; cv=none; b=pLsdPBErWk6S63b2vyeGE838FybIt74dMP4wIhjD95haBFPH8h5jlEWqfJ/+Vsd4ZzWEf+yPPEELVrwitcyjbJnMoP6ycc+vwss/DX25HyFZgGhpJNmtorKsG6hCB6NQYd8D5Rx6L8tr9TIsJwXTNrKIUGg5LQXCcmQhYjmTFtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499697; c=relaxed/simple;
	bh=KfHgXhbPniMJaBbvlyUkTWGRgQ2rzezoVeU83qmDbrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNWNogM7H0jswQ3Xynjuu2YKrxlmPcgbUqgZr1vt/bBPD6Y/3ZjN9h+buXi9nTjZPhAYaTDRwMThjgDen8ygjUgTgl8nOABlKFwgWy5F6yougKoZRGzQDDoN4hzfOH9NX97CLt5rOrUfX/EISt89A6jqceZv+xWmAfddsmsbMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqaTe9LR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2541F00898;
	Wed,  3 Jun 2026 15:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499696;
	bh=yhNbQwCeczwm1UBqSPhOp+DKXYAnRtGUvgijtL9mFpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oqaTe9LRINPluBj1nYX3rF+qC+0yH62e6bO6RETvfhelxXfCN8LGDqOvS8KM0nba5
	 qie+aNpzAQ7ZHh5EFKO7bEzlkKBbF739FQCIgCfja+6p2pNFjGN0OWsrYKuCkLl1Ay
	 k1lLYV2PGrvvk2KH/S/Z4HqSHPOafWzFeGa/0shjGFcMNK1QER8o0NagoXUw95NkyT
	 Xbf7IvgECPQwwbEQPZTaFBmeWKfdBT3w8RZ5kLcrS368DDZ3SbFYbjyCHNtc7RZPC8
	 qdOZYPQrec85nsZXlyfmEALparaAjW8EUXfhYUVx2NxAQGcq9t4ZdeXUxJrQNDcmw0
	 O4L/z//j9Rncw==
From: Sasha Levin <sashal@kernel.org>
To: Li hongliang <1468888505@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	patzilla007@gmail.com,
	stable@vger.kernel.org,
	willemb@google.com
Subject: Re: [PATCH 6.1.y] net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()
Date: Wed,  3 Jun 2026 11:14:22 -0400
Message-ID: <20260603111500.item068@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601061558.3703791-1-1468888505@139.com>
References: <20260601061558.3703791-1-1468888505@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260132-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:1468888505@139.com,m:sashal@kernel.org,m:kuba@kernel.org,m:patzilla007@gmail.com,m:stable@vger.kernel.org,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,google.com];
	FREEMAIL_TO(0.00)[139.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF2FD6397E6

Queued for 6.1.y, thanks.

5.15.y and 5.10.y need a separate hand-crafted backport - the
upstream patch doesn't apply cleanly there.

-- 
Thanks,
Sasha

