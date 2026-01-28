Return-Path: <stable+bounces-212363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPq8L6Uzeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:04:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD5EA5079
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E0E5306C90B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E0303A15;
	Wed, 28 Jan 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B0UKmiWg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528B242D7F;
	Wed, 28 Jan 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615269; cv=none; b=D5/hewVnMn8bfk19t0NeG16HIYqG+hTNIGCCfPVrC/IVb+jvqW7hFsnB8TYx2ZxR0yjyImiaTesDPLzbr/HWo6nQYds2Ou8gb1K/7qSQkSoMj9B9Bq1yj6mgevRbQDmC66AsSQ7MME1RPTM9x+Mna2Io+LKe7xTk0L3uhejeub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615269; c=relaxed/simple;
	bh=UGkgN0We3p0cNpJoQMa0fwKJy8zieScxVXqgyP2vGgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OG66L11xEmfwTObAxpzhHVCocfbOB38XPRwo8eNP+mMkbRw8ugpuo1UicBkKea2z8HdYJ/8jbb1aOt+E9/md44LHsg3bmpq8QlkvsQUAvetk5qm7xa4JnEf7KKonh4MSGFy/idnLuZAXsqHXFBcP541VqQ3Qlac7+ck5mS/+stQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B0UKmiWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5357C4CEF1;
	Wed, 28 Jan 2026 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615269;
	bh=UGkgN0We3p0cNpJoQMa0fwKJy8zieScxVXqgyP2vGgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0UKmiWgK8GWe+3uhFz0p2ovAzzhhshB0CyZbkmbtPH8O9++kWhZ+wfkHPcHBUxYI
	 HIFBMyoUh+ZWlumNjpk58JNtabYlcZS0cj4zFsEfOhDuA5QtnuIalY4mTlpjwROcF8
	 XpTDRy5rBuZKaXBq0ptQxA3AG9+oBf6xPWJducNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ingo Franzki <ifranzki@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 6.12 129/169] s390/ap: Fix wrong APQN fill calculation
Date: Wed, 28 Jan 2026 16:23:32 +0100
Message-ID: <20260128145338.651897043@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212363-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFD5EA5079
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

commit 3317785a8803db629efc759d811d0f589d3a0b2d upstream.

The upper limit of the firmware queue fill state for each APQN
is reported by the hwinfo.qd field. This field shows the
numbers 0-7 for 1-8 queue spaces available. But the exploiting
code assumed the real boundary is stored there and thus stoppes
queuing in messages one tick too early.

Correct the limit calculation and thus offer a boost
of 12.5% performance for high traffic on one APQN.

Fixes: d4c53ae8e4948 ("s390/ap: store TAPQ hwinfo in struct ap_card")
Cc: stable@vger.kernel.org
Reported-by: Ingo Franzki <ifranzki@linux.ibm.com>
Reviewed-by: Ingo Franzki <ifranzki@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/ap_card.c  |    2 +-
 drivers/s390/crypto/ap_queue.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/s390/crypto/ap_card.c
+++ b/drivers/s390/crypto/ap_card.c
@@ -44,7 +44,7 @@ static ssize_t depth_show(struct device
 {
 	struct ap_card *ac = to_ap_card(dev);
 
-	return sysfs_emit(buf, "%d\n", ac->hwinfo.qd);
+	return sysfs_emit(buf, "%d\n", ac->hwinfo.qd + 1);
 }
 
 static DEVICE_ATTR_RO(depth);
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -268,7 +268,7 @@ static enum ap_sm_wait ap_sm_write(struc
 		list_move_tail(&ap_msg->list, &aq->pendingq);
 		aq->requestq_count--;
 		aq->pendingq_count++;
-		if (aq->queue_count < aq->card->hwinfo.qd) {
+		if (aq->queue_count < aq->card->hwinfo.qd + 1) {
 			aq->sm_state = AP_SM_STATE_WORKING;
 			return AP_SM_WAIT_AGAIN;
 		}



