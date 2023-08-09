Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8DF776B13
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 23:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHIVjR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Wed, 9 Aug 2023 17:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjHIVjP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 17:39:15 -0400
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 14:39:13 PDT
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27E51BFB
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 14:39:13 -0700 (PDT)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 3033540F39;
        Wed,  9 Aug 2023 21:32:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id C7B7D2002F;
        Wed,  9 Aug 2023 21:32:33 +0000 (UTC)
Message-ID: <1f4f00799730ae53da67b48b0f4aea60e0d81a45.camel@perches.com>
Subject: Re: get_maintainer, b4, and CC: stable
From:   Joe Perches <joe@perches.com>
To:     Mark Brown <broonie@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Kernel.org Tools" <tools@linux.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 09 Aug 2023 14:32:32 -0700
In-Reply-To: <6dabeab8-d013-40fc-a705-d2d202510549@sirena.org.uk>
References: <CAKwvOdmOVnhKws_6DdakK9SDxiCCCR1d6VJwvz94Ng_y3V8QCg@mail.gmail.com>
         <6dabeab8-d013-40fc-a705-d2d202510549@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: ros5iojdmbs9dhgybjpbuc41qbwrdh5y
X-Rspamd-Server: rspamout04
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_05,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: C7B7D2002F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/GAX33WtLekNY3FtCoxzml/9XOuULYUJE=
X-HE-Tag: 1691616753-354429
X-HE-Meta: U2FsdGVkX1/dCbVfGFSPqx//Rs2O0b1z173ZDQr6AYLThdF8udEXg2MKFpG7QHhaDhAYncYOevebJmKtDuZYE5WM34t+swqtc430QBMaWYriEWsJhaRudjHJMupOOEHGHFYbZUBm38xw5i3nwzfwydHHH69kpqmCTULizTEy1rn4N/HufGb/g80uW12EEY/QZvqPhIvpuGhpWDdPu+VLPBjtYZB3ZVB6cg2XZ72rwu6AuisN1kxb1qrOWNS/wxN4FFBMyuzf7mFbKpOk3zlygsaRky4QuiDpzqqh4+FBZvlyJRyzK1a4TLs3GQ6Ue888
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2023-08-09 at 18:21 +0100, Mark Brown wrote:
> On Wed, Aug 09, 2023 at 09:50:00AM -0700, Nick Desaulniers wrote:
> 
> > I suspect that either b4 or get_maintainer could see the Fixes tag and
> > then suggest to Cc stable for me.
> 
> > Should get_maintainer.pl make such recommendations?
> 
> People use the Fixes tag all the time for bugs that never made it into a
> release...


As Nick suggests, likely not.  Many fixes do
not belong in stable and are only commits
that update the current rc.

get_maintainer checks the "fixes:" tag and
cc's the signers of the commit being fixed.

