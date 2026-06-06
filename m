Return-Path: <stable+bounces-260890-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IZzDCDUhJGru3QEAu9opvQ
	(envelope-from <stable+bounces-260890-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:31:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E564DA27
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 15:31:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="di/Kk4ZY";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260890-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260890-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48E21300EC78
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E003E3932E4;
	Sat,  6 Jun 2026 13:31:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE523183F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 13:31:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752687; cv=none; b=bEY8CRZ1o35bV2aRgLujeznN5VhOINL4TA6V+A0T3WwykC0z6ddv7PCFoKgGQONaMUyA4FrcTp2FKkpCgNgMBkNsE+UrupkOZmVLw4RTwOFrT7wfo6s09MXFumQehH8vK3lp/eGmr7/v6+4jZR+LQ0k1DGiuCILri0Cxr4OO/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752687; c=relaxed/simple;
	bh=3HzAmxbHLtK3XRYOD+GQMkne8MWGT7yxsAMYToruO1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdsvrPr6MxaNRAqSX8nclrl6BgOkNUVRBtEegasWvuRFE5J+KeBKwAfrYdFS4aFezfrI0AgS/10DUqL24anSIoDOhDmD1mTQiwHXH6S9ANNwoqkKcExD8rk3j+8tbnC0cPf3TBoRU4nBV/qS7UsOk7UVTEErho1+78tJGY8yM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di/Kk4ZY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7E61F00898;
	Sat,  6 Jun 2026 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752686;
	bh=t73p2I3zof5OTdzUFh0Y+Fxp//BaqZzHgLjsEtNLW6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=di/Kk4ZY+s51NVv6YLzok9h1x9jk5PtqrBKESGrLq9yKPRFhFHRrPOOWXxIrUv/wo
	 HiJM8v6AUzuZgrYDrNGrAoTxYMRCZyEfaDBywfqJCIaLqqU2EE3EqRX/LjB3fM4mqJ
	 pwyupTaq2Xp1JL5Cb+QyYpk+CfbEqc1ZC6TaF64/YLd/WQOEAVrDiWdukovEWRXIEG
	 bFwoOU/IE37GEpoSEOE+6EVAtVn8ZtKJmGNPYsz1vYqMAcUEXzjn7P29xZeElltglo
	 So4xTrQu5a7sL9c8IZfU962b5ulej2Nfnmd8QA3nB5p3ib0dQNlo+Fn7a2oHum5jTK
	 Uds/ZdEvp6ecg==
From: Sasha Levin <sashal@kernel.org>
To: jiayuan.chen@shopee.com,
	pabeni@redhat.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Rajani Kantha <681739313@139.com>
Subject: Re: [PATCH 6.1.y] bpf/bonding: reject vlan+srcmac xmit_hash_policy change when XDP is loaded
Date: Sat,  6 Jun 2026 09:31:14 -0400
Message-ID: <20260606-stable-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605060744.2302-1-681739313@139.com>
References: <20260605060744.2302-1-681739313@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260890-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@shopee.com,m:pabeni@redhat.com,m:sashal@kernel.org,m:stable@vger.kernel.org,m:681739313@139.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 733E564DA27

Queued for 6.1, thanks.

-- 
Thanks,
Sasha

