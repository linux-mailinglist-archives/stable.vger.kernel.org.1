Return-Path: <stable+bounces-110593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4168AA1CA38
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B927F7A26C3
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3165200BB9;
	Sun, 26 Jan 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxMT9f8D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8C200BA8;
	Sun, 26 Jan 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903431; cv=none; b=H+0vhKJ87PAUwo5NToElPaUloMXXks0q3loB+nsw34469XQvEZEXUCII1Ent976Ktzypqvwmu6X8lZn3q8TjHVH0qeuALRZ23Ryh6MY7MZjAHZ/M8LDqLFhhB4OIyXoZIMZ8Yk2lfMVYi6VkLw0fwQ8P/6ho9fdninRlirA+rqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903431; c=relaxed/simple;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eUTQmzdPnvndCMK7rlCJQx8JG83ks82QBZgT2NMHId3f7BEca4U2BLIxHXeX9Z5vs5r1LlekJmOPEGcR3+LvtcUFhWi/R9bbg+Dny6IhGpGQ8f7Gi7r/R/tb62rW8E7jq2f4tJqNggZxbMBJNqvXOI3CHtroIGvuw/CdfMUwbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxMT9f8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEEAC4CED3;
	Sun, 26 Jan 2025 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903431;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxMT9f8Dlgluc8lm1dpiXrex9ipp0Fc6zSBBYAPJPAw8LTU48n2ef5xVcT77G121B
	 zF2f4zb+Doohw+H42WImYGG0nmRM+b7uQ1s0XC6NF3L9p5db22bmElzXGp7hETEZe9
	 kzm7hyntUmKX+QLMSgOxdMCVUBl5aW1hA7Yj35UuCFkF2cxg0BmTv95NjExPfyBwEm
	 Hp3L7N+Vo2VCoYB/LEsUR9F9V51b2t+dECoLOxDuZafFdxXrKTGN9O8V8+Ko90/o0/
	 REoyI7yvlv8vb1bOI9UDEawBeckOpl1cupjmriyrHgvZHoRg5OppPN+B32RuNkJZPj
	 4vhwvC1HXGZ/Q==
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
Subject: [PATCH AUTOSEL 6.1 9/9] safesetid: check size of policy writes
Date: Sun, 26 Jan 2025 09:56:51 -0500
Message-Id: <20250126145651.943149-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145651.943149-1-sashal@kernel.org>
References: <20250126145651.943149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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


