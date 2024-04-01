Return-Path: <stable+bounces-35179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12438942C3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D556B20B97
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48584653C;
	Mon,  1 Apr 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SdwzKUIP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5B63E;
	Mon,  1 Apr 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990558; cv=none; b=aq5r2HkW00GesDZWjOR0y7HiGsua+j/d+FqR3qdOZ4e0pNUKWTMGp4hZOGea3vSfA3H4oPfrOW5CB3kZ8j7wWq3uf1drt1Uw5Nl8p+YBo0N3ZRiaKbyKxl4756tP6U4ld3ElkUIq4ZlKkXGFEguRWj/xB3KzS2KoP3uQ/nZAp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990558; c=relaxed/simple;
	bh=Mzi30M9E/Ie2zhlr5jtbM4pEMZWHiceVFhrxjHIrfLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ep+hCSMxLUvt2h///HoYPi8uAstjeBBveAKDyXJcMMTT73WsOaIi4Du6ucCYoOeEAm5FutcWJMe5wV/9wWEQg0a6FHxMXXxyxDbOPW4yJGg7paiBVuGQDX+g8Ku3SZwA65rst57ybwp40a0qvqM7A5fH1U+HUiIPRTRxUG3sZzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SdwzKUIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E742C433C7;
	Mon,  1 Apr 2024 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990557;
	bh=Mzi30M9E/Ie2zhlr5jtbM4pEMZWHiceVFhrxjHIrfLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SdwzKUIPfZyn0Mtk/tdV2PRcW7zP8fSlMHMHZYGHJDqdBBKa/sSjhzMkWj2nR4X8s
	 06ja1Qz8pq36HxM8d1JQ1jnSAsGb24StmTdQzqXbL72lN7R5QpPW7zoW1l23I0LPbE
	 iXQET/+89d05gzRLcstW0Id2ZQ92LSgmuwogRVZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 391/396] scsi: lpfc: Correct size for cmdwqe/rspwqe for memset()
Date: Mon,  1 Apr 2024 17:47:20 +0200
Message-ID: <20240401152559.568225160@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

commit 16cc2ba71b9f6440805aef7f92ba0f031f79b765 upstream.

The cmdwqe and rspwqe are of type lpfc_wqe128. They should be memset() with
the same type.

Fixes: 61910d6a5243 ("scsi: lpfc: SLI path split: Refactor CT paths")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20240304091119.847060-1-usama.anjum@collabora.com
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_bsg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -3169,10 +3169,10 @@ lpfc_bsg_diag_loopback_run(struct bsg_jo
 	}
 
 	cmdwqe = &cmdiocbq->wqe;
-	memset(cmdwqe, 0, sizeof(union lpfc_wqe));
+	memset(cmdwqe, 0, sizeof(*cmdwqe));
 	if (phba->sli_rev < LPFC_SLI_REV4) {
 		rspwqe = &rspiocbq->wqe;
-		memset(rspwqe, 0, sizeof(union lpfc_wqe));
+		memset(rspwqe, 0, sizeof(*rspwqe));
 	}
 
 	INIT_LIST_HEAD(&head);



