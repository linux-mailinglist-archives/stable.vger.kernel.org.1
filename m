Return-Path: <stable+bounces-121752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB50AA59C1B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B984816DB55
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481823373D;
	Mon, 10 Mar 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVZ985h/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC31233716;
	Mon, 10 Mar 2025 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626526; cv=none; b=hQDK5RsHl4FbJ+pHqmAULNjPRbVdk06qUo6/4++IWBKYOUFWR690RmmYWCBJeXIfHegV+eSxqJNPkANMl1qL5NJ6Hh5xkfTo0UYeiCE0rHZuFVz4+eJdbzSbjaZoO0lVCjJhwMKSHS474IdzSI0igucPLsTEy2f9LpHWXl2p1kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626526; c=relaxed/simple;
	bh=j+1+wV5u91QVQDKY9T/nEqfA1g2QWT8DQ+14ELEyvOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGosoXuzA4uzaRwrz5JNiQQUYJO+pNnTCQYeoxPPpdI0EiwuJxl58DqgHT8U7ovpf9LgvLa6dPAm5SA/McQLUPa05I+V+yFyAPF8TdrlgMKjK6GMbjyBxG/YSOneGV7OiQdKDF0tup0XAZkLIA4Eg4KaGJG8zvp3AVFzCpOESbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RVZ985h/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1765CC4CEE5;
	Mon, 10 Mar 2025 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626526;
	bh=j+1+wV5u91QVQDKY9T/nEqfA1g2QWT8DQ+14ELEyvOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVZ985h/sLdV7p7J9/6m4fBrZTQ00V55Gwt5kYNIhPPYvWDSqtPDz2Hp9a89AEdm0
	 /sRY1uIxR3a4f44AJkuQlYkF+elrRCc2vDpfxhA6xr0tN3w97rrVdtf+Bjqij7pY2E
	 bnf/62c/0I5FQnKfy8At1SLk3R+uPLZxZOvqhpNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Norbert Szetei <norbert@doyensec.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.13 022/207] ksmbd: fix use-after-free in smb2_lock
Date: Mon, 10 Mar 2025 18:03:35 +0100
Message-ID: <20250310170448.652048192@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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
@@ -7457,13 +7457,13 @@ out_check_cl:
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



