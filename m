Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8BE75D187
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGUSt5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjGUSt4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC9930CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C6F061D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA7CC433C8;
        Fri, 21 Jul 2023 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965394;
        bh=+UOsnBcpgKz9xa4EYyJ+aRlxF8GlBzUf+ZuVWmMAcDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8DOvuDc6V2OMMDZNm9sMDBXW77Sj8Qxfml38dQJpOvYqOZN5FipcEoKJtbL7+hcD
         WLxImOLqDOGBQMbK2Sr48dztYdgLrVcYd2sH4tV4stFid8Z4EOxlZarnBcqx5fbNKp
         XuSqe4GX0q7ivQ44pyVko/+ZwWEXhbKh3/cuaKUU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chungkai Yang <Chung-kai.Yang@mediatek.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.4 251/292] PM: QoS: Restore support for default value on frequency QoS
Date:   Fri, 21 Jul 2023 18:06:00 +0200
Message-ID: <20230721160539.700723476@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Chungkai Yang <Chung-kai.Yang@mediatek.com>

commit 3a8395b565b5b4f019b3dc182be4c4541eb35ac8 upstream.

Commit 8d36694245f2 ("PM: QoS: Add check to make sure CPU freq is
non-negative") makes sure CPU freq is non-negative to avoid negative
value converting to unsigned data type. However, when the value is
PM_QOS_DEFAULT_VALUE, pm_qos_update_target specifically uses
c->default_value which is set to FREQ_QOS_MIN/MAX_DEFAULT_VALUE when
cpufreq_policy_alloc is executed, for this case handling.

Adding check for PM_QOS_DEFAULT_VALUE to let default setting work will
fix this problem.

Fixes: 8d36694245f2 ("PM: QoS: Add check to make sure CPU freq is non-negative")
Link: https://lore.kernel.org/lkml/20230626035144.19717-1-Chung-kai.Yang@mediatek.com/
Link: https://lore.kernel.org/lkml/20230627071727.16646-1-Chung-kai.Yang@mediatek.com/
Link: https://lore.kernel.org/lkml/CAJZ5v0gxNOWhC58PHeUhW_tgf6d1fGJVZ1x91zkDdht11yUv-A@mail.gmail.com/
Signed-off-by: Chungkai Yang <Chung-kai.Yang@mediatek.com>
Cc: 6.0+ <stable@vger.kernel.org> # 6.0+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/power/qos.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -426,6 +426,11 @@ late_initcall(cpu_latency_qos_init);
 
 /* Definitions related to the frequency QoS below. */
 
+static inline bool freq_qos_value_invalid(s32 value)
+{
+	return value < 0 && value != PM_QOS_DEFAULT_VALUE;
+}
+
 /**
  * freq_constraints_init - Initialize frequency QoS constraints.
  * @qos: Frequency QoS constraints to initialize.
@@ -531,7 +536,7 @@ int freq_qos_add_request(struct freq_con
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(qos) || !req || value < 0)
+	if (IS_ERR_OR_NULL(qos) || !req || freq_qos_value_invalid(value))
 		return -EINVAL;
 
 	if (WARN(freq_qos_request_active(req),
@@ -563,7 +568,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
  */
 int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
 {
-	if (!req || new_value < 0)
+	if (!req || freq_qos_value_invalid(new_value))
 		return -EINVAL;
 
 	if (WARN(!freq_qos_request_active(req),


