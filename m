Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4307F0B8B
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 06:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjKTF0T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 20 Nov 2023 00:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTF0R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 00:26:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B5103;
        Sun, 19 Nov 2023 21:26:13 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 36FEC1F74D;
        Mon, 20 Nov 2023 05:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700457972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nqNiOlAE7bus2fwY4NaNzeqwQIjz99V6eJfBfXnTss=;
        b=sP5zz1Dtytg3dgeeE22ZJldk6F84PKmUOEXsQXp0/5IQJlaUqXRP7Xv+Y3VwefAS1YLH6t
        rRQSGML+vKDWAjqNTgpCZBJ+9fgJyenDZ12BfgmN3vbaj2PqBnC1nrxhjW3QF8SP62WcQF
        dC6QPxHZb02J4aC6FHXNkbKPDlSVfz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700457972;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nqNiOlAE7bus2fwY4NaNzeqwQIjz99V6eJfBfXnTss=;
        b=IKV4iEzwAduaJsNeYPbAyokOFr1tMd0tI7QYh9vLkmxlt+MnU7dWyanXHSN4/aqxv+NDgV
        ocPYZslSQHHmYFCw==
Received: from localhost.localdomain (colyli.tcp.ovpn1.nue.suse.de [10.163.16.22])
        by relay2.suse.de (Postfix) with ESMTP id 30C0A2C433;
        Mon, 20 Nov 2023 05:26:09 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 02/10] bcache: check return value from btree_node_alloc_replacement()
Date:   Mon, 20 Nov 2023 13:24:55 +0800
Message-Id: <20231120052503.6122-3-colyli@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231120052503.6122-1-colyli@suse.de>
References: <20231120052503.6122-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of colyli@suse.de) smtp.mailfrom=colyli@suse.de
X-Rspamd-Server: rspamd1
X-Spamd-Result: default: False [21.99 / 50.00];
         ARC_NA(0.00)[];
         BAYES_SPAM(0.00)[38.60%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         NEURAL_SPAM_SHORT(3.00)[1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.de];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[6];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         MX_GOOD(-0.01)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         MID_CONTAINS_FROM(1.00)[];
         RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
         VIOLATED_DIRECT_SPF(3.50)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2]
X-Spam-Score: 21.99
X-Rspamd-Queue-Id: 36FEC1F74D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In btree_gc_rewrite_node(), pointer 'n' is not checked after it returns
from btree_gc_rewrite_node(). There is potential possibility that 'n' is
a non NULL ERR_PTR(), referencing such error code is not permitted in
following code. Therefore a return value checking is necessary after 'n'
is back from btree_node_alloc_replacement().

Signed-off-by: Coly Li <colyli@suse.de>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/btree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index ae5cbb55861f..de8d552201dc 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1532,6 +1532,8 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 		return 0;
 
 	n = btree_node_alloc_replacement(replace, NULL);
+	if (IS_ERR(n))
+		return 0;
 
 	/* recheck reserve after allocating replacement node */
 	if (btree_check_reserve(b, NULL)) {
-- 
2.35.3

