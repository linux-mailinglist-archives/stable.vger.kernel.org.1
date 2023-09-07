Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09E7976C5
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbjIGQQU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 12:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbjIGQP6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 12:15:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1F493FE
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 09:14:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB4CC36AF1;
        Thu,  7 Sep 2023 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694098239;
        bh=+gO7O6tHf+BV9PIKE7c/h7YCFsv3vVrvtAyihjc2yNA=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=c9FmK49Q20pe55+Zb+EyNBOOge1ZRdMtE+UZj5GKYjA5phs1JzDOamw0Ac00GTb1T
         QkOeqd3TaSQ8tzl71GBnIQK2Fy1M8hTxzQ8wrrGr9F6NL0Yraybq8LMBn8bU9Op+Ik
         mdo6GrXbpcklesT7ZhSMzegeRn64/Wk4JARtFNkxJtn++wq1hKqBmWUaE9pxyN/W2/
         DaLTT2r3UlWi9Ux7VKuFpo1MeB0GifymRATRpoRspvzk+tzQXr/5UKfqEoj40qbuNu
         DOoqxw/BtshCVn21OJzC/2+DytDMUY6KzelYqOLwQFZuIpovZ7wmzMTftIWwtb+meA
         3grjwpB8jbXew==
Message-ID: <8708c8beff5669e772a8d2e0dd76c9e3.mripard@kernel.org>
Date:   Thu, 07 Sep 2023 14:50:36 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= 
        <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 1/2] drm/tests: helpers: Avoid a driver uaf
In-Reply-To: <20230907135339.7971-2-thomas.hellstrom@linux.intel.com>
References: <20230907135339.7971-2-thomas.hellstrom@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        stable@vger.kernel.org, "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@gmail.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 7 Sep 2023 15:53:38 +0200, Thomas Hellstr=C3=B6m wrote:
> when using __drm_kunit_helper_alloc_drm_device() the driver may be
> dereferenced by device-managed resources up until the device is
> freed, which is typically later than the kunit-managed resource code
> frees it. Fix this by simply make the driver device-managed as well.
>=20
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
