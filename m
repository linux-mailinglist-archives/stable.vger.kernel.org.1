Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825F7356E8
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 14:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjFSMbd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 08:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjFSMbc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 08:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F7B9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42F1E60BEA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 12:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56542C433C0;
        Mon, 19 Jun 2023 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687177890;
        bh=LFfupsc+YKuBvn524SzFnwtQzzShZhqgx2xJYr29qos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSlQsCh5iw5RWFp2311dnA1ERBakHa7Zs2lVrAtKVDd1eChLKodHrw3g7cSkaQSDv
         zHvv5IjTgeMhOLxBl0KoPxoqDb06WChAD/TLPq63UTHhZRJutxuH7ZPDvby8Xpw+pM
         y9naP+Ylb5LnbT0K4imgIw57b1Tdj2i2pqow0AdE=
Date:   Mon, 19 Jun 2023 14:31:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pedro Tammela <pctammela@mojatatu.com>
Cc:     davem@davemloft.net, jhs@mojatatu.com, simon.horman@corigine.com,
        stable@vger.kernel.org
Subject: Re: Patch "net/sched: act_api: move TCA_EXT_WARN_MSG to the correct
 hierarchy" has been added to the 6.1-stable tree
Message-ID: <2023061959-reclining-zebra-38a4@gregkh>
References: <2023061951-existing-canned-81a5@gregkh>
 <ecd5cd8c-66f8-0775-d509-32313bb4e70e@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd5cd8c-66f8-0775-d509-32313bb4e70e@mojatatu.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 09:23:01AM -0300, Pedro Tammela wrote:
> On 19/06/2023 03:52, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >      net/sched: act_api: move TCA_EXT_WARN_MSG to the correct hierarchy
> > 
> > to the 6.1-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       net-sched-act_api-move-tca_ext_warn_msg-to-the-correct-hierarchy.patch
> > and it can be found in the queue-6.1 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> >  From 923b2e30dc9cd05931da0f64e2e23d040865c035 Mon Sep 17 00:00:00 2001
> > From: Pedro Tammela <pctammela@mojatatu.com>
> > Date: Fri, 24 Feb 2023 14:56:01 -0300
> > Subject: net/sched: act_api: move TCA_EXT_WARN_MSG to the correct hierarchy
> > 
> > From: Pedro Tammela <pctammela@mojatatu.com>
> > 
> > commit 923b2e30dc9cd05931da0f64e2e23d040865c035 upstream.
> > 
> > TCA_EXT_WARN_MSG is currently sitting outside of the expected hierarchy
> > for the tc actions code. It should sit within TCA_ACT_TAB.
> > 
> > Fixes: 0349b8779cc9 ("sched: add new attr TCA_EXT_WARN_MSG to report tc extact message")
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   net/sched/act_api.c |    4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
> > @@ -1603,12 +1603,12 @@ static int tca_get_fill(struct sk_buff *
> >   	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
> >   		goto out_nlmsg_trim;
> > -	nla_nest_end(skb, nest);
> > -
> >   	if (extack && extack->_msg &&
> >   	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
> >   		goto out_nlmsg_trim;
> > +	nla_nest_end(skb, nest);
> > +
> >   	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
> >   	return skb->len;
> > 
> 
> Hi!
> This commit is bogus. The correct one to pull is:
> 2f59823fe696 ("net/sched: act_api: add specific EXT_WARN_MSG for tc action")
> If it's already in the queue then just removing this one is enough.

It is in the queue, AND I grabbed the revert of this original one, to
preserve the history properly and ensure we don't try to apply it again.

thanks,

greg k-h
