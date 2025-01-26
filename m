Return-Path: <stable+bounces-110584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83117A1CA46
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C553AA7AC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7908B1FF1DD;
	Sun, 26 Jan 2025 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ2fP8NN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311941FF1D5;
	Sun, 26 Jan 2025 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903411; cv=none; b=Nq3ecDjTWmHunY50upQlNW4i5TiwXX3ZixzlhETmErIhIV3Iy2fq6MgN6ljm7936GRTd51sJBo1G97x3LXApxlugXxQ6Q9C8/8U372Z4IgHiqi1ZN0FS4bepl+HiEtb6uz21dXAOEXmb+4lMX54zpvolPtxbrnSeFaDeYDtuuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903411; c=relaxed/simple;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1Xs5hGIQNR7lY5QzbPY0/FFMDCP/pj0ietY242fayxaiAz1cmbwBXDmCT4PlrGNdeWAA54nItBSCiO3lv9rNg01BaRhhlUEwdzhzMF6dUEP69noxt03/qpUAJJbKEZRhZnFtVZAHSnW2nk6r8rCBjUnecfpjY4C/UuICkshTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ2fP8NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B06C4CEE3;
	Sun, 26 Jan 2025 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903411;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJ2fP8NNJFMz1c5Df2kgEy/COa7hEFw0KIc5Hxl4bflYwyROVR6pyDmj6rpfCcd4P
	 O8IitPdLrViALXWzsgsgCHFeUEgsM+yiVf4efhcbg70RbJQF8t85WhW+pzQuCR7zcA
	 bwpRMu/cmGqQwWod8icmmsZrxeNFLOuriahZzN5GlKdOVLJIBWKNvWt0ajhOJBA6Kw
	 tVSSm4JTg9adMCY9xeM3PWcHOCJ/suaplrpkdvks1pUaxQYDz4W+SJjBq+MuIvlWNp
	 J3s62Ffuy0k0qmvrJtVaByItq8gjo33A6vYK4AMYo9ZDsG5gJeRgy0E3ciy5xlxZPS
	 1C04Oa2tN+Xjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>,
	mortonm@chromium.org,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/17] safesetid: check size of policy writes
Date: Sun, 26 Jan 2025 09:56:12 -0500
Message-Id: <20250126145612.937679-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145612.937679-1-sashal@kernel.org>
References: <20250126145612.937679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Leo Stone <leocstone@gmail.com>

[ Upstream commit f09ff307c7299392f1c88f763299e24bc99811c7 ]

syzbot attempts to write a buffer with a large size to a sysfs entry
with writes handled by handle_policy_update(), triggering a warning
in kmalloc.

Check the size specified for write buffers before allocating.

Reported-by: syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4eb7a741b3216020043a
Signed-off-by: Leo Stone <leocstone@gmail.com>
[PM: subject tweak]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/safesetid/securityfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 25310468bcddf..8e1ffd70b18ab 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -143,6 +143,9 @@ static ssize_t handle_policy_update(struct file *file,
 	char *buf, *p, *end;
 	int err;
 
+	if (len >= KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
 	pol = kmalloc(sizeof(struct setid_ruleset), GFP_KERNEL);
 	if (!pol)
 		return -ENOMEM;
-- 
2.39.5


