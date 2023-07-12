Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4844751469
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 01:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjGLX0y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 19:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjGLX0w (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 19:26:52 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A301BF0
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 16:26:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f122ff663eso171439e87.2
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 16:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689204407; x=1691796407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eX7ler/unybEEB87pkzJRfEIlGcdEpKXUpbLiHALcWs=;
        b=gK6dgVUVl9fXCQzQpwk0Vta2voZg2T1QCMWyXYVxed0R2wqtK0Zg32/nG/SF0Xf57B
         Xt/BYCWLVObpcwHdEIzl8RGpBzWgOneAqsqfh9sMfH6tH3LWWmEFf1icgvJ/tflGvk6y
         6+oxV/qHO0HPEXkMvxVw1xV8+ZgnMf8Ys62V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689204407; x=1691796407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eX7ler/unybEEB87pkzJRfEIlGcdEpKXUpbLiHALcWs=;
        b=V1GL5uZ4mdU+xzb2CS7iN9Tx5oZ4pZ+Ly/r7y1kTLNN5bjWUZDCxxeVzDOLARuCwhB
         KWPq6ovpltO0VVmfoL2x8aNxHLNTior/hORbxP4VbVxVW30TDUarstM99kViyshv2HJ9
         RGh2vHAbrxGfYT7miWqC1VnXtzWmB03yycQl6xBR7hcyQQvelmxr7QNS7B7hXLMc53NU
         NAHM9khFdPZLV2qZ581e3Rv5BGHCz/DsfjurwbgE0vtmI2WK8kktREXqwEpTuouxQOBS
         h9hpodnlqjUGMUpLYQVlpT0jPYi0XJxAnOZIQkIvwaUHnsWQ5rahmNxNt+N+H4yXFJfy
         ybWg==
X-Gm-Message-State: ABy/qLbijQyioRacquCx0ZCl8G3D9EUVyTJ21wkluDDTN4/YglloHvoR
        yftujvec9aOK3iY6kGY4NtwSnDHXMBDldT8hcFhMt9R/
X-Google-Smtp-Source: APBJJlEJwmnTjE2UeHhtwwnANS0f/OnNGsW5pz8hG0ZQIt9CRvRJ+HJ9zEp9avZCQ0gmMKdXMzbSbA==
X-Received: by 2002:a05:6512:2344:b0:4fb:7675:1c16 with SMTP id p4-20020a056512234400b004fb76751c16mr17894649lfu.49.1689204407348;
        Wed, 12 Jul 2023 16:26:47 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h22-20020ac25976000000b004fbbd818568sm881742lfp.137.2023.07.12.16.26.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 16:26:46 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2b702319893so122683481fa.3
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 16:26:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3c89:b0:4f8:75ac:c4e8 with SMTP id
 h9-20020a0565123c8900b004f875acc4e8mr20148535lfv.43.1689204406009; Wed, 12
 Jul 2023 16:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230712223021.636335-1-mkhalfella@purestorage.com> <20230712190723.26ebadea@gandalf.local.home>
In-Reply-To: <20230712190723.26ebadea@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jul 2023 16:26:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPB3kwZwJvk2jdmfw7jLKG5UAn8FMvySiJvELDZ-4_5Q@mail.gmail.com>
Message-ID: <CAHk-=wgPB3kwZwJvk2jdmfw7jLKG5UAn8FMvySiJvELDZ-4_5Q@mail.gmail.com>
Subject: Re: [PATCH] tracing/histograms: Add histograms to hist_vars if they
 have referenced variables
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mohamed Khalfella <mkhalfella@purestorage.com>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 12 Jul 2023 at 16:07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I run this through my full test suite, and then send Linus another pull
> request.

Ok, I'll ignore the one I currently have in my inbox.

              Linus
