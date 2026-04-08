Return-Path: <stable+bounces-233794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMFwI2j91Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:02:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EB43B7D28
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D97C43011075
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31721364E88;
	Wed,  8 Apr 2026 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H85KjCyR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD8351C0D
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631716; cv=none; b=MI4Zbae615oDGuVu2MWrdqJMr6JlzVZW3QkRCBIRI1Pbv58KQDH3v4m/nSeVGmkfhqDQeaTB5gky6fPclH9w50/MQ2VOkfPa2omew6aUMm66prFeLbWYsdlmpMe1rd3tRv6NEQ2RYJ3V6vVAj7vzcMbgZh0wD+Nvo++lavLIakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631716; c=relaxed/simple;
	bh=mZoUGeuR+pxuqwii+NYBSvsBZwn6WFK21rv8fBde668=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=StgXwAEHJJPjqRI6itQINAuLwI6gMWOW8SModk7ro3eX+MJ4gYa8sBqL3AcFaJ9XhGIpfI9eSfGrGIHWeGnAPn88iKzyNLSEd7d3TA+Ud62HOS3dmEUtXaujrr6ZKQyVdi1FeRPdp3cHTe+6c+7KrrzFOC0QgSYI9hbLFbmXNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H85KjCyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AA9C2BC9E;
	Wed,  8 Apr 2026 07:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775631715;
	bh=mZoUGeuR+pxuqwii+NYBSvsBZwn6WFK21rv8fBde668=;
	h=Subject:To:Cc:From:Date:From;
	b=H85KjCyRd018NMvtoNCvY3cqPwnEnXk/r2BqWHn2ocpXTYErB1qVcvLbY/xj6W9iw
	 aNGytnfos0CXgZ/5KO3mItFCM3WHzqGM6DjbTG6lwHg4EfVxiNKMoGSHPRzQOtPX7h
	 M1Rwz1kvRTew2KF1QgjikWopiB2azfxwGUrMtvBM=
Subject: FAILED: patch "[PATCH] misc: fastrpc: check qcom_scm_assign_mem() return in" failed to apply to 6.12-stable tree
To: micro6947@gmail.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,xjdeng@buaa.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 08 Apr 2026 09:01:53 +0200
Message-ID: <2026040853-keg-enchanted-fd3d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233794-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,linuxfoundation.org,buaa.edu.cn];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,msgid.link:url,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 23EB43B7D28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6a502776f4a4f80fb839b22f12aeaf0267fca344
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040853-keg-enchanted-fd3d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a502776f4a4f80fb839b22f12aeaf0267fca344 Mon Sep 17 00:00:00 2001
From: Xingjing Deng <micro6947@gmail.com>
Date: Sat, 31 Jan 2026 14:55:39 +0800
Subject: [PATCH] misc: fastrpc: check qcom_scm_assign_mem() return in
 rpmsg_probe

In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
reserved memory to the configured VMIDs, but its return value was not checked.

Fail the probe if the SCM call fails to avoid continuing with an
unexpected/incorrect memory permission configuration.

This issue was found by an in-house analysis workflow that extracts AST-based
information and runs static checks, with LLM assistance for triage, and was
confirmed by manual code review.
No hardware testing was performed.

Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool access to the DSP")
Cc: stable@vger.kernel.org # 6.11-rc1
Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://patch.msgid.link/20260131065539.2124047-1-xjdeng@buaa.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 19cfc487df7c..1080f9acf70a 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2390,8 +2390,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		if (!err) {
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-			qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
+			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
 				    data->vmperms, data->vmcount);
+			if (err)
+				goto err_free_data;
 		}
 
 	}


