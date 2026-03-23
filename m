Return-Path: <stable+bounces-228313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOAmCnFOwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4432F49FC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E369304734B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992B3AEF58;
	Mon, 23 Mar 2026 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KDBVVWVf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE03ACEFE;
	Mon, 23 Mar 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274776; cv=none; b=gqvbSg4DJQZjxzzmG5Bv/3VZHdpW2JYGRbh79lgOAPfLfOdqRqOmzXkuC4I8xLm8mTeupVA7ws1oo0Au21vqY7NlJNfcpkqQuE7v6JZeY3fRes2lAbKVousfjxP5mrjL3IDfBPSkl1utL7JydxbXVVtS129L7XTQjoYjcxZT4Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274776; c=relaxed/simple;
	bh=Ydu9ktrHkKL7dpw1iZNVlingdylqJrrPczYvWohYRKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwickJu1I1bbrw9Dg2dXSShmLL2KXAni/ZmE8r2T8mqUk7l4Ky+V4x85dE4UyLHFhHVxKQCQuyfZt0CO9Jo8MaOv5aFv9t2s5xCxw10W6KePSMFPMw0P7dYxwOXbY9aWMXYdWSuke3iaOWwAEB+PIHY3DISERHB7sFe8E9nbnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KDBVVWVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5259FC4CEF7;
	Mon, 23 Mar 2026 14:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274776;
	bh=Ydu9ktrHkKL7dpw1iZNVlingdylqJrrPczYvWohYRKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDBVVWVfQ5I5OmZjdrKsm8GTjJ2c20PKt7UpSeCzUNmRcxgZ7i9q5ppUeAsurccjG
	 T5r7acq45T3ZatPgdlQdz0Rmgxe+A5t39MauSWV0h8oH847rvCmHPi8zTRFhilMMae
	 zCRcvlrbDQw7S4yUcnqw9uqxj6fOt7Q8sDYRaDX0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Genoud <richard.genoud@bootlin.com>,
	CHAMPSEIX Thomas <thomas.champseix@alstomgroup.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 105/212] soc: fsl: qbman: fix race condition in qman_destroy_fq
Date: Mon, 23 Mar 2026 14:45:26 +0100
Message-ID: <20260323134507.102127261@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228313-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8F4432F49FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Genoud <richard.genoud@bootlin.com>

[ Upstream commit 014077044e874e270ec480515edbc1cadb976cf2 ]

When QMAN_FQ_FLAG_DYNAMIC_FQID is set, there's a race condition between
fq_table[fq->idx] state and freeing/allocating from the pool and
WARN_ON(fq_table[fq->idx]) in qman_create_fq() gets triggered.

Indeed, we can have:
         Thread A                             Thread B
    qman_destroy_fq()                    qman_create_fq()
      qman_release_fqid()
        qman_shutdown_fq()
        gen_pool_free()
           -- At this point, the fqid is available again --
                                           qman_alloc_fqid()
           -- so, we can get the just-freed fqid in thread B --
                                           fq->fqid = fqid;
                                           fq->idx = fqid * 2;
                                           WARN_ON(fq_table[fq->idx]);
                                           fq_table[fq->idx] = fq;
     fq_table[fq->idx] = NULL;

And adding some logs between qman_release_fqid() and
fq_table[fq->idx] = NULL makes the WARN_ON() trigger a lot more.

To prevent that, ensure that fq_table[fq->idx] is set to NULL before
gen_pool_free() is called by using smp_wmb().

Fixes: c535e923bb97 ("soc/fsl: Introduce DPAA 1.x QMan device driver")
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Tested-by: CHAMPSEIX Thomas <thomas.champseix@alstomgroup.com>
Link: https://lore.kernel.org/r/20251223072549.397625-1-richard.genoud@bootlin.com
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qbman/qman.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 9be240999f877..43a4e8d58b9bc 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1827,6 +1827,8 @@ EXPORT_SYMBOL(qman_create_fq);
 
 void qman_destroy_fq(struct qman_fq *fq)
 {
+	int leaked;
+
 	/*
 	 * We don't need to lock the FQ as it is a pre-condition that the FQ be
 	 * quiesced. Instead, run some checks.
@@ -1834,11 +1836,29 @@ void qman_destroy_fq(struct qman_fq *fq)
 	switch (fq->state) {
 	case qman_fq_state_parked:
 	case qman_fq_state_oos:
-		if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID))
-			qman_release_fqid(fq->fqid);
+		/*
+		 * There's a race condition here on releasing the fqid,
+		 * setting the fq_table to NULL, and freeing the fqid.
+		 * To prevent it, this order should be respected:
+		 */
+		if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID)) {
+			leaked = qman_shutdown_fq(fq->fqid);
+			if (leaked)
+				pr_debug("FQID %d leaked\n", fq->fqid);
+		}
 
 		DPAA_ASSERT(fq_table[fq->idx]);
 		fq_table[fq->idx] = NULL;
+
+		if (fq_isset(fq, QMAN_FQ_FLAG_DYNAMIC_FQID) && !leaked) {
+			/*
+			 * fq_table[fq->idx] should be set to null before
+			 * freeing fq->fqid otherwise it could by allocated by
+			 * qman_alloc_fqid() while still being !NULL
+			 */
+			smp_wmb();
+			gen_pool_free(qm_fqalloc, fq->fqid | DPAA_GENALLOC_OFF, 1);
+		}
 		return;
 	default:
 		break;
-- 
2.51.0




