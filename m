Return-Path: <stable+bounces-247903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGM8FCZpB2qZ2AIAu9opvQ
	(envelope-from <stable+bounces-247903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:42:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A05566C7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94F3430C10AF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93C3FF1CD;
	Fri, 15 May 2026 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QtrhFck+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE23FF1D5;
	Fri, 15 May 2026 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860369; cv=none; b=UhlblNFG9sacSABNT1UsF6ecFG9oYiNj5A0AdZNG/yKzLI12O7+YAn/wVDVCt4LzQyCD9zCwzHIHPnNqaJXm0RRUignFE1NIrq9Y7X0qw+8eTuGIctGtXX57Ergm3Cg2giI2Mg2p8RqjBmNcASEB/mRiZrKMTMVzI2gu6OZUDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860369; c=relaxed/simple;
	bh=wOPqWAp4L0MNR4N4eLK0oL6p5Z9C7s1m3m2wBE/ncYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGXZAOMBBpuJzxco/9YulpSemixpIf1zD5GiFYRtfZTXL3vq5wqB7Nuq+Nj3dC+nGjXEZu90wKbw6a7hba2cFC4brFzWucKR5iXo4iGJTO7PN37bkB400Ygk9aGqBbYqXXZhW3zxv16Xn/5LEeZ2C7XSjoHAzfPtgSizUAV2urw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QtrhFck+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E40C2BCB0;
	Fri, 15 May 2026 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860369;
	bh=wOPqWAp4L0MNR4N4eLK0oL6p5Z9C7s1m3m2wBE/ncYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtrhFck+NxsMXQ0MotphCAfFdJ984pC898KcaN1pYxg/68UE96Ad2wFwdwXrTW70E
	 aAGPRXrj1MIeWQo6URD07p9J3M/Au/21ci92dHSYCUqfT17OSHDaDVC8YClg5xjEqx
	 7ixX5ve7vhC2BxTlrcRQLmFWHy/1zstzOpwUn4r8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.12 020/144] media: intel/ipu6: fix error pointer dereference
Date: Fri, 15 May 2026 17:47:26 +0200
Message-ID: <20260515154653.964717970@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B56A05566C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247903-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Tidmore <ethantidmore06@gmail.com>

commit 8dd088b8b106f7b119664f965b691785998edcfb upstream.

In a error path isp->psys is confirmed to be an error pointer not NULL so
this condition is true and the error pointer is dereferenced. So isp-psys
should be set to NULL before going to out_ipu6_bus_del_devices.

Detected by Smatch:
drivers/media/pci/intel/ipu6/ipu6.c:690 ipu6_pci_probe() error:
'isp->psys' dereferencing possible ERR_PTR()

Fixes: 25fedc021985a ("media: intel/ipu6: add Intel IPU6 PCI device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
[Sakari Ailus: Fix commit message.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/intel/ipu6/ipu6.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -685,7 +685,7 @@ out_free_irq:
 out_ipu6_rpm_put:
 	pm_runtime_put_sync(&isp->psys->auxdev.dev);
 out_ipu6_bus_del_devices:
-	if (isp->psys) {
+	if (!IS_ERR_OR_NULL(isp->psys)) {
 		ipu6_cpd_free_pkg_dir(isp->psys);
 		ipu6_buttress_unmap_fw_image(isp->psys, &isp->psys->fw_sgt);
 	}



