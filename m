Return-Path: <stable+bounces-207319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1424D09C50
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBB0230C4710
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4795C359708;
	Fri,  9 Jan 2026 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mnJrgDx+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A1359701;
	Fri,  9 Jan 2026 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961717; cv=none; b=DhJvi2aJqxiH556B32TCScbZQYGlppjSBrCmJM3iHodH2xcyWXTzdoWQNkfpGReMdvgLqMd7vBA7KE20A4uRk4ckoFjD5XITYPYosAca2zhQgae57zZDbd9levy7HiPJ7PoLHJknaoot9tpjZQU8SPV6DbAXoZv9PMkdHvtk8Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961717; c=relaxed/simple;
	bh=+FVqqwQ7SUIWPlBXsoo9cvC2rc8mU8/7+alCA9PKGww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj2/PIenh4qD6x2wkehJXqzw12mVRXErZm/UU2mBfHO3m5dGEzCFzuTJOMbwTHX+VSD+d3zuhY7Wc9+EEygRo4NKfpds/yDjRllfu72PylpAoGbJNB7MI9xDTiQ7mbsusqhwKKlUIjr9A7ifbc2/7k+S7F/zNV+rbv/cVGVlDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mnJrgDx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88705C4CEF1;
	Fri,  9 Jan 2026 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767961716;
	bh=+FVqqwQ7SUIWPlBXsoo9cvC2rc8mU8/7+alCA9PKGww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnJrgDx+G1yZX0q1Vzn3ox89ptBp7zkUHHLFedYcjcCuhkyq+CX2cfbX0FM9+nJUn
	 hpEiYDp0KFdnqqq1s2Gq6ycpEoFlZleBpwMoWSPgfKnV/3oVg02mmZw8wm2nzAaYef
	 x++G/+5iS9WUqLFaGVXD0AI1GDH8LwyNUrprfnAs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haotian Zhang <vulab@iscas.ac.cn>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/634] scsi: sim710: Fix resource leak by adding missing ioport_unmap() calls
Date: Fri,  9 Jan 2026 12:36:30 +0100
Message-ID: <20260109112121.648443301@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haotian Zhang <vulab@iscas.ac.cn>

[ Upstream commit acd194d9b5bac419e04968ffa44351afabb50bac ]

The driver calls ioport_map() to map I/O ports in sim710_probe_common()
but never calls ioport_unmap() to release the mapping. This causes
resource leaks in both the error path when request_irq() fails and in
the normal device removal path via sim710_device_remove().

Add ioport_unmap() calls in the out_release error path and in
sim710_device_remove().

Fixes: 56fece20086e ("[PATCH] finally fix 53c700 to use the generic iomem infrastructure")
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20251029032555.1476-1-vulab@iscas.ac.cn
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sim710.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sim710.c b/drivers/scsi/sim710.c
index e519df68d603d..70c75ab1453a1 100644
--- a/drivers/scsi/sim710.c
+++ b/drivers/scsi/sim710.c
@@ -133,6 +133,7 @@ static int sim710_probe_common(struct device *dev, unsigned long base_addr,
  out_put_host:
 	scsi_host_put(host);
  out_release:
+	ioport_unmap(hostdata->base);
 	release_region(base_addr, 64);
  out_free:
 	kfree(hostdata);
@@ -148,6 +149,7 @@ static int sim710_device_remove(struct device *dev)
 
 	scsi_remove_host(host);
 	NCR_700_release(host);
+	ioport_unmap(hostdata->base);
 	kfree(hostdata);
 	free_irq(host->irq, host);
 	release_region(host->base, 64);
-- 
2.51.0




