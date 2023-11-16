Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D297EE920
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 23:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjKPWQK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 16 Nov 2023 17:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPWQJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 16 Nov 2023 17:16:09 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B1393;
        Thu, 16 Nov 2023 14:16:01 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SWZ9m4dYjz9sqm;
        Thu, 16 Nov 2023 23:15:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owenh.net; s=MBO0001;
        t=1700172956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IOs5PKValxWwrHSRlwT5CjuUgDsEUY/5qwCngDdQ3zg=;
        b=kDjPJbayGy0oHTuomMkZ0A2KY2B7z8B/c5Vox56YlXqprW5+e7r5R7svpnsbVR2dLLlUv8
        FefVqtlNtgGrpFVHC4UTcKW1V5Rl9vIluGSFS//ygN84udTaWyBycVB7By3XvnzTST2iM1
        FsR3JfL0hr6yKQXRFC2SrZEc2uuyskubLrGHNYPIy587BXn9FOOla7IKd473Y3mGP69KeQ
        VkjqhNeJzSwbfCPBh7IYsMNY/JUSpTAW19FBNWAo8EAhu71nivcmYIVrvqjnGEz8tC4V89
        zEbkVF4X+JiARv6Apgez/MKJVqGYdOMzeZePpjwKsG+fNLPIFZZLmsHpGkqR/g==
Message-ID: <2c23665d-7ba4-45f5-9065-76c58f6768b2@owenh.net>
Date:   Thu, 16 Nov 2023 16:15:45 -0600
MIME-Version: 1.0
Subject: Re: [REGRESSION]: acpi/nouveau: Hardware unavailable upon resume or
 suspend fails
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     stable@vger.kernel.org, regressions@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
References: <9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net>
 <CAAd53p7BSesx=a1igTohoSkxrW+Hq8O7ArONFCK7uoDi12-T4A@mail.gmail.com>
 <a592ce0c-64f0-477d-80fa-8f5a52ba29ea@redhat.com>
 <CAAd53p608qmC3pvz=F+y2UZ9O39f2aq-pE-1_He1j8PGQmM=tg@mail.gmail.com>
 <d1ac9c1e-f3fe-4d06-ba2e-2c049841d19b@owenh.net>
 <55698544-8cba-4413-bdd3-79cfaa1f3c44@redhat.com>
From:   "Owen T. Heisler" <writer@owenh.net>
In-Reply-To: <55698544-8cba-4413-bdd3-79cfaa1f3c44@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4SWZ9m4dYjz9sqm
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11/12/23 14:43, Hans de Goede wrote:
> Owen, Kai-Heng thank you for testing. I've submitted these patches
> to Rafael (the ACPI maintainer) now (with you on the Cc).
> Hopefully they will get merged soon.

That's great, thanks!

Owen

