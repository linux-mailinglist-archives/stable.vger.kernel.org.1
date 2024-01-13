Return-Path: <stable+bounces-10731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C773582CB63
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744B22834A9
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DCB12B67;
	Sat, 13 Jan 2024 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxOTVofw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08239FC19;
	Sat, 13 Jan 2024 09:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78651C433F1;
	Sat, 13 Jan 2024 09:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705139937;
	bh=1vxJ9gOvWy5SZNiT032byLkvnPplRcxQUN5U/rt3buE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxOTVofwMVoo0cpBb4Mlu5Xjl+McUMa8oaW8n+plDZq0y4thH4CjHhy0wwFuAXAEE
	 lMRCScA03xwMfNOZvTvFRRIelIlpkv9cM1dr+/ofKOsPftYwbr+naw9nn/usj7R+rp
	 /nJGqZrMRBDpaKvVDgmrQnQj1nIhiS2gQ8ZN/A0g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Sperbeck <jsperbeck@google.com>,
	Bean Huo <beanhuo@micron.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 43/43] Revert "nvme: use command_id instead of req->tag in trace_nvme_complete_rq()"
Date: Sat, 13 Jan 2024 10:50:22 +0100
Message-ID: <20240113094208.362103980@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094206.930684111@linuxfoundation.org>
References: <20240113094206.930684111@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 706960d328f5bdb1a9cde0b17a98ab84a59eed8e which is
commit 679c54f2de672b7d79d02f8c4ad483ff6dd8ce2e upstream.

It is reported to cause issues.

Reported-by: John Sperbeck <jsperbeck@google.com>
Link: https://lore.kernel.org/r/20240109181722.228783-1-jsperbeck@google.com
Cc: Bean Huo <beanhuo@micron.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -98,7 +98,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_fast_assign(
 		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->qid = nvme_req_qid(req);
-		__entry->cid = nvme_req(req)->cmd->common.command_id;
+		__entry->cid = req->tag;
 		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		__entry->retries = nvme_req(req)->retries;
 		__entry->flags = nvme_req(req)->flags;



