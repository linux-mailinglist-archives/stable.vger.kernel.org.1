Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB587C60ED
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 01:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjJKXNP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 11 Oct 2023 19:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbjJKXNP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Oct 2023 19:13:15 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DE3A4
        for <stable@vger.kernel.org>; Wed, 11 Oct 2023 16:13:12 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D73E985095;
        Thu, 12 Oct 2023 01:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1697065990;
        bh=jHegH9hKburtQjpJbCtxtjkqlJHwi1u7c4KR3CukdBk=;
        h=Date:To:Cc:From:Subject:From;
        b=ltXQQbXA9MnaDNbFp1p8XkNzY9kCYO8Z9m1AWCQZ1l29tqC4sG3bQzOOb+CPkoH9C
         lKT3fult0owHEZlgu9fVgNT67eGdB0stwo5dDdqqW1AKWCYfvzbcojV75F2oKe8kBG
         aWLOmZOqbmZu33YS2FDQA20UbVd/R0CRgyJKex46c8kpVqqItISPksZka9LRluQ0el
         MJpXRL5AKkSay2+Uysibscl5JpQaH9CZnuC+jgzK6whDApduqxt41+RcS5j6uRZa2X
         j789tyqO6ABLazNekowkrTQ3bFzosI6R3e3lMNsFPlUwZYU0DA1PbWLMblJkH/w1GU
         XIYD8Yn/ydIRg==
Message-ID: <aaa0d2cc-832d-4b57-a06d-0d1fa77a4b03@denx.de>
Date:   Thu, 12 Oct 2023 01:13:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     linux-stable <stable@vger.kernel.org>
Cc:     Rafael Aquini <aquini@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Waiman Long <llong@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Marek Vasut <marex@denx.de>
Subject: Linux 5.10.y / ipc: replace costly bailout check in
 sysvipc_find_ipc()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Please backport to Linux 5.10.y :

20401d1058f3f841f35a594ac2fc1293710e55b9
ipc: replace costly bailout check in sysvipc_find_ipc()

This should address CVE-2021-3669
https://nvd.nist.gov/vuln/detail/CVE-2021-3669

Thank you
