Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8907F09D4
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 00:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjKSXUW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 19 Nov 2023 18:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSXUV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 19 Nov 2023 18:20:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2581612D
        for <stable@vger.kernel.org>; Sun, 19 Nov 2023 15:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1700436013;
        bh=76dgy/q3s+u4p4Cb3MeIetYWtCubfvcxxj7D9CtJh6U=;
        h=From:To:Cc:Subject:Date:From;
        b=q5QOG72OVYAXPZy+ExCRxU4NQrqmT1g+ww/78GDQS/z4pHLvhzbOSWSJQETmIsERz
         /tyiKYI4oQNO70OMvq1CYS8k7ApI9o0EfPrIbqrtPD1nefSnrQ73+izLgKcdbFzUUc
         +FoBJ5qcNgBpIj6uIjtTmRP/qLbyN1QRC65GLYMVNdeb+2TAcyPcZldYoxUPPMr4wU
         sLkXXpsGFnZkZB0Gkq7eTFUUb4EQZBrXvHzrKcw30w+PJIgAilXnJ6lfw+dFCoMnQj
         h1L9yCPugbH2GLUME6unkZcvTehXq2JHaIc39o/quAiJi8nVyhjHBDV+OxHHsjt94I
         Q5xEgVvqtUwLA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SYRSY37gsz4wcj;
        Mon, 20 Nov 2023 10:20:13 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     stable@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, matoro_mailinglist_kernel@matoro.tk
Subject: Please backport feea65a338e5 ("powerpc/powernv: Fix fortify source
 warnings in opal-prd.c")
Date:   Mon, 20 Nov 2023 10:20:13 +1100
Message-ID: <87edgl72ky.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

Please backport feea65a338e5 ("powerpc/powernv: Fix fortify source
warnings in opal-prd.c") to the 6.5, 6.1, 5.15, 5.10 stable trees.

cheers
