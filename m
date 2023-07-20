Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9375BB0D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 01:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGTXW0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 19:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGTXWZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 19:22:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E837E2D4F
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 16:22:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC1061CAE
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B0BC433C9
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 23:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689895337;
        bh=H+l5lDvqwbGfGk2Dg94YUJBcnv3izlyw0JIMOrMWtdA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GdHnKC7SuZifgdYuXfTkVCofJOkow6xBHhVW+qLIudc5D5zyZiEnTxGgPbG5mJIHO
         Lkk10bs9ISh/bbtgmXxisn+66OYYECpbt1Yr6aduvcRSOaTn6q6fcEUyQQk8/8se93
         nBb5rMrs4VFQAxOmdbJnasIFFyAabxpq8dg++vC2Kh2VyxlPrEdpGxBdGBBAdz1yv4
         jOaTXpd/hpVPimxyFpZ72Ig9O5rnNSeTwrNcO4vg/P4g89MbaFOR5gxxZ9Ug+wQFf9
         rfzF/n2m/6ZNHX+UKwsPKYrhxhYrDNg3Kg1xHeF4Gr1RKx4ynlEDPGDLa8VKA4AJoC
         IPACYxJkRhdbw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-565db4666d7so916383eaf.0
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 16:22:17 -0700 (PDT)
X-Gm-Message-State: ABy/qLaUNB5FWfAQw89ehv+dD3PpzA6WUK0KBKEy5QjSDx9Ym3zsWeuJ
        0uOtbYBodh+C1stlz6rPtVmutukX+GkRfzp9xHY=
X-Google-Smtp-Source: APBJJlHkgz5GOOFVyI6WfKg9NIrScgVE8cqrz7YgbIo6ypUrBRslS83xQVhJJhDvjUIi1b7lgh6GJIXq2MmUMUdbIyU=
X-Received: by 2002:a4a:9250:0:b0:565:9e41:85d8 with SMTP id
 g16-20020a4a9250000000b005659e4185d8mr243839ooh.6.1689895337125; Thu, 20 Jul
 2023 16:22:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:53c4:0:b0:4e8:f6ff:2aab with HTTP; Thu, 20 Jul 2023
 16:22:16 -0700 (PDT)
In-Reply-To: <2023072055-compel-survival-2158@gregkh>
References: <20230720132336.7614-1-linkinjeon@kernel.org> <2023072055-compel-survival-2158@gregkh>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 21 Jul 2023 08:22:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8n4VOffrV1s=HWZuv3oBvJ=tw6_aRuvkT1AmSgXSHxmw@mail.gmail.com>
Message-ID: <CAKYAXd8n4VOffrV1s=HWZuv3oBvJ=tw6_aRuvkT1AmSgXSHxmw@mail.gmail.com>
Subject: Re: [5.15.y PATCH 0/4] ksmbd: ZDI Vulnerability patches for 5.15.y
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, stfrench@microsoft.com, smfrench@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

2023-07-21 2:54 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> On Thu, Jul 20, 2023 at 10:23:27PM +0900, Namjae Jeon wrote:
>> These are ZDI Vulnerability patches that was not applied in linux 5.15
>> stable kernel.
>>
>> Namjae Jeon (4):
>>   ksmbd: use ksmbd_req_buf_next() in ksmbd_smb2_check_message()
>>   ksmbd: validate command payload size
>>   ksmbd: fix out-of-bound read in smb2_write
>>   ksmbd: validate session id and tree id in the compound request
>>
>>  fs/ksmbd/server.c   | 33 ++++++++++++++++++++-------------
>>  fs/ksmbd/smb2misc.c | 38 ++++++++++++++++++++------------------
>>  fs/ksmbd/smb2pdu.c  | 44 +++++++++++++++++++++++++++++++++++++++-----
>>  3 files changed, 79 insertions(+), 36 deletions(-)
>>
>> --
>> 2.25.1
>>
>
> All now queued up now, thanks!
Thank you!
>
> greg k-h
>
