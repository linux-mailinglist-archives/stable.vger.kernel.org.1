Return-Path: <stable+bounces-268642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BpFyHeBrPWr42wgAu9opvQ
	(envelope-from <stable+bounces-268642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:56:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 949DC6C80E2
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 19:56:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=k2jxmSrq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268642-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268642-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75C6130207EF
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142BF3B19B4;
	Thu, 25 Jun 2026 17:56:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A73D9688
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 17:56:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410172; cv=none; b=RuQXfv1TqFf1DJdde9SOF8mqw1KBDbrXpot0VPBRRQQsirwYK8OuGdUkloFV/cT3pdTpMTlhYLhiLMVDyIvkqyQYGj+8zf5iNX3o3zTE/VloS+s74Wmu9TGl7q8zTi1kpL45QkjiM+8PC0Z9NnTo7CGkb7b0u0rEXde9NXwOrdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410172; c=relaxed/simple;
	bh=c1JovLtNMIL8kiSbfL85fembU3MkagrZ6hsCffMFG/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fskIr5BISTBgpbR/MVW2JZR0nSSSdc0U5EcHmBPqAePBp6U0Fs5Wf6G5KAWs3uD8zhVkU1wpYzZGuxljV0U1oy2YXlEDrHgx1vU8EQPfXTjhgSDWsW8ZjWOS1Sz5FCa9rWYJxu6CHHEqC8ODEV4lpB/6Djb1x3yelPZTTyGuljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2jxmSrq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAD41F00A3A;
	Thu, 25 Jun 2026 17:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410171;
	bh=kbRZmQgyFT5qaUe7Qtpvk+Su5KAJ1RI/2oxuTzmOPSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k2jxmSrqeBpJoXT/S8nDdwu9vCzQmHWN7IjEH5pJ6bgyejtnJBIbvO6nnnSBt8oU1
	 B3xTBODZn0NiaISydZeRMQcx4rumCK/n6codLyYXAqsoB5BT042enSPe+p4bWKxTFv
	 5nTX01puPR7leo+rkpIz2DTA1qwhdqmdvDm9UizKC/BL7BG1Ieg03RirR9MvKPj5SF
	 HSB4eNYtrSVBTFXXVj+P0KzF2WoRdX4kWskd6xOxSWON+X6TL68BZRoGBIBCBP+eAD
	 MkVu3hcYKrwB/O5o/ZrhKB2upsGb4TrLMpfz1kXvgtwo30G5vLsczVTanS6dZT7NkT
	 43tKsiDYVaanw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	=?UTF-8?q?Aur=C3=A9lien=20Bombo?= <abombo@microsoft.com>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Greg Kurz <gkurz@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] virtiofs: fix UAF on submount umount
Date: Thu, 25 Jun 2026 13:56:09 -0400
Message-ID: <20260625175609.2544109-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062516-legroom-wrongdoer-ad3f@gregkh>
References: <2026062516-legroom-wrongdoer-ad3f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mszeredi@redhat.com,m:abombo@microsoft.com,m:chengzhihao1@huawei.com,m:gkurz@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268642-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 949DC6C80E2

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 06b41351779e9289e8785694ade9042ae85e41ea ]

iput() called from fuse_release_end() can Oops if the super block has
already been destroyed.  Normally this is prevented by waiting for
num_waiting to go down to zero before commencing with super block shutdown.

This only works, however, for the last submount instance, as the wait
counter is per connection, not per superblock.

Revert to using synchronous release requests for the auto_submounts case,
which is virtiofs only at this time.

Reported-by: Aurélien Bombo <abombo@microsoft.com>
Reported-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: Greg Kurz <gkurz@redhat.com>
Closes: https://github.com/kata-containers/kata-containers/issues/12589
Fixes: 26e5c67deb2e ("fuse: fix livelock in synchronous file put from fuseblk workers")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kurz <gkurz@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 23bc96887abcb7..a8c080b485d036 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -330,8 +330,14 @@ void fuse_release_common(struct file *file, bool isdir)
 	 * aio and closes the fd before the aio completes.  Since aio takes its
 	 * own ref to the file, the IO completion has to drop the ref, which is
 	 * how the fuse server can end up closing its clients' files.
+	 *
+	 * Exception is virtio-fs, which is not affected by the above (server is
+	 * on host, cannot close open files in guest).  Virtio-fs needs sync
+	 * release, because the num_waiting mechanism to wait for all requests
+	 * before commencing with fs shutdown doesn't work if submounts are
+	 * used.
 	 */
-	fuse_file_put(ff, false, isdir);
+	fuse_file_put(ff, ff->fm->fc->auto_submounts, isdir);
 }
 
 static int fuse_open(struct inode *inode, struct file *file)
-- 
2.53.0


