Return-Path: <stable+bounces-94902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD809D707B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E63B2820CB
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD618FDAB;
	Sun, 24 Nov 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw3sr+en"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8014A191478;
	Sun, 24 Nov 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455194; cv=none; b=QXTkvnMGdF17ehfqoP/xhJI0zU3F9GPf9S/+l0pUaQ3XxG+A85KPnrjc+UMeVAPa3Q/9wF4fGAbvuAV1iZt5Zwoa9NFAfm3eE+HYK+GjlYMjmiXXBODfr6ETtE6wUUGtqMa0pe5sLLZOrxy4nm84t5yPOulUjribgaQtEnEWskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455194; c=relaxed/simple;
	bh=hQ5NY1jaizmgk7a+NJFuengPPuLOsa5k6ked4uj/5pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljChHjv4Jw1XoFWRt1c9sE9ezv8MsEj7mzcTL+5Fn0dulzEPfkUCZbfvTYqAopm6wivIsoJkxs+7RNAYe3SlN+ONPLVIzv9Eh4FWT4tPhXZqYIMg9BtGKhW7v+7GpnaQKJgQajR7R8u/qAO1+a7kAWiCKDWeP2jnwTOmKQH7YEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw3sr+en; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00C5C4CED1;
	Sun, 24 Nov 2024 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455194;
	bh=hQ5NY1jaizmgk7a+NJFuengPPuLOsa5k6ked4uj/5pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tw3sr+enxbn1sRA54Rjp4hNQ6xS+FIbajuASedcJl2sZn6Z7cuSx6VrA2wzsfGS2k
	 /3NCK9EFukZXZxsYu4gn2ef3+ztGsOWdapqLjA/q1Iwue+ZaqJdaaW2IGSduiUDfpG
	 Dbe2P+rFbqBwo27xTk6gwcbOJswXSQXxJtl7wkjQr5YyLdN8JUURRzR2xjEhu1rBwt
	 jItnWpxPIz8jK4GesDWXM7cAQd06n/lp7ilhQGVIJcKn1OMdVUrvOViFmdC1R5bTS0
	 3J5sv8i3HVPaU19/BQM6+mKWZnR3N/9NFzJEu/l8BIvFS49LvtarZE8V23rhphxySW
	 cZXJaCQnsQZEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 006/107] drm/xe/pciids: Add PVC's PCI device ID macros
Date: Sun, 24 Nov 2024 08:28:26 -0500
Message-ID: <20241124133301.3341829-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

[ Upstream commit 5b40191152282e1f25d7b9826bcda41be927b39f ]

Add PVC PCI IDs to the xe_pciids.h header. They're not yet used in the
driver.

Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/6ac1829493a53a3fec889c746648d627a0296892.1725624296.git.jani.nikula@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/intel/xe_pciids.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/drm/intel/xe_pciids.h b/include/drm/intel/xe_pciids.h
index 67dad09e62bc8..59233eb008628 100644
--- a/include/drm/intel/xe_pciids.h
+++ b/include/drm/intel/xe_pciids.h
@@ -189,6 +189,22 @@
 	MACRO__(0x7D60, ## __VA_ARGS__),	\
 	MACRO__(0x7DD5, ## __VA_ARGS__)
 
+/* PVC */
+#define XE_PVC_IDS(MACRO__, ...)		\
+	MACRO__(0x0B69, ## __VA_ARGS__),	\
+	MACRO__(0x0B6E, ## __VA_ARGS__),	\
+	MACRO__(0x0BD4, ## __VA_ARGS__),	\
+	MACRO__(0x0BD5, ## __VA_ARGS__),	\
+	MACRO__(0x0BD6, ## __VA_ARGS__),	\
+	MACRO__(0x0BD7, ## __VA_ARGS__),	\
+	MACRO__(0x0BD8, ## __VA_ARGS__),	\
+	MACRO__(0x0BD9, ## __VA_ARGS__),	\
+	MACRO__(0x0BDA, ## __VA_ARGS__),	\
+	MACRO__(0x0BDB, ## __VA_ARGS__),	\
+	MACRO__(0x0BE0, ## __VA_ARGS__),	\
+	MACRO__(0x0BE1, ## __VA_ARGS__),	\
+	MACRO__(0x0BE5, ## __VA_ARGS__)
+
 #define XE_LNL_IDS(MACRO__, ...) \
 	MACRO__(0x6420, ## __VA_ARGS__), \
 	MACRO__(0x64A0, ## __VA_ARGS__), \
-- 
2.43.0


