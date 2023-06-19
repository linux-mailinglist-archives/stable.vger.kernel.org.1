Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6807973564B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjFSLyJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFSLyH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:54:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5166F1A6
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:54:03 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9106:d00:f642:3517:2a5f:cfa3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5FE8C6606E98;
        Mon, 19 Jun 2023 12:54:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687175641;
        bh=GM+9Gp4EImsxJ3Xf/RDP2oO+LXAqdvzw6XUHFejpLIM=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=oYeP1BTAcqaSf0iDUc+uOHISQiHFMVIxhWr6Wm6vr6uo6Qom64gtEssK3jYO8F1qB
         kxMotNqEFbOQHyiQAoMcm1HDqHOXLr5fw+4iPEMfCZZJuiH2Fkvhxlz/aq3OEMlfM2
         ugCktk50fXeiAiIfKp0x9bgXLMBDzuc/jJEszpHyDgdO3wLlU4Cx4Qlo6YPlbotpkd
         VNiC/RcWWcEtdPMr/uDu2YcxOW6va+GHGSygBBIKV8LJ85NvSCMJkMTugrrt+jUH9J
         0INDlSXSPbXB+ysNVa9EgLfyJ2jTY2JRiaJcl//Sdl/7154b9o9XqF4EdsxI8f2YhW
         j8ucmTjZv/BTw==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     "Linux regression tracking \(Thorsten Leemhuis\)" 
        <regressions@leemhuis.info>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>
Subject: Re: stable-rc/linux-4.14.y bisection: baseline.login on meson8b-odroidc1
References: <1fcff522-337a-c334-42a7-bc9b4f0daec4@collabora.com> <585b00d1-5ad7-ecff-e905-71e370613dfb@leemhuis.info> <4f77c914-562c-42ef-dfd0-43239398815d@collabora.com> <a42f43e1-8586-a608-d073-3190af4eca94@leemhuis.info> <1296be13-e15e-5478-452f-8ae8494563c0@leemhuis.info>
In-reply-to: <1296be13-e15e-5478-452f-8ae8494563c0@leemhuis.info>
Date:   Mon, 19 Jun 2023 13:53:58 +0200
Message-ID: <87pm5ris6h.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Thorsten,

On lun, jun 19 2023 at 11:36:02, "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:
> BTW and JFYI (as you earlier said my docs helped you): the aspect "who
> is responsible to handle this regression: the regular maintainer or the
> stable team?" that came up earlier with this report lead me to sit down
> and write a text called "Why your Linux kernel bug report might be
> ignored or is fruitless" I published here:
>
> https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

This is fantastic and a much needed document that should be mandatory
training for anyone reporting kernel regressions. IMO this kind of
documents should be located in a more prominent place so that it can
become a key reference, specially in this case where there's no single
right workflow. Maybe with a bit of effort of us all we can improve the
situation so that bugs and regression reporting and tracking in the
kernel becomes a much more streamlined process.

>> That leads to the question: should we spend our time on it?
>
> As expected there wasn't any progress (at least afaics).
> [...]
> Ricardo, how would do you and Kernelci folks feel about ignoring this?

I can't speak on behalf of the KernelCI people, but this being something
that isn't failing in mainline and considering that the stable release
where it happened was very close to EOL puts this in the low-priority
category for me. Fixing bugs can become a quite expensive task in terms
of time, and I'm try to factor in the impact of the fix to make sure the
time spent fixing it is worth it.
In other words, making test results green just for the sake of
green-ness is not a sound reason to go after the failures. We're trying
to improve the kernel quality after all, so I'd rather focus on the
regressions that seem more important for the kernel integrity and for
the users.

Cheers,
Ricardo
