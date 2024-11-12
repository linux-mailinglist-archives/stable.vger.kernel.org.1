Return-Path: <stable+bounces-92757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185559C580F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185E5B28D36
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E529521C16E;
	Tue, 12 Nov 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIiM6e1w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116621B45B;
	Tue, 12 Nov 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408490; cv=none; b=LexxAJ15zigg7uANaO2NYSvGyuhhJtpAeXfnsKWu1QlQGqoGgoq3NI0reCocRtg/od4AtzUoz30EAcbJZGoVBZvmaGamHMLCKOCDucQD4fETf3N8RXc04v25OA+xrSSudytq4pKRUNzOjYgG+VAJXLDkpXqo+uQsk0ejMyLdjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408490; c=relaxed/simple;
	bh=K2Nz6eOKyPslq2VWy5/gWEb0u1m+Lwn9bBYYPKbS5rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUoatZ7TLmHp9RUn+m2UncK92TLxdjc/l/EwQk2OyZEyrjPZMd6EYdCQ78pgVCcpSqSNAHg/eHSeMpnC3M2INdhcUKWt9xh0ipNsCRQ5fY/rDeFaT+2b6rVKjtS+m99n9h7YuZ51W9kuTqjGFUcKBMBL29sH3ewNoNemrW5mEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DIiM6e1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2A1C4CECD;
	Tue, 12 Nov 2024 10:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408490;
	bh=K2Nz6eOKyPslq2VWy5/gWEb0u1m+Lwn9bBYYPKbS5rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIiM6e1w+1DOISHO8Ncdue3ZrgdBeof9j0CporL1RKJ8P7FNIgUuEZaGPbIyfCORp
	 kKXHD2A5xLeuqTM2CSqA8aylp97wBMxtg/9tNlJYzaRUwa89ecRKB5pybS1dMCpDwo
	 h4qQouHXBpNWYi6u5WgSC87o1ePp/5IuRwZLK4QA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Badal Nilawar <badal.nilawar@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 179/184] drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout
Date: Tue, 12 Nov 2024 11:22:17 +0100
Message-ID: <20241112101907.731215004@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nirmoy Das <nirmoy.das@intel.com>

[ Upstream commit 7d1e2580ed166f36949b468373b468d188880cd3 ]

Flush xe ordered_wq in case of ufence timeout which is observed
on LNL and that points to recent scheduling issue with E-cores.

This is similar to the recent fix:
commit e51527233804 ("drm/xe/guc/ct: Flush g2h worker in case of g2h
response timeout") and should be removed once there is a E-core
scheduling fix for LNL.

v2: Add platform check(Himal)
    s/__flush_workqueue/flush_workqueue(Jani)
v3: Remove gfx platform check as the issue related to cpu
    platform(John)
v4: Use the Common macro(John) and print when the flush resolves
    timeout(Matt B)

Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: stable@vger.kernel.org # v6.11+
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2754
Suggested-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241029120117.449694-2-nirmoy.das@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 38c4c8722bd74452280951edc44c23de47612001)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_wait_user_fence.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_wait_user_fence.c b/drivers/gpu/drm/xe/xe_wait_user_fence.c
index 92f65b9c52801..2bff43c5962e0 100644
--- a/drivers/gpu/drm/xe/xe_wait_user_fence.c
+++ b/drivers/gpu/drm/xe/xe_wait_user_fence.c
@@ -155,6 +155,13 @@ int xe_wait_user_fence_ioctl(struct drm_device *dev, void *data,
 		}
 
 		if (!timeout) {
+			LNL_FLUSH_WORKQUEUE(xe->ordered_wq);
+			err = do_compare(addr, args->value, args->mask,
+					 args->op);
+			if (err <= 0) {
+				drm_dbg(&xe->drm, "LNL_FLUSH_WORKQUEUE resolved ufence timeout\n");
+				break;
+			}
 			err = -ETIME;
 			break;
 		}
-- 
2.43.0




