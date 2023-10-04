Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC097B8A02
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbjJDSbR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244336AbjJDSbR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:31:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F121AD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:31:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C64C433C7;
        Wed,  4 Oct 2023 18:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444273;
        bh=ZfZcfhXkw8Xd9lpa3h5BgYMpOjVFVTZIqoZikRt3EAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbiaQ04oasEve1XBHTc9C7Og86Di2cN1+NfAA5YnZS5ftScmC9fD+4S3h2r3q/Xjk
         XHfhCei9d6UfIQ8ECVykGBaluuJpyBSTpLnYBkEA0mHpsWBmdAVomJrbSWROqMJ+4j
         J0TriQiTBlH6pLFkET4peYAnE+EwzE5ugICqMeV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hawking Zhang <Hawking.Zhang@amd.com>,
        Yang Wang <kevinyang.wang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 192/321] drm/amdgpu: fallback to old RAS error message for aqua_vanjaram
Date:   Wed,  4 Oct 2023 19:55:37 +0200
Message-ID: <20231004175238.118527553@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hawking Zhang <Hawking.Zhang@amd.com>

[ Upstream commit ffd6bde302061aeee405ab364403af30210f0b99 ]

So driver doesn't generate incorrect message until
the new format is settled down for aqua_vanjaram

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8aaa427f8c0f6..7d5019a884024 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1061,7 +1061,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 	info->ce_count = obj->err_data.ce_count;
 
 	if (err_data.ce_count) {
-		if (adev->smuio.funcs &&
+		if (!adev->aid_mask &&
+		    adev->smuio.funcs &&
 		    adev->smuio.funcs->get_socket_id &&
 		    adev->smuio.funcs->get_die_id) {
 			dev_info(adev->dev, "socket: %d, die: %d "
@@ -1081,7 +1082,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
 		}
 	}
 	if (err_data.ue_count) {
-		if (adev->smuio.funcs &&
+		if (!adev->aid_mask &&
+		    adev->smuio.funcs &&
 		    adev->smuio.funcs->get_socket_id &&
 		    adev->smuio.funcs->get_die_id) {
 			dev_info(adev->dev, "socket: %d, die: %d "
-- 
2.40.1



