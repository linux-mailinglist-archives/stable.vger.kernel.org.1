Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF64174D8B2
	for <lists+stable@lfdr.de>; Mon, 10 Jul 2023 16:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGJOOF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 10 Jul 2023 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjGJOOF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 10 Jul 2023 10:14:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47279D2
        for <stable@vger.kernel.org>; Mon, 10 Jul 2023 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688998444; x=1720534444;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r+Y4MnkAaEiMin2v4tuR3LJZq/mmbkPQN38NGj84L3A=;
  b=b2jbSPYnJgGFhnnoOdnJfQpf2jwjhrhfMcsBwh350WHLo1v3pKKqKmq1
   PWSdI5Pilmg6Osya7g33J846Kum58VaBltSUx5/5eOWZdI26u5F0YExa6
   1Uqt212Lpo6iBLlcYgdpsH4HQkmLij+w2NSb/WChzMCK/6gUjllh22hGz
   GCOceJZLVAnQ9YoJ/6I2fWiqveoN9A9NdZmoLemC3N26IeOWLvjD8rH7n
   m2AnbFtU4rqacQfT1tDf/D1RiptCF0/bjjow9ZBoBev6DscqI98irduwN
   IVC3VXEDgl1pxmj41MXgaTftAqOEdIys72crKcUSXCZ5WJ5Qhwi/1o4xw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="366927451"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="366927451"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:14:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="834291292"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834291292"
Received: from unknown (HELO ideak-desk.fi.intel.com) ([10.237.72.78])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:14:02 -0700
From:   Imre Deak <imre.deak@intel.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     intel-gfx@lists.freedesktop.org
Subject: [PATCH 0/1] v6.1 stable backport request
Date:   Mon, 10 Jul 2023 17:13:58 +0300
Message-Id: <20230710141359.754365-1-imre.deak@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Stable team, please apply patch 1/1 in this patchset along with its
dependencies to the v6.1 stable tree. The patch required a trivial
rebase adding a header include, hence resending it, while its 2
dependencies listed at Cc: stable lines in the commit message can be
cherry-picked as-is.

Thanks,
Imre

Imre Deak (1):
  drm/i915/tc: Fix system resume MST mode restore for DP-alt sinks

 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_tc.c       | 51 +++++++++++++++++--
 2 files changed, 48 insertions(+), 4 deletions(-)

-- 
2.37.2

