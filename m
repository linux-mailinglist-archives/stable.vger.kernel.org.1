Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8597C814C
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 11:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjJMJDK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMJDK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 05:03:10 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07B9C0
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haquarter.de;
        s=protonmail2; t=1697187784; x=1697446984;
        bh=jBuPPGIq9BUwl8uFGT3MVjQDWFrHcr1CZzsDVg+Xorc=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=SPg2BflGksGhLQBYEp61uevqyT602hfGNkvFn9BfJ+boZ0IDoNOI5lS0d15+jlYL/
         E5X8BPEoOizAPZFfgyxsBD4vjvsA3zpZFRPyCCT2fVk1UkVovp3SvJlPZAc51K0oB9
         FJx1NDMnOtELdbEXV5uO41XYBY0rzvRnOj8cNmUoJ2yj8EfNyc6OKu8k7356YfFqYu
         CVQxb8dxKP0gPyXUhMUDWKEcKn/6UfZ7pSLsRczPX3ygogYYm/7KO2LaJzZsHjUFCD
         i7DKDdrcCkMlvB7q9n3AR340xad8VbGY6in8HonYxs6xdl71nbSuUO2PsIl9eaxMEj
         gB62kUwtt32TQ==
Date:   Fri, 13 Oct 2023 09:02:54 +0000
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>
From:   craig <craig@haquarter.de>
Subject: tcp: enforce receive buffer memory limits by allowing the tcp window to shrink
Message-ID: <MzUupJN3oxWdw7O3tyFkgevmIelXS340Dl-1oKnkGG-e4G5sqRpblEfCpbKyAzk3x3SmccNR9egn4F5j-H7eiojEJW1HlrtBIfxhamuf7W4=@haquarter.de>
Feedback-ID: 11697729:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

I hope I'm doing this correctly, as per=C2=A0https://www.kernel.org/doc/htm=
l/latest/process/stable-kernel-rules.html, Option 2. :)

Subject of the patch: tcp: enforce receive buffer memory limits by allowing=
 the tcp window to shrink
Full details including reproducers, impact, tests are available here: https=
://blog.cloudflare.com/unbounded-memory-usage-by-tcp-for-receive-buffers-an=
d-how-we-fixed-it/

commit ID: b650d953cd391595e536153ce30b4aab385643ac

Why I think it should be applied:
- linux TCP sessions are allocating more memory than they should
- the kernel drops incoming packets which it should not drop
- large amounts of memory can be saved (see https://blog.cloudflare.com/unb=
ounded-memory-usage-by-tcp-for-receive-buffers-and-how-we-fixed-it/#memory)

What kernel versions you wish it to be applied to: 6.1.x (stable).
Thank you! :)

- craig
