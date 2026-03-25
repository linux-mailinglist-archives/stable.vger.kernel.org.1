Return-Path: <stable+bounces-230384-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGsOEwA3xGnkxQQAu9opvQ
	(envelope-from <stable+bounces-230384-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:26:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E28AF32B370
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 20:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B6C03028ECB
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF673559C0;
	Wed, 25 Mar 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T29qZ/V2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F533542E5;
	Wed, 25 Mar 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466809; cv=none; b=TvfKJIru0s21xYR4h3NUwgEBEpaHb5w2QEv6OXQC44yQXyrzaBrp2IZMmhZuHddejJzkT2I5SOzTSxpa+AJdOTWNlCjy+RusgLZ2sDfLlQ7QwU+SGUbA04VieMm8EPbBDrtPwr5F9lpGeImZ4McmyIy5LCqpLYUijoiMeQX5zhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466809; c=relaxed/simple;
	bh=EUSJ4WHhXpBP/yrcWI3vj8IKzFI1fiOhCeYVPZCdZK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJHOyzJXMYQfMvHN/CyvPSShTjerwhewEgHx37yw3uWb9zlDGiHhveMP65Ap/uPtXrtn5Vgff0K9+OQpYwQWMLVBG1A25+ULrThSRA8pI/6YgHzjPbFA9ixoWcGQRxLr8RO7eSB6yFHre1pgnE0M/jN5j+LeJsN0XKLAX1eEH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T29qZ/V2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774466808; x=1806002808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EUSJ4WHhXpBP/yrcWI3vj8IKzFI1fiOhCeYVPZCdZK0=;
  b=T29qZ/V28G6C4fQ8Co9pvqe3e9ctR8v0go6uALxDg7TTKlRZzLP7Xl1f
   G9xCylSHD3TNiiNFdsjoKATnQ9I9baEu6EDoSCOY3fEodGzaGk8FiJT1e
   n1Yzbepo6+W7Jz0ZsD8Qe1UVgXFhooh0xQfn2yJoPMQXb81ICwRhsccs7
   jbUrzth0PnGYxAHruGZgQ7VIYp6y4f7oH+JE4H96xbZVc9IiE6GQDQvU0
   qxc5cp5ujQabmJ5BRUFi3+MXoRU+bmcQzWQl6I7+RIS2pMJp2yC2v3FyC
   IDO8C66RyfcvNSg9tQCBNjzf+O70CNfW1Qtg05nFtRgN0dvd/8aQgXs/Y
   A==;
X-CSE-ConnectionGUID: iC8sDJsdToC5HXAqSLzoDg==
X-CSE-MsgGUID: yunMiMR1SZa+2Iw30hFbrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75401029"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75401029"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 12:26:48 -0700
X-CSE-ConnectionGUID: 3Q1ChaFPQtyMUFUUDzbYWQ==
X-CSE-MsgGUID: bpEpeqTBRnWqjbh447nwww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="229551188"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2026 12:26:47 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: ISST: Reset core count to 0
Date: Wed, 25 Mar 2026 12:26:38 -0700
Message-ID: <20260325192638.3417281-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230384-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E28AF32B370
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Based on feature revision, number of buckets can be less than the
TRL_MAX_BUCKETS. In that case core counts in the remaining buckets
can be set to some invalid values.

Hence reset core count to 0 for all buckets before assigning correct
values.

Fixes: 885d1c2a30b7 ("platform/x86: ISST: Support SST-TF revision 2")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index b8cdaa233ea9..dc22504aea32 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1458,6 +1458,8 @@ static int isst_if_get_turbo_freq_info(void __user *argp)
 					    SST_MUL_FACTOR_FREQ)
 	}
 
+	memset(turbo_freq.bucket_core_counts, 0, sizeof(turbo_freq.bucket_core_counts));
+
 	if (feature_rev >= 2) {
 		bool has_tf_info_8 = false;
 
-- 
2.52.0


