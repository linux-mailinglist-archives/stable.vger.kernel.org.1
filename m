Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD9B7D32E4
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjJWLYw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjJWLYv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:24:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907BD102
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:24:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC408C433C7;
        Mon, 23 Oct 2023 11:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060288;
        bh=vdQLv1kieDuGZe+2J2WsnDybCmoDlmYEbDt0AqwOGIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iChLhxujeBnTxcr2qmSZyB3wDSZPvHYM8MgGgr3tbzcTXXqFbCWWUxsXhbmaN/vq0
         n0pXvvYUC481VCElox8gtIVQ+s4Nx66KyK1zHDyS6yqnqRU/V8x15od1j7Ithm/EQR
         BIfTDhxA8f0pC79xwDnoK1CpQp8mom8GUFolSPx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kenneth Feng <kenneth.feng@amd.com>,
        Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 122/196] drm/amd/pm: add unique_id for gc 11.0.3
Date:   Mon, 23 Oct 2023 12:56:27 +0200
Message-ID: <20231023104831.958190194@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit 4953856f280b2b606089a72a93a1e9212a3adaca ]

add unique_id for gc 11.0.3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8472013ff38a2..0e78437c8389d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1991,6 +1991,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
+		case IP_VERSION(11, 0, 3):
 			*states = ATTR_STATE_SUPPORTED;
 			break;
 		default:
-- 
2.40.1



