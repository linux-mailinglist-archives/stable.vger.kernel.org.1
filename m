Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376567924B1
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 17:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjIEP73 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353687AbjIEHOx (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 03:14:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7BCC2
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 00:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2088B80932
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 07:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3327AC433C8;
        Tue,  5 Sep 2023 07:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693898086;
        bh=PZloC2cOQQ3LO2YUAwJI9sm1uo3q+HxM4cjpDG/uvDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2U7lgLEh2SoHZVVePbz04UTORFhMGPsC2S7DdgJwq24cMsjWlOQ5IJN8+VFhp5SE
         0C+EriYFAircPTj0yLOp7oJ4UGIj5VxK+tPPAt3PwIQpFRvh8Go490FebXRStPJFCA
         NCjxi1DhQpK4gp1n7K4eBQ87d1/21QtYbZqlmHpE=
Date:   Tue, 5 Sep 2023 08:14:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Nan <linan666@huaweicloud.com>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>, stable@vger.kernel.org,
        Jan Kara <jack@suse.com>, lvc-project@linuxtesting.org,
        Jan Kara <jack@suse.cz>, yangerkun <yangerkun@huawei.com>,
        linan122@huawei.com
Subject: Re: [PATCH 5.10 1/1] udf: Handle error when adding extent to a file
Message-ID: <2023090520-dwelled-dullness-c3c5@gregkh>
References: <20230815113453.2213555-1-VEfanov@ispras.ru>
 <4c28f962-0830-1138-7b91-ef6685a56afa@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c28f962-0830-1138-7b91-ef6685a56afa@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 05, 2023 at 02:57:48PM +0800, Li Nan wrote:
> Hi Greg,
> 
> Our syzbot found the this issue on v5.10, could you please pick it up
> for v5.10?

What issue?  Pick what up?

There's no context here :(
