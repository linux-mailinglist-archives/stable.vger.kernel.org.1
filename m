Return-Path: <stable+bounces-187367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 397F8BEA3DA
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E65215874C1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA791330B20;
	Fri, 17 Oct 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nTmk6BfK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F445330B1C;
	Fri, 17 Oct 2025 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715869; cv=none; b=EqESy8TJVH+IZZZg2nEhsdjAoiGBbjYipcOMu1uWPB0wWQXuMLy8DEicB3nqbjFEr22169mblxmW0/rtQRUkQyaSMpOqpdbU24atSFkvFJu5KIYIIB/yNpAeRjbsnswAenPw9bm8gATyQ/Tnn7lqvzJc1Qg7RVTDbGm8gnNvHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715869; c=relaxed/simple;
	bh=lgSq0hr+PeiiJfrEVejA1pa75brgx5nc6a7gXpONxl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwMI6RGf1MWlMOKwGsBHCz/insaOHunpwXvprYkBqyx5rVUpqVwsTWqp6sRrO5LzIid59IJyTVwg10ih9Ybzg/fDYRNOMbAbPbI0y3o2YFrdfEnsY8mJOCReSKUMRQ9BKjAeGQHAVvjrJWWlH2VcSXmvQYUGRO8qT5xJn/wFdFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nTmk6BfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE559C113D0;
	Fri, 17 Oct 2025 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715869;
	bh=lgSq0hr+PeiiJfrEVejA1pa75brgx5nc6a7gXpONxl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nTmk6BfKSbR9292HB2dhwuXW6mUABFAH/CHu6eF6n8iUFwrvEqSdEq1vxouwVj91d
	 fESlQkxFJhsblqXUFa/KlCWg1vCgDw8bbbQe3jPqlo017OJfrb/aUjU8q+NDXzzpdl
	 boJEikIUSflo79PM2dVTsCkK2VfwKcqKcdoOpO/w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 365/371] nsfs: validate extensible ioctls
Date: Fri, 17 Oct 2025 16:55:40 +0200
Message-ID: <20251017145215.292205160@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit f8527a29f4619f74bc30a9845ea87abb9a6faa1e ]

Validate extensible ioctls stricter than we do now.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nsfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 59aa801347a7d..34f0b35d3ead7 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -169,9 +169,11 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
 	/* Extensible ioctls require some extra handling. */
 	switch (_IOC_NR(cmd)) {
 	case _IOC_NR(NS_MNT_GET_INFO):
+		return extensible_ioctl_valid(cmd, NS_MNT_GET_INFO, MNT_NS_INFO_SIZE_VER0);
 	case _IOC_NR(NS_MNT_GET_NEXT):
+		return extensible_ioctl_valid(cmd, NS_MNT_GET_NEXT, MNT_NS_INFO_SIZE_VER0);
 	case _IOC_NR(NS_MNT_GET_PREV):
-		return (_IOC_TYPE(cmd) == _IOC_TYPE(cmd));
+		return extensible_ioctl_valid(cmd, NS_MNT_GET_PREV, MNT_NS_INFO_SIZE_VER0);
 	}
 
 	return false;
-- 
2.51.0




