Return-Path: <stable+bounces-101588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8829EED5A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10F2166D3A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED02222D52;
	Thu, 12 Dec 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ntnzPvRT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABF8222D4E;
	Thu, 12 Dec 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018089; cv=none; b=VOJKPgz7CxrTdx7H8mmG5gOSJahoUiJQ5W+d6C1F1lDAeaOwrad+B0hBicwSAcJW8puid7sF8K5Rt+N8XAJ63aAQa9qqN9zs5VX+2aWLL2DfVF+uLncOsrpqOGIK96gVMzaYOAaZjOpK8F6/+oK892O87NtmNWp4hOIww8+DoF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018089; c=relaxed/simple;
	bh=b19EL3yo+LDscVvqG6L3UTmXpC7mUWG8L4am/BfwgCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOaEGV3/ik8lKj49ohGCttyC3x/usMN/6fS0MKLgB5tOMrRMqUwTeNdhXUzrJlDoq1ggFey6NrbmG7e82sXrkYLAHE96qgV6DGN+tYqNKiT+TBV5vnkRCdb9ktjLQPX56OLAKm45u+gV14tJ0wIuOWbvqO+9vBI5qy9c8yxmdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ntnzPvRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F57CC4CECE;
	Thu, 12 Dec 2024 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734018089;
	bh=b19EL3yo+LDscVvqG6L3UTmXpC7mUWG8L4am/BfwgCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntnzPvRTXQQxaV9O2Af54duWWhnkJi26TFRXhSiNkJZp5hqn9Qi6+WsGiupXcJCvI
	 XBfH61O/Jtk5EFtCo1b8/qNV9cOKa9PNSBwAbs7xQEXbd0ovHNwEp6LtIpIxsPUC04
	 b4ggvgapW0pwc/dSxmjcSuBS1Frt70eidv93kE8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liequan Che <cheliequan@inspur.com>,
	Zheng Wang <zyytlz.wz@163.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Coly Li <colyli@suse.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 164/356] bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again
Date: Thu, 12 Dec 2024 15:58:03 +0100
Message-ID: <20241212144251.114717024@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liequan Che <cheliequan@inspur.com>

commit b2e382ae12a63560fca35050498e19e760adf8c0 upstream.

Commit 028ddcac477b ("bcache: Remove unnecessary NULL point check in
node allocations") leads a NULL pointer deference in cache_set_flush().

1721         if (!IS_ERR_OR_NULL(c->root))
1722                 list_add(&c->root->list, &c->btree_cache);

>From the above code in cache_set_flush(), if previous registration code
fails before allocating c->root, it is possible c->root is NULL as what
it is initialized. __bch_btree_node_alloc() never returns NULL but
c->root is possible to be NULL at above line 1721.

This patch replaces IS_ERR() by IS_ERR_OR_NULL() to fix this.

Fixes: 028ddcac477b ("bcache: Remove unnecessary NULL point check in node allocations")
Signed-off-by: Liequan Che <cheliequan@inspur.com>
Cc: stable@vger.kernel.org
Cc: Zheng Wang <zyytlz.wz@163.com>
Reviewed-by: Mingzhe Zou <mingzhe.zou@easystack.cn>
Signed-off-by: Coly Li <colyli@suse.de>
Link: https://lore.kernel.org/r/20241202115638.28957-1-colyli@suse.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1724,7 +1724,7 @@ static void cache_set_flush(struct closu
 	if (!IS_ERR_OR_NULL(c->gc_thread))
 		kthread_stop(c->gc_thread);
 
-	if (!IS_ERR(c->root))
+	if (!IS_ERR_OR_NULL(c->root))
 		list_add(&c->root->list, &c->btree_cache);
 
 	/*



