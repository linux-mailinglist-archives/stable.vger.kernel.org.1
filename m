Return-Path: <stable+bounces-134829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5AA95240
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3128D3AA959
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE026659B;
	Mon, 21 Apr 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nYVQrAJc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379D266592
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243998; cv=none; b=SOiqwTjF//+I2Y1AcJBeGss03hM5Ei1Vgzo/cpnzbuFfuIXY7cxMiYrRIn5SlN76UZS8w1t6A0+eUOo6NH65AjuR9bbOi6AgwTq/YmctqPFhVoecqj5ypA89dWtPhAQlQvyIY4F4gHm2DvsssRzvAL/TS9vPzE04l6GJS0Q6uWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243998; c=relaxed/simple;
	bh=dX57rTDpsqhxn6Mvn0Eb0CtCv3gdnvzic1ecz1HOiNk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ap0HctppZ34s5zMOYoZ4YJb99ImtmcUatW22MIrzsqogfvEwC2MiCcV0ZNHuhJ0+8wXTJny3VXU5gMKS5j6eewAzXoMoJp+PZKpn3NzlTyNwv7SfDTQutUvSmZF8uAp0PufUfSdURndHnWKTiPD6fLF1TK1cXVJ3xiqEYCCyZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nYVQrAJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DB9C4CEE4;
	Mon, 21 Apr 2025 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243997;
	bh=dX57rTDpsqhxn6Mvn0Eb0CtCv3gdnvzic1ecz1HOiNk=;
	h=Subject:To:Cc:From:Date:From;
	b=nYVQrAJcqeGUiX+18YL/M0/9QJgcfQI6gNSdfXH3qXfpEhltWjbn1PLfbSWRBOAzi
	 szdpPv/wf7lOyy0yTZs87+yOVOdbxWMkZgfw+t0X4OamWTZDVkCFivvB46EtDQTACT
	 27RJdmUXaGBBoS5U6aZvmmpe7paSQXSvhun4X2hk=
Subject: FAILED: patch "[PATCH] selftests/mm: generate a temporary mountpoint for cgroup" failed to apply to 5.10-stable tree
To: broonie@kernel.org,aishwarya.tcv@arm.com,akpm@linux-foundation.org,almasrymina@google.com,longman@redhat.com,shuah@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:59:45 +0200
Message-ID: <2025042145-carmaker-turbofan-c6eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9c02223e2d9df5cb37c51aedb78f3960294e09b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042145-carmaker-turbofan-c6eb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9c02223e2d9df5cb37c51aedb78f3960294e09b5 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Fri, 4 Apr 2025 17:42:32 +0100
Subject: [PATCH] selftests/mm: generate a temporary mountpoint for cgroup
 filesystem

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

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index 67df7b47087f..e1fe16bcbbe8 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -29,7 +29,7 @@ fi
 if [[ $cgroup2 ]]; then
   cgroup_path=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup2 none $cgroup_path
     do_umount=1
   fi
@@ -37,7 +37,7 @@ if [[ $cgroup2 ]]; then
 else
   cgroup_path=$(mount -t cgroup | grep ",hugetlb" | awk '{print $3}')
   if [[ -z "$cgroup_path" ]]; then
-    cgroup_path=/dev/cgroup/memory
+    cgroup_path=$(mktemp -d)
     mount -t cgroup memory,hugetlb $cgroup_path
     do_umount=1
   fi
diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 11f9bbe7dc22..0b0d4ba1af27 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -23,7 +23,7 @@ fi
 if [[ $cgroup2 ]]; then
   CGROUP_ROOT=$(mount -t cgroup2 | head -1 | awk '{print $3}')
   if [[ -z "$CGROUP_ROOT" ]]; then
-    CGROUP_ROOT=/dev/cgroup/memory
+    CGROUP_ROOT=$(mktemp -d)
     mount -t cgroup2 none $CGROUP_ROOT
     do_umount=1
   fi


