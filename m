Return-Path: <stable+bounces-157694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7109AE552A
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865344469D0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF68B221FCA;
	Mon, 23 Jun 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ITKiEDJE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A77080E;
	Mon, 23 Jun 2025 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716495; cv=none; b=jzSvcfiNP044BYemRP4O5VBled0phPW8VIPD75gOd0LT04O9MeEKGEcRElnO0zcapflZGrEXJnJei0AV4QlBtTEnOPCw0sEp0QdLpR5ayINjVwzT23tTh8h1RkSPd3qUBu8DN9WrnM16YdtWi2CQgSPchR1cJlhuKjoMD6pOD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716495; c=relaxed/simple;
	bh=rvOfejDVmzlMW1FD7T1PflqrWjkGbXvxHYjZK7YdNiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EygDapBauH65OD6EPTIq8Q30usUXhL7802WzygpF5lqATKgVOK9A6bRW7Txo7QO5fhOFhaP/szfb1Gq/vE9gYcnaEE90JRZEqifcM4Me3f53dcFxpBmu+ClpR2tP4s+1COanL86XoWa9rYpA9E7YLv9ym3UpO/g3id0OuV/Ty0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ITKiEDJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A82C4CEEA;
	Mon, 23 Jun 2025 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716495;
	bh=rvOfejDVmzlMW1FD7T1PflqrWjkGbXvxHYjZK7YdNiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITKiEDJExrf7siQFDuHj6cak7RZ/VB9MyacB3jDs9f/Osu7QXjmLpH2jumajrxsm0
	 cS2QOTeI8jR3ahWsAfMqwU8jT0wVerxd5salcEcGYpa9Qao2faPPuQeAifce98NEfJ
	 y4fXmUEr1rBfIgGLSwKG10UWqhU6uR0cjzMgjkHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dennis Marttinen <twelho@welho.tech>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.1 329/508] ceph: set superblock s_magic for IMA fsmagic matching
Date: Mon, 23 Jun 2025 15:06:14 +0200
Message-ID: <20250623130653.421147420@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Marttinen <twelho@welho.tech>

commit 72386d5245b249f5a0a8fabb881df7ad947b8ea4 upstream.

The CephFS kernel driver forgets to set the filesystem magic signature in
its superblock. As a result, IMA policy rules based on fsmagic matching do
not apply as intended. This causes a major performance regression in Talos
Linux [1] when mounting CephFS volumes, such as when deploying Rook Ceph
[2]. Talos Linux ships a hardened kernel with the following IMA policy
(irrelevant lines omitted):

[...]
dont_measure fsmagic=0xc36400 # CEPH_SUPER_MAGIC
[...]
measure func=FILE_CHECK mask=^MAY_READ euid=0
measure func=FILE_CHECK mask=^MAY_READ uid=0
[...]

Currently, IMA compares 0xc36400 == 0x0 for CephFS files, resulting in all
files opened with O_RDONLY or O_RDWR getting measured with SHA512 on every
open(2):

10 69990c87e8af323d47e2d6ae4... ima-ng sha512:<hash> /data/cephfs/test-file

Since O_WRONLY is rare, this results in an order of magnitude lower
performance than expected for practically all file operations. Properly
setting CEPH_SUPER_MAGIC in the CephFS superblock resolves the regression.

Tests performed on a 3x replicated Ceph v19.3.0 cluster across three
i5-7200U nodes each equipped with one Micron 7400 MAX M.2 disk (BlueStore)
and Gigabit ethernet, on Talos Linux v1.10.2:

FS-Mark 3.3
Test: 500 Files, Empty
Files/s > Higher Is Better
6.12.27-talos . 16.6  |====
+twelho patch . 208.4 |====================================================

FS-Mark 3.3
Test: 500 Files, 1KB Size
Files/s > Higher Is Better
6.12.27-talos . 15.6  |=======
+twelho patch . 118.6 |====================================================

FS-Mark 3.3
Test: 500 Files, 32 Sub Dirs, 1MB Size
Files/s > Higher Is Better
6.12.27-talos . 12.7 |===============
+twelho patch . 44.7 |=====================================================

IO500 [3] 2fcd6d6 results (benchmarks within variance omitted):

| IO500 benchmark   | 6.12.27-talos  | +twelho patch  | Speedup   |
|-------------------|----------------|----------------|-----------|
| mdtest-easy-write | 0.018524 kIOPS | 1.135027 kIOPS | 6027.33 % |
| mdtest-hard-write | 0.018498 kIOPS | 0.973312 kIOPS | 5161.71 % |
| ior-easy-read     | 0.064727 GiB/s | 0.155324 GiB/s | 139.97 %  |
| mdtest-hard-read  | 0.018246 kIOPS | 0.780800 kIOPS | 4179.29 % |

This applies outside of synthetic benchmarks as well, for example, the time
to rsync a 55 MiB directory with ~12k of mostly small files drops from an
unusable 10m5s to a reasonable 26s (23x the throughput).

[1]: https://www.talos.dev/
[2]: https://www.talos.dev/v1.10/kubernetes-guides/configuration/ceph-with-rook/
[3]: https://github.com/IO500/io500

Cc: stable@vger.kernel.org
Signed-off-by: Dennis Marttinen <twelho@welho.tech>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1136,6 +1136,7 @@ static int ceph_set_super(struct super_b
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 	s->s_flags |= SB_NODIRATIME | SB_NOATIME;
+	s->s_magic = CEPH_SUPER_MAGIC;
 
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)



