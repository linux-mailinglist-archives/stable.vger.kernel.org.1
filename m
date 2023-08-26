Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D1D78991B
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 22:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjHZUnd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 16:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHZUnI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 16:43:08 -0400
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Aug 2023 13:43:04 PDT
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC43100
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 13:43:04 -0700 (PDT)
Message-ID: <3dc52ac6-790b-42b7-949b-cc1aa6a54b5b@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1693082207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6cRVY6AmG52g7WjXpoJk4ZJSUetrDa2WM7oK9jSWd/g=;
        b=DdpBqM2FWXWRYkg5kJbwL15XknhVwURRq95Z85EVpAzZR+AojDL0g2+DXd8MyIbZHr9oed
        wgSZ8TKMNyd6VSNjQbcMGbcQV6V5JCO/ce8lYdzFGcsnYtcnNPcIhSkHVmm0Ientv4oCab
        5JlV1kRT+rJ7zCteuGkAetM+/yIggx5Xx36MN88NVLPeTeLi2tXjbErIPD7SRNN6Xo3VVP
        YEEz8UGtwwXDeojPoiY4Xi2woxjujnfWPG3918GulcBzGeCCUxCpILyZYjHH2arwxR4rqj
        mnWjQOzmoz+yLBlGI+aB1/BmMUm5znxHUFNRjYmtd47PpxFqAhnoKgrallO4kw==
Date:   Sat, 26 Aug 2023 22:36:41 +0200
MIME-Version: 1.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Bernhard Landauer <bernhard@manjaro.org>
From:   =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Subject: =?UTF-8?B?NS4xMC4xOTIgZmFpbHMgdG8gYnVpbGQgKGVycm9yOiDigJhSVDcxMV9K?=
 =?UTF-8?Q?D2=5F100K=E2=80=99_undeclared_here_=28not_in_a_function=29=29?=
Organization: Manjaro Community
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

please revert the following two patches as 5.10.192 fails to build with 
them:

asoc-intel-sof_sdw-add-quirk-for-lnl-rvp.patch
asoc-intel-sof_sdw-add-quirk-for-mtl-rvp.patch

Error message: error: ‘RT711_JD2_100K’ undeclared here (not in a function)

2023-08-26T17:46:51.3733116Z sound/soc/intel/boards/sof_sdw.c:208:41: 
error: ‘RT711_JD2_100K’ undeclared here (not in a function)
2023-08-26T17:46:51.3744338Z   208 |                 .driver_data = 
(void *)(RT711_JD2_100K),
2023-08-26T17:46:51.3745547Z       | 
     ^~~~~~~~~~~~~~
2023-08-26T17:46:51.4620173Z make[4]: *** [scripts/Makefile.build:286: 
sound/soc/intel/boards/sof_sdw.o] Error 1
2023-08-26T17:46:51.4625055Z make[3]: *** [scripts/Makefile.build:503: 
sound/soc/intel/boards] Error 2
2023-08-26T17:46:51.4626370Z make[2]: *** [scripts/Makefile.build:503: 
sound/soc/intel] Error 2

This happened before already:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/queue-5.10?id=2e4795b45723de3d253f38bc57724d9512c737f5

-- 
Best, Philip
