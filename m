Return-Path: <stable+bounces-936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F817F7D36
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECC3282164
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19E39FE9;
	Fri, 24 Nov 2023 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O6SZJn44"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840739FE7;
	Fri, 24 Nov 2023 18:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8057CC433C8;
	Fri, 24 Nov 2023 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850149;
	bh=sMq8G0qM9tkEPsRZdn6u+TK+xu8WR+LTlhKj6jf8VnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6SZJn44yQDzCHFLhtasqar7HklOHmRgQnmjHW+Ig9bGVxMamaAy5S0ZOhk2KfzYA
	 1iHj3NyY+ne3ZOql0OyCr9VdFnqC8tag6xaqLQvdo/HOEp6ZFiolf/vaOqR2zPjl8P
	 pn7TYdaBhnafX44LT+Tw9T5Q9c+bf//vqsnTfV9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Hebert <nhebert@chromium.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.6 457/530] media: venus: hfi: fix the check to handle session buffer requirement
Date: Fri, 24 Nov 2023 17:50:23 +0000
Message-ID: <20231124172041.987621509@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Vikash Garodia <quic_vgarodia@quicinc.com>

commit b18e36dfd6c935da60a971310374f3dfec3c82e1 upstream.

Buffer requirement, for different buffer type, comes from video firmware.
While copying these requirements, there is an OOB possibility when the
payload from firmware is more than expected size. Fix the check to avoid
the OOB possibility.

Cc: stable@vger.kernel.org
Fixes: 09c2845e8fe4 ("[media] media: venus: hfi: add Host Firmware Interface (HFI)")
Reviewed-by: Nathan Hebert <nhebert@chromium.org>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/venus/hfi_msgs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -398,7 +398,7 @@ session_get_prop_buf_req(struct hfi_msg_
 		memcpy(&bufreq[idx], buf_req, sizeof(*bufreq));
 		idx++;
 
-		if (idx > HFI_BUFFER_TYPE_MAX)
+		if (idx >= HFI_BUFFER_TYPE_MAX)
 			return HFI_ERR_SESSION_INVALID_PARAMETER;
 
 		req_bytes -= sizeof(struct hfi_buffer_requirements);



