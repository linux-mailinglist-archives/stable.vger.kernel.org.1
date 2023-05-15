Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA13703440
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbjEOQqh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242973AbjEOQq3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631BE4EF3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E669B628F7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EDFC433D2;
        Mon, 15 May 2023 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169181;
        bh=ssgSVG3ia+fo3vsUV4rKrbwTfMtiCcmBF3U9aWDIi3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSMsY1l9/mL/UUNK+K55VqlPHCCc6UL6xY+EVrzVk4FOSIhEbuJjduxH4qvGLgqqD
         DSyEjqpwJmL9ieeuSNuVUpb1oe9TwDVYcdpDOitcpT3V5d2NbC1kYYAVizQ0fOeKAH
         3dkz0yB0q8WdLZ/cjCEmGPcMhU4zaQsYpPZ2vqdk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pawel Witek <pawel.ireneusz.witek@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 4.19 169/191] cifs: fix pcchunk length type in smb2_copychunk_range
Date:   Mon, 15 May 2023 18:26:46 +0200
Message-Id: <20230515161713.567518267@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pawel Witek <pawel.ireneusz.witek@gmail.com>

commit d66cde50c3c868af7abddafce701bb86e4a93039 upstream.

Change type of pcchunk->Length from u32 to u64 to match
smb2_copychunk_range arguments type. Fixes the problem where performing
server-side copy with CIFS_IOC_COPYCHUNK_FILE ioctl resulted in incomplete
copy of large files while returning -EINVAL.

Fixes: 9bf0c9cd4314 ("CIFS: Fix SMB2/SMB3 Copy offload support (refcopy) for large files")
Cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Witek <pawel.ireneusz.witek@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/smb2ops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1180,7 +1180,7 @@ smb2_copychunk_range(const unsigned int
 		pcchunk->SourceOffset = cpu_to_le64(src_off);
 		pcchunk->TargetOffset = cpu_to_le64(dest_off);
 		pcchunk->Length =
-			cpu_to_le32(min_t(u32, len, tcon->max_bytes_chunk));
+			cpu_to_le32(min_t(u64, len, tcon->max_bytes_chunk));
 
 		/* Request server copy to target from src identified by key */
 		kfree(retbuf);


