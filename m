Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FB57DD513
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376391AbjJaRrE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376394AbjJaRrD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:47:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F07AA2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:47:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51A6C433C9;
        Tue, 31 Oct 2023 17:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774421;
        bh=v6oP9dCY9HsutAeT7qat7nt3BfXa81LB/kEyu+qbRBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPOw/ahytBqNAPRlA4aIq0pF/FqlBG5MdPb656+Cp1hESDfA3yjPkISlAGDEt0oIa
         04Xvly+mVuflyJ2MIg+FOfdGnM05RQoAEGo7vhhtfpTP61tnF1FwkkKtvRcBkH3czR
         eqT7S8QnX0QrI2ALpSHcO9R9btyOSmS1i+QdXve0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Paolo Gentili <paolo.gentili@canonical.com>
Subject: [PATCH 6.5 041/112] drm/amd: Disable ASPM for VI w/ all Intel systems
Date:   Tue, 31 Oct 2023 18:00:42 +0100
Message-ID: <20231031165902.605131587@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 64ffd2f1d00c6235dabe9704bbb0d9ce3e28147f upstream.

Originally we were quirking ASPM disabled specifically for VI when
used with Alder Lake, but it appears to have problems with Rocket
Lake as well.

Like we've done in the case of dpm for newer platforms, disable
ASPM for all Intel systems.

Cc: stable@vger.kernel.org # 5.15+
Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
Reported-and-tested-by: Paolo Gentili <paolo.gentili@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/vi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct amdgp
 	bool bL1SS = false;
 	bool bClkReqSupport = true;
 
-	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_aspm_support_quirk())
+	if (!amdgpu_device_should_use_aspm(adev) || !amdgpu_device_pcie_dynamic_switching_supported())
 		return;
 
 	if (adev->flags & AMD_IS_APU ||


