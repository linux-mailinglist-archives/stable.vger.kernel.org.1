Return-Path: <stable+bounces-269778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ymPRBvaGQmq09AkAu9opvQ
	(envelope-from <stable+bounces-269778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 16:53:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3E6DC52E
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 16:53:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=AQbUdujE;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=e9IbIHUm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269778-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269778-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F4AD303EDAC
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 14:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70353BFADE;
	Mon, 29 Jun 2026 14:41:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6C3A2549
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 14:41:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744100; cv=none; b=n8zq9noqXVT0urWZkg16Ss6PpWPmqOOCRlaQcd/lu3tHfP4JpHaWQJ7yphlPly8uuPgkyy2oT4i+O9mc5bpSQtbNI8FSKWIQusntdCqeCzUmP6JDlVYQnVLyKxoir0ZKzvN8SAluMVDldS9w6qX9yLibzItdzyEgPgXrPbIEvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744100; c=relaxed/simple;
	bh=a+jH0hfgg9A1skt6sKLqlzAuNa/TNIR69rHvYoFXunY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPs0iw6N3uLzHDzzR4FjpjwDH7eXm7qGIBwZ+qOh7kxTL+YA04i8nFRcrK8Nfr2CsVeHATOPHbuoSEUgcM6lsW06UC68NcRSo7Adjvnx6IxNm26lBtZfSCzwu7Xqo9dqAtP2eFFZgT42gCeYUELdjWvXKFrLf4gCKwPPBb4aWqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQbUdujE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e9IbIHUm; arc=none smtp.client-ip=193.142.43.55
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782744097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rg7Ts0DBVabun5qwzoKxHmHbEQwrJgOSzqVBjFyzk18=;
	b=AQbUdujEi8LQTQ1Q1ajxNR8I2+nVhLPVv8thDHc2uTHauyybp1YOk6cWVMJxQO/u4dHT5j
	VgxF0K6PXmMECvr6SEooXQ0p29G2vmECvg6gRu+2G2FPXm+9oWGguyn4RqKURs+oL4ihnD
	faCONKxvQj/vhjYQxuhy5L3tIxGyuCX5kKs3m8EsL8w460RKsQD7MgYcD3+e0hOxWLQyTv
	ugSnGCYgz4wGDuKoTUnFPaE81t3l3duH02uLzLaNKvm/A9CkWVbAG57P5WpCnAxfXTmILH
	yomJEm4YCPlWRBoiL2nhFK0dVJ01pvQCfyujzUtImmapKH7PW+wxtXz48feFag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782744097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rg7Ts0DBVabun5qwzoKxHmHbEQwrJgOSzqVBjFyzk18=;
	b=e9IbIHUmKaJpbr2ja6M2V09MBZO4JEws3zTfDp4+TR1IS8BVPRw9XmxSNxwXpxILdHrfJZ
	NLqVnnX4rsFzkHCQ==
To: stable@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.18 0/3] ARM: PREEMPT_RT backports
Date: Mon, 29 Jun 2026 16:41:28 +0200
Message-ID: <20260629144131.788576-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:jan.kiszka@siemens.com,m:j-humphreys@ti.com,m:rmk+kernel@armlinux.org.uk,m:bigeasy@linutronix.de,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269778-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:dkim,linutronix.de:mid,linutronix.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5A3E6DC52E

Hi,

ARM missed the PREEMPT_RT window for v6.18. The following three patches
have been merged as of v7.1-rc1 and are the missing pieces.

I've been asked by people if it would be possible to include them in the
stable tree as it would make their life easier.

Russell King (Oracle) (1):
  ARM: ensure interrupts are enabled in __do_user_fault()

Sebastian Andrzej Siewior (1):
  ARM: 9463/1: Allow to enable RT

Thomas Gleixner (1):
  ARM: 9459/1: Disable jump-label on PREEMPT_RT

 arch/arm/Kconfig    | 3 ++-
 arch/arm/mm/fault.c | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

Sebastian

