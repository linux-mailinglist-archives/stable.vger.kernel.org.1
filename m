Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC875BFD9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGUHfy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGUHfv (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:35:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA12D7E
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:35:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2DB561335
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C77C433C9;
        Fri, 21 Jul 2023 07:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924944;
        bh=hKhjwoNTFFrDMlr4EV6N/xpHu/qFFk23VH1lQpo3Thc=;
        h=Subject:To:Cc:From:Date:From;
        b=ZcEiASmJZu3YFDrkhelxgfA0soD80FM/Z4KoUdsMRkguXv2Huc2O9um+wWZoECD9/
         qCKWQaf8v7gbAyehcs8h1qz5+ZVbYHwIw+qkz46vTevVfcANKk1cNPnXXjedrQb6Ve
         aoe4K4HfBOYHMNJDoHzI0ZfUoE01F+DlwQfVR7U0=
Subject: FAILED: patch "[PATCH] drm/amd/pm: fix smu i2c data read risk" failed to apply to 6.1-stable tree
To:     kevinyang.wang@amd.com, alexander.deucher@amd.com,
        lijo.lazar@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:35:41 +0200
Message-ID: <2023072141-deluxe-zips-9820@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d934e537c14bfe1227ced6341472571f354383e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072141-deluxe-zips-9820@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d934e537c14b ("drm/amd/pm: fix smu i2c data read risk")
511a95552ec8 ("drm/amd/pm: Add SMU 13.0.6 support")
230dd6bb6117 ("drm/amd/amdgpu: implement mode2 reset on smu_v13_0_10")
e1dd28fc5bef ("drm/amd/pm: drop unused SMU v13 API")
1794f6a9535b ("drm/amd/pm: enable GPO dynamic control support for SMU13.0.0")
48aa62f07467 ("drm/amd/pm: Enable bad memory page/channel recording support for smu v13_0_0")
8ae5a38c8cb3 ("drm/amd/pm: enable runpm support over BACO for SMU13.0.0")
60cfad329ab8 ("drm/amd/pm: enable mode1 reset on smu_v13_0_10")
7e5632cdf68b ("drm/amd/pm: update driver-if header for smu_v13_0_10")
c6863be23179 ("drm/amd/pm: fulfill SMU13.0.0 cstate control interface")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d934e537c14bfe1227ced6341472571f354383e8 Mon Sep 17 00:00:00 2001
From: Yang Wang <kevinyang.wang@amd.com>
Date: Tue, 20 Jun 2023 17:05:25 +0800
Subject: [PATCH] drm/amd/pm: fix smu i2c data read risk

the smu driver_table is used for all types of smu
tables data transcation (e.g: PPtable, Metrics, i2c, Ecc..).

it is necessary to hold this lock to avoiding data tampering
during the i2c read operation.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 9cd005131f56..3bb18396d2f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2113,7 +2113,6 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -2130,6 +2129,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c94d825a871b..95f6d821bacb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3021,7 +3021,6 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -3038,6 +3037,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index f7ed3e655e39..8fe2e1716da4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3842,7 +3842,6 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -3859,6 +3858,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index e80f122d8aec..ce50ef46e73f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1525,7 +1525,6 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -1542,6 +1541,7 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 124287cbbff8..1d995f53aaab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2320,7 +2320,6 @@ static int smu_v13_0_0_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -2337,6 +2336,7 @@ static int smu_v13_0_0_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6ef12252beb5..1ac552142763 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1763,7 +1763,6 @@ static int smu_v13_0_6_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_v13_0_6_request_i2c_xfer(smu, req);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -1780,6 +1779,7 @@ static int smu_v13_0_6_i2c_xfer(struct i2c_adapter *i2c_adap,
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }

