Return-Path: <stable+bounces-105455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE189F97B8
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D7616F3C7
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF95228C99;
	Fri, 20 Dec 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mslib96C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3B228C8D;
	Fri, 20 Dec 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714743; cv=none; b=Bsnc6rSmcmOh7DNSmVrHQQIUP8JQc8NwpmFiFYPJ/Ay6Ik259284pBNqgetC8Fd+/dumLEDt+61QnLdrnuW+1ubWoUJEqaIRj9lWnEyw1izdbSTLrCXj8RtH7d7qj+cysfbmHZ9Im+oJ4srQ4PKLTIEUTmBGMei6IyITzzAMFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714743; c=relaxed/simple;
	bh=P3qZBSh1r8lSSEUyz038gIsRJtCw4sm+4oR0mTcz8Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=udWDq5qL5CFnU1u/bXTFzXZqAsmD871/5Pp3iTjdiLrVqJrCeXYlWWTj0HAk8d9O93sT6HkUGLI6MPBOlRno/YvyGm/+Gl5YIcQZJjPvCu2mdPCQ/d4q11AwDdfj89FcXyfTKBc5PHfvUtuAfOjTYoueA8CGMs2GtN1tQZhg/Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mslib96C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F62BC4CED3;
	Fri, 20 Dec 2024 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714743;
	bh=P3qZBSh1r8lSSEUyz038gIsRJtCw4sm+4oR0mTcz8Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mslib96Cp8yiTIgZ/y99pL1oP2MGecY3ZDc67mlgPFrJ97KFr34C+3Z5GiiGmCdTP
	 2lpZBcqO7JbQ3CyqC5uPvRDVhd2VQwtyrZQd3ZEOVOc/9qngYIYpJ6u5MkYTGe9BL8
	 g37bcSQWee9SORk7gH4tVZiOfAwC7yHWX64haYxh8Knr+W9GEGMRFYopp35uYbY2Hr
	 6H9Ol9bu1N00QEgpYFRfDJhmE6B07T8n61U1oJ2mmrtUAnqM+I3btby28qgg+J3v3+
	 Vl8qZHzL2QLnacCOR1iLAQsqAjyft7XxSC51swNbf0ePWM1B0+HrLlsgHSj8jBKCOM
	 Ba/PHwY2z392Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.12 23/29] smb: client: destroy cfid_put_wq on module exit
Date: Fri, 20 Dec 2024 12:11:24 -0500
Message-Id: <20241220171130.511389-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Enzo Matsumiya <ematsumiya@suse.de>

[ Upstream commit 633609c48a358134d3f8ef8241dff24841577f58 ]

Fix potential problem in rmmod

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index bf909c2f6b96..0ceebde38f9f 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -2018,6 +2018,7 @@ exit_cifs(void)
 	destroy_workqueue(decrypt_wq);
 	destroy_workqueue(fileinfo_put_wq);
 	destroy_workqueue(serverclose_wq);
+	destroy_workqueue(cfid_put_wq);
 	destroy_workqueue(cifsiod_wq);
 	cifs_proc_clean();
 }
-- 
2.39.5


