Return-Path: <stable+bounces-249093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGrPKS7ICWropQQAu9opvQ
	(envelope-from <stable+bounces-249093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2A25614F0
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67BF73019F08
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF4126B973;
	Sun, 17 May 2026 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhiAP5RV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377D1A9F9F
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025943; cv=none; b=KM69hiyfO2Exp29d+XOgB19dybGcGAlsNqiN8oOGKQFeUxtR6yceZVxrZC3rrM2vfblrSAg8Ps7cvMHRnMJe+TvLo131q6qFso1PtEz2EO3+qJzviogzAKDTCSAJ+z8W0tsLjn07TCVe2SA6aMLywFvwlyBw/XCNX9v/HCVy68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025943; c=relaxed/simple;
	bh=yvRThhtFRzgNLNcZCuDT8RcuBgO7/FLtuzpeOVLUW9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDfnqv2ZlBi8TvaVp/7ixWd0mj4JsuFZQ0whn5zYsWv46x+cetrXmxzC0+b4KFpvXtZ3I8Dh5q1XDr9HN5BCNh6RfGxktx9S0zldmTAfDgEQcY8DWJ0Bh5+6Gs64xAZII9JfNpN/P3mlAQlGH+5aNnO8qa3CnHLBHWl/06T+U9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhiAP5RV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2baca4df358so6989605ad.2
        for <stable@vger.kernel.org>; Sun, 17 May 2026 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779025941; x=1779630741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t7vRy14fAIhG2Wr4kGou1JDcvmH5z+z8GUCNDyefuA=;
        b=BhiAP5RVnssOdyMMW3sT74bM4e4o+oiqPzeOm6hNPJMKOjVaQ4Fxj3J4dbg0qZNr7Z
         XM3cr5Rd37AO7AB70CkJUXU9Qa0UP4aWPc5TOIla705YFg0e54dknqTAV/ojSz0hEWG+
         j69n7ezzw56OaZLwflSliHCsqaQUyijnNvdc6I2FHeursV2P6qCMYMjWUGpeUb8rQE10
         dBEd+NFPDd6Uxmho0c+hDCTkFXaDO+cYQYOi8lNLWKs7A/bJhbtW0pReIC0BUA7b4QFc
         dJgwFK7faDWBtejq2360C2PGL74DlEVyYHvbzo0aFBGRqA362KrMRBB/ozVT/PzZdZl3
         oaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025941; x=1779630741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1t7vRy14fAIhG2Wr4kGou1JDcvmH5z+z8GUCNDyefuA=;
        b=WE8vibPr6JkI7x5fa836UNY7RYpmU3+tsxi5/weXgwf9gQ9tdF3pDHmwyob6/Io1IU
         DoCko2ASsJ6UVYjqAM8ofMBqduNhgDDcOBCVVmRPisoawq/XmCUAgHHYD7OXDCcUPV2n
         epBRe3X0IkO3tzyumez/HMW/ZgaN4JVBxGz6zKiMSrh1fMVi+RcGx2NU5uKs1qCG0a3y
         3BsqeiDmoUkgrbwpupJ0DJ0yyU6akKcN7PR68bEiV+e3j2wLqd3X8JHgRWChgGlWywHi
         QyGY6EUwIyMY7EntesV7uwoYFZoNkuKVKbtsvpZKa0q2Qfy3edeUDxJUFQU3v+ZV9JX3
         l3cA==
X-Forwarded-Encrypted: i=1; AFNElJ/U2OQ+PFThAVXD6gnhpHYFKB3teSNx9piruDGWcVu5zvGwgozljszbHeF1FsK7BtDiHh+6+6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YznDnRtiYZySwho/Fp/fsa6bmAhe1AUMXDP5NDq22bzQArEk6fh
	4cKKa2gRFFu2IIZQsTQPs+4hOd1JLL6b7Eq8iuew43Olj5JMx/HLmKFT
X-Gm-Gg: Acq92OFkbyM1nHeoREHuIlikn9Xl3N0Vygte1w+bX5Y8+lGsdE4+kmwD6epLVuh7xf4
	PXw/5dX2/6JGZ+h4y4N5vooeBRqehnkIPGlXCMos2aFjmP3NaNLaI15NyW/ZPJ9rMwCtfr2jxZ/
	vmUXo4liN8L8ujuGQd6ocdSqcot8gdAxxcehWasB434eVnhdb2Kg0uel7THlzmhdq0EP+i1jUmU
	I1qHf2tieWBjY3InV7H0jWtuhl6wTLFrzUW7xZhkAMLoxHQsjwYt3F+SVDmTnySAaGQySMhFNJ4
	i6rAtYQoIxQttth6uA2YWLmj62F/IWZKydXKQGT3rkiTpI0wZybERX6sHG6v68MfY+M1KbcsVqE
	OdNlGztAYE1sLRrYS6fbzNgIsxxXrCblTKmYHXoKSG0+qBbRP8EW3l/lN/vUc2hAkgsnlZ2sZfq
	dNj5yqcZK3dxaRAL41zxU5FF1c2vT4AdoiSE4W1ifVLPuRjcUa
X-Received: by 2002:a17:902:b60a:b0:2bc:b366:4731 with SMTP id d9443c01a7336-2bd7e9b8086mr84503465ad.31.1779025941162;
        Sun, 17 May 2026 06:52:21 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fc47sm113873385ad.10.2026.05.17.06.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:52:20 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 1/4] HID: wacom: validate report length for PL and PTU handlers
Date: Sun, 17 May 2026 22:52:12 +0900
Message-ID: <20260517135215.2220117-2-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
References: <20260517135215.2220117-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A2A25614F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249093-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinmo44yang@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

wacom_pl_irq() and wacom_ptu_irq() access fixed offsets up to data[7]
in the raw HID report buffer without validating the buffer length.
These sub-functions are called from wacom_wac_irq() which receives the
length parameter but does not pass it to the handlers.

A malicious USB device can declare a small HID report in its descriptor
and send a matching short report that passes the HID core size check
(csize >= rsize), but the driver assumes a full-size hardware report
layout, leading to slab-out-of-bounds reads.

Add minimum length checks in wacom_wac_irq() before dispatching to
wacom_pl_irq() and wacom_ptu_irq().

Fixes: 4104d13fe019 ("Input: move USB tablets under drivers/input/tablet")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
 drivers/hid/wacom_wac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index da1f0ea85..6d06842b6 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3453,6 +3453,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case PL:
+		if (len < 8)
+			return;
 		sync = wacom_pl_irq(wacom_wac);
 		break;
 
@@ -3464,6 +3466,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case PTU:
+		if (len < 8)
+			return;
 		sync = wacom_ptu_irq(wacom_wac);
 		break;
 
-- 
2.53.0


