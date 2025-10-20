Return-Path: <stable+bounces-188222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F328EBF2C1A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75EA44FD89A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A148332EAB;
	Mon, 20 Oct 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GJ/1B2u/"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE53321D5
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981876; cv=none; b=j/0/HUcazXuxzSXYKhQKFVcGXe99S5m2atJqGeLOlamKEKWyfjKIfj+nDlchlvRQ8t/mWjEzeY8ehRdlwPGF25dAUXHphBHRpwHsxZ1Szu5v8sV0pTQS1hAiNw5Z4f+4EuTA5xIXmChSeWq4mbHk85nbb9g+kSHUpLdm/d0FCDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981876; c=relaxed/simple;
	bh=spzmXTwXQMCw0dXOjAbfUadG6yGJaimkFswvX5WHPw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q75NaTmBYDXXy2rqOU/PBCz3drnTp3zG2g33EvxUNqoNAlR1u4inw4VjwkRvcrfnwtcK6RxY0JMJe0kGk67mwBtu7lEPxel3srh5KspVP46NZitSnfB58IfsPWcGJKPEN9FRjrnd01cu1053A0/cwX4TNpfvhvILdKBkwUY4cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GJ/1B2u/; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Opz1DiEiL9POmhUwn0D2PIaPxzczIzD/ebRRhmPcnnc=;
	b=GJ/1B2u/zGoC19ipzC/6ssZhRiv0uhPjUysylD0DVlLKnlGaoEM1QWsgPXZrzgKpFf8etH
	ApoBrctSr4BhS/zfZRirerQ+Z9vkWHei/KH3rJ6PPwVoNxrZnZKQ9W7ZPxCLPUFbPb06fe
	kT7SE3+F698IK6ZxuumoKYgHiLf0pp8=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 09/10] drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug
Date: Tue, 21 Oct 2025 01:36:23 +0800
Message-Id: <20251020173624.20228-10-wen.yang@linux.dev>
In-Reply-To: <20251020173624.20228-1-wen.yang@linux.dev>
References: <20251020173624.20228-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: K Prateek Nayak <kprateek.nayak@amd.com>

[ Upstream commit c26fabe73330d983c7ce822c6b6ec0879b4da61f ]

Until commit 5c2712387d48 ("cacheinfo: Fix LLC is not exported through
sysfs"), cacheinfo called populate_cache_leaves() for CPU coming online
which let the arch specific functions handle (at least on x86)
populating the shared_cpu_map. However, with the changes in the
aforementioned commit, populate_cache_leaves() is not called when a CPU
comes online as a result of hotplug since last_level_cache_is_valid()
returns true as the cacheinfo data is not discarded. The CPU coming
online is not present in shared_cpu_map, however, it will not be added
since the cpu_cacheinfo->cpu_map_populated flag is set (it is set in
populate_cache_leaves() when cacheinfo is first populated for x86)

This can lead to inconsistencies in the shared_cpu_map when an offlined
CPU comes online again. Example below depicts the inconsistency in the
shared_cpu_list in cacheinfo when CPU8 is offlined and onlined again on
a 3rd Generation EPYC processor:

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # echo 0 > /sys/devices/system/cpu/cpu8/online
  # echo 1 > /sys/devices/system/cpu/cpu8/online

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8

  # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
    136

  # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
    9-15,136-143

Clear the flag when the CPU is removed from shared_cpu_map when
cache_shared_cpu_map_remove() is called during CPU hotplug. This will
allow cache_shared_cpu_map_setup() to add the CPU coming back online in
the shared_cpu_map. Set the flag again when the shared_cpu_map is setup.
Following are results of performing the same test as described above with
the changes:

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # echo 0 > /sys/devices/system/cpu/cpu8/online
  # echo 1 > /sys/devices/system/cpu/cpu8/online

  # for i in /sys/devices/system/cpu/cpu8/cache/index*/shared_cpu_list; do echo -n "$i: "; cat $i; done
    /sys/devices/system/cpu/cpu8/cache/index0/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index1/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index2/shared_cpu_list: 8,136
    /sys/devices/system/cpu/cpu8/cache/index3/shared_cpu_list: 8-15,136-143

  # cat /sys/devices/system/cpu/cpu136/cache/index0/shared_cpu_list
    8,136

  # cat /sys/devices/system/cpu/cpu136/cache/index3/shared_cpu_list
    8-15,136-143

Fixes: 5c2712387d48 ("cacheinfo: Fix LLC is not exported through sysfs")
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20230508084115.1157-3-kprateek.nayak@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/base/cacheinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 60ecf7cc0250..9e11d42b0d64 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -365,11 +365,14 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 			coherency_max_size = this_leaf->coherency_line_size;
 	}
 
+	/* shared_cpu_map is now populated for the cpu */
+	this_cpu_ci->cpu_map_populated = true;
 	return 0;
 }
 
 static void cache_shared_cpu_map_remove(unsigned int cpu)
 {
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *this_leaf, *sib_leaf;
 	unsigned int sibling, index, sib_index;
 
@@ -404,6 +407,9 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 		if (of_have_populated_dt())
 			of_node_put(this_leaf->fw_token);
 	}
+
+	/* cpu is no longer populated in the shared map */
+	this_cpu_ci->cpu_map_populated = false;
 }
 
 static void free_cache_attributes(unsigned int cpu)
-- 
2.25.1


