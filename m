Return-Path: <stable+bounces-245221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNx4D5vfAWpslwEAu9opvQ
	(envelope-from <stable+bounces-245221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:54:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF07650F65F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 15:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F8BF3016427
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0644D3F23BF;
	Mon, 11 May 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jOQvoowK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FuLTK+aX"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB153DA7E5
	for <stable@vger.kernel.org>; Mon, 11 May 2026 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507648; cv=none; b=M/IuQtQmpiHT+bG8tCKYHfn+mOOakDqowRzivowRCj4YgZE3EFcte3Q7K8Tll+tFd0cxC4U7jt0oLnt9bN1qbJGFPHmXy+CBUslO0tfPSfXEhP+EcPQUOcGqGdmIuP5PDZyGycbVGt7W5HG6+AZfe4/GbbCa8cTDGly56mNo2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507648; c=relaxed/simple;
	bh=dr5Mh/OBZjllUVTQ5PrZoOFd/gxEIigBwHA6Px7PttQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgkcJYT6bhRzSQgULr6+Hn7XLi+OBliVC5kcJ9kQM4urSNMQ2h7l7OPDk28jrxqm8Zcm7gzLvzjGCpq7crOeILXvXMMvoDDvTRnrk15I/IJQ7UnEGTjJrNM6biHy9l5avg39Yk2nys99XoSjLGxs0VYquXJxp4d1DgublWdgZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jOQvoowK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FuLTK+aX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zzr4Se1oURXIlnB24qCxYuS0qvjtQ0uCFxwLbMmBOtA=;
	b=jOQvoowKXaPF/dw593lSbuEdeaWrcF1RuAxImCNkdedmXI2L+f6Sctz1DCgnYmRilsqgGT
	OgTmi54I0iQtYNGFi+DyNrEn16o4gdS5xzAohFsT9Ei8vA2KRO++iWhuEfqd15Cdybz3fd
	JWZTLtHs3DQrUvfNQnZwf3dl+iuQCDHhnusP0aKsZv71+chAjPk1tsNuZPL0OZEm22puk0
	SEXhTOcEff12lEUL1HwRzsJJ0FkqHruz49eTH5fql+7XYN7caLJbtgJv5fKJxy3X/+oiUb
	EadlE040JpXtjT41fCXSCmvmUYyOZD8VLkEMYiwCXPd2t3fUrheNeMQXH4c4rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778507646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zzr4Se1oURXIlnB24qCxYuS0qvjtQ0uCFxwLbMmBOtA=;
	b=FuLTK+aXFQea/hN54W3mxpZBMJAgGNJJtevmbaH7OCNSlZrX749XlzzP929Nji2bQ5ri9D
	4Q7LAANv6YFey0Dw==
To: stable@vger.kernel.org
Cc: Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/4] ARM: stable backports
Date: Mon, 11 May 2026 15:53:53 +0200
Message-ID: <20260511135357.2786242-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CF07650F65F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245221-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable,kernel];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Action: no action

This is a backport of ARM related fixes. This applies cleanly to v6.18
and v6.12. I have an updated batch for v6.6 and v6.1 because this does
not apply cleanly.

#1 and #2 are prerequisites for #3.

Can't tell the origin of #3 (fix hash_name() fault). It might be there
since the begin of time.

#4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.

If there are no objections I would post the v6.6 version once this is
accepted and then rebase the PREEMPT_RT bits on top of this.

Russell King (Oracle) (4):
  ARM: group is_permission_fault() with is_translation_fault()
  ARM: allow __do_kernel_fault() to report execution of memory faults
  ARM: fix hash_name() fault
  ARM: fix branch predictor hardening

 arch/arm/mm/alignment.c |   6 ++-
 arch/arm/mm/fault.c     | 100 ++++++++++++++++++++++++++++++----------
 2 files changed, 80 insertions(+), 26 deletions(-)

--=20
2.53.0


