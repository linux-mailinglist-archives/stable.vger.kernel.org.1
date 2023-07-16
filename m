Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC27475573A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjGPU6d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjGPU6c (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:58:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65057E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE7CE60E9E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F577C433C8;
        Sun, 16 Jul 2023 20:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689541111;
        bh=z33L9lHSTgTDRjudfiekVOPXJyoLs7+x5SZe1phdEF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFAnrozq1go2+sTLSPXB+vCz7QXbtAtXB9exeptVDwq4tmOVc8UUxCbAAKozP2F3q
         EBe8LD5Ck8s7g+A54+822oi9KaMmBkVOf+TIbL00atme9BBqaAi5NdDMtG7kCbKQkg
         9POOjMypNr+a/rLjBaq/QLMLQcCx0WKPAdKY7W8E=
Date:   Sun, 16 Jul 2023 22:03:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH -stable v5.10 0/3] Fixes for rcutorture TRACE02 warning
Message-ID: <2023071655-buffed-perish-fa75@gregkh>
References: <20230715004711.2938489-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715004711.2938489-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 15, 2023 at 12:47:08AM +0000, Joel Fernandes (Google) wrote:
> These patches required to prevent the following TRACE02 warning when running rcutorture.
> 
> I confirmed the patch fixes the following splat:

All now queued up, thanks.

greg k-h
