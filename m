Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC18718A45
	for <lists+stable@lfdr.de>; Wed, 31 May 2023 21:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjEaTh1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 15:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjEaThZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 15:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B1128
        for <stable@vger.kernel.org>; Wed, 31 May 2023 12:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23C6A63300
        for <stable@vger.kernel.org>; Wed, 31 May 2023 19:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B58C433EF;
        Wed, 31 May 2023 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685561836;
        bh=3QH5aZlcSRU4610XRsKINe3bPQBeJWZu9g5TAOJVi7w=;
        h=From:Subject:Date:To:Cc:From;
        b=fPMKndLi9viZAHFFW2eLfnnGeWze5hhHLCesrPMrAVCWPyClxCAWrpA0wf7xfD7l6
         DhNEGQvFRR9evmkQjBVYol/fjklY4DFBoKkYi7jJ5o9Xtdfy3/0MYQXwYm6fldvKG3
         IYF3Vv3STI+CNjI1jSt0DonO6Jd1oFRN2GDUAH5deF/064A6EdtsnAjYblyhtkWVXQ
         s7cwlbT/TGFUlxhDC36AS4G8VMRz6/9f/F+22TxRMXLG6+a3U6q0BjKPCxIOONAzSX
         peNOvUDfUJtCtjO5TFa+UhemN+CyCMVra1aBjuofdWH27HQRnhLCVkGeh1DB221TZv
         TNoXP+28JwIjg==
From:   Mat Martineau <martineau@kernel.org>
Subject: [PATCH net 0/6] mptcp: Fixes for connect timeout, access
 annotations, and subflow init
Date:   Wed, 31 May 2023 12:37:02 -0700
Message-Id: <20230531-send-net-20230531-v1-0-47750c420571@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN6hd2QC/z2NwQqEMAxEf0Vy3oC2FWR/RTy0Jq45mJVGFkH8d
 6uHPb4Z3swBxlnY4F0dkPknJl8t0LwqGOeoH0ahwuBq5+vWN2ishMob/pPgOqIp+BSYoHgpGmP
 KUcf5NrdlRV3uYs08yf6c9VAmYDjPC2Lc8vqBAAAA
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, stable@vger.kernel.org,
        Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Patch 1 allows the SO_SNDTIMEO sockopt to correctly change the connect
timeout on MPTCP sockets.

Patches 2-5 add READ_ONCE()/WRITE_ONCE() annotations to fix KCSAN issues.

Patch 6 correctly initializes some subflow fields on outgoing connections.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Paolo Abeni (6):
      mptcp: fix connect timeout handling
      mptcp: add annotations around msk->subflow accesses
      mptcp: consolidate passive msk socket initialization
      mptcp: fix data race around msk->first access
      mptcp: add annotations around sk->sk_shutdown accesses
      mptcp: fix active subflow finalization

 net/mptcp/protocol.c | 140 ++++++++++++++++++++++++++++-----------------------
 net/mptcp/protocol.h |  15 +++---
 net/mptcp/subflow.c  |  28 +----------
 3 files changed, 88 insertions(+), 95 deletions(-)
---
base-commit: 448a5ce1120c5bdbce1f1ccdabcd31c7d029f328
change-id: 20230531-send-net-20230531-428ddf43b4ed

Best regards,
-- 
Mat Martineau <martineau@kernel.org>

