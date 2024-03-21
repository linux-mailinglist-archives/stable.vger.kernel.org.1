Return-Path: <stable+bounces-28556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7928C8859A2
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 14:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C3628342D
	for <lists+stable@lfdr.de>; Thu, 21 Mar 2024 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C699B84A31;
	Thu, 21 Mar 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gaOXGXvs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1448405C;
	Thu, 21 Mar 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711026515; cv=none; b=i5ZGPqaGqxHbPjKbW9ZwJfqXoVrT6qT61tFQkGDvdi+/sZY2Nt3p6tdez/EYn2IAUdtXf/b7SLxmXLubtOSKZb2mJwXeQ9FXxlGudd+1LBdmi6LwrsGeFTJsw7GT5laIxjk331UEoCklZ7X+hxGgb861yoR92VKTetxLA7kB76E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711026515; c=relaxed/simple;
	bh=WsoSQZkGlz+fd8Vlgor7mRrcyeqvtpLqLmRK3+jjBzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ke3O0dAud5iDyqJYVaFJamTxdL2enaWyM/R6ZpTKrvqXq93KDYI5p/YGcRC0hHmKU/qFk6rfbcNxqCjDz+v0R2AgrMQCSQJwsCW29M2BtsRQZz0+yktUyBHcpMEXRzmPXDIvHHDmdWax5BCcefUhimJ1LnLSHef2IU4OJDCa0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gaOXGXvs; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711026514; x=1742562514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WsoSQZkGlz+fd8Vlgor7mRrcyeqvtpLqLmRK3+jjBzs=;
  b=gaOXGXvsaOYbGlxYxa0X8mk2hTt7SwiWigexcIEkB6WpwW9MJ4HA72Lj
   BziCCp5FH0XwSjL6AWV4tYZIhwOeg5H9dgWXmSmStEKc7oumHPgz8FxzY
   bh5hlD4N9cgjMZvoQM9uNCbScPO7bnA+G+8mPPbnQynrz1YlTdgBpBWqS
   YXPg75hTNhGlVlDAF6r/9SN7VaG6dXl/AlYQ83X7Bz5T5JvJG1CKt/Oz0
   ZM1G7FXIEHsyTc47bYx80OC2LKt73Bf7kQt81Lar5SEugn1FKx5Eyl6BL
   vFphvgpZcDwDuJVfDGQTVa1tyRDTmQq8n25Cuvy9LQAEBp4KH4azMgeip
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6127268"
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="6127268"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,142,1708416000"; 
   d="scan'208";a="51923326"
Received: from vyakovle-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.54.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 06:08:27 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH 16/17] ALSA: hda: Add pplcllpl/u members to hdac_ext_stream
Date: Thu, 21 Mar 2024 15:08:13 +0200
Message-ID: <20240321130814.4412-17-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
References: <20240321130814.4412-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pplcllpl/u can be used to save the Link Connection Linear Link
Position register value to be used for compensation of the LLP register
value in case the counter is not reset (after pause/resume or
stop/start without closing the stream).

The LLP can be used along with PPHCLDP to calculate delay caused by the DSP
processing for HDA links.

Cc: stable@vger.kernel.org # 6.8
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/hdaudio_ext.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index a8bebac1e4b2..957295364a5e 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -56,6 +56,9 @@ struct hdac_ext_stream {
 	u32 pphcldpl;
 	u32 pphcldpu;
 
+	u32 pplcllpl;
+	u32 pplcllpu;
+
 	bool decoupled:1;
 	bool link_locked:1;
 	bool link_prepared;
-- 
2.44.0


