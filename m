Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E875B04C
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 15:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGTNoH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 09:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjGTNoG (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 09:44:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3491986
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:44:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4509561AF8
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 13:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8147DC433D9
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689860644;
        bh=I3b9EtinLNbCz5CRqNrBJ9w/ZSNSBV6osrRod8qJbHg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GCwhLMq345YsftT2sBAt8bi93iqL52QcA6ERCjHZSv61eRGkf871a31YneV8RAhp+
         t7lTCt7FEASWnhvdQ8yb0vozsbVt8baSAef1Cd9gBZcV55pEsr/32PqvSDV4Updu+q
         W2si3V4xf1vtXp9qswZbWK3GSpZzacSp+iL+i8xRzEQdXLHiW2+jhQw2I8fVNLrA6P
         VHmtVs0VL6l1J1/cRzcT+bMzqXIGR5TkvS2mP/bkm9xKE7z76Nd/A7U0E9n6AUkXHU
         khX7P1epx3u1AuG7HNmHm8O2tfVgFWkyLlLM54LjRSNTqrrGMT88fRsSaF6NO2ZLvQ
         u+qK0xldPfSXQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1b06da65bdbso621275fac.1
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:44:04 -0700 (PDT)
X-Gm-Message-State: ABy/qLbttaDR2x/9ByE1ge+o1ABjva1kMcoveUSbM96xcGM/FY7QRbv3
        9mMuLqNKU3e9xE4DbCSlwFDzjOlRffWvv5GLidM=
X-Google-Smtp-Source: APBJJlEaRzTSqBL1I6fcUoDkmT9+yvAftbiMOLb84t9JMjRhqOoMYh5djCFFk5B9brJCr1wMHm61oR54erm8pWa3eVI=
X-Received: by 2002:a05:6870:9108:b0:1b7:3fd5:87cd with SMTP id
 o8-20020a056870910800b001b73fd587cdmr1802088oae.48.1689860643614; Thu, 20 Jul
 2023 06:44:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:53c4:0:b0:4e8:f6ff:2aab with HTTP; Thu, 20 Jul 2023
 06:44:03 -0700 (PDT)
In-Reply-To: <20230720132336.7614-7-linkinjeon@kernel.org>
References: <20230720132336.7614-1-linkinjeon@kernel.org> <20230720132336.7614-7-linkinjeon@kernel.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 20 Jul 2023 22:44:03 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_TyD1RAZNY_F+yf8Cggsdd2gdvV7NmpFq5ktHskD670w@mail.gmail.com>
Message-ID: <CAKYAXd_TyD1RAZNY_F+yf8Cggsdd2gdvV7NmpFq5ktHskD670w@mail.gmail.com>
Subject: Re: [5.15.y PATCH 1/4] ksmbd: use ksmbd_req_buf_next() in ksmbd_smb2_check_message()
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stfrench@microsoft.com,
        smfrench@gmail.com, Namjae Jeon <linkinjeon@kernel.org>,
        Ralph Boehme <slow@samba.org>, Tom Talpey <tom@talpey.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

2023-07-20 22:23 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
> From: Ralph Boehme <slow@samba.org>
>
> commit b83b27909e74d27796de19c802fbc3b65ab4ba9a upstream.
>
> Use ksmbd_req_buf_next() in ksmbd_smb2_check_message().
Note that same patch sent twice...
>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Ralph Boehme <slow@samba.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>  fs/ksmbd/smb2misc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
> index 33a927df64f1..abc18af14f04 100644
> --- a/fs/ksmbd/smb2misc.c
> +++ b/fs/ksmbd/smb2misc.c
> @@ -347,16 +347,11 @@ static int smb2_validate_credit_charge(struct
> ksmbd_conn *conn,
>
>  int ksmbd_smb2_check_message(struct ksmbd_work *work)
>  {
> -	struct smb2_pdu *pdu = work->request_buf;
> +	struct smb2_pdu *pdu = ksmbd_req_buf_next(work);
>  	struct smb2_hdr *hdr = &pdu->hdr;
>  	int command;
>  	__u32 clc_len;  /* calculated length */
> -	__u32 len = get_rfc1002_len(pdu);
> -
> -	if (work->next_smb2_rcv_hdr_off) {
> -		pdu = ksmbd_req_buf_next(work);
> -		hdr = &pdu->hdr;
> -	}
> +	__u32 len = get_rfc1002_len(work->request_buf);
>
>  	if (le32_to_cpu(hdr->NextCommand) > 0)
>  		len = le32_to_cpu(hdr->NextCommand);
> --
> 2.25.1
>
>
