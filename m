Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5286FA0DC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 09:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjEHHUM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 03:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjEHHUK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 03:20:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201D64683
        for <stable@vger.kernel.org>; Mon,  8 May 2023 00:20:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3063433fa66so2597905f8f.3
        for <stable@vger.kernel.org>; Mon, 08 May 2023 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683530407; x=1686122407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4qm2kkFPXz3iMSaYWzsWVc+tB/w60qM5yghYXF0h/0=;
        b=nsF9aVsijncPE+t+hLMawCqEjVXfmoX/hewa8CUd63NcXN39Y4rdtD8x2/WbkXCIQ2
         l7folrWOcmK1QpB3JhT+5XlalATtvfJEAmdV07BX7wmRsHRP81zk86Fy7pOlzr+nONp7
         fMpYG8AfLNmVaR1Y00f17Q/HSAPF4GwMawfWBJLqewbiX/6rgeUBeuUMzVtI4i83/OQb
         dVqKYfTR45mS/kQut1gLdRnUb2h+AT+j7oVFrY71aT7nhIh42+xYu4sYFqblWKze8JEV
         LiMvDX2/uCKuZCmk4WkWf8Plqcygtxqa6AA1wR650N3KWsxLF6gdozLfzVoFaHjQ8cUR
         o37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683530407; x=1686122407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4qm2kkFPXz3iMSaYWzsWVc+tB/w60qM5yghYXF0h/0=;
        b=E1fosoGfZvbcchjwaFTE7apcZaoyR7Bxi5f/JS5pnz90mB0gNQyZjQ3Lm+iI6oGYMr
         nyWndvmW7sy53leeNKXFa8FBOUWoiCWMXHQZr0wPUCSUvJXLe5onSLI8Yo+DEF0Caln8
         m5LHG5Sqb8ZPO5i39PJaiwhVoKBy4fmFBFDzYqgDGvBbRHNFbOLoTHYmS0v8CARJZv5c
         mevf8tLbZsj8eE3dAd5gnZCWelyK7jHcy87yOLwBv0J3v15insUuA0C2sz5EeQQ1hE0g
         hIflvvF7yyvmoSnD7v9mo0TfAVrDtSPD8fq2laWNpcQ+BqAmj62gCnWNxksnxsqP4Nr8
         DKUw==
X-Gm-Message-State: AC+VfDyuuZm+uVWeFfFP93d+lKmtOp2fbbflzoHsFgDpQgk4xlLUldNv
        M8Go5EuNLUSGgpN44jYeKaQqjtYDyKVFQ/vD6Wg=
X-Google-Smtp-Source: ACHHUZ7WTBlORjwkJt26PTeAlkR7lXtaXVNu3cHYCYU3i3qcQh5kXX6930OWBGXYthJwDm/hOStRvA==
X-Received: by 2002:adf:f291:0:b0:306:3bf0:f1ec with SMTP id k17-20020adff291000000b003063bf0f1ecmr6922529wro.7.1683530407529;
        Mon, 08 May 2023 00:20:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d4dd0000000b003062ad45243sm10363523wru.14.2023.05.08.00.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 00:20:05 -0700 (PDT)
Date:   Mon, 8 May 2023 10:20:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ceph: fix the Smatch static checker warning in
 reconnect_caps_cb()
Message-ID: <83208f55-7c60-48a1-bbe2-5973e1f46a09@kili.mountain>
References: <20230508065335.114409-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508065335.114409-1-xiubli@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, May 08, 2023 at 02:53:35PM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Smatch static checker warning:
> 
>   fs/ceph/mds_client.c:3968 reconnect_caps_cb()
>   warn: missing error code here? '__get_cap_for_mds()' failed. 'err' = '0'
> 
> Cc: stable@vger.kernel.org
> Fixes: aaf67de78807 ("ceph: fix potential use-after-free bug when trimming caps")

Of course, thanks for the patch. But this is not really a bug fix since
it doesn't change runtime at all.  And definitely no need to CC stable.

regards,
dan carpenter

