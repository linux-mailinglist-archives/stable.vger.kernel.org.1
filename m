Return-Path: <stable+bounces-244461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJYpDMC3+2kXDwAAu9opvQ
	(envelope-from <stable+bounces-244461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:50:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1E84E0C06
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48937303816A
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C413B47D9;
	Wed,  6 May 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7iCvLGE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744B3B3C13;
	Wed,  6 May 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104163; cv=none; b=T6Oa75Efr1K10lsKlwTvUMrsdGwLIh+PhTjiK5+LWu+CtLU9hDtyaPS88+7xJT5Z7K/zI7lEido/v5rWUnsWpeSvhNga20SQLnrz1A8FrEEkTIQtW48UiFk4i7XGSGmeMLF7upbgjmT5lmqJLAMUpq1Ocd4z77fx87Ar5MdNMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104163; c=relaxed/simple;
	bh=XRWPwr6l1RtNzlOmlm4Rrmc0k4vQSq0Aasb1nYRLfZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qj2f80FGKlyjgjBLtH1CjNCztnXpcKBKP9R/uOadKJELDxef9ISZCuHjbyQxmo8wGd+Jbev0fi/FypHyPlvFffpDSiadzhPCxHkkFiOFNKYsk7059yfZzePNIhya+Mxjd2DpuYyTeWHEbOMunIbwXkMFY61HtNxxdnDyNIC2vww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7iCvLGE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104161; x=1809640161;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=XRWPwr6l1RtNzlOmlm4Rrmc0k4vQSq0Aasb1nYRLfZQ=;
  b=F7iCvLGEhAduuYjd2k7R5gHmkD9b0MMa/t5Wyu4Gay8Z1dX/mYEldEUY
   PFpGoJY+6od2uoFhCwV1KYzREu4ljadsQA9N+hnJj8LtyR1ls6YUVaDzI
   gCXvEzg8YG0TlPrHkas+JPFVjUj7hGaEkMOGYTXN1wzI1SDKhiO9NU+wf
   TH92xvU9yBqW9NEZ19lSG63tjLdo5yS5Dud2W6ydvhKyQowo1awf+fA59
   KEXK68rlMO3Vspgz16FEAYYmfHfnm9OO26raG825tSj177LXli0aElp0E
   sIo+PDDcbTprwLE5iTCsfWHKxKfAeKKQ/9teNRtysZwV3qrzxBf7x/9qa
   Q==;
X-CSE-ConnectionGUID: ZkDjRk/CSpukuHULbje/pA==
X-CSE-MsgGUID: Brv3t2PnQk+6m+nNWcHvow==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982508"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78982508"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:20 -0700
X-CSE-ConnectionGUID: Qn+o2goMQbiMx6z7wkFMxg==
X-CSE-MsgGUID: 0yy8dFR6Sz293DgtCHLaOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259698623"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:19 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 06 May 2026 14:48:13 -0700
Subject: [PATCH net v2 4/8] idpf: fix double free and use-after-free in aux
 device error paths
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-4-a5ea4dc837a9@intel.com>
References: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
In-Reply-To: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
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
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf22ME7554w/OxnTfyzJLyo9u2phUph19PMv/PI//rR
 oew+HGvjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACaiosDI8P/6ZNl/Cm/62j2/
 BYruu8u0qbM8tv3i0sPXXu09lFYg1c/wP7Erw2GjuKXVrXob1dMv6ra2fuizTjmS+OxMKHPnKp0
 J/AA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 7D1E84E0C06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244461-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,lunn.ch:email,linuxfoundation.org:email,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

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


