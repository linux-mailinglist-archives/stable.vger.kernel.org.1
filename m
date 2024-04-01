Return-Path: <stable+bounces-35452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC6894400
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7726A1C21AA6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E2482EF;
	Mon,  1 Apr 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbJ7/lu4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7D621105;
	Mon,  1 Apr 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991444; cv=none; b=pGIAHtXRajH4m3FoSwDclTPUuzuFsXf1MAmBjWrKMWfps6FWclq8OeVUMYAy0WjTbSSjmIqlKU2TmhBNxGjpr9N0Tjflm3YQnw1gIU2KdqUWu/zjIyBAhPilo0/q4kOJsoxUxB/w0pYYDSab89z+g99M+rTJGex6/0DnnxJt6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991444; c=relaxed/simple;
	bh=LmMY8TPgpXTFGDtVnARcRWaN0CeUlWjrnrcdFnbMyQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjS57GtiPL8YMDsYxLkJWssICSCDrc5ww2l9zzk0EJit7ReS/2qzo1E97uCOo8z+hQt+aXBrQ9pGI0bM7bbljP4IVn8/0m/TWxr2C5FgVKqTBbG5uALW1vjf7vqAY/h0DyWZbNgntykYAtkReX4fy5ssxOOWW8A42VqnodXYs8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbJ7/lu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBCEC433F1;
	Mon,  1 Apr 2024 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991444;
	bh=LmMY8TPgpXTFGDtVnARcRWaN0CeUlWjrnrcdFnbMyQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wbJ7/lu4FdjdsCqtnEfLsMCY0+bpjoumHHHUew3s61rqWoep1cg2Ygx5mb3aYNqs2
	 nPYNw5+msEGOu+hsJ370lE/bN5cIjAM7Siuh5xECQiNSV6xtU3rdOk+9H3jVguZSbR
	 rWcjlOgx0uLnUl6/ky1djgAp61RCjzhHpYjA4NpI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Justin Tee <justin.tee@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 266/272] scsi: lpfc: Correct size for cmdwqe/rspwqe for memset()
Date: Mon,  1 Apr 2024 17:47:36 +0200
Message-ID: <20240401152539.368808013@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



