Return-Path: <stable+bounces-208290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66271D1B148
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 20:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E8D3301E1B8
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 19:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C904936C5A6;
	Tue, 13 Jan 2026 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lx3W1//z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDED30EF88;
	Tue, 13 Jan 2026 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333126; cv=none; b=mGfhYyu5A0dAS4+RLg5E+FWCFi7JFEYXm/YC3NtghbgG01YMrwbqrn5GA7wT6z7jIfF/NypBYQQL4DMom63mo7WdVuTz6g1QQn7jMPAenJ8+NO4g+5q1Jv5QTK541HvA5lGOrbY3+lzfCsLW5OdKPurzrasPNf/MFCRYsRVBohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333126; c=relaxed/simple;
	bh=jEtf1ydCCX46cmNa/3QR3V9ozblq9GLYYAgW3YJ8E94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCFLAzcJDMVkCkPJX8bFxjmZ8s+mUpup9tql/D3eFC4wP4EswqI4Zw6s9CaNGjY9Q2YCQm8++Np9KxpGOgwgF6ld8LrVkequgdlR5yFBBMweQpoLfL5GHq9KTnmOlOxb5NQ7bdUAgk8wYXbbyst8I5NtfKT5r0G7hwJ1jwk4L3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lx3W1//z; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768333125; x=1799869125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jEtf1ydCCX46cmNa/3QR3V9ozblq9GLYYAgW3YJ8E94=;
  b=Lx3W1//zzCuBGGKILF0Bh9j07xaFr4b6bzuErKACTUSs/RRo1+j2BIDj
   aFjshU8NZa0LTGpRe/7yGw84RmgB5HpvHe+QBo3x2FQTlrGlpH3sLqrDd
   ziQcuIILx0r7KPhKY5fXWPl9q4LLm56CSippg6pM3wwYQDlL53kzZaSWy
   a2VDtSVFig64t0ez1A0OzzCBNEASVPyC9TVGnzDR+39oanUdsw6OxyGAn
   L6mgyOYNNgyI08qn+4F8IPIty201RiZw4xEXymYFbW7yk3Wwly3XDdZeC
   kx02ON9Rn+AFgmahkOOufNoY3rItiyH+c1JVBMzG7kAiNWNrUu7K5jGM8
   w==;
X-CSE-ConnectionGUID: g9+5Wro6Rp+DvId/Uxnu0g==
X-CSE-MsgGUID: t2Un/i6aQ4mgCQLDOeZB7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80993504"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80993504"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 11:38:44 -0800
X-CSE-ConnectionGUID: Wk4Q4ESsRWaYfdnVw0F4dQ==
X-CSE-MsgGUID: kznnjLrFS9ymw2PuD78+/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="208629040"
Received: from kasadzad-mobl.ger.corp.intel.com (HELO soc-5CG4396XFB.clients.intel.com) ([10.94.252.226])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 11:38:42 -0800
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jakub Staniszewski <jakub.staniszewski@linux.intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	stable@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net 1/2] ice: reintroduce retry mechanism for indirect AQ
Date: Tue, 13 Jan 2026 20:38:16 +0100
Message-ID: <20260113193817.582-2-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
References: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>

Add retry mechanism for indirect Admin Queue (AQ) commands. To do so we
need to keep the command buffer.

This technically reverts commit 43a630e37e25
("ice: remove unused buffer copy code in ice_sq_send_cmd_retry()"),
but combines it with a fix in the logic by using a kmemdup() call,
making it more robust and less likely to break in the future due to
programmer error.

Cc: Michal Schmidt <mschmidt@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 3056df93f7a8 ("ice: Re-send some AQ commands, as result of EBUSY AQ error")
Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
Ccing Michal, given they are the author of the "reverted" commit.

 drivers/net/ethernet/intel/ice/ice_common.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a400bf4f239a..aab00c44e9b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1879,34 +1879,40 @@ ice_sq_send_cmd_retry(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 {
 	struct libie_aq_desc desc_cpy;
 	bool is_cmd_for_retry;
+	u8 *buf_cpy = NULL;
 	u8 idx = 0;
 	u16 opcode;
 	int status;
 
 	opcode = le16_to_cpu(desc->opcode);
 	is_cmd_for_retry = ice_should_retry_sq_send_cmd(opcode);
 	memset(&desc_cpy, 0, sizeof(desc_cpy));
 
 	if (is_cmd_for_retry) {
-		/* All retryable cmds are direct, without buf. */
-		WARN_ON(buf);
+		if (buf) {
+			buf_cpy = kmemdup(buf, buf_size, GFP_KERNEL);
+			if (!buf_cpy)
+				return -ENOMEM;
+		}
 
 		memcpy(&desc_cpy, desc, sizeof(desc_cpy));
 	}
 
 	do {
 		status = ice_sq_send_cmd(hw, cq, desc, buf, buf_size, cd);
 
 		if (!is_cmd_for_retry || !status ||
 		    hw->adminq.sq_last_status != LIBIE_AQ_RC_EBUSY)
 			break;
 
+		if (buf_cpy)
+			memcpy(buf, buf_cpy, buf_size);
 		memcpy(desc, &desc_cpy, sizeof(desc_cpy));
-
 		msleep(ICE_SQ_SEND_DELAY_TIME_MS);
 
 	} while (++idx < ICE_SQ_SEND_MAX_EXECUTE);
 
+	kfree(buf_cpy);
 	return status;
 }
 
-- 
2.51.0


