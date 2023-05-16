Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1C7044A8
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 07:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjEPFYf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 01:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjEPFYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 01:24:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4E3AA5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 22:24:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E656634C1
        for <stable@vger.kernel.org>; Tue, 16 May 2023 05:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212E8C4339B;
        Tue, 16 May 2023 05:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684214669;
        bh=CiBzm8GPPNVO7gEfzbDFwI+aBKB+KiTkVj+hDfD/OjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OXed7dV7ZDKD+LRaz6zCKo3Oje2vWhyjG6fLKce0IXQIluXdh+3+itDM/WxKC0bvt
         FAODZRoIw+HWd48DTimfvRtUJ4Rrqc7hYdPs9P70nWUMYmnrTD0GcFkq0KhMmRzsDz
         3oRQ59u2nvK+JpB6bmNiQosZLBJ/n22G8P+Ezzwo=
Date:   Tue, 16 May 2023 07:24:26 +0200
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     Yeongjin Gil <youngjin.gil@samsung.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        'Mike Snitzer' <snitzer@kernel.org>,
        'Sasha Levin' <sashal@kernel.org>
Subject: Re: [PATCH 5.10 307/381] dm verity: fix error handling for
 check_at_most_once on FEC
Message-ID: <2023051653-dumpling-famine-ac7f@gregkh>
References: <20230515161736.775969473@linuxfoundation.org>
 <CGME20230515174837epcas1p3624d7b3e158107dd951fc08a777bd8c2@epcas1p3.samsung.com>
 <20230515161750.705280788@linuxfoundation.org>
 <078a01d98797$1e931f30$5bb95d90$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078a01d98797$1e931f30$5bb95d90$@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 16, 2023 at 10:38:30AM +0900, Yeongjin Gil wrote:
> > > From: Yeongjin Gil <youngjin.gil@samsung.com>
> > >
> > > [ Upstream commit e8c5d45f82ce0c238a4817739892fe8897a3dcc3 ]
> > >
> > > In verity_end_io(), if bi_status is not BLK_STS_OK, it can be return
> > > directly. But if FEC configured, it is desired to correct the data
> > > page through verity_verify_io. And the return value will be converted
> > > to blk_status and passed to verity_finish_io().
> > >
> > > BTW, when a bit is set in v->validated_blocks, verity_verify_io()
> > > skips verification regardless of I/O error for the corresponding bio.
> > > In this case, the I/O error could not be returned properly, and as a
> > > result, there is a problem that abnormal data could be read for the
> > corresponding block.
> > >
> > > To fix this problem, when an I/O error occurs, do not skip
> > > verification even if the bit related is set in v->validated_blocks.
> > >
> > > Fixes: 843f38d382b1 ("dm verity: add 'check_at_most_once' option to
> > > only validate hashes once")
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> > > Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > ---
> > Hello Greg.
> > This patch is the wrong patch I mentioned :( Please check the v2 patch I
> > sent yesterday.
> > If you are still confused, would it be better to change mail subject and
> > send v3?
> I checked that the previous patch was queued in stable kernel.
> (dm verity: skip redundant verity_handle_err() on I/O errors)

It is queued up, see the full series for details.

> I didn't know how to handle dependent commit in stable kernel.

The documentation shows how to do this.

> There is no problem with the below current patch.
> Thank you and I'm sorry for confusion.

Thanks for checking!

greg k-h
