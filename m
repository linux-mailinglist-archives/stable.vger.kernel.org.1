Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C186FD3E1
	for <lists+stable@lfdr.de>; Wed, 10 May 2023 04:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEJCkR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 22:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEJCkR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 22:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EC4171A
        for <stable@vger.kernel.org>; Tue,  9 May 2023 19:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3ACC616DA
        for <stable@vger.kernel.org>; Wed, 10 May 2023 02:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF274C4339C;
        Wed, 10 May 2023 02:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683686415;
        bh=xTwXGJpY+tfvtuEgoFDlHnaFapgn8t7yLtoIYT2vFVk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A22gwnVL1ZntAP9vyhb7DWjkw4mSJeYqGJfQeJBnvCZa6ylXZUajqblHiEPYjv4yX
         W5CztsJMkTAvq6v8FimwwfjjDyoYdIhVpJHcvbjaRTBvX5v8XYeF491T6qV6ZGFZC3
         sqJk7loQFy8d3xq6F3sliZIDd9TywBZQfhD+S6SbDTlPh9zDulQplY9A4UKskuEyLZ
         O/Ry1qWzTZFYeHod72OAeJJg6JegHwn7fchW1W0ckEU+zAZ2hX9YcLUpQ64VkEAnZZ
         ckv5UqTWIcWqrIbbjsTNWTYHNni9Cq0Zz30RDPsHWHcge7AU7QQ9E/k/CFoHBdoJrc
         MhMHmCRgedW2A==
Date:   Tue, 9 May 2023 19:40:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Louis Peens <louis.peens@corigine.com>
Cc:     David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        oss-drivers@corigine.com
Subject: Re: [PATCH net] nfp: fix rcu_read_lock/unlock while
 rcu_derefrencing
Message-ID: <20230509194013.3c73ffbb@kernel.org>
In-Reply-To: <20230509060632.8233-1-louis.peens@corigine.com>
References: <20230509060632.8233-1-louis.peens@corigine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue,  9 May 2023 08:06:32 +0200 Louis Peens wrote:
> +static inline
> +struct net_device *nfp_app_dev_get_locked(struct nfp_app *app, u32 id,

_locked() in what way? RCU functions typically use an _rcu suffix, no?

> +					  bool *redir_egress)
> +{
> +	struct net_device *dev;
> +
> +	if (unlikely(!app || !app->type->dev_get))
> +		return NULL;
> +
> +	rcu_read_lock();
> +	dev = app->type->dev_get(app, id, redir_egress);
> +	rcu_read_unlock();
> +
> +	return dev;

this looks very suspicious, RCU takes care primarily of the lifetime of
objects, in this case dev. Returning it after dropping the lock seems
wrong.

If the context is safe maybe it's a better idea to change the 
condition in rcu_dereference_check() to include rcu_read_lock_bh_held()?
-- 
pw-bot: cr
