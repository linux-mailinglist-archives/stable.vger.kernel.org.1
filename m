Return-Path: <stable+bounces-221047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB+2MIdJo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413C31C7C1D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12411331D6D3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCD3175A7B;
	Sat, 28 Feb 2026 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lc8RQ6N4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD40175A89;
	Sat, 28 Feb 2026 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301390; cv=none; b=bIGjuN2GvsE8TFuJ/rvaQfSugys010cx2CewmX5TiCsD7pFjgL2gli7HuafPpa5vVfyGADHmQWZjI4CVQNgnsMV08AapTkTSKmmALK+BpT5ytXhh3SaoBArwdaZkMKvv7ijBE0ljNlnNniyy1RS7lEfUg9EN4fwWO1/7DpW57Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301390; c=relaxed/simple;
	bh=acpezPzvl69WK9Iiw/Yx2kb/8Q2BHP9ENnwHM2ALXNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYAyPZ2mkicY9byFWUZIdIPZ2EF7BgPa0JN1hy66/4FYiD+CwfuyqZz9NXUGGSLoE5IxxddRujrCA5UnYWUFzvK+/Bnsfh8/9/uXddWUTiMsPedfTetxYhUyQK07zDlfgbr0Hssi3CR0UGG/h3Wx41eB6REzdZ2Dk1APlm0Nc8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lc8RQ6N4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767D2C19425;
	Sat, 28 Feb 2026 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301390;
	bh=acpezPzvl69WK9Iiw/Yx2kb/8Q2BHP9ENnwHM2ALXNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lc8RQ6N4P1yOUH6/e6P3IoenmbmgQbWwIXrXGai4YRBHLYb77ToSHCqijSgXStur7
	 AHAg8baKWSFjDJMOkakJMXynWNQ2OjiAPh1YNafZh+nBnhm0vWKJOuHT9ftXIQ2F+G
	 X5rCNSpAGXjgKSXYBQ6FIpcA1od9oUo2HD+0h2n7ApTLScaGs+TxgjW4oyN41/LcF5
	 NgdCaCz6keSx524JLE89S5fE5imSVvE8gTUMDUGUl8TrTjBa/vUONqtC/RKoZCLV25
	 mmjckllqYt01jcckIm5KwT+TncNHN4gs3wELNwVuum7SOcQU+UrosxldpumcQM5vK2
	 YHyXKerCLKBnw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Li Wang <liwang@redhat.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 578/752] selftests/mm/charge_reserved_hugetlb: drop mount size for hugetlbfs
Date: Sat, 28 Feb 2026 12:44:49 -0500
Message-ID: <20260228174750.1542406-578-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221047-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,charge_reserved_hugetlb.sh:url]
X-Rspamd-Queue-Id: 413C31C7C1D
X-Rspamd-Action: no action

From: Li Wang <liwang@redhat.com>

[ Upstream commit 1aa1dd9cc595917882fb6db67725442956f79607 ]

charge_reserved_hugetlb.sh mounts a hugetlbfs instance at /mnt/huge with a
fixed size of 256M.  On systems with large base hugepages (e.g.  512MB),
this is smaller than a single hugepage, so the hugetlbfs mount ends up
with zero capacity (often visible as size=0 in mount output).

As a result, write_to_hugetlbfs fails with ENOMEM and the test can hang
waiting for progress.

=== Error log ===
  # uname -r
  6.12.0-xxx.el10.aarch64+64k

  #./charge_reserved_hugetlb.sh -cgroup-v2
  # -----------------------------------------
  ...
  # nr hugepages = 10
  # writing cgroup limit: 5368709120
  # writing reseravation limit: 5368709120
  ...
  # write_to_hugetlbfs: Error mapping the file: Cannot allocate memory
  # Waiting for hugetlb memory reservation to reach size 2684354560.
  # 0
  # Waiting for hugetlb memory reservation to reach size 2684354560.
  # 0
  ...

  # mount |grep /mnt/huge
  none on /mnt/huge type hugetlbfs (rw,relatime,seclabel,pagesize=512M,size=0)

  # grep -i huge /proc/meminfo
  ...
  HugePages_Total:      10
  HugePages_Free:       10
  HugePages_Rsvd:        0
  HugePages_Surp:        0
  Hugepagesize:     524288 kB
  Hugetlb:         5242880 kB

Drop the mount args with 'size=256M', so the filesystem capacity is sufficient
regardless of HugeTLB page size.

Link: https://lkml.kernel.org/r/20251221122639.3168038-3-liwang@redhat.com
Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
Signed-off-by: Li Wang <liwang@redhat.com>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/mm/charge_reserved_hugetlb.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
index e1fe16bcbbe88..fa6713892d82d 100755
--- a/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/mm/charge_reserved_hugetlb.sh
@@ -290,7 +290,7 @@ function run_test() {
   setup_cgroup "hugetlb_cgroup_test" "$cgroup_limit" "$reservation_limit"
 
   mkdir -p /mnt/huge
-  mount -t hugetlbfs -o pagesize=${MB}M,size=256M none /mnt/huge
+  mount -t hugetlbfs -o pagesize=${MB}M none /mnt/huge
 
   write_hugetlbfs_and_get_usage "hugetlb_cgroup_test" "$size" "$populate" \
     "$write" "/mnt/huge/test" "$method" "$private" "$expect_failure" \
@@ -344,7 +344,7 @@ function run_multiple_cgroup_test() {
   setup_cgroup "hugetlb_cgroup_test2" "$cgroup_limit2" "$reservation_limit2"
 
   mkdir -p /mnt/huge
-  mount -t hugetlbfs -o pagesize=${MB}M,size=256M none /mnt/huge
+  mount -t hugetlbfs -o pagesize=${MB}M none /mnt/huge
 
   write_hugetlbfs_and_get_usage "hugetlb_cgroup_test1" "$size1" \
     "$populate1" "$write1" "/mnt/huge/test1" "$method" "$private" \
-- 
2.51.0


