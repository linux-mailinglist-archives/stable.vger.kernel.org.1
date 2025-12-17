Return-Path: <stable+bounces-202858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C19C3CC8863
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA4D304D4A4
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7925342500;
	Wed, 17 Dec 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RidJEmiW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D9346AD1;
	Wed, 17 Dec 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982364; cv=none; b=e2dQTKWPO9AbxL59DK94haIszgEXu/6X5+aSpGA3BpP5ZUbLvbxCnRjGgW0qIOZNC/Z5Gmdwrf8DmfjQdvSrGPL9GK5xnZNHAQ9ZQzK4+1AtZf5e5jJRdyrAtT85tTBVaxNG60d3Wz8OWgBvoxH3KhoP4QH7mxtnRjvfMAACgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982364; c=relaxed/simple;
	bh=5M/FreqJMCecssMHLNuLCbO16y1R8fNmAZPpdJa4Ulc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFNpR9Amv2qcYAqbdZU9IogpsqeJO8DUDwq4/SJh7uUQxaTxSd9UwRhEFXYGcHoZmzpyF3fAMMZkyr+jbFEFcl5HRuBKcFA8SYUib4BnggdqgWtM7JTOa3rxuxm7QG0gjd8Pz/sN2VsINqdOGVUdIIFSH/TKwyI+tNR4ko3fqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RidJEmiW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982363; x=1797518363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5M/FreqJMCecssMHLNuLCbO16y1R8fNmAZPpdJa4Ulc=;
  b=RidJEmiW+YwRJHnfxwougtiNJU1KH/giqFpWK1ywJBa3qOIQA/FrA04m
   9RxFNbjdmvELevaEOXzPOQD3MZCe0pCwgqLWv6e+pKTfUZz/wbapzTKIH
   3Ozognlgq+pqqi/9255nMUkmxeYBIac8Yuxuqs9oJSEntOd4i0Ryim9kE
   t94JZcDQ1Z8cc4u9j6keyynYX3UDb6GtO4ZVRFhPEY9iDL0qUvswLMrOW
   VMLYiKHWbefCYvIvgpdvygXTk7E/ieLktFz/7UW59kKqhq4snGrEUQ/ts
   6l9lRsa9SEN8I0jxuWDMqvv4LvWcjZjJwpHljxqp3IeLIAvMU9duisnUJ
   Q==;
X-CSE-ConnectionGUID: SEKOX55OQWKlVqsV41IRkA==
X-CSE-MsgGUID: AEg/r48IR0uqHt75g1b6Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859823"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859823"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:23 -0800
X-CSE-ConnectionGUID: JHT/dV9zQ/S9EGmyQxW9FQ==
X-CSE-MsgGUID: 1j6P33iCSd+e+wX6TL6jBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198084901"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:19 -0800
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
Subject: [PATCH v3 0/8] ASoC: SOF: ipoc4: Support for generic bytes controls
Date: Wed, 17 Dec 2025 16:39:37 +0200
Message-ID: <20251217143945.2667-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v2:
- correct the fixes tag for the second path

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


