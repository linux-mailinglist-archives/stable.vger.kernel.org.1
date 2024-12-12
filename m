Return-Path: <stable+bounces-102804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AE79EF54B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1E9170C33
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D72D22968F;
	Thu, 12 Dec 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1j9VmlIt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F452288F5;
	Thu, 12 Dec 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022553; cv=none; b=IRYlODVZLK9uCpO6yWAxMTB+lmDd7OmCCXv/+D88FI/VGTNCIO+RmwLpDKVID2St0S5DWm5TZBkmHGbJp8tcruXYONct/4oqE2pzzmWi3nomhJYhd4e057LFKxq0+JdD3jBFnizMSSpPb1dTG6ulrjzWhjrTGyMW+9zu9H47jT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022553; c=relaxed/simple;
	bh=i0ARyF5ushn4AXN0OZ4tCGXhN5zWJJ/MxN/k2lVwEKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAeJEjqkdebXXhuPHMNKn167u8qJzf+uMD9s/eth9aSCj2jLzW5ktmNVGhV3qfkHty4RaNpOLmpMQpgCdXMZ9lecc64F+Il4DYwMC1pCsYR/lu6WWrcAqjJxIk8CgZ1kj/KE4lYc36S83f8lK/x8OOgYhlFe1azd4wyFskKa7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1j9VmlIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A98AC4CED4;
	Thu, 12 Dec 2024 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022553;
	bh=i0ARyF5ushn4AXN0OZ4tCGXhN5zWJJ/MxN/k2lVwEKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1j9VmlItcN8UvFMNC2jfGOT7anobyA1I/gDo2+slfELPcdl1QrF9z+SjcouvdE4cY
	 YC1L0AuAPruwCKXA3NEw1GRU1prFBc/dZYNjYX8NDI4TADetWCxlKSoyIfUIBuJZ/E
	 dwjqzrS7Z7CTziHBBy/j4N9ZN2FtqO5VblZNnj8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Eric Sandeen <sandeen@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 272/565] fs_parser: update mount_api doc to match function signature
Date: Thu, 12 Dec 2024 15:57:47 +0100
Message-ID: <20241212144322.214671679@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c66f759832a83cb273ba5a55c66dcc99384efa74 ]

Add the missing 'name' parameter to the mount_api documentation for
fs_validate_description().

Fixes: 96cafb9ccb15 ("fs_parser: remove fs_parameter_description name field")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20241125215021.231758-1-rdunlap@infradead.org
Cc: Eric Sandeen <sandeen@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/mount_api.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/mount_api.rst b/Documentation/filesystems/mount_api.rst
index eb358a00be279..12e30da6a511c 100644
--- a/Documentation/filesystems/mount_api.rst
+++ b/Documentation/filesystems/mount_api.rst
@@ -778,7 +778,8 @@ process the parameters it is given.
 
    * ::
 
-       bool fs_validate_description(const struct fs_parameter_description *desc);
+       bool fs_validate_description(const char *name,
+                                    const struct fs_parameter_description *desc);
 
      This performs some validation checks on a parameter description.  It
      returns true if the description is good and false if it is not.  It will
-- 
2.43.0




