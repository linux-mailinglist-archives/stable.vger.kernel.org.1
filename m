Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCB97E956E
	for <lists+stable@lfdr.de>; Mon, 13 Nov 2023 04:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjKMDX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 12 Nov 2023 22:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbjKMDX7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 12 Nov 2023 22:23:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25715172B
        for <stable@vger.kernel.org>; Sun, 12 Nov 2023 19:23:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3970EC433B6;
        Mon, 13 Nov 2023 03:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699845835;
        bh=3fhqQ/6Paof6tKXgjKwnx+l50Cg3avv/xAwzx5scwHA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cHdRd0B2QP8kwbaKeutfP4bb6zeLjivj6vjCDrlzRkfmENozNn5IK8TQhzd2TZtLW
         2hb44pwT1g04n+hfzQQA+rMbnEFa43VxfnKK0mVW+9JvcJNuX43GIrpDPN16BwKSRU
         Azs+PDkJg+14ukH5bZC7NxBSydgjSAyFLzT77tDD3kF1raUoh5t3JJt0hVItieSCwC
         saAjdm2d1ntefledwJJbvRfedLAHCGIxfOXOp+Umd3trduL9iC7WwUxITe533aUS17
         SzjCuM6h3SY2M1WH+UumCLa7HEZr157CKpz01DH5zfE/I8o4Aal+KdjqYU38QZsHTM
         ud9Bz4HzTdDRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F47EE21ECD;
        Mon, 13 Nov 2023 03:23:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] iio: cros_ec: fix an use-after-free in
 cros_ec_sensors_push_data()
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169984583512.27851.7360374052526064442.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 03:23:55 +0000
References: <20230829030622.1571852-1-tzungbi@kernel.org>
In-Reply-To: <20230829030622.1571852-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org, jic23@kernel.org,
        lars@metafoo.de, chrome-platform@lists.linux.dev,
        gwendal@chromium.org, linux-iio@vger.kernel.org,
        dianders@chromium.org, swboyd@chromium.org, stable@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Jonathan Cameron <Jonathan.Cameron@huawei.com>:

On Tue, 29 Aug 2023 11:06:22 +0800 you wrote:
> cros_ec_sensors_push_data() reads `indio_dev->active_scan_mask` and
> calls iio_push_to_buffers_with_timestamp() without making sure the
> `indio_dev` stays in buffer mode.  There is a race if `indio_dev` exits
> buffer mode right before cros_ec_sensors_push_data() accesses them.
> 
> An use-after-free on `indio_dev->active_scan_mask` was observed.  The
> call trace:
> [...]
>  _find_next_bit
>  cros_ec_sensors_push_data
>  cros_ec_sensorhub_event
>  blocking_notifier_call_chain
>  cros_ec_irq_thread
> 
> [...]

Here is the summary with links:
  - [v2] iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()
    https://git.kernel.org/chrome-platform/c/7771c8c80d62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


