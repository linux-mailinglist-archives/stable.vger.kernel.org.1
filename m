Return-Path: <stable+bounces-153927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBD9ADD6F9
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC8B4A3050
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ACE2EE268;
	Tue, 17 Jun 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HkfNtj4y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB062ED174;
	Tue, 17 Jun 2025 16:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177549; cv=none; b=hmj/xZALefP8bO9XKNrkROmIsmBBruDvawXOvjYSwdtmbi9unZVleEPPDiipYCYTGMrkax1JnKGFZ+/dMbg5OgI918cTR8BHIWZ77OEl+3t3VwqxYsvA/MjHoxM9gchN4f3aKjD8lUXqIAJqiw6J0LiyubSkfG22DXX85oo3oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177549; c=relaxed/simple;
	bh=QCgQbm+7ezgTV/YdAMdd+aNs3kBiR2u1oFygenIJofw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdTptWZCgO/a6rjGwvcgZfJMO/HlH2Mm7l/CLS5k4p7VgWsl8O9A0I4psxxRL927E6Ilw+47bC+BwaxUS4/QlJI03FB0Esr14aIw+zRXP/+ThRBo4EJeQw/XmVuLKnHnBio1zv1jH1u4wDSD35/9ejYiR6rV7bIBCisKY5Q+sQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HkfNtj4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B74C4CEE3;
	Tue, 17 Jun 2025 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177549;
	bh=QCgQbm+7ezgTV/YdAMdd+aNs3kBiR2u1oFygenIJofw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkfNtj4ylNOai87PRmlXMApJV0xzbQUQJJDW2nHbELcOJbYW2yMQSTZ0jvZR+TQiQ
	 G+EWnFLeZn8BsM3VsQsQPDfroLMZKAyFzCBJI998yjZBOsND1WryZyCxl0iWD8GJJC
	 2BYTTTu1KJ79HE1JOONFfw89zWWJkkZ6E//UTLgs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 344/512] drm/xe: Make xe_gt_freq part of the Documentation
Date: Tue, 17 Jun 2025 17:25:10 +0200
Message-ID: <20250617152433.534910898@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

[ Upstream commit 55f8aa083604ce098c9d6a0911c6bcde15d03a80 ]

The documentation was created with the creation of the component,
however it has never been actually shown in the actual Documentation.

While doing this, fixes the identation style, to avoid new warnings
while building htmldocs.

Fixes: bef52b5c7a19 ("drm/xe: Create a xe_gt_freq component for raw management and sysfs")
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://lore.kernel.org/r/20250521165146.39616-3-rodrigo.vivi@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit af53f0fd99c3bbb3afd29f1612c9e88c5a92cc01)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/gpu/xe/index.rst      |  1 +
 Documentation/gpu/xe/xe_gt_freq.rst | 14 ++++++++++++++
 drivers/gpu/drm/xe/xe_gt_freq.c     |  2 ++
 3 files changed, 17 insertions(+)
 create mode 100644 Documentation/gpu/xe/xe_gt_freq.rst

diff --git a/Documentation/gpu/xe/index.rst b/Documentation/gpu/xe/index.rst
index 3f07aa3b54325..89bbdcccf8eb7 100644
--- a/Documentation/gpu/xe/index.rst
+++ b/Documentation/gpu/xe/index.rst
@@ -16,6 +16,7 @@ DG2, etc is provided to prototype the driver.
    xe_migrate
    xe_cs
    xe_pm
+   xe_gt_freq
    xe_pcode
    xe_gt_mcr
    xe_wa
diff --git a/Documentation/gpu/xe/xe_gt_freq.rst b/Documentation/gpu/xe/xe_gt_freq.rst
new file mode 100644
index 0000000000000..c0811200e3275
--- /dev/null
+++ b/Documentation/gpu/xe/xe_gt_freq.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+==========================
+Xe GT Frequency Management
+==========================
+
+.. kernel-doc:: drivers/gpu/drm/xe/xe_gt_freq.c
+   :doc: Xe GT Frequency Management
+
+Internal API
+============
+
+.. kernel-doc:: drivers/gpu/drm/xe/xe_gt_freq.c
+   :internal:
diff --git a/drivers/gpu/drm/xe/xe_gt_freq.c b/drivers/gpu/drm/xe/xe_gt_freq.c
index ab76973f3e1e6..a05fde2c7b122 100644
--- a/drivers/gpu/drm/xe/xe_gt_freq.c
+++ b/drivers/gpu/drm/xe/xe_gt_freq.c
@@ -32,6 +32,7 @@
  * Xe's Freq provides a sysfs API for frequency management:
  *
  * device/tile#/gt#/freq0/<item>_freq *read-only* files:
+ *
  * - act_freq: The actual resolved frequency decided by PCODE.
  * - cur_freq: The current one requested by GuC PC to the PCODE.
  * - rpn_freq: The Render Performance (RP) N level, which is the minimal one.
@@ -39,6 +40,7 @@
  * - rp0_freq: The Render Performance (RP) 0 level, which is the maximum one.
  *
  * device/tile#/gt#/freq0/<item>_freq *read-write* files:
+ *
  * - min_freq: Min frequency request.
  * - max_freq: Max frequency request.
  *             If max <= min, then freq_min becomes a fixed frequency request.
-- 
2.39.5




