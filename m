Return-Path: <stable+bounces-138815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D79AA1A39
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228949C5E51
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34CE24E00F;
	Tue, 29 Apr 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lAFJ02Xu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C512517AC;
	Tue, 29 Apr 2025 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950437; cv=none; b=E6k9SPeCDKpLhdqVfjf3DBk3vp64tsRyBD1kK4iQPcPzFzL0K/vd3jIC8UyWkVPOvQ96vg8JJn9oIcxXA5fLa8OwT4UK4tYvY1R1URPrlyfdsTqCvNhJJ9Sq8jOs7YwlSfgUEQuzLmI1HJNmk5+EX8xDJShudHPkfj5DaEwYNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950437; c=relaxed/simple;
	bh=KdANkyBZc6Am3HVApavNrEjtXnv25lqZhtR1ZbuIwm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tb1KJj2k2FV4QzI4Ox92OCGZwvgr6Jto39dhQFqMMxGq2A98iMbW8hj745vqL6LozMbfpMjrfjQP/YT8sZ/egcJeQXlpyt2qlN01hcEDmET+W0OkrybaIrn+owZvxc6uh8nQIu6IDqVJOBBMHuDYBO/wb0rKHSSNCwRR9MuTunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lAFJ02Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D752EC4CEE9;
	Tue, 29 Apr 2025 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950437;
	bh=KdANkyBZc6Am3HVApavNrEjtXnv25lqZhtR1ZbuIwm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAFJ02XuiIIT6FBneRaLSPxtY1VmaQOYfWNEL0SW+aUnwUFIGgs13TqlIMZOKatK3
	 NX7/OM0pNmkmO9nshaXuJRAbBrgjGzCjxQF1vzVoosVDDkz2+69V4tcTEhbqckpJdf
	 liSexPqU5mxmv4MP4aZJ2+aiFFzNGLOPar94rnTc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	stable <stable@kernel.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Subject: [PATCH 6.6 094/204] char: misc: register chrdev region with all possible minors
Date: Tue, 29 Apr 2025 18:43:02 +0200
Message-ID: <20250429161103.285243360@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

commit c876be906ce7e518d9ef9926478669c151999e69 upstream.

register_chrdev will only register the first 256 minors of a major chrdev.
That means that dynamically allocated misc devices with minor above 255
will fail to open with -ENXIO.

This was found by kernel test robot when testing a different change that
makes all dynamically allocated minors be above 255. This has, however,
been separately tested by creating 256 serio_raw devices with the help of
userio driver.

Ever since allowing misc devices with minors above 128, this has been
possible.

Fix it by registering all minor numbers from 0 to MINORMASK + 1 for
MISC_MAJOR.

Reported-by: kernel test robot <oliver.sang@intel.com>
Cc: stable <stable@kernel.org>
Closes: https://lore.kernel.org/oe-lkp/202503171507.6c8093d0-lkp@intel.com
Fixes: ab760791c0cf ("char: misc: Increase the maximum number of dynamic misc devices to 1048448")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Tested-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Link: https://lore.kernel.org/r/20250317-misc-chrdev-v1-1-6cd05da11aef@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/misc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -315,7 +315,7 @@ static int __init misc_init(void)
 		goto fail_remove;
 
 	err = -EIO;
-	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
+	if (__register_chrdev(MISC_MAJOR, 0, MINORMASK + 1, "misc", &misc_fops))
 		goto fail_printk;
 	return 0;
 



