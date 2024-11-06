Return-Path: <stable+bounces-91271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF9D9BED38
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91FE61F24876
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F09E1DFD9D;
	Wed,  6 Nov 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tSg+FUHb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01D1E0E1F;
	Wed,  6 Nov 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898242; cv=none; b=ZiuejZJ40Eb3AdxhbPQGEqNGkB6DClbTRDvVvIwyQAjmLIdsDv4fSs4uf4TDdrgQzvWgUnpxEmvWPNsC2WlgRVntP+gX0uq3n7DavpzcTuCVyYE1LJvFcXRXZ5uQWsVNEZX6kGSmt9hRhMAUOYkYr+8cOLpVxK+TeEblf6cK4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898242; c=relaxed/simple;
	bh=Pd/bmRVhbI6xyGxM4oBH7c2TONgq+EHpXiBhX7/uT0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQYMvQEcw6DV/HhBQvOkomPVrr8IoHiiLsuLtJAYxRl+xc2PaTZr+n2FVj/TWuIAQtXbUh4kMZ3CAQcKRIvvWUwci22X/0mP4tdxOo4p2ZMUFQ32k+cAld+/RxtmyYnzMgk+aAYL9rbpAZsz6S6MKOYa4qOWcINzqq4nBYisnXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tSg+FUHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949D6C4CECD;
	Wed,  6 Nov 2024 13:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898242;
	bh=Pd/bmRVhbI6xyGxM4oBH7c2TONgq+EHpXiBhX7/uT0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSg+FUHb/lsjMHKnjFwadbCeRvEfAZ562QaIKyoufYWDsEFJjtfdGnosmUCk7g3if
	 lo9qUd2nDpS0ogyQx+cX29vPbOprBngJq9t3br7IGL9uFNpv+OC9rnbfO6bINSDBLd
	 ZaPUIRp58hINst/Hi76DHGESQMUsJtrH1LYWtwXQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <error27@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.4 172/462] usb: yurex: Fix inconsistent locking bug in yurex_read()
Date: Wed,  6 Nov 2024 13:01:05 +0100
Message-ID: <20241106120335.770459908@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

commit e7d3b9f28654dbfce7e09f8028210489adaf6a33 upstream.

Unlock before returning on the error path.

Fixes: 86b20af11e84 ("usb: yurex: Replace snprintf() with the safer scnprintf() variant")
Reported-by: Dan Carpenter <error27@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202312170252.3udgrIcP-lkp@intel.com/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Link: https://lore.kernel.org/r/20231219063639.450994-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/yurex.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -414,8 +414,10 @@ static ssize_t yurex_read(struct file *f
 		return -ENODEV;
 	}
 
-	if (WARN_ON_ONCE(dev->bbu > S64_MAX || dev->bbu < S64_MIN))
+	if (WARN_ON_ONCE(dev->bbu > S64_MAX || dev->bbu < S64_MIN)) {
+		mutex_unlock(&dev->io_mutex);
 		return -EIO;
+	}
 
 	spin_lock_irq(&dev->lock);
 	scnprintf(in_buffer, MAX_S64_STRLEN, "%lld\n", dev->bbu);



