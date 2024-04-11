Return-Path: <stable+bounces-38671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E08A0FCA
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84545281D5A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382E71465BE;
	Thu, 11 Apr 2024 10:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZbtAMA/S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0631422CE;
	Thu, 11 Apr 2024 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831255; cv=none; b=XUQaC97g/bYAOoBZ34ukUc/UYz086doFiOmcdSp8PPpBBFX8qQIBAPJxcSRurOVvnfZpkqWKx2QWedWJUbofQA1jtS/LIW9YeveieBGpFgz7bcgpl6Jzf2A7fCZNcSnHP+mY1uhb5ovyKAnC+3ipjIoUiFyZRjYwEJ524x/dz2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831255; c=relaxed/simple;
	bh=VbYIJ9sU6O9KOfEOllV0DtK7Zy0zKEno5aORUeC/l/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOAWsK70gYbwKRlc+1tEyLXQQY4upe54FCYxH1IVfkXJNORzFCe7wddflArgk5RMnR/x89puFTMoZ3x5WGXLLINlI+ShFmsYsImquZxtwZa+VJwQu6d1dsrHe8pOHyC9lTMXPgJ1PjifipOD5v6D8IXWObOBhL6OuEEzBmmlzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZbtAMA/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718E2C43390;
	Thu, 11 Apr 2024 10:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831254;
	bh=VbYIJ9sU6O9KOfEOllV0DtK7Zy0zKEno5aORUeC/l/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZbtAMA/StBk9XRUixH0DpeafBV1mQ5i8TYEKIiM0BO7C78On7+ag/ouPylhNF7M5Q
	 cG/giohYusZ2/dxEdZ1/28P8YJ46rblHUulUZGbySzb53HyBkbDwUXT5CLJU2i/3pe
	 1B+c51PrYokGB7ryHEn2VVbkJJ2ZfewqjXyE8GvQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Elfring <elfring@users.sourceforge.net>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 023/114] firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()
Date: Thu, 11 Apr 2024 11:55:50 +0200
Message-ID: <20240411095417.569627603@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 1315848f1f8a0100cb6f8a7187bc320c5d98947f ]

The kfree() function was called in one case by
the get_filename() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function “kzalloc” failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/tegra/bpmp-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index 6dfe3d34109ee..b20d04950d99b 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -77,7 +77,7 @@ static const char *get_filename(struct tegra_bpmp *bpmp,
 
 	root_path_buf = kzalloc(root_path_buf_len, GFP_KERNEL);
 	if (!root_path_buf)
-		goto out;
+		return NULL;
 
 	root_path = dentry_path(bpmp->debugfs_mirror, root_path_buf,
 				root_path_buf_len);
-- 
2.43.0




