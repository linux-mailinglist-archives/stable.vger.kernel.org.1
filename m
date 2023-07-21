Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522FA75CEE5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjGUQZf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjGUQZO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:25:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F059DE
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:21:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B814C6108F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC36C433C8;
        Fri, 21 Jul 2023 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956490;
        bh=CmvkcYQglLiid8Jo3TWlBQLHoY53n2v2ywKXcWqJs4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfyNIr85+vdU4tsW0JJX5Epq+HvL60sfdjUV+1rHpDmAxmfgNYUPxgVFUg4c5FB2m
         /lujNvMWs+3vOoT/697HQ5tiZi84JoeemAT5fhdJQc3ldx4YV3cgOZ5gzaJbg0+67N
         2rA5TMNmglreA+log3LdHKm3JQE2DrCspcRtl4P0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Wang <kevinyang.wang@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 210/292] drm/amd/pm: fix smu i2c data read risk
Date:   Fri, 21 Jul 2023 18:05:19 +0200
Message-ID: <20230721160537.898987958@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yang Wang <kevinyang.wang@amd.com>

commit d934e537c14bfe1227ced6341472571f354383e8 upstream.

the smu driver_table is used for all types of smu
tables data transcation (e.g: PPtable, Metrics, i2c, Ecc..).

it is necessary to hold this lock to avoiding data tampering
during the i2c read operation.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c      |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    |    2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2113,7 +2113,6 @@ static int arcturus_i2c_xfer(struct i2c_
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -2130,6 +2129,7 @@ static int arcturus_i2c_xfer(struct i2c_
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3021,7 +3021,6 @@ static int navi10_i2c_xfer(struct i2c_ad
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -3038,6 +3037,7 @@ static int navi10_i2c_xfer(struct i2c_ad
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3842,7 +3842,6 @@ static int sienna_cichlid_i2c_xfer(struc
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -3859,6 +3858,7 @@ static int sienna_cichlid_i2c_xfer(struc
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1525,7 +1525,6 @@ static int aldebaran_i2c_xfer(struct i2c
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -1542,6 +1541,7 @@ static int aldebaran_i2c_xfer(struct i2c
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1838,7 +1838,6 @@ static int smu_v13_0_0_i2c_xfer(struct i
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -1855,6 +1854,7 @@ static int smu_v13_0_0_i2c_xfer(struct i
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1639,7 +1639,6 @@ static int smu_v13_0_6_i2c_xfer(struct i
 	}
 	mutex_lock(&adev->pm.mutex);
 	r = smu_v13_0_6_request_i2c_xfer(smu, req);
-	mutex_unlock(&adev->pm.mutex);
 	if (r)
 		goto fail;
 
@@ -1656,6 +1655,7 @@ static int smu_v13_0_6_i2c_xfer(struct i
 	}
 	r = num_msgs;
 fail:
+	mutex_unlock(&adev->pm.mutex);
 	kfree(req);
 	return r;
 }


