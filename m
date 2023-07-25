Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8020B7615B5
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGYLcM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjGYLcL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E8F3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7252061648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5FBC433C7;
        Tue, 25 Jul 2023 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284729;
        bh=aeKFfjKwT/mX9zvk9wCighil8LV1zahjBSlt/uG75Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vu6RhSncfYsJF73GPayF7FSR38wYecO7bRz+w8sdlAndMCG1Xc1EbTN+YuUL6xh8t
         bvlQHglJBhXAoffNwnUdFeiw+fYx8y1AqXzoJKDrXNUQRxeARR5cnZ26H2DtvTenRH
         xE6ckrqYkWYfpw7dQhVhSDnpi+0Hh1nQ1AixckU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 460/509] btrfs: add xxhash to fast checksum implementations
Date:   Tue, 25 Jul 2023 12:46:39 +0200
Message-ID: <20230725104614.814806446@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: David Sterba <dsterba@suse.com>

[ Upstream commit efcfcbc6a36195c42d98e0ee697baba36da94dc8 ]

The implementation of XXHASH is now CPU only but still fast enough to be
considered for the synchronous checksumming, like non-generic crc32c.

A userspace benchmark comparing it to various implementations (patched
hash-speedtest from btrfs-progs):

  Block size:     4096
  Iterations:     1000000
  Implementation: builtin
  Units:          CPU cycles

	NULL-NOP: cycles:     73384294, cycles/i       73
     NULL-MEMCPY: cycles:    228033868, cycles/i      228,    61664.320 MiB/s
      CRC32C-ref: cycles:  24758559416, cycles/i    24758,      567.950 MiB/s
       CRC32C-NI: cycles:   1194350470, cycles/i     1194,    11773.433 MiB/s
  CRC32C-ADLERSW: cycles:   6150186216, cycles/i     6150,     2286.372 MiB/s
  CRC32C-ADLERHW: cycles:    626979180, cycles/i      626,    22427.453 MiB/s
      CRC32C-PCL: cycles:    466746732, cycles/i      466,    30126.699 MiB/s
	  XXHASH: cycles:    860656400, cycles/i      860,    16338.188 MiB/s

Comparing purely software implementation (ref), current outdated
accelerated using crc32q instruction (NI), optimized implementations by
M. Adler (https://stackoverflow.com/questions/17645167/implementing-sse-4-2s-crc32c-in-software/17646775#17646775)
and the best one that was taken from kernel using the PCLMULQDQ
instruction (PCL).

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5a114cad988a6..608b939a4d287 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2256,6 +2256,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 		if (!strstr(crypto_shash_driver_name(csum_shash), "generic"))
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		break;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
+		break;
 	default:
 		break;
 	}
-- 
2.39.2



