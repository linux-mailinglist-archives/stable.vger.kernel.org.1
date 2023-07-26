Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED199762983
	for <lists+stable@lfdr.de>; Wed, 26 Jul 2023 05:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGZDxf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 23:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGZDxe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 23:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA0D1BF2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 20:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 155D1611C8
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 03:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB35C433C8;
        Wed, 26 Jul 2023 03:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690343612;
        bh=RMr8bRzLunRxtCrJQOL6/k3E088XGswEuiJqIShjTck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eREjlYaqD/aAAXCBw18NEa45ugyBsTiwP49e89Rd7Jba3DQEcvKYLhkF9Itrgbkr5
         HLDXC3vgLBOkNj/RWI7gm0LIKj7rhbKCujeU4xqPIEiyDUC6RMqWtFEuCnqMlWVksV
         hK83dE0mj8aJu2SxMc5JNNtwjUgQeJe9wwEgVsdk=
Date:   Wed, 26 Jul 2023 05:53:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     iommu@lists.linux.dev,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, stable@vger.kernel.org,
        syzbot+7574ebfe589049630608@syzkaller.appspotmail.com,
        Terrence Xu <terrence.xu@intel.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH rc 1/3] iommufd/selftest: Do not try to destroy an access
 once it is attached
Message-ID: <2023072608-foam-impotency-04e5@gregkh>
References: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <1-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 25, 2023 at 04:05:48PM -0300, Jason Gunthorpe wrote:
> The access must be detached first.
> 
> To make the cleanup simpler copy the fdno to userspace before creating the
> access in the first place. Then there is no need to unwind after
> iommufd_access_attach.
> 
> Fixes: 54b47585db66 ("iommufd: Create access in vfio_iommufd_emulated_bind()")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/selftest.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
