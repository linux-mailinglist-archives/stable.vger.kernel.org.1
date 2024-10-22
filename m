Return-Path: <stable+bounces-87681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D49A9BA2
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 09:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C250B23666
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE5155322;
	Tue, 22 Oct 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SB2sf2oZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2137A154C07
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583911; cv=none; b=rHXYWQQS/pqFhrhW6YVpQoGRZ0FjmRdhy76PsMKYv3ac57J2m6hbm9IlQrjKDV/6wva9oNQh/HlcreqRZBNHXUxIfB4BI2VN/QhMNsMEymZC7f1ZrLuxSNWh0rOGfa/RszLzvLBu6JjyqYdGbj09/yu7QuvlPXtsHRNuJz91RVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583911; c=relaxed/simple;
	bh=W8JmJTW/Ju6B8JsnPREvejbFjoLZX+zXwaUz/0YIYbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtBJCXgOSE9cdmo76ZdrsRFoKUCS7qxvVE4sO+aRxhVPb0ijUI7Lr0CJXDQjMm1iIbET3h7esNLI+tUrz/TwJ7rGZpsUP5u8xY6kXM1k8ddsziYSvtQ4txYBV/i1oeCa8XoRcfphF6ShaDgqArrMBjFz61xuqfYbR0xljzUVuyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SB2sf2oZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729583910; x=1761119910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W8JmJTW/Ju6B8JsnPREvejbFjoLZX+zXwaUz/0YIYbo=;
  b=SB2sf2oZ3n4/jSwZtox2AW8hZeWwNAWg8T5RlMoP5k9fDqrQwrU0ddui
   cT9QSfANSW8hKW73OusN1SAJzbkgxqv7HjOjiYZ0w2ZezlzxzDxMy5mbt
   PXu+YXUgY8ZinNSkrVlTnQrdifQN1d1MykaBuT2k2BZEC8pS4TBCq2vP9
   rZW4wrw9djOFpwAQwEq4sz8v7sbkTMGsRZQpPzPDIcApXfAG/OW738R4n
   PHQycyIEr1IXyX6AdB9WysHJZa0890/cW8WjVDURO7gFZh/LXCWUuSxKQ
   N3sYOYb/UHlXwChClb+NuVtko8Z5/g8j5OHzLMEkuv8dU4ToqJq1NzhPl
   g==;
X-CSE-ConnectionGUID: /mraxNpMTvCM2hL8o/MOww==
X-CSE-MsgGUID: icPXXvYjTLeICGPlJbTAtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="46587865"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="46587865"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:58:28 -0700
X-CSE-ConnectionGUID: kPQwIWCJRnWOFH1H7155og==
X-CSE-MsgGUID: NSU//8KmRY+k8Qn9X2K0yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79954781"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.97])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 00:58:26 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH stable-6.6.x 1/3] ASoC: SOF: ipc4-topology: Add definition for generic switch/enum control
Date: Tue, 22 Oct 2024 10:58:50 +0300
Message-ID: <20241022075852.21271-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022075852.21271-1-peter.ujfalusi@linux.intel.com>
References: <20241022075852.21271-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 060a07cd9bc69eba2da33ed96b1fa69ead60bab1 upstream.

Currently IPC4 has no notion of a switch or enum type of control which is
a generic concept in ALSA.

The generic support for these control types will be as follows:
- large config is used to send the channel-value par array
- param_id of a SWITCH type is 200
- param_id of an ENUM type is 201

Each module need to support a switch or/and enum must handle these
universal param_ids.
The message payload is described by struct sof_ipc4_control_msg_payload.

Stable 6.6.y note:
Fixes NULL dereference on Meteor Lake platforms with new SOF release
due to the use of Swithc/Enum controls.
Link: https://github.com/thesofproject/sof/issues/9600

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230919103115.30783-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 6.6.x
---
 sound/soc/sof/ipc4-topology.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index 21436657ad85..0fb759c6eeaf 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -319,7 +319,7 @@ struct sof_ipc4_copier {
 /**
  * struct sof_ipc4_ctrl_value_chan: generic channel mapped value data
  * @channel: Channel ID
- * @value: gain value
+ * @value: Value associated with @channel
  */
 struct sof_ipc4_ctrl_value_chan {
 	u32 channel;
@@ -343,6 +343,23 @@ struct sof_ipc4_control_data {
 	};
 };
 
+#define SOF_IPC4_SWITCH_CONTROL_PARAM_ID	200
+#define SOF_IPC4_ENUM_CONTROL_PARAM_ID		201
+
+/**
+ * struct sof_ipc4_control_msg_payload - IPC payload for kcontrol parameters
+ * @id: unique id of the control
+ * @num_elems: Number of elements in the chanv array
+ * @reserved: reserved for future use, must be set to 0
+ * @chanv: channel ID and value array
+ */
+struct sof_ipc4_control_msg_payload {
+	uint16_t id;
+	uint16_t num_elems;
+	uint32_t reserved[4];
+	DECLARE_FLEX_ARRAY(struct sof_ipc4_ctrl_value_chan, chanv);
+} __packed;
+
 /**
  * struct sof_ipc4_gain_params - IPC gain parameters
  * @channels: Channels
-- 
2.47.0


