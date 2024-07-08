Return-Path: <stable+bounces-58247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DADD92A951
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCAE1C210CE
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EE814AD03;
	Mon,  8 Jul 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcQC/9iG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD514884B;
	Mon,  8 Jul 2024 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464880; cv=none; b=QvL2mzavfT9jVKtYOj7DcIbysmSVbqZljrymAMdbzEDZzvXVOUovbf8BVq4Y7VNiaEUYhscipceiW/OVI/bGV0heq/U2l/c3HIYVXqeeilQSZb6492vf0/uwbyAOrdpkzTcQywlgDiveJHdV+Zsx/uvogwyGOYanJ5rR5cDPdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464880; c=relaxed/simple;
	bh=RGobAnthjkgsb/QzuzeMGs8pm1LeGhwCVTyS3CsT0Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LE2d9yODGsZELlloZdlAJ8l86360+QuXA6QjovFAEUnqV9NpgF2B3OmhYWw4LcDhcrurpUTG7qhxwG3dye1VJ5VfTS3iHe6CwRz/ecambVblxzB/8ZYs37QzDo9O03fiwJDzun9FWOM9hRfH7I/DiMB18fBU+zQEkvn3wm+ax4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcQC/9iG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720464879; x=1752000879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RGobAnthjkgsb/QzuzeMGs8pm1LeGhwCVTyS3CsT0Qo=;
  b=UcQC/9iGn8k43t8NzwATs7YuwSs/TQW3SnamfmIeuUs817t9ZrBrfN7/
   exGuy0QT4KE9YnUX34Trf0/8EJH5u/BS3P83F3kL0yM/xKdvbJtvIhh8K
   6OLawh6jegv0H51XldX6YYhYYRXU6wrrBQCa5XctlW4QgQBVPhwL3E0bb
   T/mX6a9tdaEeKm1RRm/M/ov6UjGIkY+qNm1OEzXwdcJg0ZJ5jpOlLTmvp
   wPDVjraiHgtTNqnBBRZT0BUNC9Uy9Srhsr2UfggotzVtyUko41EExUIC1
   I9FA7d46Kq8XpoWW7T8tzjCOUjcjT6ml1RGoohOkaRQsUCf+D49NjYyav
   Q==;
X-CSE-ConnectionGUID: 12ujBxCORxOIPsVYiSUp4A==
X-CSE-MsgGUID: BgcurYY5RT+PY8i/t9P6mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17789384"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17789384"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 11:54:38 -0700
X-CSE-ConnectionGUID: fQQNpucPQZq/rBYKUn0T5A==
X-CSE-MsgGUID: E7YIioPMRCuT4dEjJ2sIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="52004138"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jul 2024 11:54:37 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH] perf/x86/intel/uncore: Fix the bits of the CHA extended umask for SPR
Date: Mon,  8 Jul 2024 11:55:24 -0700
Message-Id: <20240708185524.1185505-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
event.

 $perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls
    event syntax error: '..0x35,umask=0x10c0008101/'
                                      \___ Bad event or PMU

The definition of the CHA umask is config:8-15,32-55, which is 32bit.
However, the umask of the event is bigger than 32bit.
This is an error in the original uncore spec.

Add a new umask_ext5 for the new CHA umask range.

Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
Closes: https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.11354@Diego/
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/uncore_snbep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index a96496bef678..7924f315269a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -461,6 +461,7 @@
 #define SPR_UBOX_DID				0x3250
 
 /* SPR CHA */
+#define SPR_CHA_EVENT_MASK_EXT			0xffffffff
 #define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
 #define SPR_CHA_PMON_EVENT_MASK			(SNBEP_PMON_RAW_EVENT_MASK | \
 						 SPR_CHA_PMON_CTL_TID_EN)
@@ -477,6 +478,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8-15,32-43,45-55");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
+DEFINE_UNCORE_FORMAT_ATTR(umask_ext5, umask, "config:8-15,32-63");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
@@ -5957,7 +5959,7 @@ static struct intel_uncore_ops spr_uncore_chabox_ops = {
 
 static struct attribute *spr_uncore_cha_formats_attr[] = {
 	&format_attr_event.attr,
-	&format_attr_umask_ext4.attr,
+	&format_attr_umask_ext5.attr,
 	&format_attr_tid_en2.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
@@ -5993,7 +5995,7 @@ ATTRIBUTE_GROUPS(uncore_alias);
 static struct intel_uncore_type spr_uncore_chabox = {
 	.name			= "cha",
 	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
-	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.event_mask_ext		= SPR_CHA_EVENT_MASK_EXT,
 	.num_shared_regs	= 1,
 	.constraints		= skx_uncore_chabox_constraints,
 	.ops			= &spr_uncore_chabox_ops,
-- 
2.35.1


