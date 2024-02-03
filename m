Return-Path: <stable+bounces-18547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989C7848327
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE541F24399
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F61CD05;
	Sat,  3 Feb 2024 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q7sgqRQK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E261CAAD;
	Sat,  3 Feb 2024 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933879; cv=none; b=XxAVFckqmPVvB/e6YZNHu2nbSmw0Vm4gAGQKT5UFRPJdvejvPBXqPQbxLpQjJbgFAS2+vIRZIz4DCVrzGj19t4TKy+FcJ+Fkw+R6uZc5oFfLCI7hOBkgvL+XPR0OwkXcnqY7HW8ELPA6knOUOOlm12eYjwHvdPqjhuRpOgmeK+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933879; c=relaxed/simple;
	bh=JpjuQnrhCeVltkB8FUPpHEpV2GDcN6ztc9uZjo41Qwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVxjOXBuPJbTGw1hM702b9qaiiu3bwygyqrBH7PQHaeQ6xOc6TT5MnNYDjwsUvLbcQB4vvfoSd2MspuXrTn4zCwJLJvtk305q4eTfQ8hgHe7ditawq0EoJ7IQtEdiGSAd3jFCS16mgcgfCQJVdGiCGhXEFb6wYmOZWGCWxbPyAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q7sgqRQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6CBC43390;
	Sat,  3 Feb 2024 04:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933879;
	bh=JpjuQnrhCeVltkB8FUPpHEpV2GDcN6ztc9uZjo41Qwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7sgqRQKdA0hS+BPTjGf3mVWSRfbNlxDmAFODmB9L5LRP3blFj/OYDY9TMjwW9Wio
	 viHAMMdt2kVOYLiA9t0uyTEcFHcaaTMfqPffMDAYSgvD5rstgVcbMK8zh0ZSNu1xjq
	 //bup4SWj2ITXjkoj7JAFYP7KnfcvuXbcag2KTkA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dafna Hirschfeld <dhirschfeld@habana.ai>,
	Oded Gabbay <ogabbay@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 219/353] accel/habanalabs/gaudi2: fix undef opcode reporting
Date: Fri,  2 Feb 2024 20:05:37 -0800
Message-ID: <20240203035410.612317951@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

[ Upstream commit 0ec346779644039c4c05cfa7f071b1a24e54d8d9 ]

currently the undefined opcode event bit in set only for lower cp and
only if 'write_enable' is true. It should be set anyway and for all
streams in order to report that event to userspace.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 819660c684cf..bc6e338ef2fd 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -7929,21 +7929,19 @@ static int gaudi2_handle_qman_err_generic(struct hl_device *hdev, u16 event_type
 				error_count++;
 			}
 
-		if (i == QMAN_STREAMS && error_count) {
-			/* check for undefined opcode */
-			if (glbl_sts_val & PDMA0_QM_GLBL_ERR_STS_CP_UNDEF_CMD_ERR_MASK &&
-					hdev->captured_err_info.undef_opcode.write_enable) {
+		/* check for undefined opcode */
+		if (glbl_sts_val & PDMA0_QM_GLBL_ERR_STS_CP_UNDEF_CMD_ERR_MASK) {
+			*event_mask |= HL_NOTIFIER_EVENT_UNDEFINED_OPCODE;
+			if (hdev->captured_err_info.undef_opcode.write_enable) {
 				memset(&hdev->captured_err_info.undef_opcode, 0,
 						sizeof(hdev->captured_err_info.undef_opcode));
-
-				hdev->captured_err_info.undef_opcode.write_enable = false;
 				hdev->captured_err_info.undef_opcode.timestamp = ktime_get();
 				hdev->captured_err_info.undef_opcode.engine_id =
 							gaudi2_queue_id_to_engine_id[qid_base];
-				*event_mask |= HL_NOTIFIER_EVENT_UNDEFINED_OPCODE;
 			}
 
-			handle_lower_qman_data_on_err(hdev, qman_base, *event_mask);
+			if (i == QMAN_STREAMS)
+				handle_lower_qman_data_on_err(hdev, qman_base, *event_mask);
 		}
 	}
 
-- 
2.43.0




