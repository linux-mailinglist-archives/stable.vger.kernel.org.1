Return-Path: <stable+bounces-220712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CwOJbFAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 348381C6EC8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E8E230D34F1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C73FC8A6;
	Sat, 28 Feb 2026 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6YNI7N2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A8748C8B0;
	Sat, 28 Feb 2026 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300592; cv=none; b=iKJ7SgO0ECZAjUNBXho5aXSCSkKL9W9swsf/sHAzmBRqxTCcRLJj0b2DLEMZgIP9njFwBa5iVkEdZ78c032Z9Xv386IwhWFp3RSrwlSWzWRG20qjXq2D18qgjMXWBg51HNRuHb0+sTOPXTfku/KQ+433EOhz9xg9afPM1n75hDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300592; c=relaxed/simple;
	bh=JeycNq1VemZIYqY51x/gy/WypAJZyGeGTg/g26vA578=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ar4T+ZTy5ekO5SVNuHkPMXKKVSL0X0tFXkQMZlOHQ4Jv4jDP1+OPe8KlyuoQqKoe+flVfZIwgLtA5LZ0O1TFF7n4DgGTEzkIbPfcHv5XBWVpmyhFgr/shlSvhUMk12JbtXxRBaP3cJH0ihcw7iVuy2Fdx4ViumNsXHqNvLZeFMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6YNI7N2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25750C19423;
	Sat, 28 Feb 2026 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300592;
	bh=JeycNq1VemZIYqY51x/gy/WypAJZyGeGTg/g26vA578=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6YNI7N2R6n4TCZ8J65PRjXL0Ykun64f4WGUbmEnbeITBBZAh3mjwTs2HbMKmDm2Z
	 UMzs2OzXwbxVYGUJ8TcI7LSLl4U2Rw+C9XyRWDdIQawp8W7qIG7fZTlRa3uuMsXdbJ
	 KlBx9mbVLbh8H/hiOymTavmWsHAomJNBWDj1BU2dAF02kSiKAxVu+exxoxnieh+yOw
	 QiaXryoE9/MZA/4RwS8Lh/3CZ4j3BTACuosA9wgzWmeiKYsTk8EGc5ejSudlLx/I9a
	 KBciWxJgBOITHp1JDePw6KnaEiDQRIQiZBld+DwPYG01J25w8Ap9yzNLHD8WkwhXDl
	 JpnSMBxwhacAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vishnu Reddy <quic_bvisredd@quicinc.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 633/844] media: iris: Fix ffmpeg corrupted frame error
Date: Sat, 28 Feb 2026 12:29:06 -0500
Message-ID: <20260228173244.1509663-634-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220712-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,linaro.org:email,quicinc.com:email]
X-Rspamd-Queue-Id: 348381C6EC8
X-Rspamd-Action: no action

From: Vishnu Reddy <quic_bvisredd@quicinc.com>

[ Upstream commit 89f7cf35901138d9828d981ce64c131a3da6e867 ]

When the ffmpeg decoder is running, the driver receives the
V4L2_BUF_FLAG_KEYFRAME flag in the input buffer. The driver then forwards
this flag information to the firmware. The firmware, in turn, copies the
input buffer flags directly into the output buffer flags. Upon receiving
the output buffer from the firmware, the driver observes that the buffer
contains the HFI_BUFFERFLAG_DATACORRUPT flag. The root cause is that both
V4L2_BUF_FLAG_KEYFRAME and HFI_BUFFERFLAG_DATACORRUPT are the same value.
As a result, the driver incorrectly interprets the output frame as
corrupted, even though the frame is actually valid. This misinterpretation
causes the driver to report an error and skip good frames, leading to
missing frames in the final video output and triggering ffmpeg's "corrupt
decoded frame" error.

To resolve this issue, the input buffer flags should not be sent to the
firmware during decoding, since the firmware does not require this
information.

Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and firmware response")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
index 52da7ef7bab08..b6261d186d215 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
@@ -282,7 +282,7 @@ static int iris_hfi_gen1_queue_input_buffer(struct iris_inst *inst, struct iris_
 		com_ip_pkt.shdr.session_id = inst->session_id;
 		com_ip_pkt.time_stamp_hi = upper_32_bits(buf->timestamp);
 		com_ip_pkt.time_stamp_lo = lower_32_bits(buf->timestamp);
-		com_ip_pkt.flags = buf->flags;
+		com_ip_pkt.flags = 0;
 		com_ip_pkt.mark_target = 0;
 		com_ip_pkt.mark_data = 0;
 		com_ip_pkt.offset = buf->data_offset;
-- 
2.51.0


