Return-Path: <stable+bounces-48794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B058FEA92
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362D71C2561B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7511A0AE2;
	Thu,  6 Jun 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1MmV/4D8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA11991B4;
	Thu,  6 Jun 2024 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683150; cv=none; b=KEkR+lt9n6skBXjfkxFCQ8eN82/wfGpxKgcZjo4F6ysEoM78QEBlevM1TKWIxR33t83kV2aCOfyBFFkjz7OwAwb2ryOEIQnoRXWDjDeDuVN0FsT6xEb9JtLtr39GTwnFBTp67aj4Ad2OryPWD5bNJAx5nBZKny8sJJFowjIerEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683150; c=relaxed/simple;
	bh=WHLCH+h06rT2mnF+HQP833QKFNE2xjXjsfM+T0A8SuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwa8xLTtKiS4fle+yMxs3PLZzqb9flyzBmUnYkYKObuAp1ODqGTl+RekC3kHhqjm0ezPsuscauYVTzj3YgF0pqt5MWCBZ01OF7l9H3p4dd0oJwA4GktXUYqjCD1xA389k0d/WKjupMokU0bLCEGne2o37dlqiEjka+GCJNWZ+m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1MmV/4D8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B352C2BD10;
	Thu,  6 Jun 2024 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683150;
	bh=WHLCH+h06rT2mnF+HQP833QKFNE2xjXjsfM+T0A8SuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1MmV/4D8P/JA9mhNqBlbYF5lVjU6jZ7g5uOb61h+X/f4Uh/+CYVpADri/K9HY5nU7
	 y8rJZVcq3WQo9FP8v0MzPMLTeWZqH9srydUhaJ5k6AYgXwNTQbkkxL9Jo91YlCYxqo
	 GLdbTE143aFIyUODlWHAN4B+kVX3uQQybIy5b2u4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nandor Kracser <bonifaido@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 022/473] ksmbd: ignore trailing slashes in share paths
Date: Thu,  6 Jun 2024 15:59:11 +0200
Message-ID: <20240606131700.592004586@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nandor Kracser <bonifaido@gmail.com>

commit 405ee4097c4bc3e70556520aed5ba52a511c2266 upstream.

Trailing slashes in share paths (like: /home/me/Share/) caused permission
issues with shares for clients on iOS and on Android TV for me,
but otherwise they work fine with plain old Samba.

Cc: stable@vger.kernel.org
Signed-off-by: Nandor Kracser <bonifaido@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/mgmt/share_config.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -165,8 +165,12 @@ static struct ksmbd_share_config *share_
 
 		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
 				      GFP_KERNEL);
-		if (share->path)
+		if (share->path) {
 			share->path_sz = strlen(share->path);
+			while (share->path_sz > 1 &&
+			       share->path[share->path_sz - 1] == '/')
+				share->path[--share->path_sz] = '\0';
+		}
 		share->create_mask = resp->create_mask;
 		share->directory_mask = resp->directory_mask;
 		share->force_create_mode = resp->force_create_mode;



