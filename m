Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7EE76AFB9
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjHAJt4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjHAJtm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65505CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 047816150C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C48C433C7;
        Tue,  1 Aug 2023 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883321;
        bh=qzPLeVpAPGwxJgvvJOrR3xVkTEY54jDBCbQtesfK6qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=apMWVZYVj7W0pDa/MPf3kdU2p44L+uk7D8ObWq8VUTvbMfMp4IWfetKx9joIMcVLZ
         1X3O1WOnZTu4GIkjjOV8c6DddCfL1Hyj0rHWopQQsolEMK03/LOD9BMqqwDFbOG+W5
         i3V7W4hxOzOD4JQbQIFnKuTaPrxSLJtUCFzHfkmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 6.4 187/239] btrfs: check if the transaction was aborted at btrfs_wait_for_commit()
Date:   Tue,  1 Aug 2023 11:20:51 +0200
Message-ID: <20230801091932.427452650@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit bf7ecbe9875061bf3fce1883e3b26b77f847d1e8 upstream.

At btrfs_wait_for_commit() we wait for a transaction to finish and then
always return 0 (success) without checking if it was aborted, in which
case the transaction didn't happen due to some critical error. Fix this
by checking if the transaction was aborted.

Fixes: 462045928bda ("Btrfs: add START_SYNC, WAIT_SYNC ioctls")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/transaction.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -933,6 +933,7 @@ int btrfs_wait_for_commit(struct btrfs_f
 	}
 
 	wait_for_commit(cur_trans, TRANS_STATE_COMPLETED);
+	ret = cur_trans->aborted;
 	btrfs_put_transaction(cur_trans);
 out:
 	return ret;


