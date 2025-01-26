Return-Path: <stable+bounces-110533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84A7A1C9DF
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBC83A8DB5
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEED1F76B6;
	Sun, 26 Jan 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ev58wf6l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4609A1F76AC;
	Sun, 26 Jan 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903280; cv=none; b=FTkzdX4RqK7ad5fLXtQMxLrC72I7n0eje9TFXwZ8MvAuo/outYldPcLEi6Za9jIDLevrqRzYzh6xZi5qfbSdG8MwFuw37tdhjPkolP5suP02vgUyK7oYSamBVdq8MPekecJbDJ4svOgGUMaOey9yWBnOrJ4gqGz8Ph+YsuR1cds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903280; c=relaxed/simple;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAu6QxQeYbAGgz9FjUXtWDs2f0blIspb6TBcKKQvtpfRoYv7mLLNAgLljCfN9mbSWZnQNdFjP3LMBvJ9GwDNjbwKk49gmK1uKs07k0URY0En8mjQFFw9QadDpSJ7Kk4Yp3Klii/NUy1Iks16BPuAdAugLW5ReJtrGR3YKhwBOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ev58wf6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF17C4CEE5;
	Sun, 26 Jan 2025 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903280;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ev58wf6l1lvIEozBkVIMkEThsIFP513RILG5cR16jUEPv3LNoiiRTPUMiAlGDiVTt
	 B1JKzFq6afmpHBzNiQsHq5qdTp4SYZRv3x+5pm7lRpjGZkBJFDnM39t+9Mif2Qz7iE
	 ay/Ps06OyYwEdPYQfVR88CmclYgBQmSCEtfg23eFDLdHaeQafeB3QCW12cA5MZZsU3
	 Vhwe+LrLzhVl+cEVJPNBBA88Fm517lcArvfN2gM/iB/GevOuIWDeroCsvItZAlmKSP
	 KkyCr9FweR975CErwta7e8J2xpo4xWJabJ00ARIct6o4wEiXk6ul1U8UrboNyVm1ra
	 joM4qYs1n0raA==
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
Subject: [PATCH AUTOSEL 6.13 31/34] safesetid: check size of policy writes
Date: Sun, 26 Jan 2025 09:53:07 -0500
Message-Id: <20250126145310.926311-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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


