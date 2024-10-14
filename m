Return-Path: <stable+bounces-84216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D4F99CF00
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038E3289934
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EB4595B;
	Mon, 14 Oct 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FvC8igzT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59B1ABEB7;
	Mon, 14 Oct 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917235; cv=none; b=uBocd0U8BzQnXYPMm74OXEvokmH1QHMPGN1W/ged6ZrNelZjdXLOtP8JTrhjjolottVpH1Ahi4fHiBcVzMgZEXZZN2fgVd5p4mGN6PMrUQu0dSkKBBnNB1e2FL9fQIGd7VYUszdVLcrIOkAFhTMOiuxl400EGvuyzs8jdpP2iLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917235; c=relaxed/simple;
	bh=025uWzUSr1zlbiq99DhlQy9H13g6K3lTM/R0nn6RX9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9v717M6EgVhf8NW/UE7k06dYBqmHGeh+nmdbmXxr3keAhxrsaI6ND9ENTYpVx2mhxD0EiTYGQhwdJUFgDv6ljIfcJEGo0VaRC3otXr7G3WTwnuh8tsy02nXqVKi+UM1qnLw1QjSFRq4IwdXHXUpgi2Jdst3hB61JYxWhRSxSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FvC8igzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E4AC4CEC3;
	Mon, 14 Oct 2024 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917234;
	bh=025uWzUSr1zlbiq99DhlQy9H13g6K3lTM/R0nn6RX9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvC8igzTP4rZ6WIQjQ7KA3rjvBI9h3JCO1kXK0bq+U0psM/243nsv93zskWrRtZvO
	 /8bpTYQnHbmq/gzwQw2JIVlaA1QAIl9nKIiKN7TOhrQC5zaXikjF/SQjb2yrn/8j5G
	 cBFGx6gqLULdXFX/MzkfUN4mMBC+LrNg4XiXJY6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Palmer <daniel@0x0f.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	stable@kernel.org,
	Finn Thain <fthain@linux-m68k.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 192/213] scsi: wd33c93: Dont use stale scsi_pointer value
Date: Mon, 14 Oct 2024 16:21:38 +0200
Message-ID: <20241014141050.455606304@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
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

From: Daniel Palmer <daniel@0x0f.com>

commit 9023ed8d91eb1fcc93e64dc4962f7412b1c4cbec upstream.

A regression was introduced with commit dbb2da557a6a ("scsi: wd33c93:
Move the SCSI pointer to private command data") which results in an oops
in wd33c93_intr(). That commit added the scsi_pointer variable and
initialized it from hostdata->connected. However, during selection,
hostdata->connected is not yet valid. Fix this by getting the current
scsi_pointer from hostdata->selecting.

Cc: Daniel Palmer <daniel@0x0f.com>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: stable@kernel.org
Fixes: dbb2da557a6a ("scsi: wd33c93: Move the SCSI pointer to private command data")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Co-developed-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Link: https://lore.kernel.org/r/09e11a0a54e6aa2a88bd214526d305aaf018f523.1727926187.git.fthain@linux-m68k.org
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/wd33c93.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -831,7 +831,7 @@ wd33c93_intr(struct Scsi_Host *instance)
 		/* construct an IDENTIFY message with correct disconnect bit */
 
 		hostdata->outgoing_msg[0] = IDENTIFY(0, cmd->device->lun);
-		if (scsi_pointer->phase)
+		if (WD33C93_scsi_pointer(cmd)->phase)
 			hostdata->outgoing_msg[0] |= 0x40;
 
 		if (hostdata->sync_stat[cmd->device->id] == SS_FIRST) {



