Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2319375B5ED
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 19:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGTRyN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 13:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjGTRyM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 13:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE9E75
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 10:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68BA761BA3
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 17:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E229C433C9;
        Thu, 20 Jul 2023 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689875650;
        bh=yVLhnDdc9AkcjIXy4GfqrEHP3C5330HYEuy1riPL2fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6QvbmI4jo5ma3hcb2zo4oz8GjEiSX8UgpTr8MtxqahAyTtPK0UsG7PULYw/GpRcR
         n+0nlW0d2n1bmS00efFBZpja+GE6cVYCyJmTECoO4KJIDjPkWvuzB/tmy+UhApCbQt
         mZ3zItq30j3FusXQ17GrPQbaSWxfKa5wg0iu55l0=
Date:   Thu, 20 Jul 2023 19:54:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     stable@vger.kernel.org, stfrench@microsoft.com, smfrench@gmail.com
Subject: Re: [5.15.y PATCH 0/4] ksmbd: ZDI Vulnerability patches for 5.15.y
Message-ID: <2023072055-compel-survival-2158@gregkh>
References: <20230720132336.7614-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720132336.7614-1-linkinjeon@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jul 20, 2023 at 10:23:27PM +0900, Namjae Jeon wrote:
> These are ZDI Vulnerability patches that was not applied in linux 5.15
> stable kernel.
> 
> Namjae Jeon (4):
>   ksmbd: use ksmbd_req_buf_next() in ksmbd_smb2_check_message()
>   ksmbd: validate command payload size
>   ksmbd: fix out-of-bound read in smb2_write
>   ksmbd: validate session id and tree id in the compound request
> 
>  fs/ksmbd/server.c   | 33 ++++++++++++++++++++-------------
>  fs/ksmbd/smb2misc.c | 38 ++++++++++++++++++++------------------
>  fs/ksmbd/smb2pdu.c  | 44 +++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 79 insertions(+), 36 deletions(-)
> 
> -- 
> 2.25.1
> 

All now queued up now, thanks!

greg k-h
