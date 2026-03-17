Return-Path: <stable+bounces-226021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DguMmRbuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:47:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BC72AB301
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86006306B4D5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C98E2BCF5D;
	Tue, 17 Mar 2026 13:44:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0930B270540
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773755054; cv=none; b=KFSsarD7UxSYcCVUbU9w9WSgc7MYkqXTuwyp4Lsgv3JMDmz51U1xH+byStRMyFRyf/GVmBRMOzlrk4gm1X8JGi58w7fTMTozSUgFcSTfBAk93NzI58PRixR1tUu1CAZDqgGDb+z8modntTfMw6mEcDsDTSGSOA6zY92cz6mo0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773755054; c=relaxed/simple;
	bh=XYjZHTppgKs5SbL5+cLw3qL+6wVoZ+Un/E4/O0lTWOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOAqPKeUyCGGbKgV2miVANHd2uGsD74OV2mpWy+JLbiw7S2S/DM5mShob+8BnjOPP+azsQcMK5v55Gt9iK5cRLJJKKAhV/oZNXMXecQ/C8p5twuF6480Qeon0KBbc1lWkOBAh2rah55Qcxm6g91ERwlsBYga26zOB4W2Q2rcFJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 57D0748A3B;
	Tue, 17 Mar 2026 14:44:03 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: 
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/xe: allow request_irq on GSC interrupt
Date: Tue, 17 Mar 2026 22:43:14 +0900
Message-ID: <20260317134351.3350-2-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317134351.3350-1-Simon.Richter@hogyros.de>
References: <20260317134351.3350-1-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[hogyros.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226021-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[Simon.Richter@hogyros.de,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,hogyros.de:email,hogyros.de:mid]
X-Rspamd-Queue-Id: 28BC72AB301
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The default flags for freshly allocated interrupts are platform dependent,
and apparently powerpc and arm set IRQ_NOREQUEST by default.

The normal path is to clear this flag from irq_domain_associate_locked(),
which wraps the irq domain's "map" function, but the xe driver does not
define an irq domain and instead allocates the irq descriptor directly, so
the flags need to be set up manually as well.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6468
Fixes: 87a4c85d3a3ed579c86fd2612715ccb94c4001ff
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/gpu/drm/xe/xe_heci_gsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
index 5af8903e10af..3c4972a9922c 100644
--- a/drivers/gpu/drm/xe/xe_heci_gsc.c
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -39,6 +39,7 @@ static int heci_gsc_irq_init(int irq)
 	irq_set_chip_and_handler_name(irq, &heci_gsc_irq_chip,
 				      handle_simple_irq, "heci_gsc_irq_handler");
 
+	irq_modify_status(irq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	return irq_set_chip_data(irq, NULL);
 }
 
-- 
2.47.3


