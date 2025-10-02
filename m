Return-Path: <stable+bounces-183060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B3BBB41B2
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD55422D41
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C03115A2;
	Thu,  2 Oct 2025 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HG8nW5gx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E414310655;
	Thu,  2 Oct 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413424; cv=none; b=qfP/JdjJGCxA1OKm0qQ99kcx9wMYYDEDGvbP4iwtNdvRy2brtAW8V8Axt/pb/8BiQM5DX0mbqn1UFQTSH2gUfGYnW/DfPahtB6AP3y/QjQWB6Nj2y/hUZzY7dA0TSQzV+LFuYcvq1X8c0rpVnqcGqU2vyodgaBQYm5d0dDYZCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413424; c=relaxed/simple;
	bh=qDL2g7o1Ga9AfjM5rEwMwKfXIXga9Owkr4OhV4F7SpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm0nrzSpytAOhXU79hCcr9BnSujIpUC1evU6C9SjAzB2MIhQwRrhPzn7QX6nCeScxLyPQAjSZf7wczluoudMYuvxb4utUd75SIPf8B/KYWEopEcr4zrXFuPsSZeayvoyRkxgcNPOD0SS5DA+c6rMD9Pq946kmM3Ka5lcaMSbuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HG8nW5gx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759413422; x=1790949422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qDL2g7o1Ga9AfjM5rEwMwKfXIXga9Owkr4OhV4F7SpQ=;
  b=HG8nW5gxMIxPb5bpdEu2OxlqXu+hj2l0v5cQdQRlk2nyCO7PNtqVJq4/
   XtDBtBJQ00Ep3fYgcu6EYLWC74sTmD58y8nbFe6pyWV0BJRQ77iUeUt7D
   9BZOyR8DukqjCerHln5D8hV17ydEH20kOELrsXd0AdMeAO/kcROOASrH7
   EZ5nu1DYKRcla/dPhxC0NQW5GqmSQcjxeSFKwqlGJ8sqW+/WVsAMJ99l0
   38DqONLzsfHqCmK5U7X8vAgKkoQzMZ6zSgzwmNBj8EJlx59VBaY70nTUG
   Rc1WEZzm4dgm1PzHAsvlQyrtZTRCiXUOzYRw5kFBPI/9apiGWzG6eQQ6G
   w==;
X-CSE-ConnectionGUID: UBgn2MSgRe+CT03ZCno6MQ==
X-CSE-MsgGUID: yG2GSvXAQem8ZClElD6vaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="49251134"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="49251134"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:57:02 -0700
X-CSE-ConnectionGUID: eIUyRM8IRQSbjVMQrxUURQ==
X-CSE-MsgGUID: 5zSbbh/fQCm11lp+27lG+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="179460660"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:56:59 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] ASoC: SOF: ipc4-topology: Correct the minimum host DMA buffer size
Date: Thu,  2 Oct 2025 16:57:50 +0300
Message-ID: <20251002135752.2430-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002135752.2430-1-peter.ujfalusi@linux.intel.com>
References: <20251002135752.2430-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware has changed the minimum host buffer size from 2 periods to
4 periods (1 period is 1ms) which was missed by the kernel side.

Adjust the SOF_IPC4_MIN_DMA_BUFFER_SIZE to 4 ms to align with firmware.

Link: https://github.com/thesofproject/sof/commit/f0a14a3f410735db18a79eb7a5f40dc49fdee7a7
Fixes: 594c1bb9ff73 ("ASoC: SOF: ipc4-topology: Do not parse the DMA_BUFFER_SIZE token")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index dfa1a6c2ffa8..d6894fdd7e1d 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -70,8 +70,8 @@
 #define SOF_IPC4_CHAIN_DMA_NODE_ID	0x7fffffff
 #define SOF_IPC4_INVALID_NODE_ID	0xffffffff
 
-/* FW requires minimum 2ms DMA buffer size */
-#define SOF_IPC4_MIN_DMA_BUFFER_SIZE	2
+/* FW requires minimum 4ms DMA buffer size */
+#define SOF_IPC4_MIN_DMA_BUFFER_SIZE	4
 
 /*
  * The base of multi-gateways. Multi-gateways addressing starts from
-- 
2.51.0


