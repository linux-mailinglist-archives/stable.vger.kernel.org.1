Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2827454C5
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 07:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGCFXY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 01:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCFXX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 01:23:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630F1A7;
        Sun,  2 Jul 2023 22:23:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZ874DWqz4wxS;
        Mon,  3 Jul 2023 15:23:19 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        Hari Bathini <hbathini@linux.ibm.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, stable@vger.kernel.org
In-Reply-To: <20230425065829.18189-1-hbathini@linux.ibm.com>
References: <20230425065829.18189-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/bpf: populate extable entries only during the last pass
Message-Id: <168836167606.46386.1266997701169825170.b4-ty@ellerman.id.au>
Date:   Mon, 03 Jul 2023 15:21:16 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 25 Apr 2023 12:28:29 +0530, Hari Bathini wrote:
> Since commit 85e031154c7c ("powerpc/bpf: Perform complete extra passes
> to update addresses"), two additional passes are performed to avoid
> space and CPU time wastage on powerpc. But these extra passes led to
> WARN_ON_ONCE() hits in bpf_add_extable_entry() as extable entries are
> populated again, during the extra pass, without resetting the index.
> Fix it by resetting entry index before repopulating extable entries,
> if and when there is an additional pass.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/bpf: populate extable entries only during the last pass
      https://git.kernel.org/powerpc/c/35a4b8ce4ac00e940b46b1034916ccb22ce9bdef

cheers
