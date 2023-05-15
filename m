Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01370369C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbjEORL7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243605AbjEORLc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:11:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498DD72B3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:09:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28925620FF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C792C433D2;
        Mon, 15 May 2023 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170585;
        bh=/BZDfdZh+7pjby76Bk5kvnrPm/wW7RJBSV9FyR+uujE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1uC1NFWER4TLQ9tmm8vCnIJKmEnVZjsLRFRbbDVLoL1mvJTb1nVEw5j0zVxKti/Ei
         cQsEEep3CX9TAPBy6fIwDJ4mQPu07WwoHb2asFkJzoT50zwW8hNbc2TumiuLtjy965
         f8/x8ETTQXTzyisjarY9BPJ1NzsqT7KG52nvwJQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Graham Sider <Graham.Sider@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 176/239] drm/amdgpu: remove deprecated MES version vars
Date:   Mon, 15 May 2023 18:27:19 +0200
Message-Id: <20230515161726.944845799@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Graham Sider <Graham.Sider@amd.com>

commit 6040517e4a29d3828160c571681eec9ffe10043f upstream.

MES scheduler and kiq versions are stored in mes.sched_version and
mes.kiq_version, respectively, which are read from a register after
their queues are initialized. Remove mes.ucode_fw_version and
mes.data_fw_version which tried to read this versioning info from the
firmware headers (which don't contain this information).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |    2 --
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  |    4 ----
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |    4 ----
 3 files changed, 10 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -91,14 +91,12 @@ struct amdgpu_mes {
 	struct amdgpu_bo		*ucode_fw_obj[AMDGPU_MAX_MES_PIPES];
 	uint64_t			ucode_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	uint32_t			*ucode_fw_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t                        ucode_fw_version[AMDGPU_MAX_MES_PIPES];
 	uint64_t                        uc_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* mes ucode data */
 	struct amdgpu_bo		*data_fw_obj[AMDGPU_MAX_MES_PIPES];
 	uint64_t			data_fw_gpu_addr[AMDGPU_MAX_MES_PIPES];
 	uint32_t			*data_fw_ptr[AMDGPU_MAX_MES_PIPES];
-	uint32_t                        data_fw_version[AMDGPU_MAX_MES_PIPES];
 	uint64_t                        data_start_addr[AMDGPU_MAX_MES_PIPES];
 
 	/* eop gpu obj */
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -415,10 +415,6 @@ static int mes_v10_1_init_microcode(stru
 
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)
 		adev->mes.fw[pipe]->data;
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_version);
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_data_version);
 	adev->mes.uc_start_addr[pipe] =
 		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
 		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -484,10 +484,6 @@ static int mes_v11_0_init_microcode(stru
 
 	mes_hdr = (const struct mes_firmware_header_v1_0 *)
 		adev->mes.fw[pipe]->data;
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_version);
-	adev->mes.ucode_fw_version[pipe] =
-		le32_to_cpu(mes_hdr->mes_ucode_data_version);
 	adev->mes.uc_start_addr[pipe] =
 		le32_to_cpu(mes_hdr->mes_uc_start_addr_lo) |
 		((uint64_t)(le32_to_cpu(mes_hdr->mes_uc_start_addr_hi)) << 32);


