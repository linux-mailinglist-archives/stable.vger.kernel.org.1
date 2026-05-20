Return-Path: <stable+bounces-252137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOLlMEz/DWpV5QUAu9opvQ
	(envelope-from <stable+bounces-252137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:37:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7638C596C66
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF54033BA304
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D623F8707;
	Wed, 20 May 2026 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bmovZeC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013C3EA953;
	Wed, 20 May 2026 17:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299889; cv=none; b=RPu96C3KpAcS2KL+IeKCoWuAcJQQ+N9pHm5oHjImmy22EJjZDfXWEkl7obS7Q4FRWgibO6Z++ga3M7YvuBg0gwMjvv8/DFhKSAX1yvaOvUQ8pBb+Qwu/rKD82nojQ+gdcSj1PsBhmIyZZhchbM3vrtp5aMHt7umPFFkLVu096pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299889; c=relaxed/simple;
	bh=QPLM0Tmt9o8B2VePd7PFQWQtZ9UpDAnV/XKj9cFTJfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVot3uXNajixRCVXXm2mIEBYSt6fUQOtWQvHNWEQ2b0CPKingjyK8x2UJNS/1Q84USjLKn8msy4gWYbcVX86zSIYhaBBIcZuXD7mi7xiVXx86xzrdnXyfafspRhxVyENs8Wm1zFIHVCCsnpAxH2gKvarNB6/R2WtpgHaxIZ684o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bmovZeC/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DDD1F00893;
	Wed, 20 May 2026 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299886;
	bh=HCp+HEcAFpLr8Go6UAD3AlvtjImqkaHxDbfcd1HguLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmovZeC/RzeNH8C3NnLXkO7pI7WrcZH6P56QRt5M8f0B3CR8g2hxC7NM1uNQGA6od
	 MPoLBNmoMr16p1g50Dj/rlL5dwJAOSBLzw30JXpyJTJAHgCHRXy3AGpcFLBGyTlCqp
	 XFV/RQHe99w+S0D7f8d7km5Kw9/M5RBoDDvdWHws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	stable@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 887/957] idpf: fix double free and use-after-free in aux device error paths
Date: Wed, 20 May 2026 18:22:50 +0200
Message-ID: <20260520162153.804940417@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252137-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,lunn.ch:email]
X-Rspamd-Queue-Id: 7638C596C66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 6c77b9510829a424d1b74409b7db9456e3522871 upstream.

When auxiliary_device_add() fails in idpf_plug_vport_aux_dev() or
idpf_plug_core_aux_dev(), the err_aux_dev_add label calls
auxiliary_device_uninit() and falls through to err_aux_dev_init.  The
uninit call will trigger put_device(), which invokes the release
callback (idpf_vport_adev_release / idpf_core_adev_release) that frees
iadev.  The fall-through then reads adev->id from the freed iadev for
ida_free() and double-frees iadev with kfree().

Free the IDA slot and clear the back-pointer before uninit, while adev
is still valid, then return immediately.

Commit 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev deinitialization")
fixed the same use-after-free in the matching unplug path in this file but
missed both probe error paths.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: stable@kernel.org
Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260506-jk-iwl-net-2026-05-04-v2-4-a5ea4dc837a9@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 7e4f4ac92653..b7d6b08fc89e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -90,7 +90,10 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 	return 0;
 
 err_aux_dev_add:
+	ida_free(&idpf_idc_ida, adev->id);
+	vdev_info->adev = NULL;
 	auxiliary_device_uninit(adev);
+	return ret;
 err_aux_dev_init:
 	ida_free(&idpf_idc_ida, adev->id);
 err_ida_alloc:
@@ -228,7 +231,10 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
 	return 0;
 
 err_aux_dev_add:
+	ida_free(&idpf_idc_ida, adev->id);
+	cdev_info->adev = NULL;
 	auxiliary_device_uninit(adev);
+	return ret;
 err_aux_dev_init:
 	ida_free(&idpf_idc_ida, adev->id);
 err_ida_alloc:
-- 
2.54.0




