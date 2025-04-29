Return-Path: <stable+bounces-138495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73885AA1847
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B6F1BA6AB4
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0562AE96;
	Tue, 29 Apr 2025 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G/5vA4xe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFA233735;
	Tue, 29 Apr 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949433; cv=none; b=WDuY8+O2IMJbP6u1UbU2twfIVbLQxExlh1+qG/KqGf7PTvQ/8um0Otoqyuv5O8iVE7Mz9BV2vxbT8TjwjJKPk3hJ14h8M24/YJuuVqGXbdlNXO5FoYH61Vu1WMl6SADp5/FZPHyHBMRzpzQjNPpruL/QMwiD8tL2QM3FYYWnVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949433; c=relaxed/simple;
	bh=zK5fJvbhA1f80mpoloJzlYHwVTEZ+3b86sIAMzOAo0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPKsB8U7smyWm+x4s0guaZytHRPEhnjAoZ4qdaVyNthfjbBjpFrml3m432HgOktxNhsLOvExBntGrONvt1GUzfnB7i8Bwp9yEy1CQZTkRGgl0v6xS4P2csBMVY9ux4J2dpR/4Kw+ciB9D/FzkLk/JagcZjXnq6SQT4fPH5BupPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G/5vA4xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285FFC4CEE3;
	Tue, 29 Apr 2025 17:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949433;
	bh=zK5fJvbhA1f80mpoloJzlYHwVTEZ+3b86sIAMzOAo0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/5vA4xeu0sk2i5cAodGAl8uDUkdgZKAVEZnLehXGx3B0Diw/oPjyEyybL0mNdxQP
	 ZOqe0lF0ii7CkAaDiUTVzEKIMdi0zHjcUmTu8P+G1mqliz8wAj/ph8sdjQjxJQ1ZG7
	 Hk6kBkAx3f2nk+tzds1mbM8WUf384gnefjQ2Lvio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Mina Almasry <almasrymina@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 279/373] selftests/mm: generate a temporary mountpoint for cgroup filesystem
Date: Tue, 29 Apr 2025 18:42:36 +0200
Message-ID: <20250429161134.594542323@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 9c02223e2d9df5cb37c51aedb78f3960294e09b5 ]

Currently if the filesystem for the cgroups version it wants to use is not
mounted charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh tests
will attempt to mount it on the hard coded path /dev/cgroup/memory,
deleting that directory when the test finishes.  This will fail if there
is not a preexisting directory at that path, and since the directory is
deleted subsequent runs of the test will fail.  Instead of relying on this
hard coded directory name use mktemp to generate a temporary directory to
use as a mountpoint, fixing both the assumption and the disruption caused
by deleting a preexisting directory.

This means that if the relevant cgroup filesystem is not already mounted
then we rely on having coreutils (which provides mktemp) installed.  I
suspect that many current users are relying on having things automounted
by default, and given that the script relies on bash it's probably not an
unreasonable requirement.

Link: https://lkml.kernel.org/r/20250404-kselftest-mm-cgroup2-detection-v1-1-3dba6d32ba8c@kernel.org
Fixes: 209376ed2a84 ("selftests/vm: make charge_reserved_hugetlb.sh work with existing cgroup setting")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh  | 4 ++--
 tools/testing/selftests/vm/hugetlb_reparenting_test.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index 8e00276b4e69b..dc3fc438b3d9e 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -27,7 +27,7 @@ fi
 if [[ $cgroup2 ]]; then
   cgroup_path=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup2 none $cgroup_path
     do_umount=1
   fi
@@ -35,7 +35,7 @@ if [[ $cgroup2 ]]; then
 else
   cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup memory,hugetlb $cgroup_path
     do_umount=1
   fi
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
index 14d26075c8635..302f2c7003f03 100644
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -22,7 +22,7 @@ fi
 if [[ $cgroup2 ]]; then
   CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
-    CGROUP_ROOT=/dev/cgroup/memory
+    CGROUP_ROOT=$(mktemp -d)
     mount -t cgroup2 none $CGROUP_ROOT
     do_umount=1
   fi
-- 
2.39.5




