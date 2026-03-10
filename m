Return-Path: <stable+bounces-224336-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFYjJtkBsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224336-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:34:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEDC24B02F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C0C4311798D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21713FB042;
	Tue, 10 Mar 2026 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/lvBzDY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3A2D978B;
	Tue, 10 Mar 2026 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142030; cv=none; b=kPrx56gSy7yeruN8bh0KvUoUp71O9q1sgw3OTYW7UzKy/TlVwVGXCLtQKiXL19h8rQAiCsDsJNcKlvUUXKksOjtJm1rQM3tymhwQUCIs7o/IQH8Oxo+su7bSTUokHWXYI3qtVfdCHRZw7EYJBAICeN/KXfH5F1PPqJrsNbBnrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142030; c=relaxed/simple;
	bh=VLR98SqN9N34AOiwiXf7W2LZfRheL7J2WG7SpjTa4UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdDAAz83aMAAFDDKtCm5sWeX2oBrQgScKlWfVGbSODSq6+CqUBek9Duyajoywnz8yiJxopVtJ+1B7AGYWihbOawslPXD0vpEWk7QdCepgxE8Gbv1iNDclkBrsTyGYjmehLdparygqmCdy3aGdSc+Bl8kO50Qb7JBDV9kuwB10dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/lvBzDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DCDC2BC86;
	Tue, 10 Mar 2026 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142030;
	bh=VLR98SqN9N34AOiwiXf7W2LZfRheL7J2WG7SpjTa4UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/lvBzDYikX81YnVyu3Shao1UZHzxcbani0LxUo4wiOnkpaTmib6O07E+yuT5b6pd
	 iZszncmppLInUVa2kISF9xgRzf4YFlj8vsusJbdLmGEYKE5m4RyifbR1YWNMF1oCT7
	 VT9Ll8G3UjnPhcvI23xGzb5UQICawcqU7BCn/5y9PQ8BwiJgRq0bbDH5DCtmjbkKo9
	 xV9fAJ7cfVKgRR03F4Go0KctzTPUA+TDuMJv7NSV5rkoX5KqyF6nvsJK1+YTGFE3LK
	 96mfJ0tP5CIwFl2aV016RyMDA+50KhhNIMJXQucOBIDeGYUt+TqLC/yR+9z8J3OqTH
	 eSFZwv+u9Z+/A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Panagiotis Foliadis <pfoliadis@posteo.net>,
	Charalampos Mitrodimas <charmitro@posteo.net>,
	Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 157/314] ALSA: hda/intel: increase default bdl_pos_adj for Nvidia controllers
Date: Tue, 10 Mar 2026 07:16:56 -0400
Message-ID: <cf1c7846194494ce690bd237fda6e54059536c2e.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2EEDC24B02F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224336-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,posteo.net:email]
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
index a19258c95886c..9306e7a31f02b 100644
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


