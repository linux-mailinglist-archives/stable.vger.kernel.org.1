Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953571535F
	for <lists+stable@lfdr.de>; Tue, 30 May 2023 04:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjE3CCy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 22:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjE3CCu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 22:02:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F1E196
        for <stable@vger.kernel.org>; Mon, 29 May 2023 19:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7610D629A7
        for <stable@vger.kernel.org>; Tue, 30 May 2023 02:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948DBC433D2;
        Tue, 30 May 2023 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685412035;
        bh=YtplyAziweQ1xgaqRUnCr0MF4XhrunxSE5jGtH+5rnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s1YaOF35WEYVZ3iF9KLyTifMrsdlhNwwB0zzpPKmnJSS3G6npCQTE4NjZtsxGlf65
         wBEL7JdH7/EEr7EfAD6600+3TdeYJBCkzLj6F2Z+uN689vCXto/Kn3PyYrJ/pdpOZf
         1LIawTLla2ToEUfBBB0t0fPmWztibsREtCv3wsBO242WsOBCgQXK94LCLFQp/+kePr
         XEiMnhyKAf6uJYO83n2nNA1wpKWxAwRMJaPisWwScTBjB3hTn35VY4iE1V4ZEidtCo
         wtkbbPISUND6QcR74IE9zRUs38Rn0eI1tt3YWobtdM78z4ex8doMeZGaZN/5DKBWRK
         02a5Hh80+Zztw==
Date:   Mon, 29 May 2023 19:00:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     <gregkh@linuxfoundation.org>
Cc:     linyunsheng@huawei.com, brouer@redhat.com,
        ilias.apalodimas@linaro.org, <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] page_pool: fix inconsistency for
 page_pool_ring_[un]lock()" failed to apply to 5.15-stable tree
Message-ID: <20230529190034.5e20c2dc@kernel.org>
In-Reply-To: <2023052821-wired-primate-24c3@gregkh>
References: <2023052821-wired-primate-24c3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, 28 May 2023 17:55:22 +0100 gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Do you track the missing backports? We fumbled the Fixes tag on
this one, turns out it's not needed further back than it applies.
In such cases is it useful to let you know or just silently ignore 
the failure notification?
