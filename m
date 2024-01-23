Return-Path: <stable+bounces-14664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204D583820C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC880286ACA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284F57316;
	Tue, 23 Jan 2024 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B0ViLd15"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024F651C44;
	Tue, 23 Jan 2024 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974048; cv=none; b=JGej1GhsuGZD7VBxszY/I3cFQgKyZyMtfisTuBSGMXqRvJWb8hEQIvUN63FEo8OiL/TEXdnreh2TiXzDuZyFyIWi6PsCC+vnxrKy4E3+lz0ECQFCBjOMXAvo6djdai9TTy7al6FNEfZ9u0lw3kd7wtG/hg0YeB+oK+JQSXL2bbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974048; c=relaxed/simple;
	bh=bM4K5mqi1kw1sfQK9typFJFGnZv8qjJrMDNVqRTda9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g09CRxFSl+Jh4bvbp45+Iiy0P+MZju+cqnSo8Up0NzzqdLwdOL+DSGOGiyOXIs71MeWQZ6u0zQfzxScwZHRqlOr7sbIZTilWCvOmc/HrosRd8UjzN31VXFvlaU3xB329XHokYqssspf4JPB612jRnX51Lja6i8EL51S1aq0fWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B0ViLd15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59192C433C7;
	Tue, 23 Jan 2024 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974047;
	bh=bM4K5mqi1kw1sfQK9typFJFGnZv8qjJrMDNVqRTda9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0ViLd15MrNTVwkxH9bz2jeVFvFnbwlaYpSwtahRXDvvDNt7xBOL/a0tX5SdD2A2x
	 0ijjgD2UHLm5vCEA++f5lwZjjOevLiCqIYaPdrBcDhVEMQjKSF1HvDmbRmbkuSXYRW
	 N9oXUWO9AYLW9Eeg08Ha9OFjgIuNiNunh2kxguyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 016/583] powerpc/powernv: Add a null pointer check to scom_debug_init_one()
Date: Mon, 22 Jan 2024 15:51:07 -0800
Message-ID: <20240122235812.715785233@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 9a260f2dd827bbc82cc60eb4f4d8c22707d80742 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.
Add a null pointer check, and release 'ent' to avoid memory leaks.

Fixes: bfd2f0d49aef ("powerpc/powernv: Get rid of old scom_controller abstraction")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231208085937.107210-1-chentao@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/opal-xscom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 262cd6fac907..748c2b97fa53 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -165,6 +165,11 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
 	ent->chip = chip;
 	snprintf(ent->name, 16, "%08x", chip);
 	ent->path.data = (void *)kasprintf(GFP_KERNEL, "%pOF", dn);
+	if (!ent->path.data) {
+		kfree(ent);
+		return -ENOMEM;
+	}
+
 	ent->path.size = strlen((char *)ent->path.data);
 
 	dir = debugfs_create_dir(ent->name, root);
-- 
2.43.0




