Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798477BE3E0
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 17:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjJIPGu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbjJIPGt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 11:06:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F26AF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 08:06:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B9C433C7;
        Mon,  9 Oct 2023 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696864007;
        bh=Mvl8gmMUGBGCZa2+BmF3BHc0Ktp7URfkGdtj2C5AfQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=quXvC67axl7GtJTGnQ+A38R+W+N0CdCyMvV+QOKYW6YMMjK8eHvjtnJIIkDljGNDZ
         jNHSvIrlT+ZDsxEUo+Lv8y1fTNYDDD5XGgOmkLrSUdfXSx7QbFNXpmVF5E3kQycapg
         qHq1GxUvMMFur9nqe/rTweSWIHQeN6UQhkMmaWfA6sX976l4A/txWbMg3FjcXvL3qE
         YVPFdT2sfNdQ1SyiWj0E3/NY48pM8yg+D7V3FFechGbU6gKx2+UX9BjkKRzF2zPyCN
         sbb3qG2GjnB6qc2Hx3OYDOZs/Gyt88in4KNipyZw1GSQyBPsM3bNkotUi9xgEhudJj
         CbOoV3aErUiEQ==
Date:   Mon, 9 Oct 2023 08:06:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Pedro Tammela <pctammela@mojatatu.com>, markovicbudimir@gmail.com
Cc:     Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
        netdev@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Message-ID: <20231009080646.60ce9920@kernel.org>
In-Reply-To: <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
        <065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
        <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, 7 Oct 2023 06:10:42 +0200 Christian Theune wrote:
> The idea of not bricking your system by upgrading the Linux kernel
> seems to apply here. IMHO the change could maybe done in a way that
> keeps the system running but informs the user that something isn=E2=80=99t
> working as intended?

Herm, how did we get this far without CCing the author of the patch.
Adding Budimir.

Pedro, Budimir, any idea what the original bug was? There isn't much
info in the commit message.
