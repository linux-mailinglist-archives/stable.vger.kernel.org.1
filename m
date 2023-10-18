Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C659D7CE880
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 22:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjJRUHQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 16:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjJRUHQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 16:07:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4EA12A
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 13:07:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40662119cd0so2175e9.1
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697659629; x=1698264429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPhmrOEAGSKzMIjkwCvY5cv2O4ZSIOLkxAjWrHEja3w=;
        b=qGImROqCUOY96TrtmHXS+8iirCCu5lM5bTlxcKNGoO5ltnV79akvZdjA4NXuJSmJYR
         SOuLE/shapWsFPZEuLPAgpbs5LixNtCbhoy4iJsTScsT+0SBiUciFf5wQygrjXqZwP94
         vwN5piFoZ+tRtCol6sSUuincCy323JUyYJFAAsLT9eKkQznXH1uFz6XGQzfvZ176sFy0
         T8MpHNudCOx/W3ULIPInVnccro3vaMKwRzBv6mc4/nrmgnppykVP6zG/nejt3+syLbLM
         7YFM9+qzk3AybTHrbTqskpT7ExW/jmKu7gqigiVVuheyUql05exeMorWQ/5B0u4wj4cx
         m+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659629; x=1698264429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPhmrOEAGSKzMIjkwCvY5cv2O4ZSIOLkxAjWrHEja3w=;
        b=UZxpDuwkGqqbV8YrtdYel+h9C5mRJ8j2uy4wHjseYj6Xeg2Dwr4jLH2PE8I8KfRHwB
         pCuxigTqpMNDfzDkBhNXIM4OB45q21kB0+hlaFNPz5oYOe53K03i/qQt0iOFWT2h22Nj
         RC+GlWDO+lu8jf+vdt5mtlMSEIU2T4oPXbQlVqRynOy98bW7eHPQM3RKiHYwk+eGXoro
         eRpCTHiRxlScxPF8a/vJmkQpCktQJKwbcrUFH56cdgIVwBpmJPVQDbqjfggDLOHcQCmM
         FWEGGBHGhOsiSF5iUxtUh0bv7R77EKR0Usq1Z8/BPhzoAIwy/J0DMVG8W2vYCGhwscOP
         i1VQ==
X-Gm-Message-State: AOJu0YwMck1V9NVrA/JOfnM6w17V4u6RYCWMcfE+E0SQz0fpPKue6wqp
        hlBqoCLbCC9rIuIvMYyjRn8bcyRwP/KePqa9BUfYZg==
X-Google-Smtp-Source: AGHT+IFkedQ+OHj7eKCi9zaF6kjyK5MOXzE0T4xvjYrgCFJPKLNw2LYw0cD94nyM5tACg+nqXeEkej5ps5730sWdDBs=
X-Received: by 2002:a05:600c:1c1b:b0:405:320a:44f9 with SMTP id
 j27-20020a05600c1c1b00b00405320a44f9mr6026wms.5.1697659628765; Wed, 18 Oct
 2023 13:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231016225617.3182108-2-rdbabiera@google.com> <CACeCKac2kknw2s7orH1tu4RsiCr5+WYy1VQ483ok_zuzC2N9zQ@mail.gmail.com>
In-Reply-To: <CACeCKac2kknw2s7orH1tu4RsiCr5+WYy1VQ483ok_zuzC2N9zQ@mail.gmail.com>
From:   RD Babiera <rdbabiera@google.com>
Date:   Wed, 18 Oct 2023 13:06:57 -0700
Message-ID: <CALzBnUEhV1m841bPtcJUceOb0EiNF_jczVhOTQSFhVbvc9E=dw@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: altmodes/displayport: verify compatible
 source/sink role combination
To:     Prashant Malani <pmalani@chromium.org>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 17, 2023 at 2:33=E2=80=AFPM Prashant Malani <pmalani@chromium.o=
rg> wrote:
> OTOH, perhaps you should just introduce a macro that performs this
> bitwise operation for even better
> readability. Something like
>
> #define DP_CAP_IS_DFP_D(_cap_)        (!!(DP_CAP_CAPABILITY(_cap_) &
> DP_CAP_DFP_D))

I'll take this approach, thanks for the feedback Prashant!

---

Best,
RD
