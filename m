Return-Path: <stable+bounces-245671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFE7LIw0A2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:09:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E10521FCB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E1BB308C19C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EFC3AA9E1;
	Tue, 12 May 2026 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EX2wMr1j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D313AA9D0
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594597; cv=none; b=sFkK2OlfazEJ1UvAKm6VG1nzJ8gSOEYots5AcklO0ZyOva3uEM3bJmksSwDlzzPkeljhJCqJTc7N1EXJCNXZUtKlQ23Shjn7W96j3Azs1umMXm2p0V0jdUmF+7ViQV5KsfPog63ZifBKgEkIm7zvsKH8KA1GER0VefVFN8KFcqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594597; c=relaxed/simple;
	bh=epowdHkbJLhUF2qoan9qSV1DgPSmxanJjmh3/npmA5s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JsYwRTibIfWwdcZ0dpInygh5HI0GyyTO0RnEcjGn/MxEdGxxyKSmDP7ozkQA6NpzadHQvQmdB73zWLLNDEh66X2FUaxOtDwE82DLNVl/sMRjPtWzE6mZ3ikKRNIc6//8yXXocnPSkKfZxiJPtBZg3cIVxxHXlj4hRWj5i25EM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EX2wMr1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677D0C2BCB0;
	Tue, 12 May 2026 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594596;
	bh=epowdHkbJLhUF2qoan9qSV1DgPSmxanJjmh3/npmA5s=;
	h=Subject:To:Cc:From:Date:From;
	b=EX2wMr1j48NG0uhgTtE0sxPBdFXat6paU1Jhl389TwGNFF2b2L0Gm5YGYurAtkBdy
	 AL0qELp2DnwinbSdPKRLDOvvG25lajK2rMCDmyuVYEvLs/70It8U0RN9B2Zw/8kE/S
	 nc+ASumaPjnCaVzi43ThCxrASpgseqjahdDo9iL4=
Subject: FAILED: patch "[PATCH] RDMA/hns: Fix unlocked call to hns_roce_qp_remove()" failed to apply to 5.10-stable tree
To: jgg@ziepe.ca,huangjunxian6@hisilicon.com,jgg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:03:21 +0200
Message-ID: <2026051221-alienable-handbag-23b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 48E10521FCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245671-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,msgid.link:url,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0c99acbc8b6c6dd526ae475a48ee1897b61072fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051221-alienable-handbag-23b4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c99acbc8b6c6dd526ae475a48ee1897b61072fb Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Tue, 28 Apr 2026 13:17:48 -0300
Subject: [PATCH] RDMA/hns: Fix unlocked call to hns_roce_qp_remove()

Sashiko points out that hns_roce_qp_remove() requires the caller to hold
locks.  The error flow in hns_roce_create_qp_common() doesn't hold those
locks for the error unwind so it risks corrupting memory.

Grab the same locks the other two callers use.

Cc: stable@vger.kernel.org
Fixes: e088a685eae9 ("RDMA/hns: Support rq record doorbell for the user space")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=9
Link: https://patch.msgid.link/r/15-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Reviewed-by: Junxian Huang <huangjunxian6@hisilicon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index f94ba98871f0..bf04ee84a943 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1171,6 +1171,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	struct hns_roce_ib_create_qp_resp resp = {};
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_ib_create_qp ucmd = {};
+	unsigned long flags;
 	int ret;
 
 	mutex_init(&hr_qp->mutex);
@@ -1257,7 +1258,13 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	return 0;
 
 err_flow_ctrl:
+	spin_lock_irqsave(&hr_dev->qp_list_lock, flags);
+	hns_roce_lock_cqs(init_attr->send_cq ? to_hr_cq(init_attr->send_cq) : NULL,
+			  init_attr->recv_cq ? to_hr_cq(init_attr->recv_cq) : NULL);
 	hns_roce_qp_remove(hr_dev, hr_qp);
+	hns_roce_unlock_cqs(init_attr->send_cq ? to_hr_cq(init_attr->send_cq) : NULL,
+			    init_attr->recv_cq ? to_hr_cq(init_attr->recv_cq) : NULL);
+	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
 err_store:
 	free_qpc(hr_dev, hr_qp);
 err_qpc:


