Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F407897E3
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjHZP4t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 11:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjHZP4W (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 11:56:22 -0400
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Aug 2023 08:56:16 PDT
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7CE1BD4
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 08:56:16 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5b2e8104.dip0.t-ipconnect.de [91.46.129.4])
        by mail.itouring.de (Postfix) with ESMTPSA id 1443F147;
        Sat, 26 Aug 2023 17:46:41 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id C3BFFF01609;
        Sat, 26 Aug 2023 17:46:40 +0200 (CEST)
To:     Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Wrong patch queued up for 6.4:
 mm-disable-config_per_vma_lock-until-its-fixed.patch
Organization: Applied Asynchrony, Inc.
Message-ID: <ab4017e3-31ce-f1d0-b2b4-331868f1f643@applied-asynchrony.com>
Date:   Sat, 26 Aug 2023 17:46:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Sasha

I just saw that you queued up mm-disable-config_per_vma_lock-until-its-fixed.patch for 6.4.
The problems that this patch tried to prevent were fixed before it actually made it into a
release, and Linus un-did the commit in his merge (at the bottom):
  
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/mm/Kconfig?id=7fa8a8ee9400fe8ec188426e40e481717bc5e924

Since the fixes for PER_VMA_LOCK have been in 6.4 releases for a while, this patch
should not go in.

thanks
Holger
