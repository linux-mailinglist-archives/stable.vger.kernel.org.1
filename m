Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C371275B600
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjGTR7R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 13:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGTR7Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 13:59:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF6E270B;
        Thu, 20 Jul 2023 10:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEB1B61BB9;
        Thu, 20 Jul 2023 17:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDF8C433C8;
        Thu, 20 Jul 2023 17:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689875955;
        bh=6MC0SKh+OZqJO6ePCLzs5hDqg/4UZQUCfwGaq9beoFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1o4F2lVwLv87B8AcxxWZfpZCufRBTpvBVUDQziPAkGbY8JL+Igkz29CDuh6aaKKs8
         h08O9xmQCRPiBMhgXWD9qK3JhNmu555KerPdMgcsdZnhMPg7dbzo7VI0BqI3Gf/OUj
         +2/qDudfFTEpcV8levlyF/d+8mo16dvTbKtGigvE=
Date:   Thu, 20 Jul 2023 19:59:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     amir73il@gmail.com, miklos@szeredi.hu,
        linux-unionfs@vger.kernel.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: Re: [PATCH 6.1 0/2] ovl: fix null pointer dereference in ovl_get_acl
 rcu path
Message-ID: <2023072005-prozac-shading-8818@gregkh>
References: <20230717030904.1669754-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717030904.1669754-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jul 17, 2023 at 11:09:02AM +0800, Zhihao Cheng wrote:
> Zhihao Cheng (2):
>   ovl: let helper ovl_i_path_real() return the realinode
>   ovl: fix null pointer dereference in ovl_get_acl_rcu()
> 
>  fs/overlayfs/inode.c     | 12 ++++++------
>  fs/overlayfs/overlayfs.h |  2 +-
>  fs/overlayfs/util.c      |  7 ++++---
>  3 files changed, 11 insertions(+), 10 deletions(-)
> 
> -- 
> 2.39.2
> 

Now queued up, thanks.

greg k-h
