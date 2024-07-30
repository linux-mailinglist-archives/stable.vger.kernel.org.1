Return-Path: <stable+bounces-63540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A927941977
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448B11F258D9
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5D7183CDB;
	Tue, 30 Jul 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dPm6giEn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBDE1A6195;
	Tue, 30 Jul 2024 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357155; cv=none; b=SrMTDyX5R+Ebg8kNuoz/ZjN38BYs38uqb2nt9gwyygsEBLA31qpWQ0/53H1BwFJi1721vqDU6YsDi2vEZ2SqnkJcZoC+CraNIOmEx0SLfA87A7iNaktGCCokMSAACHMpLA7uCBMGI5sDqs33dR1d88gyAC+jcfXVOksG3DtwJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357155; c=relaxed/simple;
	bh=z58emz38b2+GinssG/KfUa9g4K0Cdp5qHIMcT2oBOqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgffmAYE8chmUYSjM+QER2lSErgSDkEf7w133HP1rxF4qs0esVrmoZZ4SCQ8Y6ww40tmVH49+dhG11UBUDB7J1g1OpytkX6kwL4cCRA+unOoc3RNaapeLbg7Jc3500y7grs3otVYT8pC460zTae1Evgpxkn5joMVvpf4K+gdt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dPm6giEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B78C32782;
	Tue, 30 Jul 2024 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357155;
	bh=z58emz38b2+GinssG/KfUa9g4K0Cdp5qHIMcT2oBOqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dPm6giEnRntPVRd0YefiUps/x57TdFNWHJUd8VSo4xPP4CQQq0R2X7A79t7HUn4CZ
	 PuVyADkDOKEZjN8La6gpG9fZuVEGLIBSv7Dq/8raSUt4B/TZZ9d7vLpODR65L/P36d
	 /XO12MAhbuKU9ZrRImPQy31YvWKYFNO8zbKXsbRY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 264/440] fs/ntfs3: Keep runs for $MFT::$ATTR_DATA and $MFT::$ATTR_BITMAP
Date: Tue, 30 Jul 2024 17:48:17 +0200
Message-ID: <20240730151626.152834453@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit eb95678ee930d67d79fc83f0a700245ae7230455 ]

We skip the run_truncate_head call also for $MFT::$ATTR_BITMAP.
Otherwise wnd_map()/run_lookup_entry will not find the disk position for the bitmap parts.

Fixes: 0e5b044cbf3a ("fs/ntfs3: Refactoring attr_set_size to restore after errors")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 94b26c951752e..0388e6b42100f 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -681,7 +681,8 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 			goto undo_2;
 		}
 
-		if (!is_mft)
+		/* keep runs for $MFT::$ATTR_DATA and $MFT::$ATTR_BITMAP. */
+		if (ni->mi.rno != MFT_REC_MFT)
 			run_truncate_head(run, evcn + 1);
 
 		svcn = le64_to_cpu(attr->nres.svcn);
-- 
2.43.0




