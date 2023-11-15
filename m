Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA597ECBFC
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjKOT0C (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjKOTZq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A62B1B6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2809DC433C9;
        Wed, 15 Nov 2023 19:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076342;
        bh=LCdbfv1oWqVcFQX7LQIJBzT/IeHrIgp+W/EgPtY8IZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyQjlcZyhPcQKqvq9BhkQIVGEPsolOgH8OQczVfo+w2XcLi9Q1ZrZy0yXDNYaIIZg
         +YD5rJmytMC7Zqs5j8o5/g3ujiKtMWTLHjUccocZpZlIIhEPJg2gXE3Adco3gKiM8U
         ByUZzjmf5s5cpzIcSV7pf2YkhgYXR3Fh3O3QHu5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Sierra <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 231/550] drm/amdkfd: retry after EBUSY is returned from hmm_ranges_get_pages
Date:   Wed, 15 Nov 2023 14:13:35 -0500
Message-ID: <20231115191616.739559575@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Sierra <alex.sierra@amd.com>

[ Upstream commit ebac9414a56a5f7c336db5f5c7cc34713b649407 ]

if hmm_range_get_pages returns EBUSY error during
svm_range_validate_and_map, within the context of a page fault
interrupt. This should retry through svm_range_restore_pages
callback. Therefore we treat this as EAGAIN error instead, and defer
it to restore pages fallback.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: eb3c357bcb28 ("drm/amdkfd: Handle errors from svm validate and map")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a9b57c66cb7d7..4c1b72194a6f8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1651,6 +1651,8 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		WRITE_ONCE(p->svms.faulting_task, NULL);
 		if (r) {
 			pr_debug("failed %d to get svm range pages\n", r);
+			if (r == -EBUSY)
+				r = -EAGAIN;
 			goto unreserve_out;
 		}
 
-- 
2.42.0



