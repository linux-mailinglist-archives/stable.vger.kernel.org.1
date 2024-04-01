Return-Path: <stable+bounces-35180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FEE8942C7
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DAC28376D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3F4C601;
	Mon,  1 Apr 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EUAQgkOc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8B4C3C3;
	Mon,  1 Apr 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990561; cv=none; b=PBUr7EMc/IOWGsOGRWLWMYegOlJrSGbzy0Z45oUarrJpuhkEn+uEM2cX4gxSjj1X46LN9jTeKR8nyLiZgkMXuYkRwdUtnDuPSyMSIksV/bJOex8FpMOZW86fepJCnC4RL5jFH1/9cWmiQ/IiRIVe2F4CZIaWwsBvuajYauq24Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990561; c=relaxed/simple;
	bh=6t/eOv2WzQQudqPLpEXYx08r2PveDcTInCMPyII0VZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eq9iaonKDHIkiFHQiQlLhNWQZClXBgZiDuniK8JWBnNUdHnQSZ/f5K5nlsdam8tSx8upA3YEkJ8gxnaKlqd2Hqkteu+mUD/iUW4ShveEH2V+DFjbDYpeZCv2z4doeBz9IIkkAuAcW0+4syAska+3TzbQtgJ9hQm3I8dCkLIuh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EUAQgkOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9345AC433F1;
	Mon,  1 Apr 2024 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990561;
	bh=6t/eOv2WzQQudqPLpEXYx08r2PveDcTInCMPyII0VZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EUAQgkOc2t6iSsCMOoDgZBwD6zbXp0YdVg17fpUkB3jbRGpQ+kUddkZHQ6lL9lvgi
	 jN4p6QsNCJ/6uYCR6UAC5UbmaKqAbESrYnfaXn87PE7SbJqd4Qrslo1p8eYTVWtvqf
	 3/TO9dtToisw0HtOAFnIi9UXDgIaXAse/mx4FfYo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Justin Tee <justintee8345@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 392/396] scsi: lpfc: Correct size for wqe for memset()
Date: Mon,  1 Apr 2024 17:47:21 +0200
Message-ID: <20240401152559.597485913@linuxfoundation.org>
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

commit 28d41991182c210ec1654f8af2e140ef4cc73f20 upstream.

The wqe is of type lpfc_wqe128. It should be memset with the same type.

Fixes: 6c621a2229b0 ("scsi: lpfc: Separate NVMET RQ buffer posting from IO resources SGL/iocbq/context")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20240304090649.833953-1-usama.anjum@collabora.com
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Justin Tee <justintee8345@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/lpfc/lpfc_nvmet.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1586,7 +1586,7 @@ lpfc_nvmet_setup_io_context(struct lpfc_
 		wqe = &nvmewqe->wqe;
 
 		/* Initialize WQE */
-		memset(wqe, 0, sizeof(union lpfc_wqe));
+		memset(wqe, 0, sizeof(*wqe));
 
 		ctx_buf->iocbq->cmd_dmabuf = NULL;
 		spin_lock(&phba->sli4_hba.sgl_list_lock);



