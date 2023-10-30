Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E327DC1DE
	for <lists+stable@lfdr.de>; Mon, 30 Oct 2023 22:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjJ3VZR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 30 Oct 2023 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3VZQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Oct 2023 17:25:16 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD1ED
        for <stable@vger.kernel.org>; Mon, 30 Oct 2023 14:25:13 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1qxZl0-0004Rm-J9; Mon, 30 Oct 2023 22:25:10 +0100
Date:   Mon, 30 Oct 2023 22:25:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     stable@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>
Subject: backport 790756c7e022 to 4.14 and 4.19?
Message-ID: <20231030212510.equbu7lxlslgoy3t@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Dear all,

after upgrading my toolchain to gcc 13.2 and GNU assembler (GNU
Binutils) 2.41.0.20230926, compiling a 4.14 kernel fails

arch/arm/mm/proc-arm926.S: Assembler messages:
arch/arm/mm/proc-arm926.S:477: Error: junk at end of line, first
unrecognized character is `#'

The problem is that gas 2.41.0.20230926 does no longer support
Solaris style section attributes like
.section ".start", #alloc, #execinstr

Commit 790756c7e022 ("ARM: 8933/1: replace Sun/Solaris style flag on
section directive") fixed up the section attributes that used the legacy
syntax. It seems that this commit landed in 5.5 and has already been
backported to 5.4.

Should we backport this commit to 4.19 and 4.14 as well? If so, should I
submit patches that apply against the 4.19 and 4.14 trees or do you want
to resolve the conflicts when you queue up the patch?

Thanks,
Martin
