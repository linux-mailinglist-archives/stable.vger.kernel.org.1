Return-Path: <stable+bounces-246467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJhCH+FsA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:09:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AB0526E8F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0677E3049E6E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1270364959;
	Tue, 12 May 2026 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CZ2EC7lK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E2633ADBA;
	Tue, 12 May 2026 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609300; cv=none; b=SZjsTfp2lUv/wlCXL8TG6DZMVh/eFU1YzjLhlUguFZPdh0KCw4m39C+/h8O6JEtjNrOIeuW3fgxJn+y1Gp1RpaAc70yNTEkCDteISt5X7PMHPZjrDCnhGNPn+07+VHxDnKv+HSI2S4fsha6FP7CDkTj7/5MbRrMzQ9PAJ3O3BpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609300; c=relaxed/simple;
	bh=TRd5d6HZIgzDbzU68AArNTMFWVop0zjUAhMPZ9my/Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZ0AqgnHEVjxSVRdjd9dZozqx0XMLIH0FRRrmv90rhc1k6b4hXvOdk3eBYiT3RzVrXvoXanjrNxOW9GYNRvXYryufBBIOerEfts1trz4o4zfz7feWtQibB0gUw71qZQshs/G2K63ptWMHecEoK4r7cZMPefKV7yJeLACxUh9W8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CZ2EC7lK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B44CC2BCB0;
	Tue, 12 May 2026 18:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609300;
	bh=TRd5d6HZIgzDbzU68AArNTMFWVop0zjUAhMPZ9my/Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZ2EC7lK2tTtdxqKmfwa634M7mFzphzLXnygN2EIwZbi0SSHeqD0/o58G9NLpMyXI
	 tgTlnyOAJI500oVTX8mJzps6DAgY5XbVAqRVT5N1ToJHqK2Q0viS0ao9hw+NnSYnYA
	 jIJFyQBgPK8UJQ+IA0sJM6E0q+UxQ80NJ0ieIdgk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 7.0 115/307] pseries/papr-hvpipe: Fix & simplify error handling in papr_hvpipe_init()
Date: Tue, 12 May 2026 19:38:30 +0200
Message-ID: <20260512173942.550141610@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 37AB0526E8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.ibm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

commit 713e468cdbc2277db6ce949c32c1acbd83501733 upstream.

Remove such 3 levels of nesting patterns to check success return values
from function calls.

ret = enable_hvpipe_IRQ()
    if (!ret)
	    ret = set_hvpipe_sys_param(1)
	        if (!ret)
		    ret = misc_register()

Instead just bail out to "out*:" labels, in case of any error. This
simplifies the init flow.

While at it let's also fix the following error handling logic:
We have already enabled interrupt sources and enabled hvpipe to received
interrupts, if misc_register() fails, we will destroy the workqueue, but
the HMC might send us a msg via hvpipe which will call, queue work on
the workqueue which might be destroyed.

So instead, let's reverse the order of enabling set_hvpipe_sys_param(1)
and in case of an error let's remove the misc dev by calling
misc_deregister().

Cc: stable@vger.kernel.org
Fixes: 39a08a4f94980 ("powerpc/pseries: Enable hvpipe with ibm,set-system-parameter RTAS")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/f2141eafb80e7780395e03aa9a22e8a37be80513.1777606826.git.ritesh.list@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c |   28 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -780,23 +780,29 @@ static int __init papr_hvpipe_init(void)
 	}
 
 	ret = enable_hvpipe_IRQ();
-	if (!ret) {
-		ret = set_hvpipe_sys_param(1);
-		if (!ret)
-			ret = misc_register(&papr_hvpipe_dev);
-	}
+	if (ret)
+		goto out_wq;
 
-	if (!ret) {
-		pr_info("hvpipe feature is enabled\n");
-		hvpipe_feature = true;
-		return 0;
-	}
+	ret = misc_register(&papr_hvpipe_dev);
+	if (ret)
+		goto out_wq;
 
-	pr_err("hvpipe feature is not enabled %d\n", ret);
+	ret = set_hvpipe_sys_param(1);
+	if (ret)
+		goto out_misc;
+
+	pr_info("hvpipe feature is enabled\n");
+	hvpipe_feature = true;
+	return 0;
+
+out_misc:
+	misc_deregister(&papr_hvpipe_dev);
+out_wq:
 	destroy_workqueue(papr_hvpipe_wq);
 out:
 	kfree(papr_hvpipe_work);
 	papr_hvpipe_work = NULL;
+	pr_err("hvpipe feature is not enabled %d\n", ret);
 	return ret;
 }
 machine_device_initcall(pseries, papr_hvpipe_init);



