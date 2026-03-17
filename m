Return-Path: <stable+bounces-226780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCr6D4mTuWnKKgIAu9opvQ
	(envelope-from <stable+bounces-226780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:46:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 935A02B01EA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A02B431F1CF2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07A733986F;
	Tue, 17 Mar 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRJuK6um"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930FA2DF132;
	Tue, 17 Mar 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768169; cv=none; b=G9RkGROPGH6II9Au+Gu3JJrJ3dUNXkeLjZyUmARm+x4ujPGpHyrX0E6c99hdAKb3HXOgb5JXrXV6hHUsQBUE5N7EcIFI+8gsdtc82LZuS1ARaTy3Yg/Ru+FIfMg0tQmIWh1oqWJSB4IMR4ac60m7RtBjjKe8ad7m2JNdtUVfz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768169; c=relaxed/simple;
	bh=C/JmQLIyx2F3HdxbT4y3826qhPc1Db9X0anu27jK9C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuKjCdgyALF/upexr9TZeVtTznpbyOkuuQOL6WrSok1X5u+QGCm8882+DmswqP7+2PYQF0+izedAsa/I7Vx7I/ksBmHu52KhPMtYRproZl8JaSBKOBsaZKHPDmyymSOShHv5mkStHMFFPQLNMjmCWXp75Zgc0Z9CcYB2eZa+K+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MRJuK6um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4606C4CEF7;
	Tue, 17 Mar 2026 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768169;
	bh=C/JmQLIyx2F3HdxbT4y3826qhPc1Db9X0anu27jK9C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRJuK6umW+wJCJM+sygq2ZNGnTMTS7vuZ9FN1t+3Vf1s3504QJ6TMj9pr1OPk/Ghy
	 zCupKLjC2re9JjI8PpH6/bXg18dPvog7zoctINIvLUdd7njRiYlFdi5grO0MIYsMGN
	 M3kzH8LdD9kn+o0bxx4KoEeBYAdmaKrSwP9tVqe0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	stable@kernel.org
Subject: [PATCH 6.18 214/333] selftests: fix mntns iteration selftests
Date: Tue, 17 Mar 2026 17:34:03 +0100
Message-ID: <20260317163007.299547161@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226780-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 935A02B01EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

commit 4c7b2ec23cc5d880e3ffe35e8c2aad686b67723a upstream.

Now that we changed permission checking make sure that we reflect that
in the selftests.

Link: https://patch.msgid.link/20260226-work-visibility-fixes-v1-4-d2c2853313bd@kernel.org
Fixes: 9d87b1067382 ("selftests: add tests for mntns iteration")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@kernel.org # v6.14+
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/filesystems/nsfs/iterate_mntns.c |   25 +++++++++------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
+++ b/tools/testing/selftests/filesystems/nsfs/iterate_mntns.c
@@ -37,17 +37,20 @@ FIXTURE(iterate_mount_namespaces) {
 	__u64 mnt_ns_id[MNT_NS_COUNT];
 };
 
+static inline bool mntns_in_list(__u64 *mnt_ns_id, struct mnt_ns_info *info)
+{
+	for (int i = 0; i < MNT_NS_COUNT; i++) {
+		if (mnt_ns_id[i] == info->mnt_ns_id)
+			return true;
+	}
+	return false;
+}
+
 FIXTURE_SETUP(iterate_mount_namespaces)
 {
 	for (int i = 0; i < MNT_NS_COUNT; i++)
 		self->fd_mnt_ns[i] = -EBADF;
 
-	/*
-	 * Creating a new user namespace let's us guarantee that we only see
-	 * mount namespaces that we did actually create.
-	 */
-	ASSERT_EQ(unshare(CLONE_NEWUSER), 0);
-
 	for (int i = 0; i < MNT_NS_COUNT; i++) {
 		struct mnt_ns_info info = {};
 
@@ -75,13 +78,15 @@ TEST_F(iterate_mount_namespaces, iterate
 	fd_mnt_ns_cur = fcntl(self->fd_mnt_ns[0], F_DUPFD_CLOEXEC);
 	ASSERT_GE(fd_mnt_ns_cur, 0);
 
-	for (;; count++) {
+	for (;;) {
 		struct mnt_ns_info info = {};
 		int fd_mnt_ns_next;
 
 		fd_mnt_ns_next = ioctl(fd_mnt_ns_cur, NS_MNT_GET_NEXT, &info);
 		if (fd_mnt_ns_next < 0 && errno == ENOENT)
 			break;
+		if (mntns_in_list(self->mnt_ns_id, &info))
+			count++;
 		ASSERT_GE(fd_mnt_ns_next, 0);
 		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
 		fd_mnt_ns_cur = fd_mnt_ns_next;
@@ -96,13 +101,15 @@ TEST_F(iterate_mount_namespaces, iterate
 	fd_mnt_ns_cur = fcntl(self->fd_mnt_ns[MNT_NS_LAST_INDEX], F_DUPFD_CLOEXEC);
 	ASSERT_GE(fd_mnt_ns_cur, 0);
 
-	for (;; count++) {
+	for (;;) {
 		struct mnt_ns_info info = {};
 		int fd_mnt_ns_prev;
 
 		fd_mnt_ns_prev = ioctl(fd_mnt_ns_cur, NS_MNT_GET_PREV, &info);
 		if (fd_mnt_ns_prev < 0 && errno == ENOENT)
 			break;
+		if (mntns_in_list(self->mnt_ns_id, &info))
+			count++;
 		ASSERT_GE(fd_mnt_ns_prev, 0);
 		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
 		fd_mnt_ns_cur = fd_mnt_ns_prev;
@@ -125,7 +132,6 @@ TEST_F(iterate_mount_namespaces, iterate
 		ASSERT_GE(fd_mnt_ns_next, 0);
 		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
 		fd_mnt_ns_cur = fd_mnt_ns_next;
-		ASSERT_EQ(info.mnt_ns_id, self->mnt_ns_id[i]);
 	}
 }
 
@@ -144,7 +150,6 @@ TEST_F(iterate_mount_namespaces, iterate
 		ASSERT_GE(fd_mnt_ns_prev, 0);
 		ASSERT_EQ(close(fd_mnt_ns_cur), 0);
 		fd_mnt_ns_cur = fd_mnt_ns_prev;
-		ASSERT_EQ(info.mnt_ns_id, self->mnt_ns_id[i]);
 	}
 }
 



