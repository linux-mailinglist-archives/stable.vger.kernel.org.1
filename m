Return-Path: <stable+bounces-16450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361ED840D02
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17751F2AEE0
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A32156967;
	Mon, 29 Jan 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2RLfj7Xs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEF157052;
	Mon, 29 Jan 2024 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548028; cv=none; b=bnyju032GrulRlY0/XtzzNnjlWrHWZmvYKCa2paSAMPk4TuUFZKwGYpAjg2zz/IQJ6TIFZ0iXM1eeDqoYYB1f9WhwMihQwwv+wrHCs38yYzBeQR6xBXG0AmXgGOfrJEan08JvUO44CJQ0TwHww6END8N7fSX1LgeMt/oFTGsPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548028; c=relaxed/simple;
	bh=6b1etTonIXqmii1EJ4SmaRhMw01/SFDUPKgnfb4BTHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQ/mJ7zHxJNcag0Tja63dEnTgm6q7Fg6MnXiGMWX39LK3ihy/Aj6mtSFrzK9ojFy/mKAAjS6qnARHeNRXsfYW4tEdcz1u/rdRs7Wv0QpExeD4tk4APFe6464smcw1MDEnW3UwukE/GG++nKn44AZCle+h3ngjQhRPffvsclnsWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2RLfj7Xs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00E9C43390;
	Mon, 29 Jan 2024 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548028;
	bh=6b1etTonIXqmii1EJ4SmaRhMw01/SFDUPKgnfb4BTHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2RLfj7Xspnysn9kQ0XWf190f409HGcdkikMBy27has0gSPgCVGMNXRYYj+Z2Xy0qi
	 RrwYEqY4LoScBpogsmd8XnB/t6p/FY+NZ3wfV5eCOA9zES2H5/WzI1li3BE/mJ5Xar
	 azgJv8v8Ba2sa+6TpEZfyyesBU3Oeid6ZG25lhJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.7 022/346] mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters
Date: Mon, 29 Jan 2024 09:00:53 -0800
Message-ID: <20240129170017.027221358@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit a7d84a2e7663bbe12394cc771107e04668ea313a upstream.

While switching to ref counters for track mtd devices use, the vmu-flash
driver was forgotten. The reason for reading the ref counter seems
debatable, but let's just fix the build for now.

Fixes: 19bfa9ebebb5 ("mtd: use refcount to prevent corruption")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312022315.79twVRZw-lkp@intel.com/
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20231205075936.13831-1-miquel.raynal@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/maps/vmu-flash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -719,7 +719,7 @@ static int vmu_can_unload(struct maple_d
 	card = maple_get_drvdata(mdev);
 	for (x = 0; x < card->partitions; x++) {
 		mtd = &((card->mtd)[x]);
-		if (mtd->usecount > 0)
+		if (kref_read(&mtd->refcnt))
 			return 0;
 	}
 	return 1;



