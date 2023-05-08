Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4876FB599
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 19:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjEHRBN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 13:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjEHRBM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 13:01:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9F95586
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:01:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7576deacbd6so109796485a.3
        for <stable@vger.kernel.org>; Mon, 08 May 2023 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683565270; x=1686157270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pG46GvARjz+oazbsADG8J8cWnfJfmTt3sQRcfy1HKus=;
        b=ATdol1HmSHQUazAN5bA6BnwEwp9y0FBHM9J14a0hj4vzEDKl6CixxjJfghNwHuYIN4
         0pPfE3ZsdA7ITznvX1+Yd5GbSFoQHkQxR+x4muhWqfvVxGNdtz3tVAdPp49sJOsbQkcK
         1sBrKGWqYzFR5r51mvpWkutvlR534wQVq/XR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565270; x=1686157270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG46GvARjz+oazbsADG8J8cWnfJfmTt3sQRcfy1HKus=;
        b=f7/sXMIoHvobYnBklB+RVrqwee4wzt1PZ7uG7m/tWmrKGUXr5EU8f1yba4qD/rKTc2
         xzjYNbbBX3+RDqp3UQ5YxmHRg4Cx2QrC7i/IIEn7P0MgaNMh12CTUslZqlnWoM5sw+Xh
         ZLtGd8B2e4qHS/+/nTaPHzZCMI6I0wVg6IU+tAhHwdOsJNriqgaMV4N1MhColf9M628f
         wHV/I6ZgiRIuGqI8FRSoFzO3dEzGv4/Rsvi+qjH6i/QTYJFZRVmeKDAt5rrjKDO9Gwti
         2/gGmdHl75z8EpFwKzYHHA8JeDdwtwO+CrhMRWHLVjo04xj22CjRHZZkX4AdZ6F5cD76
         t6ZA==
X-Gm-Message-State: AC+VfDzw9mqHfyE05gt7J0lwXpA3rd09oiMcAii4eey0pt3QUN4ApBfw
        VyoNc0q4po4KGQBFO8oMZhR4/g==
X-Google-Smtp-Source: ACHHUZ6EviS0DiWUQqkPgKZaZTcNKQ6DELL/M2y3GvjJG/dI7iFQoV90KXUcrfI/Pe3f5cykAulygg==
X-Received: by 2002:a05:6214:407:b0:5f1:5f73:aed8 with SMTP id z7-20020a056214040700b005f15f73aed8mr17720169qvx.20.1683565269653;
        Mon, 08 May 2023 10:01:09 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-132.dsl.bell.ca. [209.226.106.132])
        by smtp.gmail.com with ESMTPSA id ph14-20020a0562144a4e00b0061b5b8dbbbbsm115082qvb.57.2023.05.08.10.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:01:09 -0700 (PDT)
Date:   Mon, 8 May 2023 13:01:07 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ronald Warsow <rwarsow@gmx.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: no sha256sum for 6.3.1 (was Re: Linux 6.3.1)
Message-ID: <20230508-length-distress-784870@meerkat>
References: <f0497747-2318-7355-6ea6-ff01f9eb97ef@gmx.de>
 <2023050617-stardom-granola-32e3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023050617-stardom-granola-32e3@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, May 06, 2023 at 09:38:35AM +0900, Greg KH wrote:
> > fetching new kernels via script:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/get-verified-tarball
> > 
> > it seems
> > https://cdn.kernel.org/pub/linux/kernel/v6.x/sha256sums.asc
> > 
> > doesn't contain a hash for 6.3.1
> 
> Yeah, that does look odd.
> 
> Konstantin, I think you said you updated some things on the servers
> right after I did the 6.3.1 release, would this have caused the
> signature to not be recorded in this file?

Sorry, this got fixed last week. I forgot to mount the key storage after the
final reboot. It should be all good now.

-K
