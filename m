Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6A7BDF9F
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377086AbjJINcB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377092AbjJINcB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:32:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45306B7
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:31:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E550C433C8;
        Mon,  9 Oct 2023 13:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858318;
        bh=VoCoHa4mLFB9DNY+BeURM0gzyYGtHx4gB7Btg+Eka40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xsuCYcuQc4I4uJk0hBYYA07gVj34CPgPZF/T42ttln1KHOkn1RbJcngMIBvqkjCOW
         0pYO6rp0NvffHTmsNH9CsfCDJKCMeWx8RBnZBKjcxVTZcUZTqBdB9lCLUMBWVIGwgU
         u76pbHWSr5sSPT03igQjMQNePMcIxiCzZC8v9xrk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Greg Ungerer <gerg@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 085/131] fs: binfmt_elf_efpic: fix personality for ELF-FDPIC
Date:   Mon,  9 Oct 2023 15:02:05 +0200
Message-ID: <20231009130118.954813344@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Ungerer <gerg@kernel.org>

commit 7c3151585730b7095287be8162b846d31e6eee61 upstream.

The elf-fdpic loader hard sets the process personality to either
PER_LINUX_FDPIC for true elf-fdpic binaries or to PER_LINUX for normal ELF
binaries (in this case they would be constant displacement compiled with
-pie for example).  The problem with that is that it will lose any other
bits that may be in the ELF header personality (such as the "bug
emulation" bits).

On the ARM architecture the ADDR_LIMIT_32BIT flag is used to signify a
normal 32bit binary - as opposed to a legacy 26bit address binary.  This
matters since start_thread() will set the ARM CPSR register as required
based on this flag.  If the elf-fdpic loader loses this bit the process
will be mis-configured and crash out pretty quickly.

Modify elf-fdpic loader personality setting so that it preserves the upper
three bytes by using the SET_PERSONALITY macro to set it.  This macro in
the generic case sets PER_LINUX and preserves the upper bytes.
Architectures can override this for their specific use case, and ARM does
exactly this.

The problem shows up quite easily running under qemu using the ARM
architecture, but not necessarily on all types of real ARM hardware.  If
the underlying ARM processor does not support the legacy 26-bit addressing
mode then everything will work as expected.

Link: https://lkml.kernel.org/r/20230907011808.2985083-1-gerg@kernel.org
Fixes: 1bde925d23547 ("fs/binfmt_elf_fdpic.c: provide NOMMU loader for regular ELF binaries")
Signed-off-by: Greg Ungerer <gerg@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Greg Ungerer <gerg@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/binfmt_elf_fdpic.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -345,10 +345,9 @@ static int load_elf_fdpic_binary(struct
 	/* there's now no turning back... the old userspace image is dead,
 	 * defunct, deceased, etc.
 	 */
+	SET_PERSONALITY(exec_params.hdr);
 	if (elf_check_fdpic(&exec_params.hdr))
-		set_personality(PER_LINUX_FDPIC);
-	else
-		set_personality(PER_LINUX);
+		current->personality |= PER_LINUX_FDPIC;
 	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 


