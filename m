Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20C1792458
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 17:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjIEP6s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354837AbjIEOyr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 10:54:47 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E3D113
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693925684; x=1725461684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zARYfsbo7EneExaEHTOUrjK8lYuKcPXSZlB2w8yasWw=;
  b=lbPTalKqBgwy+J7A3zc56rc+liYlBk4Z3bmkxr+/cFUs03pJXCVUwfer
   29hxh1rPVhUPvPYrFHrzcN5W2/6t+8zY/DBMCZQVcJi2/MVJOTNExVvO2
   9PDVCaUZ9LxByXMumh7VBriRImtHWFXSsDAb42XzetjhVODEZa0CeBK99
   8=;
X-IronPort-AV: E=Sophos;i="6.02,229,1688428800"; 
   d="scan'208";a="303091055"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 14:54:37 +0000
Received: from EX19MTAUEB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id 40DB463429;
        Tue,  5 Sep 2023 14:54:34 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 5 Sep 2023 14:54:32 +0000
Received: from dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com (10.39.210.33)
 by EX19D028UEC003.ant.amazon.com (10.252.137.159) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 5 Sep 2023 14:54:30 +0000
From:   Luiz Capitulino <luizcap@amazon.com>
To:     <stable@vger.kernel.org>, <seanjc@google.com>
CC:     <lcapitulino@gmail.com>, Li RongQing <lirongqing@baidu.com>,
        Yong He <zhuangel570@gmail.com>,
        Robert Hoo <robert.hoo.linux@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Luiz Capitulino <luizcap@amazon.com>
Subject: [PATH 6.4.y] KVM: x86/mmu: Add "never" option to allow sticky disabling of nx_huge_pages
Date:   Tue, 5 Sep 2023 14:54:12 +0000
Message-ID: <20230905145412.12011-1-luizcap@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.39.210.33]
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Commit 0b210faf337314e4bc88e796218bc70c72a51209 upstream.

Add a "never" option to the nx_huge_pages module param to allow userspace
to do a one-way hard disabling of the mitigation, and don't create the
per-VM recovery threads when the mitigation is hard disabled.  Letting
userspace pinky swear that userspace doesn't want to enable NX mitigation
(without reloading KVM) allows certain use cases to avoid the latency
problems associated with spawning a kthread for each VM.

E.g. in FaaS use cases, the guest kernel is trusted and the host may
create 100+ VMs per logical CPU, which can result in 100ms+ latencies when
a burst of VMs is created.

Reported-by: Li RongQing <lirongqing@baidu.com>
Closes: https://lore.kernel.org/all/1679555884-32544-1-git-send-email-lirongqing@baidu.com
Cc: Yong He <zhuangel570@gmail.com>
Cc: Robert Hoo <robert.hoo.linux@gmail.com>
Cc: Kai Huang <kai.huang@intel.com>
Reviewed-by: Robert Hoo <robert.hoo.linux@gmail.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Tested-by: Luiz Capitulino <luizcap@amazon.com>
Reviewed-by: Li RongQing <lirongqing@baidu.com>
Link: https://lore.kernel.org/r/20230602005859.784190-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
---
 arch/x86/kvm/mmu/mmu.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

I submitted this backport for 6.1.y[1] but we agreed that having it for 6.4.y
is desirable to allow upgrade path.

Tests performed:

 * Confirmed KVM_CREATE_VM latency goes down to less than 1ms
 * Quickly booted a simple guest with kvmtool

[1] https://lore.kernel.org/stable/cover.1693593288.git.luizcap@amazon.com/

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6eaa3d6994ae..11c050f40d82 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -58,6 +58,8 @@
 
 extern bool itlb_multihit_kvm_mitigation;
 
+static bool nx_hugepage_mitigation_hard_disabled;
+
 int __read_mostly nx_huge_pages = -1;
 static uint __read_mostly nx_huge_pages_recovery_period_ms;
 #ifdef CONFIG_PREEMPT_RT
@@ -67,12 +69,13 @@ static uint __read_mostly nx_huge_pages_recovery_ratio = 0;
 static uint __read_mostly nx_huge_pages_recovery_ratio = 60;
 #endif
 
+static int get_nx_huge_pages(char *buffer, const struct kernel_param *kp);
 static int set_nx_huge_pages(const char *val, const struct kernel_param *kp);
 static int set_nx_huge_pages_recovery_param(const char *val, const struct kernel_param *kp);
 
 static const struct kernel_param_ops nx_huge_pages_ops = {
 	.set = set_nx_huge_pages,
-	.get = param_get_bool,
+	.get = get_nx_huge_pages,
 };
 
 static const struct kernel_param_ops nx_huge_pages_recovery_param_ops = {
@@ -6844,6 +6847,14 @@ static void mmu_destroy_caches(void)
 	kmem_cache_destroy(mmu_page_header_cache);
 }
 
+static int get_nx_huge_pages(char *buffer, const struct kernel_param *kp)
+{
+	if (nx_hugepage_mitigation_hard_disabled)
+		return sprintf(buffer, "never\n");
+
+	return param_get_bool(buffer, kp);
+}
+
 static bool get_nx_auto_mode(void)
 {
 	/* Return true when CPU has the bug, and mitigations are ON */
@@ -6860,15 +6871,29 @@ static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
 	bool old_val = nx_huge_pages;
 	bool new_val;
 
+	if (nx_hugepage_mitigation_hard_disabled)
+		return -EPERM;
+
 	/* In "auto" mode deploy workaround only if CPU has the bug. */
-	if (sysfs_streq(val, "off"))
+	if (sysfs_streq(val, "off")) {
 		new_val = 0;
-	else if (sysfs_streq(val, "force"))
+	} else if (sysfs_streq(val, "force")) {
 		new_val = 1;
-	else if (sysfs_streq(val, "auto"))
+	} else if (sysfs_streq(val, "auto")) {
 		new_val = get_nx_auto_mode();
-	else if (kstrtobool(val, &new_val) < 0)
+	} else if (sysfs_streq(val, "never")) {
+		new_val = 0;
+
+		mutex_lock(&kvm_lock);
+		if (!list_empty(&vm_list)) {
+			mutex_unlock(&kvm_lock);
+			return -EBUSY;
+		}
+		nx_hugepage_mitigation_hard_disabled = true;
+		mutex_unlock(&kvm_lock);
+	} else if (kstrtobool(val, &new_val) < 0) {
 		return -EINVAL;
+	}
 
 	__set_nx_huge_pages(new_val);
 
@@ -7006,6 +7031,9 @@ static int set_nx_huge_pages_recovery_param(const char *val, const struct kernel
 	uint old_period, new_period;
 	int err;
 
+	if (nx_hugepage_mitigation_hard_disabled)
+		return -EPERM;
+
 	was_recovery_enabled = calc_nx_huge_pages_recovery_period(&old_period);
 
 	err = param_set_uint(val, kp);
@@ -7164,6 +7192,9 @@ int kvm_mmu_post_init_vm(struct kvm *kvm)
 {
 	int err;
 
+	if (nx_hugepage_mitigation_hard_disabled)
+		return 0;
+
 	err = kvm_vm_create_worker_thread(kvm, kvm_nx_huge_page_recovery_worker, 0,
 					  "kvm-nx-lpage-recovery",
 					  &kvm->arch.nx_huge_page_recovery_thread);
-- 
2.40.1

