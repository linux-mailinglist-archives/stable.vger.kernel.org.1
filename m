Return-Path: <stable+bounces-23522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C17861C48
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 20:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1771C22E6C
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01834128831;
	Fri, 23 Feb 2024 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="1N9Om1Cl"
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FC11420C1
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715168; cv=none; b=Jn7ZfUGYrEVhFLwVCBxTkJqedCStwcpjEvtK9fxv+78wFtEmYUWkyDoEptWgHjFQTgmm6OKTnlw8w6Lq2dbJogB96T7qXTj/bbdgQn4bTrJFsRH1UnRKf6EZx0yT4Kjejanu7HEoVf0eXlPkLNH1BC8cSGawvK2WbgWvsqv0LKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715168; c=relaxed/simple;
	bh=qpzM6NBYR7WpVcp9/HBiZFKK8JElis+2lrx2b9BJFms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jvsa5OKu4kzfUU3etj7a1ZiNW8EG8xWVmNA8lEexnkl4xI9Lx3NuNBQH25M6PHqLWfVxuTnnFVck6kdUBJ9MaYsH65229L+B3NWJFOSV6Yw8g7K0fpvYoRvPMyVlPzzD9/akGFnkW64WQLaCOEhTdTASX9wf4odPWm2jqXTJG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=1N9Om1Cl; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ThKGt4rmsz2TC;
	Fri, 23 Feb 2024 20:05:58 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ThKGs49MCzjsT;
	Fri, 23 Feb 2024 20:05:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708715158;
	bh=qpzM6NBYR7WpVcp9/HBiZFKK8JElis+2lrx2b9BJFms=;
	h=From:To:Cc:Subject:Date:From;
	b=1N9Om1ClO+r+L8Qkam4EJkqyN1SiVBZqs5lER3lgzN2iIjXSyXKUsBnEwslb1urAP
	 jw9IIgIu8sDs1Q4U5Oe/6uKx2AlVRr4rQwt/lIGGpkjJ1kHax1FNIiJsD+DMzXzo78
	 KnimjfuRbCak8dfFUJl1/GYfQfvSCPQEYotFWX+c=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
Date: Fri, 23 Feb 2024 20:05:45 +0100
Message-ID: <20240223190546.3329966-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

selinux_lsm_getattr() may not initialize the value's pointer in some
case.  As for proc_pid_attr_read(), initialize this pointer to NULL in
selinux_getselfattr() to avoid an UAF in the kfree() call.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: stable@vger.kernel.org
Fixes: 762c934317e6 ("SELinux: Add selfattr hooks")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6bf90ace84c..338b023a8c3e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6559,7 +6559,7 @@ static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
 			       size_t *size, u32 flags)
 {
 	int rc;
-	char *val;
+	char *val = NULL;
 	int val_len;
 
 	val_len = selinux_lsm_getattr(attr, current, &val);
-- 
2.43.0


