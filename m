Return-Path: <stable+bounces-125394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033E9A6909C
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7123A172919
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941581F09A9;
	Wed, 19 Mar 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wwr3HBPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C61DE4C9;
	Wed, 19 Mar 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395157; cv=none; b=THik8eE9wQPajol4I8aCpRYf6N+ArR7HJkZZJCzwwPENzD/iQDC+xQWM3Jl0yQ7SzdahBVkDOMSQBOSGsmZaf7OgicwnoG5YoF9VFTp57Px+fBsuRYz2xFlKrJgTvfaAbdQBVRvL1NECEHw21vHaNKgII5rBTo+knAMkTvtH4fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395157; c=relaxed/simple;
	bh=scmSH+sjBKv3afpvlZHdjVQk5eCOt1ZMrfACKbqxDdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQEl/+o4JdxUcAIgNXx+0TEeYDOimQwEsDW/RhW40OhYySOh9csgMAfGvBxDCvuV1pzW/ABuCFRSqCewpWZNqbDfxmLH5I0eu7iWa60oPRzt0N6cpEfLjAXVFyRKSPBrGK0f1PITA6EUIF1V55uG5ldnvNML9S/dZRr7FEVSU8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wwr3HBPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26501C4CEE4;
	Wed, 19 Mar 2025 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395157;
	bh=scmSH+sjBKv3afpvlZHdjVQk5eCOt1ZMrfACKbqxDdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wwr3HBPjQ5V989sCiSR7fontT1aLgoGHQP2DxbE4sGTzviDnJgIFCcx3Ss9f5KEWo
	 K8PJzPpQpsXUcuroNX5h2r0TD1bFC7PmHBv7UO2ZfIhbaCVi5Enf5IM0n5c7Fg7QsC
	 9WW/91hv3/Fvx3uNQegXT9VxjpslKUecWa4oT+O8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@mt-integration.ru>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 215/231] cifs: Fix integer overflow while processing acregmax mount option
Date: Wed, 19 Mar 2025 07:31:48 -0700
Message-ID: <20250319143032.159701823@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>
References: <20250319143026.865956961@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@mt-integration.ru>

[ Upstream commit 7489161b1852390b4413d57f2457cd40b34da6cc ]

User-provided mount parameter acregmax of type u32 is intended to have
an upper limit, but before it is validated, the value is converted from
seconds to jiffies which can lead to an integer overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5780464614f6 ("cifs: Add new parameter "acregmax" for distinct file and directory metadata timeout")
Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/fs_context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index 21f8597f8d82e..e03946dc1d965 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1254,11 +1254,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		}
 		break;
 	case Opt_acregmax:
-		ctx->acregmax = HZ * result.uint_32;
-		if (ctx->acregmax > CIFS_MAX_ACTIMEO) {
+		if (result.uint_32 > CIFS_MAX_ACTIMEO / HZ) {
 			cifs_errorf(fc, "acregmax too large\n");
 			goto cifs_parse_mount_err;
 		}
+		ctx->acregmax = HZ * result.uint_32;
 		break;
 	case Opt_acdirmax:
 		ctx->acdirmax = HZ * result.uint_32;
-- 
2.39.5




