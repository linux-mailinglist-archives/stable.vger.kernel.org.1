Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE517603C2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 02:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjGYAUZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 20:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjGYAUW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 20:20:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B5810EF
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 17:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690244416; x=1721780416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sEDenkdp6a9igePe4vaXxYyCVpiVPXD2N+mOO2ObzUI=;
  b=Z3W5pfYAq40Lvo7WJYm1DjIOX4HbOKYYzTPjfgBsoriKxnTptKn37knH
   K6PSc9fICXjtH+3++c007y+nrjKJ5mT/gGH0UW8m8eU47TmG2sw42QkvB
   unh/TKGb8QlxO1lJvFcPOjPMl6deErj8a8w3IbBdbrdCtvlvFx47LEhNE
   oB447IDYvMnWD3pa+Vj+K2/PsB6OXBQ4vcgDWqOBezPgyE078BP/VTjm8
   xTtrXblneB0+J7MvwacBzgKHRLdee9DB/kEpZk8boCGfFdPl9pFRBrn4f
   qAUvuesuEhfzaXvY2/hgxfAbyvgaEUPLJxddRRdUm1GqLrzucXmSWAygZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367608254"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="367608254"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 17:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719857084"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="719857084"
Received: from gionescu-mobl2.ger.corp.intel.com (HELO intel.com) ([10.252.34.175])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 17:20:12 -0700
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-stable <stable@vger.kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v9 0/7] Update AUX invalidation sequence
Date:   Tue, 25 Jul 2023 02:19:43 +0200
Message-Id: <20230725001950.1014671-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

as there are new hardware directives, we need a little adaptation
for the AUX invalidation sequence.

In this version we support all the engines affected by this
change.

The stable backport has some challenges because the original
patch that this series fixes has had more changes in between.

This 9th version is simplified compared to the previous round.

Thanks a lot Nirmoy, Andrzej and Matt for your review and for the
fruitful discussions!

Thanks,
Andi

Changelog:
=========
v8 -> v9
 - Removed the patch that was refactoring into
   intel_emit_pipe_control_cs() the pipe control emission as it
   was adding more confusion than simplification.
 - Cleaned up the engine quiescing sequence for BCS, VECS and VCS
   engines. After this the patch that was extending the quiescing
   sequence was very little to be kept on its own and squashed
   with the one adding the CCS_FLUSH in the pipe control.
 - The above changes have brought some more refactoring in the
   very last patch.
 - Added, whenever needed, the "Required:" tag to make sure
   dependencies are held.

v7 -> v8
 - Removed the aux invalidation from the device info and added a
   helper function, instead (patch 2).
 - Use "MTL and beyond" instead of "MTL+" in comments.
 - Use the "gen12_" prefix instead of "intel_".
 - In patch 6 return an int error instead of an error embedded in
   the pointer in the intel_emit_pipe_control_cs() function and
   propagate the error to the upper layers.

v6 -> v7
 - Fix correct sequence applied to the correct engine. A little
   confusion promptly cought by Nirmoy when applying to the VD
   engine the sequence belonging to the compute engines. Thanks a
   lot, Nirmoy!

v5 -> v6
 - Fixed ccs flush in the engines VE and BCS. They are sent as a
   separate command instead of added in the pipe control.
 - Separated the CCS flusing in the pipe control patch with the
   quiescing of the memory. They were meant to be on separate
   patch already in the previous verision, but apparently I
   squashed them by mistake.

v4 -> v5
 - The AUX CCS is added as a device property instead of checking
   against FLAT CCS. This adds the new HAS_AUX_CCS check
   (Patch 2, new).
 - little and trivial refactoring here and there.
 - extended the flags{0,1}/bit_group_{0,1} renaming to other
   functions.
 - Created an intel_emit_pipe_control_cs() wrapper for submitting
   the pipe control.
 - Quiesce memory for all the engines, not just RCS (Patch 6,
   new).
 - The PIPE_CONTROL_CCS_FLUSH is added to all the engines.
 - Remove redundant EMIT_FLUSH_CCS mode flag.
 - Remove unnecessary NOOPs from the command streamer for
   invalidating the CCS table.
 - Use INVALID_MMIO_REG and gen12_get_aux_inv_reg() instad of
   __MMIO(0) and reg.reg.
 - Remove useless wrapper and just use gen12_get_aux_inv_reg().

v3 -> v4
 - A trivial patch 3 is added to rename the flags with
   bit_group_{0,1} to align with the datasheet naming.
 - Patch 4 fixes a confusion I made where the CCS flag was
   applied to the wrong bit group.

v2 -> v3
 - added r-b from Nirmoy in patch 1 and 4.
 - added patch 3 which enables the ccs_flush in the control pipe
   for mtl+ compute and render engines.
 - added redundant checks in patch 2 for enabling the EMIT_FLUSH
   flag.

v1 -> v2
 - add a clean up preliminary patch for the existing registers
 - add support for more engines
 - add the Fixes tag

Andi Shyti (5):
  drm/i915/gt: Cleanup aux invalidation registers
  drm/i915: Add the gen12_needs_ccs_aux_inv helper
  drm/i915/gt: Rename flags with bit_group_X according to the datasheet
  drm/i915/gt: Enable the CCS_FLUSH bit in the pipe control and in the
    CS
  drm/i915/gt: Support aux invalidation on all engines

Jonathan Cavitt (2):
  drm/i915/gt: Ensure memory quiesced before invalidation
  drm/i915/gt: Poll aux invalidation register bit on invalidation

 drivers/gpu/drm/i915/gt/gen8_engine_cs.c     | 140 ++++++++++++-------
 drivers/gpu/drm/i915/gt/gen8_engine_cs.h     |  21 +--
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h |   2 +
 drivers/gpu/drm/i915/gt/intel_gt_regs.h      |  16 +--
 drivers/gpu/drm/i915/gt/intel_lrc.c          |  17 +--
 5 files changed, 117 insertions(+), 79 deletions(-)

-- 
2.40.1

