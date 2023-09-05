Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE327924D6
	for <lists+stable@lfdr.de>; Tue,  5 Sep 2023 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjIEP75 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 11:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353763AbjIEH62 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 03:58:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C67CCB
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 00:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F096B81097
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 07:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A54CC433C7;
        Tue,  5 Sep 2023 07:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693900702;
        bh=qWYiuro0IBAZbKAsGtvI+npn7YR44el7AXVbk7AqHNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5axDHXJ+pChXgbrBGB1qjGvHi4HkTVA1Uzfuwl5xAvb4HDTt3Y/SKolBa5qQncSV
         ql4NCxV6zOt65oZmAP6exOn9UOoyce7o7hC1nPX/4w3uHQJC0MJI6lqeV5a+yVx8tx
         NnmMpV0L/8o4fXBRL6vT7dysr/gT4tNGm7JG/60g=
Date:   Tue, 5 Sep 2023 08:58:18 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Nan <linan666@huaweicloud.com>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>, stable@vger.kernel.org,
        Jan Kara <jack@suse.com>, lvc-project@linuxtesting.org,
        Jan Kara <jack@suse.cz>, yangerkun <yangerkun@huawei.com>
Subject: Re: [PATCH 5.10 1/1] udf: Handle error when adding extent to a file
Message-ID: <2023090529-despite-levers-6bef@gregkh>
References: <20230815113453.2213555-1-VEfanov@ispras.ru>
 <4c28f962-0830-1138-7b91-ef6685a56afa@huaweicloud.com>
 <2023090520-dwelled-dullness-c3c5@gregkh>
 <b1f154a9-0f05-f82d-d6ec-cb56ac2ca5ea@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1f154a9-0f05-f82d-d6ec-cb56ac2ca5ea@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Sep 05, 2023 at 03:49:25PM +0800, Li Nan wrote:
> 
> 在 2023/9/5 15:14, Greg Kroah-Hartman 写道:
> > On Tue, Sep 05, 2023 at 02:57:48PM +0800, Li Nan wrote:
> > > Hi Greg,
> > > 
> > > Our syzbot found the this issue on v5.10, could you please pick it up
> > > for v5.10?
> > 
> > What issue?  Pick what up?
> > 
> > There's no context here :(
> > .
> 
> I am so sorry I forgot to attach the patch. The patch is:
> https://lore.kernel.org/all/20230815113453.2213555-1-VEfanov@ispras.ru/

Odd, I missed that somehow.

Anyway, no, sorry, I can't just take it for 5.10, as you would have a
regression if you moved to a newer kernel release.  Please submit a
working version for all stable kernels 5.10 and newer, if you want us to
be able to accept this.

thanks,

greg k-h
