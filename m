Return-Path: <stable+bounces-246258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFVyDupsA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:09:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D80FA526EB0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 268E530FBF36
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFA73EDE6C;
	Tue, 12 May 2026 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BIj45zHQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43853EDE6F;
	Tue, 12 May 2026 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608762; cv=none; b=mA0saKM/PZ2rAlixP/h/lFRiW8tSa/J6XFI/LRG7+iSA/TyUICwhr+/tBdqSV1zwlOpNbfp1L61vpj5XktGKqk8ALpDmpiEgrd2lCGf8ECAGIhNyyRj/XWslQWcJmah8OAMjjb29WVy3YveVeO4NkwFOoU5tw3bgpfcsjetpTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608762; c=relaxed/simple;
	bh=uTkc50oPPkrpq8/Gi7G4/poSvJKwUe+6jUZsLrwmRPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJxELWPjcYj4fouVNWlVip8QXjr8+vY+ANU8b4dGhmjiQX+n4ny/0KI0kbDyShVetJC/vFr+EK+03eaGd6HJVGG+qXmYBuagmGGw+uel2aRtuS29mmqbsWmtNVQ/I/XoqfGhxSKdgjIdYqNtepk5ORezxPK+GAMIIEilmOgvLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BIj45zHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A907C2BCB0;
	Tue, 12 May 2026 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608762;
	bh=uTkc50oPPkrpq8/Gi7G4/poSvJKwUe+6jUZsLrwmRPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIj45zHQ3TuKkN0I6T3vYZWEcbHzsRUJFjI01Y/zlaDha9DcpBgBmAZtlltVGkBpJ
	 8tX0ELxiE6D8oLxbX7RAF0bMtoBLCoApeEGWq30ws9wJk53A2BfpKUR4qH3TcHX2O8
	 EgJ3xa6YjMZZIKDTt8NfaSwPt2mPwFCMsy+owFlg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.18 204/270] RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path
Date: Tue, 12 May 2026 19:40:05 +0200
Message-ID: <20260512173942.745248554@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: D80FA526EB0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246258-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sashiko.dev:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit e38e86995df27f1f854063dab1f0c6a513db3faf upstream.

Sashiko points out that pvrdma_uar_free() is already called within
pvrdma_dealloc_ucontext(), so calling it before triggers a double free.

Cc: stable@vger.kernel.org
Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Link: https://patch.msgid.link/r/10-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -322,7 +322,7 @@ int pvrdma_alloc_ucontext(struct ib_ucon
 	uresp.qp_tab_size = vdev->dsr->caps.max_qp;
 	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (ret) {
-		pvrdma_uar_free(vdev, &context->uar);
+		/* pvrdma_dealloc_ucontext() also frees the UAR */
 		pvrdma_dealloc_ucontext(&context->ibucontext);
 		return -EFAULT;
 	}



