Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492D178AAFD
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjH1K1A (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjH1K02 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:26:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8E683
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:26:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08EAC630B7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FC1C433C8;
        Mon, 28 Aug 2023 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218385;
        bh=o4TQMlEnn/q7WiH4I3iAjK7oQ0OGD9Bg26RN9vC+j5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=01GqR1qzoeqrrtuwRLiX/GrnmcdwjAAuQvwQ6M+6ehafkMIjg7AHvCL5wc964QiJT
         YT0Wk+fWOhIBkiIG2oMAcbKJSdHKLejFyXxTKGSAbUiUY+LKL7gxSDHK+lmPFMSzzG
         h7wfq8vMYVmE3z86Lh3ng8J1Yy11Z2p/GUDJ3GAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Russell Harmon <russ@har.mn>,
        "Paulo Alcantara (SUSE)" <pc@manguebit.com>,
        David Howells <dhowells@redhat.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 069/129] cifs: Release folio lock on fscache read hit.
Date:   Mon, 28 Aug 2023 12:12:43 +0200
Message-ID: <20230828101155.860135373@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell Harmon via samba-technical <samba-technical@lists.samba.org>

commit 69513dd669e243928f7450893190915a88f84a2b upstream.

Under the current code, when cifs_readpage_worker is called, the call
contract is that the callee should unlock the page. This is documented
in the read_folio section of Documentation/filesystems/vfs.rst as:

> The filesystem should unlock the folio once the read has completed,
> whether it was successful or not.

Without this change, when fscache is in use and cache hit occurs during
a read, the page lock is leaked, producing the following stack on
subsequent reads (via mmap) to the page:

$ cat /proc/3890/task/12864/stack
[<0>] folio_wait_bit_common+0x124/0x350
[<0>] filemap_read_folio+0xad/0xf0
[<0>] filemap_fault+0x8b1/0xab0
[<0>] __do_fault+0x39/0x150
[<0>] do_fault+0x25c/0x3e0
[<0>] __handle_mm_fault+0x6ca/0xc70
[<0>] handle_mm_fault+0xe9/0x350
[<0>] do_user_addr_fault+0x225/0x6c0
[<0>] exc_page_fault+0x84/0x1b0
[<0>] asm_exc_page_fault+0x27/0x30

This requires a reboot to resolve; it is a deadlock.

Note however that the call to cifs_readpage_from_fscache does mark the
page clean, but does not free the folio lock. This happens in
__cifs_readpage_from_fscache on success. Releasing the lock at that
point however is not appropriate as cifs_readahead also calls
cifs_readpage_from_fscache and *does* unconditionally release the lock
after its return. This change therefore effectively makes
cifs_readpage_worker work like cifs_readahead.

Signed-off-by: Russell Harmon <russ@har.mn>
Acked-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3991,9 +3991,9 @@ static int cifs_readpage_worker(struct f
 
 io_error:
 	kunmap(page);
-	unlock_page(page);
 
 read_complete:
+	unlock_page(page);
 	return rc;
 }
 


