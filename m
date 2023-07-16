Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C980B754F5A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 17:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjGPPS7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 11:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGPPS6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 11:18:58 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B5690
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:18:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BD0A75C00FF;
        Sun, 16 Jul 2023 11:18:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 16 Jul 2023 11:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689520736; x=1689607136; bh=dP
        MwpnZhJ5lYquB8kdbBEmTSZy4/uIyKNNT1a+mfeKI=; b=sSDOsxuEPpgSQxLSTP
        HSN8nkrQt1U6mx/D6uc1A4clGrD2aq5Vq+X0OZu2gkdQkk3UUn2z9vZ9VYxCgrUg
        BtvV3rGhh9PGKbUeaGSBwXdVMVvV1NCAiJ5t/tRVB8cmb0nFSQpNtCRb05zCKEtP
        hJ6Tpv/joLRMYdu9tHLU4UMIFeqeVTPPcYKkCGVS3PuKzEQRMxyPZL5Be7XosJwi
        AQRoxRV5gI8M6kx2mD75GsF708FTjDFu1S56n+FEHi0BlslFZvhrdSch/Mr32W1b
        75TNXuFg5/GOG5xbm4+oAoY9fcdgBFSZSc6WbNWFuYpwTZxX5mQHKlhCIvdi6YQt
        /pGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689520736; x=1689607136; bh=dPMwpnZhJ5lYq
        uB8kdbBEmTSZy4/uIyKNNT1a+mfeKI=; b=Sad8FCn5V60NAW48O213pvc7pVai6
        8PiUZaVejkiF4T8PH2S8zJEIItjOUKZo/jZ2tPkUm94YyfnaFm1/+CPjr4gFAj7s
        DhaP7iOsRHApiO8NIRF3MPO/DInaOHllbV/c3YtwIAiS7k7kYLm5CoPZXWXTh5Gp
        JCKcADkmz3MQ+fpXOulZMkjj6rfdnwJ5iwsuvBWs5yyf/7JJ5pzfU1CYhS75oEY8
        KR1RnaUK51u8rAEH4+4g8f9PE2HPzY0wnw6z6+X4oIc+2omDkfwsxeL5bDPSXnXo
        9wVfI26FNlCten9jYiepQoPNT4Ak8WQqLsNFsWxXSSSjhzvo+H0OPWETw==
X-ME-Sender: <xms:YAq0ZLdpHYiyrQqXzu7-IVYEifcSNi-lIDdhxW-I0nHo-eKvqbDi2g>
    <xme:YAq0ZBOJKtBLk4CuMxyYYRgXdzA50S0Fp3EXQjKUtcr2qfLWer0QvAmyUlQaflCvR
    n7r8_6yIZoQyQ>
X-ME-Received: <xmr:YAq0ZEjHJ6jC9KL0DkY-NMCDaGdh7VG5O0u2N4boetF0FpnSMmp2TEIhdA_574X2bsqu6sBePVqC42-7X28QAa-UtS5EYnHTgMzQKbX4pPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedtgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiff
    dvudeffeelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:YAq0ZM_1PcHt8hJS4slHeOhCOe0qXGfM2PubS3J3ip096sLBN9JJcw>
    <xmx:YAq0ZHtnUUsSn6iu6O98qYA53kLuOnMTyuvlZVJ48BJiI3qLXmvQ8g>
    <xmx:YAq0ZLEt7MSBNuLJLcIIuWHPPQJFU_tzjXOnjJi5vhC5uvrV3_HtHA>
    <xmx:YAq0ZA7JVVuVHVZPy7zEF1k2ReCvzXaBs1LJHUT0w-HmSE_Bz5DX-g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jul 2023 11:18:56 -0400 (EDT)
Date:   Sun, 16 Jul 2023 17:18:54 +0200
From:   Greg KH <greg@kroah.com>
To:     Lorenz Bauer <lmb@isovalent.com>
Cc:     stable@vger.kernel.org
Subject: Re: linux-5.10.y: please backport to fix BPF selftest breakage
Message-ID: <2023071647-retiring-embroider-2e33@gregkh>
References: <CAN+4W8j6G4f9Pg+rb+gcO06OU8ovudhbwXj0+E8Gg09zrozcZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN+4W8j6G4f9Pg+rb+gcO06OU8ovudhbwXj0+E8Gg09zrozcZQ@mail.gmail.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jul 12, 2023 at 10:40:32AM +0100, Lorenz Bauer wrote:
> Hi stable team,
> 
> Building BPF selftests on 5.10.186 currently causes the following compile error:
> 
> $ make -C tools/testing/selftests/bpf
> ...
>   BINARY   test_verifier
> In file included from
> /usr/src/linux-5.10.186/tools/testing/selftests/bpf/verifier/tests.h:59,
>                  from test_verifier.c:355:
> /usr/src/linux-5.10.186/tools/testing/selftests/bpf/verifier/ref_tracking.c:935:10:
> error: 'struct bpf_test' has no member named 'fixup_map_ringbuf'; did
> you mean 'fixup_map_in_map'?
>   935 |         .fixup_map_ringbuf = { 11 },
>       |          ^~~~~~~~~~~~~~~~~
>       |          fixup_map_in_map
> 
> The problem was introduced by commit f4b8c0710ab6 ("selftests/bpf: Add
> verifier test for release_reference()") in your tree.
> 
> Seems like at least commit 4237e9f4a962 ("selftests/bpf: Add verifier
> test for PTR_TO_MEM spill") is required for the build to succeed.
> 
> I previously reported this but things probably fell through the
> cracks: https://lore.kernel.org/stable/CAN+4W8iMcwwVjmSekZ9txzZNxOZ0x98nBXo4cEoTU9G2zLe8HA@mail.gmail.com/#t

Now queued up, thanks.

greg k-h
