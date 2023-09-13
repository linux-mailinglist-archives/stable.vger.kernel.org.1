Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DFE79E1B0
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 10:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbjIMIMX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjIMIMI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 04:12:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E7A2691
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 01:11:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715D1C433C8;
        Wed, 13 Sep 2023 08:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694592714;
        bh=0IeXBFuZy3+Ph/ItGmw42hC8SoQuA0PLj5qYptWmJYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AgRR8TvW04DCCuZb/sYIdX0shE1SXwbRZO9NpN4iI+v0bSwV9QCpYKFLrLkBTr0Vg
         gdsyIOSYQx+yfmJi4lFLHaeWN4Y3e1aah5IE2laVhIBcfylON98At5/Bxf4obYrZw5
         NyWcvyblWu0hBfdojX4dqyNlEmHTV0jZmku/pW6Y=
Date:   Wed, 13 Sep 2023 10:11:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        angelogioacchino.delregno@collabora.com, baohua@kernel.org,
        bgeffon@google.com, heftig@archlinux.org,
        lecopzer.chen@mediatek.com, matthias.bgg@gmail.com,
        oleksandr@natalenko.name, quic_charante@quicinc.com,
        steven@liquorix.net, suleiman@google.com, surenb@google.com,
        yuzhao@google.com, zhengqi.arch@bytedance.com,
        stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] Multi-gen LRU: fix per-zone reclaim"
 failed to apply to 6.1-stable tree
Message-ID: <2023091342-treason-jam-8a17@gregkh>
References: <2023090959-mothproof-scarf-6195@gregkh>
 <CAC_TJvfS3TWr4NtzU+STAeQQio3PcK=r5sp_NbsW2jEffhHUGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvfS3TWr4NtzU+STAeQQio3PcK=r5sp_NbsW2jEffhHUGQ@mail.gmail.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 11, 2023 at 10:58:54AM -0700, Kalesh Singh wrote:
> On Sat, Sep 9, 2023 at 6:04 AM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 669281ee7ef731fb5204df9d948669bf32a5e68d
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090959-mothproof-scarf-6195@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> >
> > Possible dependencies:
> >
> > 669281ee7ef7 ("Multi-gen LRU: fix per-zone reclaim")
> > 6df1b2212950 ("mm: multi-gen LRU: rename lrugen->lists[] to lrugen->folios[]")
> 
> Hi Greg,
> 
> Can you apply in this order please:
> 
> 1) 6df1b2212950 ("mm: multi-gen LRU: rename lrugen->lists[] to
> lrugen->folios[]")
> 2) 669281ee7ef7 ("Multi-gen LRU: fix per-zone reclaim")
> 
> With the one rename dependency, I've checked that this applies cleanly
> and tested it.
> Or let me know if you prefer I resend both.

That worked, now queued up, thanks!

greg k-h
