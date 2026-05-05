Return-Path: <stable+bounces-243975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BFWOZR9+WmZ9AIAu9opvQ
	(envelope-from <stable+bounces-243975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:18:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D894C6CAA
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC9C7304A09A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAA13C7DF0;
	Tue,  5 May 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SD/FGYq1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E23C2785;
	Tue,  5 May 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958144; cv=none; b=lPFohpO/m2I3G2FTOoWsR04gdpICpfT8BC/7kheiUGpNetPp/5tkdQFMIUvFxMYdocBDqUgn+ZnDspwsp/p3ALULx02KdCpsicAUXAiylodI6D/JPQR/s9aAvjswo3kXLNgv4WXrCogDrEP4DXnSdxflslmT+z7J3Z6plsTzktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958144; c=relaxed/simple;
	bh=XRWPwr6l1RtNzlOmlm4Rrmc0k4vQSq0Aasb1nYRLfZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jnn8ADR2QXpYO8wcQAEQi/QgEaIh2xpOo4/JyxrHbmLLnP/4AnL7+lejx95Ed0FQ/qR+v5vRmf88QAt11rvSmql18LgRU5GG1epTcXDsNwYFjney55+OjzIDDYNw7/PxbRjG7wO49cU34uzvh4Y+nLiilpTSD1aK/Ln7uQlUkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SD/FGYq1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958143; x=1809494143;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XRWPwr6l1RtNzlOmlm4Rrmc0k4vQSq0Aasb1nYRLfZQ=;
  b=SD/FGYq1HThPYJmMmVlpe32A7ZU6bYBt1qFyyq20SnvmKP/NmZ6WzaDN
   ubt2tuZtCXcP3+Yhrwe4lbZOiCD6Dx+QZdvcJkDqJVOkCFTplH5FlujTo
   iEMEZNasOfvKr50UThpIOEXd5CL+wlsvoc2PiMlHNvY0GysUmN+XiRSim
   d+ioIgKEG6lbCJUWZt4/tvWI/s77tTw82cgDx1FlugCmVqB8MwnFxKMye
   u0Nq/YihaOAZXy+dMH+vLbZS1pt3DV7lECK/DJcg01KTXLE2RSU2k8Qmc
   Nyl9F30gNiUnbJnGSdjAGYWdtFY0Y+cKViAAP8qqjBop8vzdB7qjlLvlX
   A==;
X-CSE-ConnectionGUID: lh5/kYL3T2yCHVop3rtW/g==
X-CSE-MsgGUID: QGk1T7jdTCWnvJ1TS5EXtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126469"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126469"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
X-CSE-ConnectionGUID: WZzNEPX+QTiRMy+z9haB/Q==
X-CSE-MsgGUID: oKhLxuY6TO2LoUeMEcGYNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683508"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:21 -0700
Subject: [PATCH net 08/13] idpf: fix double free and use-after-free in aux
 device error paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-8-a222a88bd962@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, stable@kernel.org, 
 Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2558;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=lcLWqa/kFQH155bW9j70SjcRR4tEHBtxdzaVazPjqAA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNd+m/d8Vdzg1ePefdcZO80IDP0ZmXl++a2M+b0F54
 blcB8ezHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEykvpXhn/7JmMt7Lbve2O2K
 +Mh8rX2NS2v5dBHWyHP++ubh7Ucnrmf4X7bsc7GIHleHV+f62qs3Ov9JsEa287Wufva1nGne95e
 WbAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 65D894C6CAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243975-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,mpg.de:email,intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: stable@kernel.org
Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
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
2.54.0.rc2.531.gaf818d63126a


