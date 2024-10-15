Return-Path: <stable+bounces-85823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B299EA31
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69D71C23B94
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C0227BA5;
	Tue, 15 Oct 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHS/G8h9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576C1F7084;
	Tue, 15 Oct 2024 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996243; cv=none; b=Q8kkZm0/6I5u4Pu4oJDCdVSbP4TXJ+gdrBQgLVGWNRixBx+6izQrNfdKpawfoa0nNUKzK3SXKRH34jtH4sNb7P2kQ4yaAjLakfwERMeaF3u2Os/4v0vX7kdpXWY8pTvwDkIUjjJPrHfojVpnSfZz5NWJ/QfIU9iwS0e3H+O2+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996243; c=relaxed/simple;
	bh=W5XKx9Quk746L7Qt7FDFxGAoA35Y1Se7+CZOvQViApQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shVDUVURtPNV200Doq/r+3WH1p1CAsWnVTAwbg7IqrTBm2p5r4bCZTcFJOEe03pihyyVNY11Gqqx5YWmXGrt7XUNiSugLCsThMtc2a4EAZUt8wTp0cdL2Zwht+efKd6iMaxZNoYRs4MLDZLZp6YUqmnHVM4/NM4H6t7birKANHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHS/G8h9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728996242; x=1760532242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W5XKx9Quk746L7Qt7FDFxGAoA35Y1Se7+CZOvQViApQ=;
  b=JHS/G8h9YJhG6sacWa6bGBJ8PtsUsKgZv312ODtXaL8ATUVRw0AYr+BS
   c531oOdvuXsVS6O3b7dAm0yUCvaq2KfkV53ous0BddX3h685tJZ7r7dfP
   G1fKv5fzGTj/LFVOBBTqaT9V0FG5YxRP+LO74/DsZx0U0x1E1j/Clv/TP
   KkKFPaq/TGS6TD4uPQPyjprm8IHh602AGS1lAK+982+5VzVBjZJtByfWO
   ShmZWMIdvfbAg+TmgBvhLM6WRQLFNUISgPAUl1d+37biNqlYpqHXuMxXI
   Rd2zGKZL4PlMqWZj3M0eGutSKfbWlfvppw6z4jnByJGLBBRTKPnh6wIu0
   A==;
X-CSE-ConnectionGUID: 6INJ+BZLRqOSyBkYeWboIA==
X-CSE-MsgGUID: KWx6zk+VR0i7FKOJUNMJQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28486116"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="28486116"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 05:44:01 -0700
X-CSE-ConnectionGUID: nPgmRvf1S06PelgmqmdnTA==
X-CSE-MsgGUID: WN6ojAK4RsCMfOgkYP4etQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="77903240"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 05:43:59 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oren Weil <oren.jer.weil@intel.com>,
	Tomas Winkler <tomasw@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Rohit Agarwal <rohiagar@chromium.org>,
	Brian Geffon <bgeffon@google.com>
Subject: [char-misc-next v3] mei: use kvmalloc for read buffer
Date: Tue, 15 Oct 2024 15:31:57 +0300
Message-ID: <20241015123157.2337026-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read buffer is allocated according to max message size, reported by
the firmware and may reach 64K in systems with pxp client.
Contiguous 64k allocation may fail under memory pressure.
Read buffer is used as in-driver message storage and not required
to be contiguous.
Use kvmalloc to allow kernel to allocate non-contiguous memory.

Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands.")
Reported-by: Rohit Agarwal <rohiagar@chromium.org>
Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@chromium.org/
Tested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---

Changes since V2:
 - add Fixes and CC:stable

Changes since V1:
 - add Tested-by and Reported-by

 drivers/misc/mei/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 9d090fa07516..be011cef12e5 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -321,7 +321,7 @@ void mei_io_cb_free(struct mei_cl_cb *cb)
 		return;
 
 	list_del(&cb->list);
-	kfree(cb->buf.data);
+	kvfree(cb->buf.data);
 	kfree(cb->ext_hdr);
 	kfree(cb);
 }
@@ -497,7 +497,7 @@ struct mei_cl_cb *mei_cl_alloc_cb(struct mei_cl *cl, size_t length,
 	if (length == 0)
 		return cb;
 
-	cb->buf.data = kmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
+	cb->buf.data = kvmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
 	if (!cb->buf.data) {
 		mei_io_cb_free(cb);
 		return NULL;
-- 
2.43.0


