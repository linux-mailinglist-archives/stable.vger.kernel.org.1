Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1316D7AC2D2
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 16:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjIWOsE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 10:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIWOsD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 10:48:03 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75248180
        for <stable@vger.kernel.org>; Sat, 23 Sep 2023 07:47:56 -0700 (PDT)
Received: from letrec.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38NElUfU008615
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Sep 2023 10:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1695480454; bh=0RRC8MGLpRZZs3PAqZ36dRbh2ZQOY6lYiKztPM8uW90=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=RxnueFZ/WQ6TyXgLaaYVnllZjtDtnv5hKwRD6Mrb4NcHuMwFpWUJcZ48m+C7zl0zN
         8bB1owLOq2flAhCAywS3R4eX/0bZKg3CKuLL8WoN4b7Sdvy/CsNwqmqv+x8v+TqbMm
         c+p6O5DucemloOntWRM+CuOz2Jw7nXOtjLbBufc04s5F4hLNo8eJ4zNnKLtVEj8d9p
         grZ3v3mkUc1aUWOiWl3ITDhTA0371kz4YM2Mq4AzBfmNVolS05otytEqWvk7wXCjfT
         RqN9Dqc/kp1vZC+KEASd/szkGQhR8c58phk9zX+3CLVlNWadjijwvN3euEviA/f8+7
         YrsQYmvUojwkg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id AD7138C036B; Sat, 23 Sep 2023 10:47:29 -0400 (EDT)
Date:   Sat, 23 Sep 2023 10:47:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        Shida Zhang <zhangshida@kylinos.cn>, stable@kernel.org,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] ext4: fix rec_len verify error
Message-ID: <ZQ76gdIz80G8Svt-@mit.edu>
References: <2023092055-disband-unveiling-f6cc@gregkh>
 <20230922025458.2169511-1-zhangshida@kylinos.cn>
 <2023092205-ending-subzero-9778@gregkh>
 <CANubcdVYCFS=UAKX6sfe=jpZCtipDBrxi_O4=RpsAr1LY4Z1BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANubcdVYCFS=UAKX6sfe=jpZCtipDBrxi_O4=RpsAr1LY4Z1BQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 23, 2023 at 05:41:19PM +0800, Stephen Zhang wrote:
> Apologies for this confusion. It appears that the '--subject-prefix' option
> of the 'git send-email' command does not work with the local patch file.

Stephen,

The --subject-prefix option applies to "git format-patch" when the
local patch file is generated, as opposed to "git send-email".  So my
general workflow is to run "rm -rf /tmp/p ; git format-patch -o /tmp/p
..."  and then examine the files in /tmp/p, and then if they look
good, run "git send-email /tmp/p/*".

I suspect it will be easier for Greg if you were to simply regenerate
the patches with the proper subject prefix, and then resend them,
since he has automation tools that can handle parsing the subject
line, which scripts can do much more easily than to disentangling the
"In-Reply-To" header to identify e-mail chains, and then parsing
human/natural language to figure out which git tree the patches should
be applied to.  :-)

Cheers,

					- Ted
