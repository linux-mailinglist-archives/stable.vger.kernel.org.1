Return-Path: <stable+bounces-228510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SILINTZPwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:33:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5952F4B89
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 804BE32FB812
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DC03B27E5;
	Mon, 23 Mar 2026 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkT9ns6z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643A3B27DC;
	Mon, 23 Mar 2026 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275323; cv=none; b=JoJBl4uJ5T5H5zyjKGvuA/zOdAL+TxDiIucYBY8JQ7O7AOT3rxY1PuPjKf1vDtkNLZ7rJIe07sw9L4jeCUEAsT+gVw0zTGUyCl6sPe+AIvqDnPoCKX7jwB/l10M364730IaDRNAHGt7gtIQTk8INT98iQdODGeNOkGs9u2XXY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275323; c=relaxed/simple;
	bh=d29qOttFzky5zopKytvEGdV/VuXfDGZVzueM0fpcrmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIIpQbPHptGsbHpnq5fXYgyTMtdAac9o0PCdW+nWtePyDLtE9rraj81MiOjKlSCUJCl8c9nqbwTgmfBUiw1BwyUfRUWnYt7FHOATNQVNEa70NZJE60uoavVc9D5BwuKK0CA1fB6bLVJP8iBpZ+A0RYVUprpZjkylJ5Fh2iMvcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkT9ns6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD196C4CEF7;
	Mon, 23 Mar 2026 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275323;
	bh=d29qOttFzky5zopKytvEGdV/VuXfDGZVzueM0fpcrmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VkT9ns6zkyHtAldkU8SiyT0RPPh468Dp3//pZM/wycKmg9ylYtXuKDejYBQs0goxE
	 h+Z7r/DKC/DI/AMYseKI8UconfcffRUU+1HGdoazZhoecyjCaWHWIGl74w01QAzGdj
	 cnBDYC5H/0PzKXih8RnqbPpO/D0wn8s3mGo/mfHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 015/460] ALSA: usb-audio: Check max frame size for implicit feedback mode, too
Date: Mon, 23 Mar 2026 14:40:11 +0100
Message-ID: <20260323134527.039246610@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228510-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5D5952F4B89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7cb2a5422f5bbdf1cf32eae0eda41000485b9346 ]

When the packet sizes are taken from the capture stream in the
implicit feedback mode, the sizes might be larger than the upper
boundary defined by the descriptor.  As already done for other
transfer modes, we have to cap the sizes accordingly at sending,
otherwise this would lead to an error in USB core at submission of
URBs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221076
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260225085233.316306-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/endpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 9d22613f71e24..2616a7efcc212 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -224,6 +224,7 @@ int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep,
 
 	packet = ctx->packet_size[idx];
 	if (packet) {
+		packet = min(packet, ep->maxframesize);
 		if (avail && packet >= avail)
 			return -EAGAIN;
 		return packet;
-- 
2.51.0




