Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F977CE9EE
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 23:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJRV00 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 17:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJRV0Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 17:26:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714969B
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 14:26:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E310C433C8;
        Wed, 18 Oct 2023 21:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697664384;
        bh=BglcM4atM+2rf5B/mp1sHG8DqPMTxuGyhRalY9Zn6Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4w2CGYYg9TGEuwZbCTuExyWqr1UZrosAv2oZcC+oL3cS3Wxsf6lKkyfXS1R/8+9w
         veQYYuO9q97Kaa/7arcQ+uU2sUPXwVwcT/jZp56PMauBCzhA5dznT0OQr2WKB0fQlc
         VVwqnaU/l9zn5yKDrxCM+FN0FCh9vERfox1hFSvp90s3zM84gAwkykTGhmR2UUOoq7
         PnFaQ+m3/nZVURYdP3feVau5Znjc7hm2LYbyrmbO4TIuzI4r3vvtFJCGZljDyH/Frr
         cSN2AQHvlPWSYizCnYMNXmcQe5ZRG1zaXr+m8K64iMzimysodmqHcZqJn+1YGjPV60
         1v/0S7ygKTgAg==
Date:   Wed, 18 Oct 2023 15:26:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, gost.dev@samsung.com,
        vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZTBNfDzxD3D8loMm@kbusch-mbp>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
 <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On further consideration and some offline chats, I believe this large
change is a bit too late for 6.6. I think this should wait for 6.7 (and
stable), hopefully preserving non-root access in some sane capacity.
It's backed out now, and current nvme-6.6 PR does not include this
patch.
