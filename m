Return-Path: <stable+bounces-25091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB208697AE
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF181C21E78
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAF913EFEC;
	Tue, 27 Feb 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ph7ClWSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB713B2B8;
	Tue, 27 Feb 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043835; cv=none; b=e7r4Y5ce2jXIjiAa5uXseJ6+3cdDXGNBMn9zST5M67dzVidpOkFxkmAk0p64oeBsPvQjSDWczsQD4SOo9PnTk2geMWd2uOL9mb0coJPh/CgY6/LwLzW6ZwzF74JwFoWam173VX904T6auJPKlo0zeoujncS5f9KdhXeajOE+6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043835; c=relaxed/simple;
	bh=35YDHMdZ0Kpo3Cymdx2tZrMvRMQ070wZ5AySUZ0jpZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9IUe0a0iHDcPe+Fg9f/dn6XPmEthY1o/00alH7jOMKJFcslOGw+z3Lpw56BAo0JZOXBo79QzUilSnCYVYtmNSP6DZ8GZU81dCqrXGwaaJI9spcU5gdD+LIq4hj52EAyz8+h3zrVW/Ooefnvr3kVw5KadW0FlDF0HnvFT/EQPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ph7ClWSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EA2C433F1;
	Tue, 27 Feb 2024 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043835;
	bh=35YDHMdZ0Kpo3Cymdx2tZrMvRMQ070wZ5AySUZ0jpZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ph7ClWSraivUNooIY7+Swq4mPIgXiOijHd1sjXbm25nDbQV0mp6xehRS43SHzAKuB
	 Bp7RK1EvKhE3bHdglPpb8fiCGP2+7DxcONrMH/obfIypkw5wzanriJETpbf8nZ9HR3
	 yM1oaXYRTld/4or/vffGOMRjLSjSE51q6eg1CuxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.4 54/84] dm-crypt: dont modify the data when using authenticated encryption
Date: Tue, 27 Feb 2024 14:27:21 +0100
Message-ID: <20240227131554.629560899@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131552.864701583@linuxfoundation.org>
References: <20240227131552.864701583@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 50c70240097ce41fe6bce6478b80478281e4d0f7 upstream.

It was said that authenticated encryption could produce invalid tag when
the data that is being encrypted is modified [1]. So, fix this problem by
copying the data into the clone bio first and then encrypt them inside the
clone bio.

This may reduce performance, but it is needed to prevent the user from
corrupting the device by writing data with O_DIRECT and modifying them at
the same time.

[1] https://lore.kernel.org/all/20240207004723.GA35324@sol.localdomain/T/

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-crypt.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1627,6 +1627,12 @@ static void kcryptd_crypt_write_convert(
 	io->ctx.bio_out = clone;
 	io->ctx.iter_out = clone->bi_iter;
 
+	if (crypt_integrity_aead(cc)) {
+		bio_copy_data(clone, io->base_bio);
+		io->ctx.bio_in = clone;
+		io->ctx.iter_in = clone->bi_iter;
+	}
+
 	sector += bio_sectors(clone);
 
 	crypt_inc_pending(io);



