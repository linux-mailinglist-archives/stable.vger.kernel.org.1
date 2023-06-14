Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5A7726F3B
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjFGU4h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjFGU4d (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A53E46
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05EC46484A
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17119C433D2;
        Wed,  7 Jun 2023 20:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171390;
        bh=yNCGDhFrL8CnF5ixFTz4zSrGT7rvIrUK6rPqESg8aq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpgmHlxLYzwQO8TM5iR5ikDAuc5ShsvwZD/Pez6DMYsWoim3v7NdUP2Ip4NI5b5pi
         lj4VquOFLsKbR51fVEXvMTXv8PAlvRZZsqSqnJTstK2TYu1SoKRqAuXk/jaUYVcxMw
         UQSZWoTSOOBGESO2A96AWY9K5mM7YQL1sLDNl5TQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lyude Paul <lyude@redhat.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 99/99] drm/edid: fix objtool warning in drm_cvt_modes()
Date:   Wed,  7 Jun 2023 22:17:31 +0200
Message-ID: <20230607200903.357056298@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit d652d5f1eeeb06046009f4fcb9b4542249526916 upstream.

Commit 991fcb77f490 ("drm/edid: Fix uninitialized variable in
drm_cvt_modes()") just replaced one warning with another.

The original warning about a possibly uninitialized variable was due to
the compiler not being smart enough to see that the case statement
actually enumerated all possible cases.  And the initial fix was just to
add a "default" case that had a single "unreachable()", just to tell the
compiler that that situation cannot happen.

However, that doesn't actually fix the fundamental reason for the
problem: the compiler still doesn't see that the existing case
statements enumerate all possibilities, so the compiler will still
generate code to jump to that unreachable case statement.  It just won't
complain about an uninitialized variable any more.

So now the compiler generates code to our inline asm marker that we told
it would not fall through, and end end result is basically random.  We
have created a bridge to nowhere.

And then, depending on the random details of just exactly what the
compiler ends up doing, 'objtool' might end up complaining about the
conditional branches (for conditions that cannot happen, and that thus
will never be taken - but if the compiler was not smart enough to figure
that out, we can't expect objtool to do so) going off in the weeds.

So depending on how the compiler has laid out the result, you might see
something like this:

    drivers/gpu/drm/drm_edid.o: warning: objtool: do_cvt_mode() falls through to next function drm_mode_detailed.isra.0()

and now you have a truly inscrutable warning that makes no sense at all
unless you start looking at whatever random code the compiler happened
to generate for our bare "unreachable()" statement.

IOW, don't use "unreachable()" unless you have an _active_ operation
that generates code that actually makes it obvious that something is not
reachable (ie an UD instruction or similar).

Solve the "compiler isn't smart enough" problem by just marking one of
the cases as "default", so that even when the compiler doesn't otherwise
see that we've enumerated all cases, the compiler will feel happy and
safe about there always being a valid case that initializes the 'width'
variable.

This also generates better code, since now the compiler doesn't generate
comparisons for five different possibilities (the four real ones and the
one that can't happen), but just for the three real ones and "the rest"
(which is that last one).

A smart enough compiler that sees that we cover all the cases won't care.

Cc: Lyude Paul <lyude@redhat.com>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_edid.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2779,6 +2779,8 @@ static int drm_cvt_modes(struct drm_conn
 
 		height = (cvt->code[0] + ((cvt->code[1] & 0xf0) << 4) + 1) * 2;
 		switch (cvt->code[1] & 0x0c) {
+		/* default - because compiler doesn't see that we've enumerated all cases */
+		default:
 		case 0x00:
 			width = height * 4 / 3;
 			break;
@@ -2791,8 +2793,6 @@ static int drm_cvt_modes(struct drm_conn
 		case 0x0c:
 			width = height * 15 / 9;
 			break;
-		default:
-			unreachable();
 		}
 
 		for (j = 1; j < 5; j++) {


