Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C447AB479
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjIVPMU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjIVPMT (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 11:12:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B75100
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 08:12:13 -0700 (PDT)
Received: from letrec.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38MFBb4P029366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 11:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1695395502; bh=rIsvtPJKI5A4W7MXZpx3scaZGfbU7dME98mLqzcBFoo=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=ZnnSLOkuW4qz4NjryVkviQFVf8oBKgekG8h4rDu+q6nZWDgagmVw9zMLl6vfHWvKI
         tR8T4RZS7P19smHB2MnJW9KdL/zT+VfH6Q6vyOWqWgqJ5SuJzM5PBLMFeblcKJKf2d
         E8Lt6u7DpNKF1zYuAAytMsrK69Hr02jULuVhdEnNqO4lUI3uBVAONROK8kwsuR0l/C
         Ijnmw2QN+lk9UHkqYbbYnpp6ems+LKyIHWgdt09oeWxXsQ7HG3g/s+4qpUL5fX0W4f
         KtkmzWb9bEQ/UzcSg/2ekNweYDaT492YnVuqmdEog395QJqilpI1WJTVJS5r/Rg04u
         vrNOrZJQS0P0g==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id AD1B58C0281; Fri, 22 Sep 2023 11:11:36 -0400 (EDT)
Date:   Fri, 22 Sep 2023 11:11:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhangshida <starzhangzsd@gmail.com>, stable@vger.kernel.org,
        Shida Zhang <zhangshida@kylinos.cn>, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] ext4: fix rec_len verify error
Message-ID: <ZQ2uqEO51hJI4RRi@mit.edu>
References: <2023092057-company-unworried-210b@gregkh>
 <20230922053915.2176290-1-zhangshida@kylinos.cn>
 <2023092232-squash-buggy-51c7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023092232-squash-buggy-51c7@gregkh>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 22, 2023 at 11:23:59AM +0200, Greg KH wrote:
> 
> What stable tree(s) are you asking this to be backported to?

I assume that from the reply to message id
2023092057-company-unworried-210b@gregkh, this was intended for the
4.14 stable tree (since the automatic backport didn't apply).

Zhangshida, for future reference, when sending a patch for an LTS
kernel, please include the kernel version in the PATCH line,
e.g. "[PATCH 4.14.123]" or some such.  This saves everyone a lot of
time (including myself, since I need to filter out the LTS backports
to ext4 patchwork dashboard).

Thanks,

					- Ted
