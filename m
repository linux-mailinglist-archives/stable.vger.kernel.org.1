Return-Path: <stable+bounces-228295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNboNupLwWmKSAQAu9opvQ
	(envelope-from <stable+bounces-228295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A33DE2F42D4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C668E307B1CB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04703B47E4;
	Mon, 23 Mar 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BZUnf0FM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B853B47DE;
	Mon, 23 Mar 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274721; cv=none; b=ogWgcXYtZHaAOhInSXhStPN2id7NWeRpm/zG9fHxmxsTfCT2JwVPxj2a3yxzxb087yw5003iEyCqmR5Pc1+FJ46x4HABzBaH+4neQtginMZbdqtiNtFdh4u/bOIzklaCNuoSgd64KlYivgAr/q6BpEXozVsIqpFSMXBtukF8FBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274721; c=relaxed/simple;
	bh=3nKdF8mhpqLTq434zIp+K0yCTrlsklbttqk27/ovzQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUNaiwFs+awv6mRxRgkEFQaZz1qIVUW+veFMO/LSjj+AZ+I6hazXNsXhLGz0EYHL8BIiO/pLeRlenFNq1411RF3JaXUTjxK3hRgVn2hpWO8FRvodOFD6jaR1ochTZLKRe0qigxlBT2B4VDP/lOSUyu64S6jN2envEgabQOE7YVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BZUnf0FM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F77C4CEF7;
	Mon, 23 Mar 2026 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274721;
	bh=3nKdF8mhpqLTq434zIp+K0yCTrlsklbttqk27/ovzQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZUnf0FMvzC9Q5dPKAIOJVok6V7adVPfMadV2Py5N5s9peYER0HxxQZSL+fedbf4p
	 zdbkwRpC1S/BgilhRRnpq4itDDbUxCXLZYQc4KLzuN+OUR/wQ1Icc6fNJDDsMutddY
	 pjt5JDTB0yFfFwKsyEGEutYU6VEcTfRyC4CPAFlk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alessio Belle <alessio.belle@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH 6.18 088/212] drm/imagination: Fix deadlock in soft reset sequence
Date: Mon, 23 Mar 2026 14:45:09 +0100
Message-ID: <20260323134506.556994236@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228295-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A33DE2F42D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alessio Belle <alessio.belle@imgtec.com>

commit a55c2a5c8d680156495b7b1e2a9f5a3e313ba524 upstream.

The soft reset sequence is currently executed from the threaded IRQ
handler, hence it cannot call disable_irq() which internally waits
for IRQ handlers, i.e. itself, to complete.

Use disable_irq_nosync() during a soft reset instead.

Fixes: cc1aeedb98ad ("drm/imagination: Implement firmware infrastructure and META FW support")
Cc: stable@vger.kernel.org
Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
Link: https://patch.msgid.link/20260309-fix-soft-reset-v1-1-121113be554f@imgtec.com
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/imagination/pvr_power.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -509,7 +509,16 @@ pvr_power_reset(struct pvr_device *pvr_d
 	}
 
 	/* Disable IRQs for the duration of the reset. */
-	disable_irq(pvr_dev->irq);
+	if (hard_reset) {
+		disable_irq(pvr_dev->irq);
+	} else {
+		/*
+		 * Soft reset is triggered as a response to a FW command to the Host and is
+		 * processed from the threaded IRQ handler. This code cannot (nor needs to)
+		 * wait for any IRQ processing to complete.
+		 */
+		disable_irq_nosync(pvr_dev->irq);
+	}
 
 	do {
 		if (hard_reset) {



