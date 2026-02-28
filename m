Return-Path: <stable+bounces-220720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDYbDPdAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:24:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2371C6F0A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 137653131E1B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FC13FE040;
	Sat, 28 Feb 2026 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6eRFul/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB83FD141;
	Sat, 28 Feb 2026 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300600; cv=none; b=J5j2678zfAeU7/VG+3Isy37+Gvw5mstjI78X5lCoj8cmqiF2uL5J41wvN36Dl0SkUPaeDiQ9Vb927c7562L3EQWhRlln9W3MFaU0VOU7EG36waGqUeWsGMRtOBFJ/Qmv96dfBld/G4lrIX9EYBm+hzdkr5GFpGQmeSafG0w6qM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300600; c=relaxed/simple;
	bh=AZImeR0YUVahPau8OXj+N1rcm15viZGdfIpYWF1HP0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvYn+mQhZmWTcqkYtjgPvr2zCizI1wevVRt4c49ZfD9zTjO+7w7sA9McK57Hhvx1eCZavoelnfpiEUvFl7eRP6tuM38zqDcrfhay3uC68JniQAJ//1x2vUQ4o9MpOIoMjJap+VP3KpwXcxZ67rpLaB3+n1PQQjwglXSOsUxg8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6eRFul/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADFDC19423;
	Sat, 28 Feb 2026 17:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300600;
	bh=AZImeR0YUVahPau8OXj+N1rcm15viZGdfIpYWF1HP0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6eRFul/+28XipuVb2iqRZ3xDvGr4ULcP8R13Esu2/4b6tG+FNzqXRfHfi9XslhkM
	 2GRnu/9oWXIk5uYlQf5Pc06JE467c1G2hTRWLVv4MM7WUbys55RmENnRgJSKyfj4Y0
	 XdY5eKXiW2ki7KNdEeJuq5/ntgUXaGLFxV0WxvcyZfI3NaeyUoyLhoyHBADnm/7fZd
	 tFXuM+dd6IkArV5CV6o75wvZonR33zzqtTzmXzKbAFMn5ruNoevS6ACxY6pk4OnXm/
	 FG20pvZTjti68QIqcynIJ6Fw3WcyAOJMC4iSA4UhJLlWsvPcn6f/NBfwRKJUxoTRkx
	 7MaDuU+2rgn3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 641/844] media: iris: gen2: Add sanity check for session stop
Date: Sat, 28 Feb 2026 12:29:14 -0500
Message-ID: <20260228173244.1509663-642-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220720-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: CB2371C6F0A
X-Rspamd-Action: no action

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

[ Upstream commit 9aa8d63d09cfc44d879427cc5ba308012ca4ab8e ]

In iris_kill_session, inst->state is set to IRIS_INST_ERROR and
session_close is executed, which will kfree(inst_hfi_gen2->packet).
If stop_streaming is called afterward, it will cause a crash.

Add a NULL check for inst_hfi_gen2->packet before sendling STOP packet
to firmware to fix that.

Fixes: 11712ce70f8e ("media: iris: implement vb2 streaming ops")
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index f912955320992..31e8fc7f8295d 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -963,6 +963,9 @@ static int iris_hfi_gen2_session_stop(struct iris_inst *inst, u32 plane)
 	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
 	int ret = 0;
 
+	if (!inst_hfi_gen2->packet)
+		return -EINVAL;
+
 	reinit_completion(&inst->completion);
 
 	iris_hfi_gen2_packet_session_command(inst,
-- 
2.51.0


