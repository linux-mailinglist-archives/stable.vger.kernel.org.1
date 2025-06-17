Return-Path: <stable+bounces-153846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CCADD758
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C541942876
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955DB2ED86F;
	Tue, 17 Jun 2025 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cvj2yOpS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3352EE5F0;
	Tue, 17 Jun 2025 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177287; cv=none; b=t0RvU1oBV9dDxq8FODQ37i7Po9zcqKV9KlyXH1W3+To34VoftZA3CGhNPVFgg94ReZ6wkKDOn/2PanTrQcpLyvWr01Zm0txHlCfURT9pMPohm802ctqIYZfLI9XrdDRQl/XYMMY2+OMxJLuGKu3WVyWuVRRtCa/pDWSdaV+mHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177287; c=relaxed/simple;
	bh=7jU2m3HstC6AknkSZ2nHmLJWKYD4Uoaku33b+qOi4xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRYsB2zB2VING6TAwe5WVTsPy9VQzw4Bsco2a7S6d7UjjTq4+FmqE2LsIuCnRV1Ik555emDfe4SLe8yM9Eh2ezAO1TevpI/ORuryG0AE4tijTqSmLVno5IvRxWMjwJyyuIe8zqwZKQmqeaxxkgRsYw8SHoxc1afo2DXRN1hCjnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cvj2yOpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BA2C4CEE3;
	Tue, 17 Jun 2025 16:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177287;
	bh=7jU2m3HstC6AknkSZ2nHmLJWKYD4Uoaku33b+qOi4xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cvj2yOpSkPwgMSAvZNQzR9xO3AH/FcginwdI1mv5n4opeRu4qcMGSIYn1kEL/bc+g
	 vxZXYawnlYt9BjTmziYuH3ukRlr9WcOpQC8NQJkCMXQNQtSDh5fnn+dAX2+lkEG5WS
	 Y4t2Jno8qxbDFPF5y+05wBy3Gl999/yRKMqBOEWk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gautam R A <gautam-r.a@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 284/780] RDMA/bnxt_re: Fix incorrect display of inactivity_cp in debugfs output
Date: Tue, 17 Jun 2025 17:19:52 +0200
Message-ID: <20250617152503.039891266@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gautam R A <gautam-r.a@broadcom.com>

[ Upstream commit 58d7a965bb2b014d467445d38cdb07099b1f0f77 ]

The inactivity_cp parameter in debugfs was not being read or
written correctly, resulting in "Invalid argument" errors.

Fixed this by ensuring proper mapping of inactivity_cp in
both the map_cc_config_offset_gen0_ext0 and
bnxt_re_fill_gen0_ext0() functions.

Fixes: 656dff55da19 ("RDMA/bnxt_re: Congestion control settings using debugfs hook")
Signed-off-by: Gautam R A <gautam-r.a@broadcom.com>
Link: https://patch.msgid.link/20250520035910.1061918-2-kalesh-anakkur.purayil@broadcom.com
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index af91d16c3c77f..a3aad6c3dbec1 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -170,6 +170,9 @@ static int map_cc_config_offset_gen0_ext0(u32 offset, struct bnxt_qplib_cc_param
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TCP_CP:
 		*val =  ccparam->tcp_cp;
 		break;
+	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INACTIVITY_CP:
+		*val = ccparam->inact_th;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -247,7 +250,9 @@ static void bnxt_re_fill_gen0_ext0(struct bnxt_qplib_cc_param *ccparam, u32 offs
 		ccparam->tcp_cp = val;
 		break;
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TX_QUEUE:
+		break;
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_INACTIVITY_CP:
+		ccparam->inact_th = val;
 		break;
 	case CMDQ_MODIFY_ROCE_CC_MODIFY_MASK_TIME_PER_PHASE:
 		ccparam->time_pph = val;
-- 
2.39.5




