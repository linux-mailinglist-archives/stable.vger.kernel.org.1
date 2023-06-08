Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831E2728B8A
	for <lists+stable@lfdr.de>; Fri,  9 Jun 2023 01:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjFHXHi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFHXHh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 19:07:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660B12D56;
        Thu,  8 Jun 2023 16:07:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-65314ee05c6so957103b3a.1;
        Thu, 08 Jun 2023 16:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686265656; x=1688857656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1j0OwP915NBFYr19GWzY112NDiJWBtc3xbzWK1LcAhw=;
        b=UL2yk66pLDFWAIOCQhPLZWFQTtZipgKzsik0G+dGmv+kdZEt3mkwReJRBSNlLHt5qs
         3CWOxo5XG8yyuZdXfoeoC/uICjYEyWBqm9SxQYHdJGYYNKz1DgofAcgv6qNPvUSA1zxa
         valPOPHyx6u5pl1ucFscA9ZuZYrzbEVEOfVF0BcgK6WLeUMgyaXaJgLcX1CEiUySbjhy
         nhFSOIKQCCBsd3feU/ATdyB+ftOlKBs392vuSKw2pITSze3xv3ieoF8wrBNV3Q5lEOGL
         1Jv1qeA2Kl3MSziVskJ3KUrTUTGOyHXGP2q2hqgLmoDXypVUOX0JdzCtFNNJDM82tz4u
         lfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686265656; x=1688857656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j0OwP915NBFYr19GWzY112NDiJWBtc3xbzWK1LcAhw=;
        b=Le8QzM1E8aycdnK1kL4MMwfZzqQdzjU0ADuFAtrFxblOeyrOvsnpJSxE5XYHj9YkPF
         hfLe05JGmokrICbOjELMsv4dphVpjTF25/8D++oH7WK15Utb8cTQKnC8isdS7Vxkwab6
         7Cs/eP9Voc4BHvWXqrBmwVOEFOcAH3qCCw/qqxHPrkc+ksoHe+qmSBE3JrEpx9ZvNlYF
         +eZSm7arWGNKr6jf92byIsCxmXsRWhobKGvfCxAclTBITV5ue+nR15j17T6qjfPpuw/8
         CykCJXLo8OFYAe7zRnzzSnxdCngQBKmZVrV883qoVxI5IyzMzns95WhNr6QIOTMwBJOU
         qfVw==
X-Gm-Message-State: AC+VfDwKqO37lI6oIe4C/Ihmh6KZtZ/eFop3PdVuNwX6ELBnEjE4T3cP
        P/3cleP/z3GNoMhI2DCIoPE=
X-Google-Smtp-Source: ACHHUZ43SwpUvLlhVTekv1MhOa0PCiu0T9XezaDuCbdRwynbg6m/b7Mc1TJV4FUXtpqR1GaUN9LeNg==
X-Received: by 2002:aa7:88ce:0:b0:65d:d5cd:6f17 with SMTP id k14-20020aa788ce000000b0065dd5cd6f17mr7717430pff.24.1686265655614;
        Thu, 08 Jun 2023 16:07:35 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id h26-20020a62b41a000000b00652c103d534sm1547802pfn.118.2023.06.08.16.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 16:07:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 8 Jun 2023 13:07:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Waiman Long <longman@redhat.com>, mkoutny@suse.com,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH V3] blk-cgroup: Flush stats before releasing blkcg_gq
Message-ID: <ZIJfN9lb6t65v4JV@slm.duckdns.org>
References: <20230525043518.831721-1-ming.lei@redhat.com>
 <ZH6suXYDNbIZjQyp@ovpn-8-17.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH6suXYDNbIZjQyp@ovpn-8-17.pek2.redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jun 06, 2023 at 11:49:13AM +0800, Ming Lei wrote:
> > V3:
> > 	- add one global blkg_stat_lock for avoiding concurrent update on
> > 	blkg stat; this way is easier for backport, also won't cause contention;
> 
> Hello Jens and Tejun,
> 
> Can we move on with this patch or Waiman's version[1]?
> 
> I am fine with either one.
> 
> [1] https://lore.kernel.org/linux-block/20230525160105.1968749-1-longman@redhat.com/

I personally like Ming's version with a separate lock as it's a bit simpler.
Let's go with that one.

Thanks.

-- 
tejun
