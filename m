Return-Path: <stable+bounces-201049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D3ECBE484
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8090730402ED
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99733A007;
	Mon, 15 Dec 2025 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqKI5XN2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DBD22154F;
	Mon, 15 Dec 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808697; cv=none; b=dwIpMhWIzinUiTVo4XWADJLOfPgqQiZ3SE7xZu6v1wvR1gMH4kuCtuq6eBKf1qBEBRCXrX3GXrdt882lBzbTc6M0Sn+QmybUUe/Bccl/t/W4wSONP+KE1dMr8jAC+oHKjDTS7aUIFWRT+mcR8XtnfVcVEvnk+ibywLnGXz6tM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808697; c=relaxed/simple;
	bh=0SIqFN+aSL2MrXoJ9ZS+Avu09jhsKJVQGDLj3CWsDvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Md7xKlLnTgUCKqCajfbgVQtKUcm7QCJe+KScQU/weHjeSPWhK1n9ktKAcnPGIYRfJt1Wlla2AVaNcaG2nDob4dqrweTl/MoKzobzXFewYZ3weEIBHiOWkn/XRluMt50k9NcQAwfvuS8PZgXte2CRLF6My2TtCZS3HWefrYZtXBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqKI5XN2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808696; x=1797344696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0SIqFN+aSL2MrXoJ9ZS+Avu09jhsKJVQGDLj3CWsDvE=;
  b=FqKI5XN2uSov/UECIe7dZWyJn4kDJ4kcdwcj7YmmduSbLKe6JuY6R9Cr
   aEtJHzo5de8Xeel6Imvjg5XNWbSFwWMtw8vWieBcq4ypnxGdwF2ESHnDb
   RX0w57/K8ez+Dk0/SaNWq/N+2iaxSsm1rSTY08ukSxyxUrFXAUug+px8z
   TA9BXWgs93+KUPYdFbvpuAq8ssa+KjRsjV5G4MMMzC1mgCEuytXkKXCmR
   bcb3Pt9elgvzUA4g31HJ5ATIt2ia1V0Wuqj7IE3DlQXmvss6/Swoatb5O
   yWuLEWAyQPo9UG3CYO0cMl1DwGx+7/lbEVpbe/SMkG1zzoiZqdIeSnej2
   g==;
X-CSE-ConnectionGUID: 9w4W1Z6OQMm+Z+CpD8CjFQ==
X-CSE-MsgGUID: lqIn6+CWTviChmUzVoDiJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67866426"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67866426"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:24:55 -0800
X-CSE-ConnectionGUID: ++mSYpAUT6OWzFM3InmuZQ==
X-CSE-MsgGUID: A46CpvFbRJ6bU54YQbczWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197362346"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:24:52 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	seppo.ingalsuo@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2 0/8] ASoC: SOF: ipoc4: Support for generic bytes controls
Date: Mon, 15 Dec 2025 16:25:08 +0200
Message-ID: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v1:
- correct SHAs for fixes tags
- add Cc stable tag

We support bytes control type for set and get, but these are module specific
controls and there is no way to handle notifications from them in a generic way.
Each control have module specific param_id and this param_id is only valid in
the module's scope, other modules might use the same id for different functions
for example.

This series will add a new generic control type, similar to the existing ones
for ENUM and SWITCH, which can be used to create bytes controls which can send
notifications from firmware on change.

The new param_id is 202 and the sof_ipc4_control_msg_payload is updated to
describe bytes payload also.

On set, the payload must include the sof_ipc4_control_msg_payload struct with
the control's ID and data size, followed by the data.

On get, the kernel needs to send the sof_ipc4_control_msg_payload struct along
with the LARGE_CONFIG_GET message as payload with the ID of the control that
needs to be retrieved. The raw data is received back without additional header.

A notification might contain data, in this case the num_elems reflects the size
in bytes, or without data. If no data is received then the control is marked as
dirty and on read the kernel will refresh the data from firmware.

The series includes mandatory fixes for existing code and adds support for
sending payload with LARGE_CONFIG_GET when the param_id is either generic ENUM,
SWITCH or BYTES control.

Regards,
Peter
---
Peter Ujfalusi (8):
  ASoC: SOF: ipc4-control: If there is no data do not send bytes update
  ASoC: SOF: ipc4-topology: Correct the allocation size for bytes
    controls
  ASoC: SOF: ipc4-control: Use the correct size for
    scontrol->ipc_control_data
  ASoC: SOF: ipc4-control: Keep the payload size up to date
  ASoC: SOF: ipc4-topology: Set initial param_id for bytes control type
  ASoC: SOF: ipc4: Support for sending payload along with
    LARGE_CONFIG_GET
  ASoC: SOF: ipc4: Add definition for generic bytes control
  ASoC: SOF: ipc4-control: Add support for generic bytes control

 sound/soc/sof/ipc4-control.c  | 197 ++++++++++++++++++++++++++++++----
 sound/soc/sof/ipc4-topology.c |  36 +++++--
 sound/soc/sof/ipc4-topology.h |   9 +-
 sound/soc/sof/ipc4.c          |  45 +++++++-
 4 files changed, 252 insertions(+), 35 deletions(-)

-- 
2.52.0


