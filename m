Return-Path: <stable+bounces-59864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7A8932C28
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B489D1F2431C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727419E810;
	Tue, 16 Jul 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lmpnKOko"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8219B59C;
	Tue, 16 Jul 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145138; cv=none; b=VvMOsii6ZwipWBs2szUSyGfdNKyHaBCYkS3n1Zz9Sori++2qijtPXLDpMoovwJCiqPZMwDcKgLPsME+kArxp2EYDl7LqDPkxfwY1OneyXWkdtz6A0fbPVhaamru7Wi6uZTwrDEWNILdC6yV6LPhgynW59JZnbwkvbOwSDsMxQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145138; c=relaxed/simple;
	bh=c1mNAw3xS5BXoyGZBZP6Nl+qD69nHk6jWN6U0jLWLW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gzl3XmvVz7QiZQABRCzo6Em20rEj+MEvFkk2mbnxp1JVIW6SW5zvE3RuDSQmSpyELraaVHP/xAL3shQr4al7eimWiB3/95WHfg1Sp6o4V/MxE9QpPzPWyRGpOKi5jZTGDC0m4U7gsCRcScly9OZCVOnd6TXvjkKw0ISavCXV/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lmpnKOko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF2AC116B1;
	Tue, 16 Jul 2024 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145138;
	bh=c1mNAw3xS5BXoyGZBZP6Nl+qD69nHk6jWN6U0jLWLW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmpnKOkoG9YUK96fvA4vDwBmGIHkDQPFdjItHiPrTz8mPdKJfO0N4FAp4PcWvOcXF
	 ByFn1F60Dvg0PbPr6zYJYsHu5PV/kHL/ZVcTV/oBxgs1lqERAErtguM99ZkMZ4fZgf
	 yglmf8ORkbSRNqZcchz+nY5gu3bBX7pxmfPF4FHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentong Wu <wentong.wu@intel.com>,
	Jason Chen <jason.z.chen@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 6.9 111/143] mei: vsc: Utilize the appropriate byte order swap function
Date: Tue, 16 Jul 2024 17:31:47 +0200
Message-ID: <20240716152800.247825682@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentong Wu <wentong.wu@intel.com>

commit a896a8a127f45d00fb69fa7536955aa9b2e5d610 upstream.

Switch from cpu_to_be32_array() to be32_to_cpu_array() for the
received ROM data.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Link: https://lore.kernel.org/r/20240625081047.4178494-4-wentong.wu@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/vsc-tp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -336,7 +336,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, c
 		return ret;
 
 	if (ibuf)
-		cpu_to_be32_array(ibuf, tp->rx_buf, words);
+		be32_to_cpu_array(ibuf, tp->rx_buf, words);
 
 	return ret;
 }



