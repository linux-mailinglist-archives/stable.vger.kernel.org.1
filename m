Return-Path: <stable+bounces-110595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E37A1CA4D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FAB16336A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9386C2010EF;
	Sun, 26 Jan 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC6qoJsh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915C20101F;
	Sun, 26 Jan 2025 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903437; cv=none; b=HEy2NIn4KEFJvt2hN2A7RIxqeNhpL664qb2LDj3Imr5qnyuAednFYvIcq9vmSzhgRuq917oe5pEdB+LzkrbqJK0MyjMWV3mI6Wv4HAJZJaW0t3xaNXq05oEvxBp4ccxYLLe0oXI3mM+EsDyVkzncZJncwr+4JOFqyWosyiOlRag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903437; c=relaxed/simple;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEtZTxfdW3m0jCzCDMyQ9s3ZVjxgvLxJFQVy3JxYCIC1Nb04uuqALPKoTLITpyKkI5UCLSQqTh2Uhesu4GeE0Jmok5xAENd8p1+NJV7ttdkuNk1TbbEca4ea7kjF2Yp3aPcevB1HquThgtjUfSkYEAgGmQNzK6HPmGVsS+X84S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC6qoJsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EF4C4CED3;
	Sun, 26 Jan 2025 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903437;
	bh=uPc4NVSveHI7GHriDuEDZNzg3746xNX8eV/7hKr234Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dC6qoJshSKChBddAbYCqgTbWczgEfdX+c70EGLUe29+zod4tq/568fwjgbGwnbRob
	 Nz9vIk4SKqbNzdLukSCGFamipMWk8/z8iBByfITTj6o6OpC2UHpy192sxypMDAIRg0
	 zbEA+S9rTOGBRrCalWS/zRgvEfJU31QBLTSFThEN7PDm7FPpeX1yYBfCtxXq9HfSuc
	 KH9lh+hRPipl604IWMBUgAKan4lNVRFJp8t7TdYxaQjwqsdlpUE4KgrbOze0OlPKCp
	 m5a1JfrkuXmyaQswTl64DLZMw1O/VaGccLWNgUrmsCs1RgMwXYfMnrGGC19PXi3PmW
	 sJU7Ys0V0pZ+A==
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
Subject: [PATCH AUTOSEL 5.15 3/3] safesetid: check size of policy writes
Date: Sun, 26 Jan 2025 09:57:11 -0500
Message-Id: <20250126145711.946014-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145711.946014-1-sashal@kernel.org>
References: <20250126145711.946014-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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


