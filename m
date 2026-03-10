Return-Path: <stable+bounces-223992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA0rEPD9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:18:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A314C24A569
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DD66313CFE1
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C136EA89;
	Tue, 10 Mar 2026 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfWlI1CW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD372BF3E2;
	Tue, 10 Mar 2026 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141125; cv=none; b=jns4+nvIVLO73tVEQp7cDf0RtPPu1qRaHMdXn64B417RefyewPej6sLuRHQySNDo3Jq7OEPsBQ4m++LTpgkeX6F3Zm4qHssyZcAhrMzaaYtuFbgex0tlskDidE5/df1IpcOC3r3iOlamnWnJ00j0wf9s5vflVr4r0SnSYCdIS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141125; c=relaxed/simple;
	bh=iZ9ixkNvZAdcP8UCnI3XKANClG5pE+Pj0ulLM6YJCrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnuwAeN114lQ6CtLAas9fdNFfJaMbwyMU6rMrgcjWIkfvmfJBgo2/8SErqdAZQfbnkX/4//E523Qiq17rVmDQDIL8vJEcJLfcFHf69TJMBPlYWqtuys3bL6eHAp8T0epO4041WPycNmttAA6vBQtxhEVv4WIaMn1BAQYvuedImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfWlI1CW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DBCC2BC9E;
	Tue, 10 Mar 2026 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141125;
	bh=iZ9ixkNvZAdcP8UCnI3XKANClG5pE+Pj0ulLM6YJCrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfWlI1CWvQr8r/9bnATnb2+DonX5JBPLjDgnCC8TtnP0ZG31NacyPTBFhFbBfLkPq
	 TiTCYxaVB/+TiqwiLsZavoMa81nQ1cXeI8HKfNj1+hbjhNulLj+je18n185vAVLD36
	 9ROyHBbVt3fWT7px3mdFcGxC1TA22Z+4KbCzW6qeg1IcCjj8WWyoIcLcTA3UtWXT9Q
	 m2g6TWEMpHTFg/8/6WbkiI7N+i3nfK+rWE4UdOI8oAhQfAp1JbljpKL92xyHits1Er
	 bfmHb97euREnkW9acQBOS1ZKl6XFWU6P849yKs9E2450CHhd2e2rWUfzuSs9iKjSVM
	 EQWc4AOVOfmqA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Panagiotis Foliadis <pfoliadis@posteo.net>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 127/311] ALSA: hda/intel: increase default bdl_pos_adj for Nvidia controllers
Date: Tue, 10 Mar 2026 07:02:54 -0400
Message-ID: <7001a1ed5929aa86885ece0a4f87e1729b5fd08b.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A314C24A569
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223992-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Panagiotis Foliadis <pfoliadis@posteo.net>

commit e9fb2028f1eb563e653cff3b0d1c87c5e0203d45 upstream.

The default bdl_pos_adj of 32 for Nvidia HDA controllers is
insufficient on GA102 (and likely other recent Nvidia GPUs) after S3
suspend/resume. The controller's DMA timing degrades after resume,
causing premature IRQ detection in azx_position_ok() which results in
silent HDMI/DP audio output despite userspace reporting a valid
playback state and correct ELD data.

Increase bdl_pos_adj to 64 for AZX_DRIVER_NVIDIA, matching the value
already used by Intel Apollo Lake for the same class of timing issue.

Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221069
Suggested-by: Charalampos Mitrodimas <charmitro@posteo.net>
Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
Link: https://patch.msgid.link/20260225-nvidia-audio-fix-v1-1-b1383c37ec49@posteo.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/controllers/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 1b365e0772970..f8919cb521a1a 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -1751,6 +1751,8 @@ static int default_bdl_pos_adj(struct azx *chip)
 		return 1;
 	case AZX_DRIVER_ZHAOXINHDMI:
 		return 128;
+	case AZX_DRIVER_NVIDIA:
+		return 64;
 	default:
 		return 32;
 	}
-- 
2.51.0


