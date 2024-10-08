Return-Path: <stable+bounces-81553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B106199440C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5836F1F237FF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7380D18BC03;
	Tue,  8 Oct 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aByUyj7R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0C18B464
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379213; cv=none; b=Y1vsbghhiIqAVqyMZp26AAN1diUfUeYsoL1/RZEauRUXJoC/eJy/MQ2MheJAoUuPi1o81GQZ6BUo+jVYGDTv9ecdkECFSiUhsxJUFadWkDIfsoHA8PrxwpV2XqG6QrMVrOPOpNq4RAdmKWY5ZLtn7wNGNJ/asqPt0DCvitN0j2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379213; c=relaxed/simple;
	bh=eUEpShZB+Q5wzzDnDEC+aT48u7pa6aIVcF+uvIMd6Wk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JfG4PPquTpF2GZsxDWcyOpnKSygLTnPX+Bv4ba6cVwjMBjlFn2uig81eHtCHpnobZdnIg3Sj7cePM5hUtWT3SE1/w5JyG2BqiecqDDoqK/DBkNIOaXPbCLrtE4sZRw3ZIWAuiLLn4Cu9xTTIXfS9wcx8xgXnK2BQLRn8Bjm4YXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aByUyj7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58909C4CECF;
	Tue,  8 Oct 2024 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728379212;
	bh=eUEpShZB+Q5wzzDnDEC+aT48u7pa6aIVcF+uvIMd6Wk=;
	h=Subject:To:Cc:From:Date:From;
	b=aByUyj7R/gMsLkA26YV4e4g61MU9cuSLOv51dWTs+fesauvGCJqlbk6huqs4+MtUq
	 2YISYjbSaWHiv+gaP720tqhviLCL9ikHGpdgQDbRiX3NzO/SgGgyNAYzIRImHNYBGy
	 mUsqeB49B6pMCgvzQNQ4PDvTZrSbzcLM1rgzsNN8=
Subject: FAILED: patch "[PATCH] drm/xe/vram: fix ccs offset calculation" failed to apply to 6.10-stable tree
To: matthew.auld@intel.com,akshata.jahagirdar@intel.com,himal.prasad.ghimiray@intel.com,lucas.demarchi@intel.com,matthew.d.roper@intel.com,shuicheng.lin@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 11:20:09 +0200
Message-ID: <2024100809-goes-diagnosis-d07c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x ee06c09ded3c2f722be4e240ed06287e23596bda
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100809-goes-diagnosis-d07c@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

ee06c09ded3c ("drm/xe/vram: fix ccs offset calculation")
638d1c79cbf1 ("drm/xe: Promote VRAM initialization function to own file")
8c52ca22b15b ("drm/xe: Drop xe_ prefix from static functions in xe_mmio.c")
2d8865b27724 ("drm/xe: Move BAR definitions to dedicated file")
2adfc4e022f3 ("drm/xe: Move XEHP_MTCFG_ADDR register definition to xe_regs.h")
c7117419784f ("drm/xe: reset mmio mappings with devm")
a0b834c8957a ("drm/xe/mmio: move mmio_fini over to devm")
f7e20cfb59c9 ("drm/xe: Cleanup xe_mmio.h")
93dd6ad89c7d ("drm/xe: Don't rely on xe_force_wake.h to be included elsewhere")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ee06c09ded3c2f722be4e240ed06287e23596bda Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Mon, 16 Sep 2024 09:49:12 +0100
Subject: [PATCH] drm/xe/vram: fix ccs offset calculation

Spec says SW is expected to round up to the nearest 128K, if not already
aligned for the CC unit view of CCS. We are seeing the assert sometimes
pop on BMG to tell us that there is a hole between GSM and CCS, as well
as popping other asserts with having a vram size with strange alignment,
which is likely caused by misaligned offset here.

v2 (Shuicheng):
 - Do the round_up() on final SW address.

BSpec: 68023
Fixes: b5c2ca0372dc ("drm/xe/xe2hpg: Determine flat ccs offset for vram")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: stable@vger.kernel.org # v6.10+
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Tested-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240916084911.13119-2-matthew.auld@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 37173392741c425191b959acb3adf70c9a4610c0)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index 5bcd59190353..80ba2fc78837 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -182,6 +182,7 @@ static inline u64 get_flat_ccs_offset(struct xe_gt *gt, u64 tile_size)
 		offset = offset_hi << 32; /* HW view bits 39:32 */
 		offset |= offset_lo << 6; /* HW view bits 31:6 */
 		offset *= num_enabled; /* convert to SW view */
+		offset = round_up(offset, SZ_128K); /* SW must round up to nearest 128K */
 
 		/* We don't expect any holes */
 		xe_assert_msg(xe, offset == (xe_mmio_read64_2x32(gt, GSMBASE) - ccs_size),


