Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D26F7A2FBA
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 13:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjIPLhl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 07:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbjIPLhM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 07:37:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC766CC4
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 04:37:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D332C433C8;
        Sat, 16 Sep 2023 11:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694864227;
        bh=Xr5UVsJYhdj/c0uxhKlPZyCDRrNnHX/EjLiS+Me4vac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcyYl3IoDFThKrueDm2i11MJgx8CCfD9O87GiNnuLyvj/iXbyN0F3wHX2k77rsaDo
         cYz7YlojOvCPed3Rp0FfwwjqnXlVZl2Nq59ZbHE8GP8FBMNt7hvWlGEfFd8Es48WcQ
         R3nrUbqTTtjafs9SwwdLwl1jSjjIJXqk8iTMdBhA=
Date:   Sat, 16 Sep 2023 13:37:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: Request to backport commit id:
 15924b0503630016dee4dbb945a8df4df659070b to 6.5/scsi-fixes
Message-ID: <2023091622-cryptic-pointless-b2ce@gregkh>
References: <SJ0PR11MB58965FCA74A2B0DD13E965A8C3F7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB58965FCA74A2B0DD13E965A8C3F7A@SJ0PR11MB5896.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Sep 14, 2023 at 04:20:24AM +0000, Karan Tilak Kumar (kartilak) wrote:
> (Re-sending email since the previous email was undeliverable due to HTML content)
> 
> Hi Team,
> 
> This is a request to backport the following fix to 6.5/scsi-fixes. This was merged into Linus' tree. 

What is "6.5/scsi-fixes"?

> This fix fixes a crash due to a null pointer exception when a lun reset is issued from sgreset for a lun. 
> With this fix, there is no longer a crash.
> 
> I have another fix, which I have tested, dependent on this fix. It is currently in the pipeline.
> I'll send out a patch for that fix when the internal review is complete.
> 
> Please let me know if you need any more information to backport this fix.

It doesn't apply as-is so how did you test this on the 6.5 tree?  Please
provide a working, and tested, backport and we will be glad to queue it
up for the stable trees.

thanks,

greg k-h
