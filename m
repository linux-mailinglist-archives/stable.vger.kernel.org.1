Return-Path: <stable+bounces-122260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDEFA59EAC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392E7166A68
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B0D22D7A6;
	Mon, 10 Mar 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xkVpqNqK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B614F1A7264;
	Mon, 10 Mar 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627987; cv=none; b=UZ8ZM0lFqQvqKv3xudalAq1gmyvUd6fynoFHbmvaeoz75i4gv9w/MKPJ9YnFx/5DJFGxu8HTMGb83dmoycfEwVphs4DCGSGDT8NhjegKMD8fmV65NYhNsudMX8A3qHdbDzJcIjjiS8mdSJ4TFX58kXKYkdPX5q0cK5EOaaRPiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627987; c=relaxed/simple;
	bh=hm+bWetTLthqzLAv+Hb+LIspyP7LS9jm4gEwF5d8Zoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUYIrpfgMIMcdblNSbRHsJHCHPtMCmb7A9aJ9tG+osT7bCBjwcNvfw4wxdn5qkWq/LMrMoSHanCkgl1PENLt/vGSpgah6ViO/Ad/6qPJjdEG+FE0IbLTeB/KxOpHvpDLwRBuwMuNFYk0EBhc3Y1IirtqLvJW6cLB9oHYtrIsudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xkVpqNqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77B9C4CEE5;
	Mon, 10 Mar 2025 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627987;
	bh=hm+bWetTLthqzLAv+Hb+LIspyP7LS9jm4gEwF5d8Zoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xkVpqNqKxw6LYKUnlAnTuizlNgRcerG6JqDSomN3rjlHKJkOw3AhxWp8OiIg6kMq3
	 RlGoJAggJXvPOkg4qkYsmiiMVo20YwlvRMj1DQBSuTp7HY6lIPf6ZKxJKUdQwJcC9M
	 UeOjZ5T284qTFcQQk48/+Ob0OlyLCSLUuxNvzaVc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Norbert Szetei <norbert@doyensec.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 031/145] ksmbd: fix use-after-free in smb2_lock
Date: Mon, 10 Mar 2025 18:05:25 +0100
Message-ID: <20250310170435.992082350@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
References: <20250310170434.733307314@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 84d2d1641b71dec326e8736a749b7ee76a9599fc upstream.

If smb_lock->zero_len has value, ->llist of smb_lock is not delete and
flock is old one. It will cause use-after-free on error handling
routine.

Cc: stable@vger.kernel.org
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7442,13 +7442,13 @@ out_check_cl:
 		}
 
 no_check_cl:
+		flock = smb_lock->fl;
+		list_del(&smb_lock->llist);
+
 		if (smb_lock->zero_len) {
 			err = 0;
 			goto skip;
 		}
-
-		flock = smb_lock->fl;
-		list_del(&smb_lock->llist);
 retry:
 		rc = vfs_lock_file(filp, smb_lock->cmd, flock, NULL);
 skip:



