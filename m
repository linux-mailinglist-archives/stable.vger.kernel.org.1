Return-Path: <stable+bounces-230433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOcSDgznxGkz5AQAu9opvQ
	(envelope-from <stable+bounces-230433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 08:58:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 398D8330BEA
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 08:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 942E8301F582
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0D839A062;
	Thu, 26 Mar 2026 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NkocM0MA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B622A49659;
	Thu, 26 Mar 2026 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511767; cv=none; b=I+8BHbyRKJbir1iy/3Q35YeI8LqdZ4Td/wIiFKE3y1I3tdkwk3NWS2TwBW7reudnz4V/KH4+38pul4Oq+0bbRUWjP3nobaO0QuvWuuQZKklEksEf3EQVz9OhpARf5gX4gVU7Rhv7zutHTG0bHqxyq+5IVlFGxv9AvrmHiwU2Dis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511767; c=relaxed/simple;
	bh=Vsfgvb9N+AKlcN7M0p4Ewk9qLtWkkUUF83yrMJWhjaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ty7dOM+PaScsCrTL8XJYHM3xmoLt0+79eimc7OKwcqWeb+im6mfSpNFCQyRWp/dKpzLC/4r7ySV0gGbo70ebY8TUmHjbnONkzWYlx+0V/4c2vXRBKxSQGOXBgkHE886fSp0gZTykLK5fRxfU0/HWIKH6twqa47+Fj9SBvMeLIHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NkocM0MA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774511767; x=1806047767;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vsfgvb9N+AKlcN7M0p4Ewk9qLtWkkUUF83yrMJWhjaw=;
  b=NkocM0MAXET/6Ep99jE/rEq5eHQXNV9goovmHV2G6y0fHU0CbRenlReM
   QMkpm34rIgX2XosLl8iPkY6IgRiuSkOtpDpb5y6mDdYLzILD5AAqg3FdA
   F7RV+NC3ILHxb03feuuzb3H2svBZny61SGlJDdCbigs2pzyYYEvEtHl2u
   oz8DHX0Ls9gaZTkSXCs/LG72Of0YAk/Db+Yasmtf4nU4jF1SkKUNKJiQE
   w+HpiOyHp/0UAn48HUrQTQXLKyaQciOEoDFq2JkoHvem94qU8p2mhYglS
   jfd2j59PsQCQsE0kqmj1mlBe7cnEv1jSpYBEnWWRJHkmeOPxAUp8SVmVP
   Q==;
X-CSE-ConnectionGUID: GAvZMFDQQn2hKdfazdTYVg==
X-CSE-MsgGUID: 4WENHPUKRx+q6MCLiug10Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75629156"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75629156"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 00:56:06 -0700
X-CSE-ConnectionGUID: Wd9q71NhREm9LZTDGigEOA==
X-CSE-MsgGUID: fb5j3yT7QYyPaxD8pcpXVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="225187419"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.219])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 00:56:02 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	seppo.ingalsuo@linux.intel.com,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH for 7.0] ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload
Date: Thu, 26 Mar 2026 09:56:18 +0200
Message-ID: <20260326075618.1603-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230433-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 398D8330BEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It is unexpected, but allowed to have no initial payload for a bytes
control and the code is prepared to handle this case, but the size check
missed this corner case.

Update the check for minimal size to allow the initial size to be 0.

Cc: stable@vger.kernel.org
Fixes: a653820700b8 ("ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
Hi Mark,

The patch that this is fixing is in 7.0-rc which is marked to be
backported [1], so I guess this patch will follow it in this way or need
to point to the older patch to be carried back?

[1] a382082ff74b ("ASoC: SOF: ipc4-topology: Add support for TPLG_CTL_BYTES")

Regards,
Peter

 sound/soc/sof/ipc4-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 82f1e44a145e..76812d8fb567 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2951,7 +2951,7 @@ static int sof_ipc4_control_load_bytes(struct snd_sof_dev *sdev, struct snd_sof_
 		return -EINVAL;
 	}
 
-	if (scontrol->priv_size < sizeof(struct sof_abi_hdr)) {
+	if (scontrol->priv_size && scontrol->priv_size < sizeof(struct sof_abi_hdr)) {
 		dev_err(sdev->dev,
 			"bytes control %s initial data size %zu is insufficient.\n",
 			scontrol->name, scontrol->priv_size);
-- 
2.53.0


