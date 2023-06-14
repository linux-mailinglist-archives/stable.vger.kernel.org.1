Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E9726BEA
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjFGU3Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjFGU3O (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:29:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C7026AA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:28:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23469644A5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B301C4339B;
        Wed,  7 Jun 2023 20:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169713;
        bh=ovzPYdzv2Xe23sZa7j8VZLK5I64txN8XhI6S3Wp1Nf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAOSS0NIsI7kW24ggHe75CX8r9Z9VFvP3KdEiOwQp19703w9saNOwUi53aGHnTqwC
         H9oN1+1CGoWEkG46zAHEhtg9jkoAPxkpKJkgosJZzjjsxOeEQ3rlkbmjsACha6DdAd
         gJyNO1L3Tm5nB8/48JMb6ZDDo0prmv+8/Yos7DUI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 185/286] drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug
Date:   Wed,  7 Jun 2023 22:14:44 +0200
Message-ID: <20230607200929.317634621@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/cacheinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 6351db6ecb57f..0fc8fbe7b361d 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -402,11 +402,14 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
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
 
@@ -439,6 +442,9 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			}
 		}
 	}
+
+	/* cpu is no longer populated in the shared map */
+	this_cpu_ci->cpu_map_populated = false;
 }
 
 static void free_cache_attributes(unsigned int cpu)
-- 
2.39.2



