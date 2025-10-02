Return-Path: <stable+bounces-183024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C067ABB2C3D
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 10:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2682519C26E0
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F842D3A9D;
	Thu,  2 Oct 2025 08:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Urhfvbli"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE282D372A;
	Thu,  2 Oct 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392289; cv=none; b=LBpd7fcQZoGlKLvKbR0OhLZdgRdsE3mTyHr4NJIadA6nbbJWrdMD8qzgvvfYJzIdk9XJxVdADKFmx6Dd35nsG2VMf9NlulYMxZM8MELzTA9xG8U9Kt99y4YCrGiD8bUZ1hSQePIFF/nMPq9MUnOG2i/1C0iOFkKNzSnPuSSGYHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392289; c=relaxed/simple;
	bh=By8ezujPNVPIIDRAbtAI0TBxBlQZC7gl4Yi+AzybT/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzfN9PsOjPKjf2rlCDgBIE0o8J4bXLMAd2qSyhY1uWbn6abwQ6RvN7wmdlZMbiFS5EJSO/D6YI9Eei63KAc6vR1h288L7ZKpXWUhQJzrRC71wSR8z5we0EGoJugjInGlUhRoLdoM0Kx1wj1w/Qq89JVw6tm+5uCXHE87VKMqcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Urhfvbli; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759392288; x=1790928288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=By8ezujPNVPIIDRAbtAI0TBxBlQZC7gl4Yi+AzybT/U=;
  b=UrhfvblicqjD7DJDeUM1JpkpgACLR+X3Swz2ixqeJEiTuB0OA6FbJI5I
   p70ppqejM6q5WwIQpy6Q562bh2STQGWO5Old6TerR19r20A+D7wjKjOUL
   lxDjKhbjrL+L7wX86HrqxvlIa7fOZIJDmPgPzCTEUlMriRx+BB1DACF8/
   q+AtUJvTrNbPg8t/G2ik/RpG11JvIDLchUw95m8IPC0nwQVaMROcdAByG
   rVG4xMB8XLrvN8pKo3oEJfm9ygDU06W8uTYolDkcbDEty/Tgj18kku/dF
   qOo/kOYW7a7JbWGvLukmBSnuf8rDAggnnASq7WFu40ClyL4VoYCw++mRE
   w==;
X-CSE-ConnectionGUID: PUKm48iYS3mHCAZUCz649g==
X-CSE-MsgGUID: 3wntjCGCTGWGEY81qcu93w==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="65524996"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="65524996"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:04:48 -0700
X-CSE-ConnectionGUID: YsmRBSnTT9a78UQaIVvceQ==
X-CSE-MsgGUID: qVQRMFyyTPeV1h17Inw0tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178268533"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:04:45 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ASoC: SOF: ipc4-topology: Correct the minimum host DMA buffer size
Date: Thu,  2 Oct 2025 11:05:36 +0300
Message-ID: <20251002080538.4418-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
References: <20251002080538.4418-1-peter.ujfalusi@linux.intel.com>
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

Cc: stable@vger.kernel.org
Link: https://github.com/thesofproject/sof/commit/f0a14a3f410735db18a79eb7a5f40dc49fdee7a7
Fixes: a2db53360203 ("ASoC: SOF: ipc4-topology: Do not parse the DMA_BUFFER_SIZE token")
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


