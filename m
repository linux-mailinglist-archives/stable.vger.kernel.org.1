Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47711791CC4
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbjIDS1j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjIDS1i (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:27:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587EF1B6
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B2AF8CE0E30
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BC4C433C7;
        Mon,  4 Sep 2023 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852052;
        bh=VRvflhTgBKLPFHrHNirijX+rhN18a8EI11DsFwhv4II=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBmxNghtCnSBOH7fiE3ceDMSfHuJ8fdlG7yJa7SBC2+5ZyyVT89SltTNEprWJ5Z2A
         j2uA9CSlYI7WN6UwDxXJk2r+/UP8vGkX1sABEsMLOzj7SFlwGjhnpf0UOXCJ5sHE3p
         M4utdCsZ1n3ITDw/b+2CWd3VFtkExhCHMwVtIuLY=
Date:   Mon, 4 Sep 2023 19:27:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     m.felsch@pengutronix.de, angus@akkea.ca, christian.bach@scs.ch,
        linux@roeck-us.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] usb: typec: tcpci: clear the fault status
 bit" failed to apply to 5.15-stable tree
Message-ID: <2023090422-whiff-monastery-6158@gregkh>
References: <2023090314-headroom-doorbell-3ac8@gregkh>
 <cdbcbbf136a2dac254a4ad4ee6b6f5ce@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdbcbbf136a2dac254a4ad4ee6b6f5ce@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 04, 2023 at 10:47:05AM -0300, Fabio Estevam wrote:
> On 03/09/2023 13:57, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> The reason that it fails to apply against 5.15 is due to the missing commit:
> 
> 7963d4d71011 ("usb: typec: tcpci: move tcpci.h to include/linux/usb/")
> 
> I have submitted it as part of a series that applies cleanly against 5.15.

Thanks all now queued up.

greg k-h
