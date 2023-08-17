Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D270377FEA6
	for <lists+stable@lfdr.de>; Thu, 17 Aug 2023 21:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbjHQTl4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 17 Aug 2023 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354723AbjHQTlu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 17 Aug 2023 15:41:50 -0400
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Aug 2023 12:41:47 PDT
Received: from danwin1210.de (danwin1210.de [116.202.17.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9281C359B
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 12:41:47 -0700 (PDT)
Received: from danwin1210.de (unknown [10.9.0.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X448 server-signature ECDSA (secp384r1) server-digest SHA384
         client-signature ED448)
        (Client CN "danwin1210.me", Issuer "danwin1210.me" (verified OK))
        by mail.danwin1210.de (Postfix) with ESMTPS id 7AE2247F0F
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 19:33:12 +0000 (UTC)
Received: from danwin1210.de (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by danwin1210.de (Postfix) with ESMTPSA id 87B6D5A200
        for <stable@vger.kernel.org>; Thu, 17 Aug 2023 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danwin1210.de;
        s=20211204-rsa; t=1692300791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kjYMXRMwg2NKwCIYm+Oudd/ndvOmCwPrFOMAc8RS4XY=;
        b=JhM3STG++4SO/PrZ9ZFftLDJSkB6JR3x4U4McAV5G4Yh8LSkZbtJJTmj7TglUn08dYLAev
        MFRAspmepeEFlzDI8kX51Xv+zTY8hdn61Qj0/ePEr7vFT4nYdBmJTOctNRQMk+oJJhZjNM
        SmNW+bT7ZxIfig+0UgiIsGq6492pbs0fYrBPa7nyz2qSAYm3Xfg3hpdMAbOxijLl440KUz
        EXn7Ck297P7gjv0AvFoM1Ga2i4PY93y47A+H5q97PlscSpEh/7DQylytUG77yJ6DflmCU3
        /N4rYxW8Pzxyo9HJFGa4fXT6jDWkPx65f+WghrLnhTZi1Q+yV7Yk+w/rdqJMTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=danwin1210.de;
        s=20211204-ed25519; t=1692300791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kjYMXRMwg2NKwCIYm+Oudd/ndvOmCwPrFOMAc8RS4XY=;
        b=Jp3D3OtUNb2lsjdkTaj+vgu++DIj/QidAtel+z2gIxsueHLMmvsI60/gLY84s2ST0GNXsX
        2562rCMe+Q2ZrYDw==
Received: from ::ffff:10.9.0.1
        by danwin1210.de with HTTP;
        Thu, 17 Aug 2023 19:33:11 -0000
Message-ID: <bfd58918-d130-5b88-bd9e-39611fdbbfae@danwin1210.de>
Date:   Thu, 17 Aug 2023 19:33:11 -0000
Subject: Request to add a patch to Stable Branch 6.1
From:   "SG" <prosparety@danwin1210.de>
To:     stable@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

(Before starting, i want to say i am not the developer of the patch, i am
just an end user of a distribution kernel, which has just faced some
problem, i don't even know if kernel team accepts patch requests from non
dev, and thi mail is mostly shot in dark)

Respected Sir/s/Ma'am/s
    I want to request that patch
https://lore.kernel.org/all/20230627062442.54008-1-mika.westerberg@linux.intel.com/#r
be accepted in to the stable 6.1 branch, it is already present in the
current branch, and i request for it to be backported. This fixes some
Intel CPUs (according to other users claims, ranging back to 6th gen
for some) not going to deeper c states with kernels 5.16+, and was
fixed by this patch in 6.4.4+, since many institutions, and
distributions use 6.1, it would be great if this is included (from
what i understand from requirements
(https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html)
i guess it fits all)

    I was facing this issue for roughly a year, and then reported in
debian(my distribution) forums, and we found nothing earlier
(https://forums.debian.net/viewtopic.php?t=154875), then i posted on
some other forums, and then i was asked to check if there was an
active bug linux kernel tracker at that time, and i could not find
one, so i decided to raise an issue
(https://bugzilla.kernel.org/show_bug.cgi?id=217616), but just a few
days prior to me posting someone had submiteed the patch, that i did
not know of, since then i am using the newest kernel(in 6.4 branch)
and am not facing issues.

I apologize for all the foolishness of mine, and just making an humble
request.


Thank You

