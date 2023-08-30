Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F6578DAFE
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbjH3SiR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 30 Aug 2023 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245667AbjH3PwV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 30 Aug 2023 11:52:21 -0400
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34D9122
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 08:52:16 -0700 (PDT)
Received: from [192.168.1.103] (178.176.75.182) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Wed, 30 Aug
 2023 18:52:10 +0300
Subject: Re: [PATCH 5.4 044/158] mmc: bcm2835: fix deferred probing
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC:     <patches@lists.linux.dev>, Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
References: <20230828101157.322319621@linuxfoundation.org>
 <20230828101158.817680940@linuxfoundation.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <4c269565-e798-7c7e-b4f1-4057b44faeaf@omp.ru>
Date:   Wed, 30 Aug 2023 18:52:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230828101158.817680940@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [178.176.75.182]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 08/30/2023 15:30:03
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 179545 [Aug 30 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 529 529 a773548e495283fecef97c3e587259fde2135fef
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.182 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info: lore.kernel.org:7.1.1;178.176.75.182:7.1.2,7.7.3;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: {rdns complete}
X-KSE-AntiSpam-Info: {fromrtbl complete}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.182
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=none header.from=omp.ru;spf=none
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/30/2023 15:35:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 8/30/2023 8:27:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 8/28/23 1:12 PM, Greg Kroah-Hartman wrote:

> 5.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [ Upstream commit 71150ac12558bcd9d75e6e24cf7c872c2efd80f3 ]
> 
> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the error
> codes upstream.  Since commit ce753ad1549c ("platform: finally disallow IRQ0
> in platform_get_irq() and its ilk") IRQ0 is no longer returned by those APIs,
> so we now can safely ignore it...
> 
> Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
> Cc: stable@vger.kernel.org # v5.19+

   After a glance at the driver, the patch seems safe to be applied to 5.4.y,
despite I tried to limit it to 5.19.y and newer...

> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Link: https://lore.kernel.org/r/20230617203622.6812-2-s.shtylyov@omp.ru
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
[...]

MBR, Sergey
