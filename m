Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589BA77ABCA
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjHMVZr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjHMVZr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:25:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8E510D7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E2162964
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31FCC433C8;
        Sun, 13 Aug 2023 21:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961948;
        bh=+Su1aaPR8khowXqHITVKYSJp3F2XRYzHxqLfBBuEURQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4CmcEzMGD2ovMTZ8pElVBjyPs/rf5HeOqJFFgR9IE+SAodLPmmSk8sZfiGOADjj2
         iNHQILL7gJtcI5z2OXT+EiB/TPbu/lvRr+5blm7BPHlW8jyRrWX7CHHW1H9xgB1Va1
         00MQA+b449IRdceMDOBXTrujLbXIGauTmeLjnOLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Jannik=20Gl=C3=BCckert?= <jannik.glueckert@gmail.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Nathan Chancellor <nathan@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.4 055/206] cpufreq: amd-pstate: fix global sysfs attribute type
Date:   Sun, 13 Aug 2023 23:17:05 +0200
Message-ID: <20230813211726.592598074@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

commit 5e720f8c8c9d959283c3908bbf32a91a01a86547 upstream.

In commit 3666062b87ec ("cpufreq: amd-pstate: move to use bus_get_dev_root()")
the "amd_pstate" attributes where moved from a dedicated kobject to the
cpu root kobject.

While the dedicated kobject expects to contain kobj_attributes the root
kobject needs device_attributes.

As the changed arguments are not used by the callbacks it works most of
the time.
However CFI will detect this issue:

[ 4947.849350] CFI failure at dev_attr_show+0x24/0x60 (target: show_status+0x0/0x70; expected type: 0x8651b1de)
...
[ 4947.849409] Call Trace:
[ 4947.849410]  <TASK>
[ 4947.849411]  ? __warn+0xcf/0x1c0
[ 4947.849414]  ? dev_attr_show+0x24/0x60
[ 4947.849415]  ? report_cfi_failure+0x4e/0x60
[ 4947.849417]  ? handle_cfi_failure+0x14c/0x1d0
[ 4947.849419]  ? __cfi_show_status+0x10/0x10
[ 4947.849420]  ? handle_bug+0x4f/0x90
[ 4947.849421]  ? exc_invalid_op+0x1a/0x60
[ 4947.849422]  ? asm_exc_invalid_op+0x1a/0x20
[ 4947.849424]  ? __cfi_show_status+0x10/0x10
[ 4947.849425]  ? dev_attr_show+0x24/0x60
[ 4947.849426]  sysfs_kf_seq_show+0xa6/0x110
[ 4947.849433]  seq_read_iter+0x16c/0x4b0
[ 4947.849436]  vfs_read+0x272/0x2d0
[ 4947.849438]  ksys_read+0x72/0xe0
[ 4947.849439]  do_syscall_64+0x76/0xb0
[ 4947.849440]  ? do_user_addr_fault+0x252/0x650
[ 4947.849442]  ? exc_page_fault+0x7a/0x1b0
[ 4947.849443]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixes: 3666062b87ec ("cpufreq: amd-pstate: move to use bus_get_dev_root()")
Reported-by: Jannik Glückert <jannik.glueckert@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217765
Link: https://lore.kernel.org/lkml/c7f1bf9b-b183-bf6e-1cbb-d43f72494083@gmail.com/
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/amd-pstate.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -986,8 +986,8 @@ static int amd_pstate_update_status(cons
 	return 0;
 }
 
-static ssize_t show_status(struct kobject *kobj,
-			   struct kobj_attribute *attr, char *buf)
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	ssize_t ret;
 
@@ -998,7 +998,7 @@ static ssize_t show_status(struct kobjec
 	return ret;
 }
 
-static ssize_t store_status(struct kobject *a, struct kobj_attribute *b,
+static ssize_t status_store(struct device *a, struct device_attribute *b,
 			    const char *buf, size_t count)
 {
 	char *p = memchr(buf, '\n', count);
@@ -1017,7 +1017,7 @@ cpufreq_freq_attr_ro(amd_pstate_lowest_n
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
-define_one_global_rw(status);
+static DEVICE_ATTR_RW(status);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -1036,7 +1036,7 @@ static struct freq_attr *amd_pstate_epp_
 };
 
 static struct attribute *pstate_global_attributes[] = {
-	&status.attr,
+	&dev_attr_status.attr,
 	NULL
 };
 


