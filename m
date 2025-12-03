Return-Path: <stable+bounces-198877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0EC9FCB9
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7962D30019C6
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB534F492;
	Wed,  3 Dec 2025 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gk8i2ngt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F3313546;
	Wed,  3 Dec 2025 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777964; cv=none; b=nNeRzffwBdlv7YD5+R6Ws2OJMuIjSHRGEfuLs6Tzml7757sE7zfUWrJJbrSbAEOm2p0LtjiygHcBL4fGM88sknMMW4HV3KUgRLmYvzjAtVUQNFoDJ4B8AqdoiMCbPz6/pyaDz6Tc6LnXv+RVIPuvfHaHXuz4IgUqMWw8+giDv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777964; c=relaxed/simple;
	bh=FjzpW1vss1ZlwpZ4vKbd9E4TTun3UB9FMmR8B32bpMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmtcS9gH3Ee43bOECWJ76uvhr3B8e215UnzEaTuZ0TSQ1tJfNb3/7IpokoZOiPkcSz2A+Ni6rnr9O9HLnFDw8gJnX9vytdRRcs7juxAWzFrlUdS77QkDUhj7wfAmFtQMWM84UVebyE97IiqeO3+g9dWTscZOSzBqgOHAvSdB998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gk8i2ngt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC13C116B1;
	Wed,  3 Dec 2025 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777964;
	bh=FjzpW1vss1ZlwpZ4vKbd9E4TTun3UB9FMmR8B32bpMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gk8i2ngtAp4vBq4Sg+F20wkZC7yBtovbDe/d2ZlOnruQuqxWWIXeJsaBkLEEXv0cS
	 2YOZ3MziyaMJw2hpvMAzgGHY4AIC//EsDzoquc6drFTMv/oxlhAXASVRj+SBEZGYan
	 i8ydy+7cIGe9TwIEOwVJFZLet48mYa0osQIUU2AA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Randall P. Embry" <rpembry@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 200/392] 9p: sysfs_init: dont hardcode error to ENOMEM
Date: Wed,  3 Dec 2025 16:25:50 +0100
Message-ID: <20251203152421.434382120@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randall P. Embry <rpembry@gmail.com>

[ Upstream commit 528f218b31aac4bbfc58914d43766a22ab545d48 ]

v9fs_sysfs_init() always returned -ENOMEM on failure;
return the actual sysfs_create_group() error instead.

Signed-off-by: Randall P. Embry <rpembry@gmail.com>
Message-ID: <20250926-v9fs_misc-v1-3-a8b3907fc04d@codewreck.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/v9fs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 52765f7a3375a..3a44a77e276b8 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -594,13 +594,16 @@ static const struct attribute_group v9fs_attr_group = {
 
 static int __init v9fs_sysfs_init(void)
 {
+	int ret;
+
 	v9fs_kobj = kobject_create_and_add("9p", fs_kobj);
 	if (!v9fs_kobj)
 		return -ENOMEM;
 
-	if (sysfs_create_group(v9fs_kobj, &v9fs_attr_group)) {
+	ret = sysfs_create_group(v9fs_kobj, &v9fs_attr_group);
+	if (ret) {
 		kobject_put(v9fs_kobj);
-		return -ENOMEM;
+		return ret;
 	}
 
 	return 0;
-- 
2.51.0




