Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23204703A8F
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244908AbjEORwa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244825AbjEORwN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822D31A399
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62C5E62F41
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A43C433A0;
        Mon, 15 May 2023 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173005;
        bh=FowtQaz1nJYoTfNE5gy61S5PKrMyX5xjKgKq3thAIO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6vwVXfn6Zf+0sctsKOOOzWbMkH4GWENsBdS5oR0joQ3dWqqTGT7m87rybDcBvOGS
         QrvVS0L4p6JL8s3LYNL0RULLUFpe/XTRls2utiFGDlRxUranVI1fGCS6cKxKQxNRdP
         I73N6qN3IQurHpBIfJOo6MO+CtncwgYxv1SGY1tA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pawel Witek <pawel.ireneusz.witek@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.10 337/381] cifs: fix pcchunk length type in smb2_copychunk_range
Date:   Mon, 15 May 2023 18:29:48 +0200
Message-Id: <20230515161752.065440318@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -1784,7 +1784,7 @@ smb2_copychunk_range(const unsigned int
 		pcchunk->SourceOffset = cpu_to_le64(src_off);
 		pcchunk->TargetOffset = cpu_to_le64(dest_off);
 		pcchunk->Length =
-			cpu_to_le32(min_t(u32, len, tcon->max_bytes_chunk));
+			cpu_to_le32(min_t(u64, len, tcon->max_bytes_chunk));
 
 		/* Request server copy to target from src identified by key */
 		kfree(retbuf);


