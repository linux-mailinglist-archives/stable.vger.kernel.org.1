Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83F713871
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjE1HkR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1HkQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:40:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240ADB4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A936460E9B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C776BC433D2;
        Sun, 28 May 2023 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685259614;
        bh=FrH8AIc7TJo3jUvcDEHLofUVr82+hr66ntasZpA8dJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJLYmhmOXOPi+4T3wuD7PX5J0xVMJrAP9qq9dimuDNf0hpYkUijBff6rpoxvY84SN
         qGzCk7ZvXqZCTlI9s6ypV4OV9kPCmH30yZ6oKDKpvUrIvOygRjXVEU5AwEaY9gnxeY
         5/SxYf21LPaPAz3gH3aTgPT1ZoyStWBH7oKmy5+Y=
Date:   Sun, 28 May 2023 08:40:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tyler Hicks <code@tyhicks.com>
Cc:     kernel test robot <lkp@intel.com>,
        Hardik Garg <hargar@linux.microsoft.com>,
        stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1 5.15 5.10 5.4 4.19 4.14] selftests/memfd: Fix unknown
 type name build failure
Message-ID: <2023052853-harvest-coasting-f857@gregkh>
References: <20230526232136.255244-1-hargar@linux.microsoft.com>
 <ZHE/avMpv2Sjqwxf@3bef23cc04e9>
 <ZHFaw6k8+2+MM1jv@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHFaw6k8+2+MM1jv@sequoia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 26, 2023 at 08:20:03PM -0500, Tyler Hicks wrote:
> On 2023-05-27 07:23:22, kernel test robot wrote:
> > Hi,
> > 
> > Thanks for your patch.
> > 
> > FYI: kernel test robot notices the stable kernel rule is not satisfied.
> > 
> > Rule: 'Cc: stable@vger.kernel.org' or 'commit <sha1> upstream.'
> > Subject: [PATCH 6.1 5.15 5.10 5.4 4.19 4.14] selftests/memfd: Fix unknown type name build failure
> > Link: https://lore.kernel.org/stable/20230526232136.255244-1-hargar%40linux.microsoft.com
> > 
> > The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > 
> > Please ignore this mail if the patch is not relevant for upstream.
> 
> I think Hardik did the right thing here. This is a build failure bug
> that's present in stable kernels but was fixed in upstream by an
> unrelated commit:
> 
>  11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC")
> 
> It wouldn't be right to backport that patch because MFD_NOEXEC_SEAL and
> MFD_EXEC weren't introduced until v6.3.
> 
> There was an (unmerged) attempt to fix this specific build failure in upstream:
> 
>  https://lore.kernel.org/all/20211203024706.10094-1-luke.nowakowskikrijger@canonical.com/
> 
> Hardik opted to follow what was done upstream in a patch specifically
> for the stable tree.

Yes, this is the right thing to do, you can ignore the bot :)
