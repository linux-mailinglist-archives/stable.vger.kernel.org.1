Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A9D735380
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjFSKqM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFSKpq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:45:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD3F4
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:45:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ADD260B5E
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E018C433C0;
        Mon, 19 Jun 2023 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171520;
        bh=ap3jkD9bWHq32RU4HgblFqK2uQUDLFh8qSg39w0GXXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ll7XIOfstt6LuncefpHDOrVs46PHhzPOUpLj8ktBaAmZg7nPVA8NsDre0hG/+K+kp
         G4vyeWOOGy75RmDUMb4fxuCI3i+VU1vqMX+vnD47J6QhBct2nrRWoSm9EGS6ctFVQ5
         ECg224jpF7YwZAODokIGksvLS/TVIW+88Zult77s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jun Yi <yijun@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1 053/166] LoongArch: Fix perf event id calculation
Date:   Mon, 19 Jun 2023 12:28:50 +0200
Message-ID: <20230619102157.331362573@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

commit 962369120d750cbc9c4dc492f32b4304669ff6aa upstream.

LoongArch PMCFG has 10bit event id rather than 8 bit, so fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Jun Yi <yijun@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/perf_event.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -271,7 +271,7 @@ static void loongarch_pmu_enable_event(s
 	WARN_ON(idx < 0 || idx >= loongarch_pmu.num_counters);
 
 	/* Make sure interrupt enabled. */
-	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base & 0xff) |
+	cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base) |
 		(evt->config_base & M_PERFCTL_CONFIG_MASK) | CSR_PERFCTRL_IE;
 
 	cpu = (event->cpu >= 0) ? event->cpu : smp_processor_id();
@@ -594,7 +594,7 @@ static struct pmu pmu = {
 
 static unsigned int loongarch_pmu_perf_event_encode(const struct loongarch_perf_event *pev)
 {
-	return (pev->event_id & 0xff);
+	return M_PERFCTL_EVENT(pev->event_id);
 }
 
 static const struct loongarch_perf_event *loongarch_pmu_map_general_event(int idx)
@@ -849,7 +849,7 @@ static void resume_local_counters(void)
 
 static const struct loongarch_perf_event *loongarch_pmu_map_raw_event(u64 config)
 {
-	raw_event.event_id = config & 0xff;
+	raw_event.event_id = M_PERFCTL_EVENT(config);
 
 	return &raw_event;
 }


