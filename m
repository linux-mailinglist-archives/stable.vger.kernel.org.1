Return-Path: <stable+bounces-211546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C6gNMhAd2mMdQEAu9opvQ
	(envelope-from <stable+bounces-211546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 11:24:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6932686CE6
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCFF83004619
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFD3330317;
	Mon, 26 Jan 2026 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="s7ynhonG"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1532ED58;
	Mon, 26 Jan 2026 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423045; cv=none; b=JE0MBGxXjm4erF1pUEQZ00MPgh6bFZ/TLxpOBEFHtIAuxiV7NDOZS+0oZa+iPRPK1sP4aabx5okO+BWLNY3jrcVzwCWBvSnoMCyQsugv1Cxkaa4ZWWEWhBCXXGoYMErPLT525kYCuA94mgDOir4/W5VkUIeRMybVKGkDJW+wXPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423045; c=relaxed/simple;
	bh=n0dRqqzXiur/MG3+g5L2rMOhE0v+G99Nj260ae84lGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b0jgGT8HQ696c+E1pNd9P7HIZFeOjGjpJK//xsg4XcCHRKS5gkbX3lqoPrZulvDhJnX0nXC36EcV06tV0ZEsGjPf29V1vYjkoebV/VmkBL/c0EB/F2fX+1+xswDWDyJlDBPjT3HO8WJPGJElzepYTTF2riBngDr6xj2vwAqg9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=s7ynhonG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=A8ybu6R862ZcWMwxooK3XqStcKgJjqojdp6nindhKlU=; b=s7ynhonGDphwv2YVwiqsO4ping
	UVLe/sOFapo8D5cwFgdoIuvUOOytM01h1xIU+EUFWyK2WfaGo7kA4FRCQmm0Na3Q5LmQalldAeLLc
	0Mk44sswS/hS4VArQk4G7R518s1k59ggIJ/YyZofXwWKvbGqpFOh/KirJCW5Mw9j2VeySY6bhoBZf
	21VSFEkMtnRWzH0ugp4SQ45OXPX8X+Xh21UhnTGixxGgkLbGxLT1oAIyNw0D72jUPoUPgRwXOfwC8
	LcFMc8JCVvPjzVhA0GjR6PRhXoY8ZdkjMf20+Q/tceOYtJru+NUv9ppRno++oHRYpIQjnEqKiNaWw
	/SBxd3iw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkJlA-00G6kN-Cf; Mon, 26 Jan 2026 10:23:52 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 26 Jan 2026 02:23:37 -0800
Subject: [PATCH] 9p: fix WARN_ON when dropping nlink on files with nlink=0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-9p-v1-1-dc234d53ae87@debian.org>
X-B4-Tracking: v=1; b=H4sIAKlAd2kC/yXMQQqDMBBG4asM/9pAHOiAuYp0UXXSjosoSSuC5
 O5SXb7F9w4UzaYFgQ5k3azYkhCobQjj55Xe6mxCILBn8S2L61b38BN7UY4SBQ1hzRptvyb98+7
 yG2Ydv3+JWk9rjwHyZgAAAA==
X-Change-ID: 20260126-9p-50d206e2f6f6
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eryu Guan <eguan@linux.alibaba.com>, Yiwen Jiang <jiangyiwen@huawei.com>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2378; i=leitao@debian.org;
 h=from:subject:message-id; bh=n0dRqqzXiur/MG3+g5L2rMOhE0v+G99Nj260ae84lGw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpd0Cz4rbiTGQYJg8vM6dHvEL3GgWpnuQwf9zRY
 9aF2ylnot6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXdAswAKCRA1o5Of/Hh3
 bWt2EACrFYPOChnEbohF/ylUVh0S8cUbxpBYqvoQXMvRuRUobYkzvHJQD38u8UFXoAOyxl2+zO6
 un9h5MmjblVl/Mj2I+Hjcdf+T40HHPejE9FdnPjMFxoxXklYr8bkUvtN24NSLoj2DpYnQklcgm6
 7mp2jQjIy+i+f9q+urw7OtHMIqy4ENfm6wV12D3/52QVQrojetjFmlTtn+UtTNE7OchUXWHpvMT
 /iRDqHOiAiWOSYrFMGyOPUa7bdhcvySurxhAJdF5nOxZ2auhW7J7FsNh2mZfVCNMY1FGpGlJOJJ
 9/304Sn8YR4bO9ZRKdUSQNbjQVTOjuNMoZRyh5QL6wifD24Xl78kBGMinMJnBlO9OtZdh0437kz
 Dena38dw5E4/0f37InUcacCHrLG+Z274PxvJRPQgrzVr8+ah0MkVWz93yYPYgLJ0mlNtGAY7/Pu
 PLcYPB21uHpYQHja+radMUyX63erIkIYe2zlvPKzXD6LIR41fUoIimBSaCByYigkrm83b+yd04g
 EEM98TpvEFPGnWQR4HBXbDhUJRLpwGybdRPTeBu1bh7hIJ5qWzDpnINdYSWRdW9Vm14MZcL6k4l
 E38hwYlke5dEzDER9Wq+u4cE8Y+stnHkyB2BLGDymzfyjprjSzBdyd8y6XJb4/3XL9R2kB7LB8L
 kFjCavH7Y53K3VQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211546-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6932686CE6
X-Rspamd-Action: no action

v9fs_dec_count() guards against decrementing nlink on directories that
have nlink <= 2, but does not guard against decrementing nlink on
regular files that already have nlink == 0.

In the 9p filesystem, the client caches inode metadata including nlink,
but the server is the source of truth. During an unlink operation, the
following race can occur:

  1. Client initiates unlink, server processes it and sets nlink to 0
  2. Client fetches updated inode metadata (nlink=0) before unlink returns
  3. Client's v9fs_remove() completes successfully
  4. Client calls v9fs_dec_count() which calls drop_nlink() on nlink=0

This race is easily triggered under heavy unlink workloads, such as
stress-ng's unlink stressor, producing the following warning:

  WARNING: fs/inode.c:417 at drop_nlink+0x4c/0xc8
  Call trace:
   drop_nlink+0x4c/0xc8
   v9fs_remove+0x1e0/0x250 [9p]
   v9fs_vfs_unlink+0x20/0x38 [9p]
   vfs_unlink+0x13c/0x258
   ...

Fix this by returning early from v9fs_dec_count() if the inode's nlink
is already zero, extending the protection that commit ac89b2ef9b55
("9p: don't maintain dir i_nlink if the exported fs doesn't either")
added for directories to also cover regular files.

Fixes: ac89b2ef9b55 ("9p: don't maintain dir i_nlink if the exported fs doesn't either")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/9p/vfs_inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 97abe65bf7c1f..b75f656af4c98 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -488,10 +488,16 @@ static int v9fs_at_to_dotl_flags(int flags)
  * - ext4 (with dir_nlink feature enabled) sets nlink to 1 if a dir has more
  *   than EXT4_LINK_MAX (65000) links.
  *
+ * For regular files, the server may have already decremented nlink to 0
+ * before the client's unlink completes, so we must also guard against
+ * decrementing an already-zero nlink.
+ *
  * @inode: inode whose nlink is being dropped
  */
 static void v9fs_dec_count(struct inode *inode)
 {
+	if (!inode->i_nlink)
+		return;
 	if (!S_ISDIR(inode->i_mode) || inode->i_nlink > 2)
 		drop_nlink(inode);
 }

---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260126-9p-50d206e2f6f6

Best regards,
--  
Breno Leitao <leitao@debian.org>


