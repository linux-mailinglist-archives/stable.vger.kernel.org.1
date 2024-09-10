Return-Path: <stable+bounces-75633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52C9737AA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 14:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F81A288E2A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB91917C4;
	Tue, 10 Sep 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7MlcYJy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE70184522;
	Tue, 10 Sep 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972007; cv=none; b=gZnpMKb/V2s/9jgyN+/ZYcjkzRLeFWmE4N2KJ/Mu7TxPDrQrGsNRPgGXnPXwnBTETbC0qQfpmM5NymbIhml2HgJHTOdNt36nnlF2gHECAxrLhJMUS3eljqW6+rmv64/u91bxCm6KHi+lcrI6nhXddrDii3ODIN0DU28vXe1Z72c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972007; c=relaxed/simple;
	bh=7o36PvgCdrSW8nk+DV+ultIJNeDQiKY0NK8w0v6rQOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sEbVzfFOh4elyREP29hPy2YaG5Kv36jsYblDj7VKOhHC6/zjQxtULaJcTBdRVXq8GP4Hb0M2WKdNv7hY/hkCwUfHk5niy4kw94eeov/8KaINgxv97r3r303nJRWB2++uhJ/6TPZip37TkEes7NmcYwiGRpjww3vpuZV7onqoNuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7MlcYJy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725972006; x=1757508006;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7o36PvgCdrSW8nk+DV+ultIJNeDQiKY0NK8w0v6rQOM=;
  b=B7MlcYJyu/CafkIedw5EvSiYOloN1f02JpLO950Dm00EagW/fJ1ellJ7
   9miFVa2Zelzau323r8Pp5MXkAzPW5O59zGgg8e5ROyTQF3ptj0LF7DuWN
   zDjWDOpaVQXVDIh4AhZXTk91Sv1VZC+5ARfcM3Q3G9QqYfUFA4D3xpKcE
   UET0QMwiF9VcPjaW1l4bwwpmFhqGQ+hqw5Li1j2PJQdmZYDMNwnRu90y5
   MiiT648qi4a0tmaq6HS5qHg1pCZoLXsYGF+26sAV3GJQb8AkVZod+0qjT
   mr2uUCqSJG+0z4jhKswbxNmTJ0kv7XWev3bn69ZxgewFZOaf5jb6Qq6Y3
   w==;
X-CSE-ConnectionGUID: vaxrBaUxQDmF00uzab6KpA==
X-CSE-MsgGUID: qpQMghIKTxeRKnxZFolfWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28605854"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="28605854"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:40:05 -0700
X-CSE-ConnectionGUID: 2jmppOX+Ty+/TnGLgBojPA==
X-CSE-MsgGUID: jsKw4KNuR/yTnGgG0wVynQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="67260782"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.155])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 05:40:01 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	krzysztof.kozlowski@linaro.org
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix programming slave ports for non-continous port maps"
Date: Tue, 10 Sep 2024 15:40:09 +0300
Message-ID: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prop->src_dpn_prop and prop.sink_dpn_prop is allocated for the _number_
of ports and it is forced as 0 index based.

The original code was correct while the change to walk the bits and use
their position as index into the arrays is not correct.

For exmple we can have the prop.source_ports=0x2, which means we have one
port, but the prop.src_dpn_prop[1] is accessing outside of the allocated
memory.

This reverts commit 6fa78e9c41471fe43052cd6feba6eae1b0277ae3.

Cc: stable@vger.kernel.org # 6.10.y
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi,

The reverted patch causes major regression on soundwire causing all audio
to fail.
Interestingly the patch is only in 6.10.8 and 6.10.9, not in mainline or linux-next.

soundwire sdw-master-0-1: Program transport params failed: -22
soundwire sdw-master-0-1: Program params failed: -22
SDW1-Playback: ASoC: error at snd_soc_link_prepare on SDW1-Playback: -22

Regards,
Peter 

 drivers/soundwire/stream.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 00191b1d2260..4e9e7d2a942d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1286,18 +1286,18 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
 					    unsigned int port_num)
 {
 	struct sdw_dpn_prop *dpn_prop;
-	unsigned long mask;
+	u8 num_ports;
 	int i;
 
 	if (direction == SDW_DATA_DIR_TX) {
-		mask = slave->prop.source_ports;
+		num_ports = hweight32(slave->prop.source_ports);
 		dpn_prop = slave->prop.src_dpn_prop;
 	} else {
-		mask = slave->prop.sink_ports;
+		num_ports = hweight32(slave->prop.sink_ports);
 		dpn_prop = slave->prop.sink_dpn_prop;
 	}
 
-	for_each_set_bit(i, &mask, 32) {
+	for (i = 0; i < num_ports; i++) {
 		if (dpn_prop[i].num == port_num)
 			return &dpn_prop[i];
 	}
-- 
2.46.0


