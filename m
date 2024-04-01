Return-Path: <stable+bounces-34776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4948940C8
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86933B21814
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181193F8F4;
	Mon,  1 Apr 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eauh8XSk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C010A3B;
	Mon,  1 Apr 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989258; cv=none; b=YBqRCgwVIxGBRyF2UKmAmo8Vrpk1uCONrTPrECHhj9xZJRgyizrZOv7a/Qawj6NZGATlsyXjLo64Uti8JcE42uKNh2MBQ+GCGxms/dt2x/aZqD+BgZ1ZhkEtrFcNygr4us3jgSb2rC6ADUV8fnncWYnwyE6ulmq2MScX9ZlgJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989258; c=relaxed/simple;
	bh=H82MKDHLj3IGXUwXKncJC1Ec0Iv0Sa3UGFzL6IboYC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4wSAwP7LfR9kKrNoW4cSfDJcj41eerVmviIsZHenpVXp7YPHt6HJJj7jkmtT8KafMYeM5EtVDw9QhUAbuT2TXxBMT78Zc3xYTow6B3FflcvVhjrjYN17N2Obz+c2QjICJ2IKSH1FiJzGu4N5Ao89AVlEp8nIGOdU3F+Nidc2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eauh8XSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334F4C433F1;
	Mon,  1 Apr 2024 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989258;
	bh=H82MKDHLj3IGXUwXKncJC1Ec0Iv0Sa3UGFzL6IboYC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eauh8XSklzA5QY+KZztJx5x/jGattGuT0ZK67qMGxLpaCD9CPgpO6oZ2mW/cmJUhs
	 8t+DRG9YVo6WoF6VJNyDK+gzLPMGAQW+a3eRPwV4fQk6J56u+ZdNYuC0oY56AiAc3c
	 d9wYa64nBxwnpIUxoI5hr6i2GBrfLifa0fyVGejU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Justin Tee <justintee8345@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.7 429/432] scsi: lpfc: Correct size for wqe for memset()
Date: Mon,  1 Apr 2024 17:46:56 +0200
Message-ID: <20240401152606.243103602@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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



