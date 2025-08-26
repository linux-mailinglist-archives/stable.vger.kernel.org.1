Return-Path: <stable+bounces-173103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB77B35B59
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A327D7A9800
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29DA2BF3E2;
	Tue, 26 Aug 2025 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cH0SkYHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB28245012;
	Tue, 26 Aug 2025 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207380; cv=none; b=DdXKcqlLbwq/5fAmqY7D77jj2Xb+GowNbkj8CKkNS0j+Uv0WvIJZnYxWUCeohqHW5M+dFT4bmS7JIazd2IZ2QHXJ1ejCMQfnl5lPRXLx+O4otev+rIbwl9SM/l1v5iSnhu7VHdHn0GYzl3YUij2IJOfrRsIWhvoz0tLbNPUr/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207380; c=relaxed/simple;
	bh=71E+72rFAJchUVrXzPGywQvOwNJOYwNRfk6cCX58viI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0mWV4n42qa1jiDD+7cv7/4GtyTn8KqBdjdc+nIEw7S4qTmEy3VzPKS0IcmQNwzLou+cxm6asIoN9pwAVCMhNfsXVWaz4Zd34y55csPjsa6An7GPgyA6ErKe/uFOpCdMIogtZBvsF0A19JN95tQJQn2N3nIjRj0vBN0eGqj4VrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cH0SkYHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B33AC4CEF1;
	Tue, 26 Aug 2025 11:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207380;
	bh=71E+72rFAJchUVrXzPGywQvOwNJOYwNRfk6cCX58viI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cH0SkYHjP01fkSJodf2n94y30TtPWDLFNdfFrqlh2R0YFHxs8HGwCC5QfsASEv0I9
	 02v+M5YF5XJ7BQXzUTO6I9M39syXy45KyknWDqhGJLI9lnwp3FiS0Rgnc2Ec1Xv41S
	 tdsd2z/pBU3pvOXgMbT5cJRw2fpzxuMrhFVXvTIQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan ODonoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 6.16 160/457] media: iris: Remove error check for non-zero v4l2 controls
Date: Tue, 26 Aug 2025 13:07:24 +0200
Message-ID: <20250826110941.329954828@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

commit 03e29ab0e94831fcca2f62c96121fd14263b399b upstream.

Remove the check for non-zero number of v4l2 controls as some SOCs might
not expose any capability which requires v4l2 control.

Cc: stable@vger.kernel.org
Fixes: 33be1dde17e3 ("media: iris: implement iris v4l2_ctrl_ops")
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Tested-by: Vikash Garodia <quic_vgarodia@quicinc.com> # on sa8775p-ride
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -80,8 +80,6 @@ int iris_ctrls_init(struct iris_inst *in
 		if (iris_get_v4l2_id(cap[idx].cap_id))
 			num_ctrls++;
 	}
-	if (!num_ctrls)
-		return -EINVAL;
 
 	/* Adding 1 to num_ctrls to include V4L2_CID_MIN_BUFFERS_FOR_CAPTURE */
 



