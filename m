Return-Path: <stable+bounces-237678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPnNDwB53WnbegkAu9opvQ
	(envelope-from <stable+bounces-237678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:15:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975353F4375
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76C5A302F404
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE08C39BFF6;
	Mon, 13 Apr 2026 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b3HldwT2"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99963502AA
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122103; cv=none; b=exJxgrktk/Hri5LaqTblkRDB3tFbm5F1i4sUc1Lx4GImukqWRsfL5TmZilfLNUJ2xTLODDICxOfREEn1GIOPXv1Y6CVpEfqSO6UGEcPqaplfFOIztNZgXAHILRplEo0QqX8+6d5XBEG7gY6ETgUHocUcE/HNfUNr5q6RAKDZXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122103; c=relaxed/simple;
	bh=tkXkkvK9eH1CjWEIWFKzD0lsEi5tPM5Eh1RlW5DSWYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sbt5VQm/cfN7s0e2KK3YgUS1Gjko+MAN30c2rPxkRzK0iccQzfXd1QEnbhdVtAsPR7eY83/Xb48DH35nIDjJ2OF2Jq3oIAdJVx5VVxFUjjeDSnaiXXCf0O5CtrcD/kRjSk0u4h5+qLLS8LnzQvPq64kx0Xqv/OmfQxXxIHiPbh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b3HldwT2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=L5NntwA7IQ37MjQk4NhzvbNpdjroZWxREwaiUAMJgaA=; b=b3HldwT2Rrax2oAmclJpIf5o06
	hrJ+H4k2fztKi9BDeqQq0fmYnJhZks0MS9VYvsDXIb7zdI0xJx5ENYLVEmAPpTcqLMQ1n+42BHX0A
	q1AlGF9u2NUrQ44l/8aZRq7QfKg8hXMWThRWdmtJc5BleV01FZLpNf857JvWGXMC6gLs2mYU+JBsU
	XQzH7uN4POhzfbtq+iLtzfHxuNFdNflbo59unxsi6B00rwz8L5WZ/6MDeAuSr+e57OzFrN787O6J3
	lE7ikZZAhNHriBi29f+HOYY8oi5ObvEs2lu4uNcziCfPT++V4uUvL/z3o5Wz2cnkfk/E1J1StMMj1
	WRpUDYXw==;
Received: from 186-249-145-49.shared.desktop.com.br ([186.249.145.49] helo=t470)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wCQUZ-00Fdt7-BH; Tue, 14 Apr 2026 01:14:55 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 6.12.y 0/2] backport: thermal: core: Address thermal zone removal races with resume
Date: Mon, 13 Apr 2026 20:14:49 -0300
Message-ID: <20260413231451.357918-1-mfo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026040820-overpass-barrette-bf09@gregkh>
References: <2026040820-overpass-barrette-bf09@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237678-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mfo@igalia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.034];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 975353F4375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a backport of upstream commit 45b859b07282 ("thermal: core: Address thermal zone removal races with resume")
which failed to apply to 6.12-stable tree, with one dependency commit
(not strictly necessary, but simple and makes the backport simpler).

Only minor changes were necessary in PATCH 2/2 (see backport comment).

Tested on v6.12.81 with the synthetic reproducers wrote for mainline.
Both scenarios fail (i.e., hit use-after-free) without these patches,
and pass (do not hit use-after-free) with these patches.

I could not perform further testing than the synthetic reproducers
(which exercise very specific code paths), so reviews and/or tests
are welcome.

Thanks,
Mauricio

Rafael J. Wysocki (2):
  thermal: core: Mark thermal zones as exiting before unregistration
  thermal: core: Address thermal zone removal races with resume

 drivers/thermal/thermal_core.c | 36 +++++++++++++++++++++++++++++-----
 drivers/thermal/thermal_core.h |  1 +
 2 files changed, 32 insertions(+), 5 deletions(-)

-- 
2.51.0


