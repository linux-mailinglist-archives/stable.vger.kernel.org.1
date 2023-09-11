Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD3079BDA2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjIKWr7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbjIKOWG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:22:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E56CDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:22:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937F8C433C8;
        Mon, 11 Sep 2023 14:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442122;
        bh=iL3i0vHVj/yrgOMX79eLtDEIK7MIrJZ6saC5FrDftes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQtlq9GhwbOkd/tQmD2E5TfZr0PqItgbOlNg9xtHLwqnklw0PRM3Cwu9hRcSR0OuE
         2TZPTtuCMTU916StvU0zbHdcS/s9/7yAg2fkH8T8Q47tcac4Stzu8uvRgDnpVJyDpz
         3ZPi1OJTpk3dDzvhhCrgCZjY9dQ0zCHMxzPo7/0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6.5 654/739] ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()
Date:   Mon, 11 Sep 2023 15:47:33 +0200
Message-ID: <20230911134709.374968641@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

commit 847fb80cc01a54bc827b02547bb8743bdb59ddab upstream.

If function pwrdm_read_prev_pwrst() returns -EINVAL, we will end
up accessing array pwrdm->state_counter through negative index
-22. This is wrong and the compiler is legitimately warning us
about this potential problem.

Fix this by sanity checking the value stored in variable _prev_
before accessing array pwrdm->state_counter.

Address the following -Warray-bounds warning:
arch/arm/mach-omap2/powerdomain.c:178:45: warning: array subscript -22 is below array bounds of 'unsigned int[4]' [-Warray-bounds]

Link: https://github.com/KSPP/linux/issues/307
Fixes: ba20bb126940 ("OMAP: PM counter infrastructure.")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/20230607050639.LzbPn%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Message-ID: <ZIFVGwImU3kpaGeH@work>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/powerdomain.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -174,7 +174,7 @@ static int _pwrdm_state_switch(struct po
 		break;
 	case PWRDM_STATE_PREV:
 		prev = pwrdm_read_prev_pwrst(pwrdm);
-		if (pwrdm->state != prev)
+		if (prev >= 0 && pwrdm->state != prev)
 			pwrdm->state_counter[prev]++;
 		if (prev == PWRDM_POWER_RET)
 			_update_logic_membank_counters(pwrdm);


