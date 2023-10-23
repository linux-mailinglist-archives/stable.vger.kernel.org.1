Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276FE7D342F
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbjJWLhV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbjJWLhU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:37:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE2D7E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:37:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D76DC433C8;
        Mon, 23 Oct 2023 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061037;
        bh=vEgjS+lIiZZW+6Z61+R44mgiqwr1kI8M7Bo3Ye81Vqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=17oM+8XucAudeyXiZuuTJSPQL9JH0DdNa3kmnq2QCfFTHmfGsn24anh2ezr1OeC5A
         tAV3UmDWI4jboykOCsLrVCDSQkPX+/zViDFJvzoFD30fNuSy4ZvOhcN7n7J6HZJpLI
         P+staNU3fFK/hUg2pBn4BPUUo0mOoTC7F8k2Jftg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 5.15 024/137] drm/i915: Retry gtt fault when out of fence registers
Date:   Mon, 23 Oct 2023 12:56:21 +0200
Message-ID: <20231023104821.790399170@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit e339c6d628fe66c9b64bf31040a55770952aec57 upstream.

If we can't find a free fence register to handle a fault in the GMADR
range just return VM_FAULT_NOPAGE without populating the PTE so that
userspace will retry the access and trigger another fault. Eventually
we should find a free fence and the fault will get properly handled.

A further improvement idea might be to reserve a fence (or one per CPU?)
for the express purpose of handling faults without having to retry. But
that would require some additional work.

Looks like this may have gotten broken originally by
commit 39965b376601 ("drm/i915: don't trash the gtt when running out of fences")
as that changed the errno to -EDEADLK which wasn't handle by the gtt
fault code either. But later in commit 2feeb52859fc ("drm/i915/gt: Fix
-EDEADLK handling regression") I changed it again to -ENOBUFS as -EDEADLK
was now getting used for the ww mutex dance. So this fix only makes
sense after that last commit.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/9479
Fixes: 2feeb52859fc ("drm/i915/gt: Fix -EDEADLK handling regression")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231012132801.16292-1-ville.syrjala@linux.intel.com
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
(cherry picked from commit 7f403caabe811b88ab0de3811ff3f4782c415761)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -231,6 +231,7 @@ static vm_fault_t i915_error_to_vmf_faul
 	case 0:
 	case -EAGAIN:
 	case -ENOSPC: /* transient failure to evict? */
+	case -ENOBUFS: /* temporarily out of fences? */
 	case -ERESTARTSYS:
 	case -EINTR:
 	case -EBUSY:


