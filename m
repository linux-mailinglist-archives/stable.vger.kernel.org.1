Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2297A0324
	for <lists+stable@lfdr.de>; Thu, 14 Sep 2023 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236843AbjINL7a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 14 Sep 2023 07:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjINL7a (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 14 Sep 2023 07:59:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6CCC3
        for <stable@vger.kernel.org>; Thu, 14 Sep 2023 04:59:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAB7C433C7;
        Thu, 14 Sep 2023 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694692765;
        bh=gssHXPbJz0czz/j6r72eiOm6doPN5TsZmH8mlKsgcDk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FxkcUmh2KpdyeHOsKSAohYWvVqmSAApyXLB1F0DdTIRaqWXrG/0cldwaGBAOCgODb
         TJYCGzoHZi7dsiPahtYeIyJ6VX0klyR5YWpOxF6pjNX1bdFp+vzot0PV5aZ6DsKtN1
         SUmtM8C0hA2RMcejE21hh7eEnEHeXiMEX+eLKFR0t3CX0aTodbQfjxu+6FfGEU6LGW
         T2sBD5QJU9kyxEEJJQEWDZ1/KJSadcXmTsffYgO3Sry/p7iqkhWPCDiRl4PCVrt66B
         kfiflZxJXeBm54W507E8+Xx63k7XsgYc2iDqvrx/LwO70S7b9AZYu22M5/LaSRvIlf
         iTrQjdI0V9Gcg==
From:   Maxime Ripard <mripard@kernel.org>
To:     intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
In-Reply-To: <20230907135339.7971-2-thomas.hellstrom@linux.intel.com>
References: <20230907135339.7971-1-thomas.hellstrom@linux.intel.com>
 <20230907135339.7971-2-thomas.hellstrom@linux.intel.com>
Subject: Re: (subset) [PATCH v3 1/2] drm/tests: helpers: Avoid a driver uaf
Message-Id: <169469276263.950625.147303108903470167.b4-ty@kernel.org>
Date:   Thu, 14 Sep 2023 13:59:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 07 Sep 2023 15:53:38 +0200, Thomas Hellström wrote:
> when using __drm_kunit_helper_alloc_drm_device() the driver may be
> dereferenced by device-managed resources up until the device is
> freed, which is typically later than the kunit-managed resource code
> frees it. Fix this by simply make the driver device-managed as well.
> 
> In short, the sequence leading to the UAF is as follows:
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime

