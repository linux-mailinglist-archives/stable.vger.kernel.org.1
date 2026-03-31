Return-Path: <stable+bounces-232525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH32BcMCzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:22:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F136E905
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0EF030FB487
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810AD317153;
	Tue, 31 Mar 2026 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TFM/QEfj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42361317150;
	Tue, 31 Mar 2026 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976973; cv=none; b=rrfOxMauSswoIldNp8VMpSIQg/L0SnSTzBQoTVDRMSjBqmvEsjPxIVHW5pNK7b0wylEgFA2cjVlmZklWAZRwRAwo7kQgLbRxRATu5DoAwT62GnVNW8TAfju4TrY0m2vOD8TIp8LJ1tkVRsMYDtRigq2msSGoGxqprhEhSlMhSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976973; c=relaxed/simple;
	bh=+4CACyGjrflPhA1mD24dNI0rCKYicAr/GfouIQXXprE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRZf876kaivijFcxzKWprCG2xObk9VSNt3dlQpCME5uE5teOleNjQ7t4t9vJXZBh/6mnIFcub23ULyydLD2J2BcnflMAI/nAq51s1U1cO5r0WX8MBEr/szyC1Ewai9YoTjUFtG88PbHAMaFdaYq4yR7w3HMKAKgibtpC+AEzPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TFM/QEfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF75C2BCB3;
	Tue, 31 Mar 2026 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976973;
	bh=+4CACyGjrflPhA1mD24dNI0rCKYicAr/GfouIQXXprE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFM/QEfjVgN0HS3qI2QP8WkQECGfwyY7fYlv1Lrc0aT9Gl64bAsLKQMQgMVpS+Gc0
	 XC1syWdENVVBDZoSynnPe78nFG6tIeaOSR+QO13ljYGOg0NW9IE7NMd88giMoKJ07/
	 HbtUHp0/bRn6pTLtfo4+9znTWHlwzfh+QFhEfxac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 299/309] selftests/mount_setattr: increase tmpfs size for idmapped mount tests
Date: Tue, 31 Mar 2026 18:23:22 +0200
Message-ID: <20260331161804.573676011@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232525-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: A66F136E905
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit c465f5591aa84a6f85d66d152e28b92844a45d4f ]

The mount_setattr_idmapped fixture mounts a 2 MB tmpfs at /mnt and then
creates a 2 GB sparse ext4 image at /mnt/C/ext4.img. While ftruncate()
succeeds (sparse file), mkfs.ext4 needs to write actual metadata blocks
(inode tables, journal, bitmaps) which easily exceeds the 2 MB tmpfs
limit, causing ENOSPC and failing the fixture setup for all
mount_setattr_idmapped tests.

This was introduced by commit d37d4720c3e7 ("selftests/mount_settattr:
ensure that ext4 filesystem can be created") which increased the image
size from 2 MB to 2 GB but didn't adjust the tmpfs size.

Bump the tmpfs size to 256 MB which is sufficient for the ext4 metadata.

Fixes: d37d4720c3e7 ("selftests/mount_settattr: ensure that ext4 filesystem can be created")
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index a688871a98eba..388bca88ec94f 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1020,7 +1020,7 @@ FIXTURE_SETUP(mount_setattr_idmapped)
 			"size=100000,mode=700"), 0);
 
 	ASSERT_EQ(mount("testing", "/mnt", "tmpfs", MS_NOATIME | MS_NODEV,
-			"size=2m,mode=700"), 0);
+			"size=256m,mode=700"), 0);
 
 	ASSERT_EQ(mkdir("/mnt/A", 0777), 0);
 
-- 
2.53.0




