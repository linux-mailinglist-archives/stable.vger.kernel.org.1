Return-Path: <stable+bounces-206254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF5D015C8
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 08:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72D8430124ED
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2078133B946;
	Thu,  8 Jan 2026 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ze53RDSj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBE82206A7;
	Thu,  8 Jan 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856485; cv=none; b=haSgQULR63ger+VdZwKNZenVRpZYLxv9eEjtzhLbtwbAnuqXa0dqcEZhfYim46CKPqjfwg3qXQXaB690HhjbuUVo3pv/wEaSl603pVdxMlwG4P/yp/ZdVwocn2gbasa5Osz+4A8qgyFP0WBb6vvkdyzcEpDCUof1+ACBLq/nVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856485; c=relaxed/simple;
	bh=KnsDYnbpZIlOE9LHEkO7zwCYzjwDP4ZvHYxTt8BPp/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NY56X1Ed2m+FLgATqzFif59j/SxZwwExefHsd3f2NJi0R3DsbXjmE5Oppu6ca7aueOQqRy+ThBCuM5aZ2OaJc7PSbhsMsR15utsfZ+QR3nhMHF0pqI5xY1oDnU+p7CX38lEy6zZMF9N8JUqUgdNbnde/1H8ZFcsjewDb19xIeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ze53RDSj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767856484; x=1799392484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KnsDYnbpZIlOE9LHEkO7zwCYzjwDP4ZvHYxTt8BPp/o=;
  b=Ze53RDSjXVV2lbuY8xUD9WwT+GbPSIx4JCBavINUB4g1B8wLWXfj18iB
   t3AVM0WlOi0BmGdgps76x61XiW4EREGM2n2xWpMWdJlOc+tH6XvjeB1eW
   NFVIuyR862QjF0cN8AlewQAkSQbqrI2HHpkCeRX+++jSLa+D/BVPFLzqR
   69lzbMJ0GskhpPOw7TL4hcT/LyCnen1R/GAJ7CqBAEx5K1VOiFQbMwT0b
   v7AzTIBI5LwLscy4bvegXBjoWtRFEh0KEektHTEg1fZmRE3PMz4ZTbJUM
   40zCpcDlJcOpwp6E5vbThBuvab/q+UD51nGAgUxKs8ix7+BQ8cHB2llmS
   g==;
X-CSE-ConnectionGUID: BkkakLVtR42vwR6zEPvN5w==
X-CSE-MsgGUID: +ESb7NhdRUCnySjvL+pozA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="72865351"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="72865351"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:14:43 -0800
X-CSE-ConnectionGUID: v/WA/9whQe+oPZLz77csdQ==
X-CSE-MsgGUID: nMLmKog0RBmHcAuiM9VjPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203150264"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 23:14:42 -0800
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [char-misc v2] mei: trace: treat reg parameter as string
Date: Thu,  8 Jan 2026 08:57:02 +0200
Message-ID: <20260108065702.1224300-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the string wrapper to check sanity of the reg parameters,
store it value independently and prevent internal kernel data leaks.
Trace subsystem refuses to emit event with plain char*,
without the wrapper.

Cc: stable@vger.kernel.org
Fixes: a0a927d06d79 ("mei: me: add io register tracing")
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---

V2: reword commit message
    add Fixes and stable

 drivers/misc/mei/mei-trace.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/mei/mei-trace.h b/drivers/misc/mei/mei-trace.h
index 5312edbf5190..24fa321d88bd 100644
--- a/drivers/misc/mei/mei-trace.h
+++ b/drivers/misc/mei/mei-trace.h
@@ -21,18 +21,18 @@ TRACE_EVENT(mei_reg_read,
 	TP_ARGS(dev, reg, offs, val),
 	TP_STRUCT__entry(
 		__string(dev, dev_name(dev))
-		__field(const char *, reg)
+		__string(reg, reg)
 		__field(u32, offs)
 		__field(u32, val)
 	),
 	TP_fast_assign(
 		__assign_str(dev);
-		__entry->reg  = reg;
+		__assign_str(reg);
 		__entry->offs = offs;
 		__entry->val = val;
 	),
 	TP_printk("[%s] read %s:[%#x] = %#x",
-		  __get_str(dev), __entry->reg, __entry->offs, __entry->val)
+		  __get_str(dev), __get_str(reg), __entry->offs, __entry->val)
 );
 
 TRACE_EVENT(mei_reg_write,
@@ -40,18 +40,18 @@ TRACE_EVENT(mei_reg_write,
 	TP_ARGS(dev, reg, offs, val),
 	TP_STRUCT__entry(
 		__string(dev, dev_name(dev))
-		__field(const char *, reg)
+		__string(reg, reg)
 		__field(u32, offs)
 		__field(u32, val)
 	),
 	TP_fast_assign(
 		__assign_str(dev);
-		__entry->reg = reg;
+		__assign_str(reg);
 		__entry->offs = offs;
 		__entry->val = val;
 	),
 	TP_printk("[%s] write %s[%#x] = %#x",
-		  __get_str(dev), __entry->reg,  __entry->offs, __entry->val)
+		  __get_str(dev), __get_str(reg),  __entry->offs, __entry->val)
 );
 
 TRACE_EVENT(mei_pci_cfg_read,
@@ -59,18 +59,18 @@ TRACE_EVENT(mei_pci_cfg_read,
 	TP_ARGS(dev, reg, offs, val),
 	TP_STRUCT__entry(
 		__string(dev, dev_name(dev))
-		__field(const char *, reg)
+		__string(reg, reg)
 		__field(u32, offs)
 		__field(u32, val)
 	),
 	TP_fast_assign(
 		__assign_str(dev);
-		__entry->reg  = reg;
+		__assign_str(reg);
 		__entry->offs = offs;
 		__entry->val = val;
 	),
 	TP_printk("[%s] pci cfg read %s:[%#x] = %#x",
-		  __get_str(dev), __entry->reg, __entry->offs, __entry->val)
+		  __get_str(dev), __get_str(reg), __entry->offs, __entry->val)
 );
 
 #endif /* _MEI_TRACE_H_ */
-- 
2.43.0


