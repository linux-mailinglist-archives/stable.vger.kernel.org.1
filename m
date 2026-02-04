Return-Path: <stable+bounces-214135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CFCCXBog2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:40:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90910E91A4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9F7630C680B
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0963529993F;
	Wed,  4 Feb 2026 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jD5NAota"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111C18859B;
	Wed,  4 Feb 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218681; cv=none; b=XbFy3vWwp4x0snEWFWvqWyidUjlF3t3QFmsI0bUaPonaFmoXAZZbUCnC9xGL2elKG0mgjxJSjCpaQv6u1KhzLvCBe463Jlczq1qDCfwVmQtKVCKgHZljOkAdZHpZlIFz96vE0/ezFoXbHZ5v4tyF2d+s2WV+VDTuB2ld342ncKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218681; c=relaxed/simple;
	bh=W+Jw5Q/paeESKLSoTUf6FZRHAoSqvqEGo+m9bln4XqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB0LqRi3KP47yPHwY8KxbnbJ3f8YRILVIzg1nGAErnObHOu4cuXvugy+CxZuXZpt23reWxmeuqU2i7+jvVEe5bK9tcyxg8LZGS5jnwZGAcErGlQ0RPeURhyNQ0mKozhopcqTzDANrHzayFe6EQXo0bKS1sK30zZPdg16k6GywCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jD5NAota; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E220C4CEF7;
	Wed,  4 Feb 2026 15:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218681;
	bh=W+Jw5Q/paeESKLSoTUf6FZRHAoSqvqEGo+m9bln4XqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jD5NAotaBmvIiXzux4aQtMKfQ/HWR+p6mkshoVqqYIwMcjZsN7fhA/gkmJWW4AcS/
	 XnRPab5z+i13TeQr5BCVHuy/cmy2pJffaFk9aX74SSA/+soqeDaQfu26qevPRHd63L
	 I683iZdJ4yZhdadIOecFgwwVlGC8+dUzh5Hh/gCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shida Zhang <zhangshida@kylinos.cn>,
	Coly Li <colyli@fnnas.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 30/87] bcache: fix I/O accounting leak in detached_dev_do_request
Date: Wed,  4 Feb 2026 15:40:28 +0100
Message-ID: <20260204143847.995871393@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214135-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email,kylinos.cn:email,fnnas.com:email,kernel.dk:email]
X-Rspamd-Queue-Id: 90910E91A4
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shida Zhang <zhangshida@kylinos.cn>

[ Upstream commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f ]

When a bcache device is detached, discard requests are completed
immediately. However, the I/O accounting started in
cached_dev_make_request() is not ended, leading to 100% disk
utilization reports in iostat. Add the missing bio_end_io_acct() call.

Fixes: cafe56359144 ("bcache: A block layer cache")
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
Acked-by: Coly Li <colyli@fnnas.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/request.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index a02aecac05cdf..6cba1180be8aa 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1107,6 +1107,7 @@ static void detached_dev_do_request(struct bcache_device *d,
 
 	if (bio_op(orig_bio) == REQ_OP_DISCARD &&
 	    !bdev_max_discard_sectors(dc->bdev)) {
+		bio_end_io_acct(orig_bio, start_time);
 		bio_endio(orig_bio);
 		return;
 	}
-- 
2.51.0




