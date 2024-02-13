Return-Path: <stable+bounces-19707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AF38530A2
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 13:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C631F225D6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A5C3D387;
	Tue, 13 Feb 2024 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJpEnJvV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26382EB12;
	Tue, 13 Feb 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827909; cv=none; b=jl2pA5YysU8z2Z7a8tvL9DQUXubEaybg3PBuvNgWEmJa6rXMWFhtzv2QeUl1V8dPJF5QPaJbDJYmSa6CPKYE7c3t9GFKTWdFOX2ivs2RZvrvEA3YzK86LKTC3Eb465+VCmfOBtzMWoEzjj4h+adE3rKy7ZwdlaZNgb9PVI79OBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827909; c=relaxed/simple;
	bh=1Li3WHJxxBd28UxYdFX2GoMG0GgTYRJL+I8HY3/mw2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tA/+lkcyqDX/8lFRjh4y27VnzTFsgwcdxU7/YdY07NjEF+hAGIHar/ZAoxMLjt9e3PYkKAx8LbUQHXB46hDaAl6YpRBwRn/ddpjBz78m/Tb7Ug98b/MdL6Rjn1eUu6IJnM6eufbMb0Z4oJqdvOc4ycqDPeh9kUBspxrzOeGCqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJpEnJvV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707827908; x=1739363908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1Li3WHJxxBd28UxYdFX2GoMG0GgTYRJL+I8HY3/mw2s=;
  b=SJpEnJvVrN5t65TywNkSwUohnSwI4kQxAZ4zegxNlYMYJukvIIZNMmlJ
   Jkjpwdne8Ja0Dr5QEqKLouwI3Wdl7KBmdxKKf63Hbyj0DuystDVaLe2Te
   XhOGFjM/GZ0BdFcTB8iW4V1eFMdq73AMJfWPkLSEnLpCDnaCRCedymp4S
   +xWwi/0teWOjXBnxXOnWR534yuRmEdgFpIFuWb3Z8vYiGmB6g1iQLRmL5
   QrVTiampOaNgyRNfgzQpwyi1byBTDYB+l9zuF04gwWSH3cRTgDmIbJM99
   9Krkg+C9WO+oruEpjs7B3j0P1yEzXu0jqCYw5VAY/wVosOScV2wcixI85
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12921878"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="12921878"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:38:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="7456411"
Received: from dcoroian-mobl.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.249.42.253])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:38:24 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	timvp@google.com,
	cujomalainey@chromium.org,
	daniel.baluta@nxp.com,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: IPC3: fix message bounds on ipc ops
Date: Tue, 13 Feb 2024 14:38:34 +0200
Message-ID: <20240213123834.4827-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Curtis Malainey <cujomalainey@chromium.org>

commit 74ad8ed65121 ("ASoC: SOF: ipc3: Implement rx_msg IPC ops")
introduced a new allocation before the upper bounds check in
do_rx_work. As a result A DSP can cause bad allocations if spewing
garbage.

Fixes: 74ad8ed65121 ("ASoC: SOF: ipc3: Implement rx_msg IPC ops")
Reported-by: Tim Van Patten <timvp@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc3.c b/sound/soc/sof/ipc3.c
index fb40378ad084..c03dd513fbff 100644
--- a/sound/soc/sof/ipc3.c
+++ b/sound/soc/sof/ipc3.c
@@ -1067,7 +1067,7 @@ static void sof_ipc3_rx_msg(struct snd_sof_dev *sdev)
 		return;
 	}
 
-	if (hdr.size < sizeof(hdr)) {
+	if (hdr.size < sizeof(hdr) || hdr.size > SOF_IPC_MSG_MAX_SIZE) {
 		dev_err(sdev->dev, "The received message size is invalid\n");
 		return;
 	}
-- 
2.43.0


