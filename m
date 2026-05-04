Return-Path: <stable+bounces-243403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEQoL1ir+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD094BF281
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A0863022628
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6972A3D5645;
	Mon,  4 May 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QdlhBatG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DADB1ADC83;
	Mon,  4 May 2026 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903794; cv=none; b=HxGgAJWEqpmHwEe5lnjEwcvxkxwC+J956pJm/TjCdJG3zcgUWenpr0Syrf0PLYs5jrsmeUGcjczzxkTtqkWKef4JUtEIs6P2y8M+/zlP6p6KF0yGs4k8S2zwZwHx0FPhBY0tdsBn4tMonwgpKpmkHKJQeXOW+hhMEH8Nptl3FFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903794; c=relaxed/simple;
	bh=sXTBtk0o5g/ZoyuX/8o5YAG+uIozQxJAMsUGu7QNXiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6X35lGt5VgA73eDWaIaachL+tBETrutpnLwqv3bG0495uzOCV2RNAT32XW2BxHkvKe66gQTEpyvs5rgRpBuoioINcsJn5ZfsBpuxenUNRc3o3cUw6K0NOkAA75S6zU42nJProxSjqmqnDybQwcTgvUYbymvwzEiChAwumlskVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QdlhBatG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7944C2BCB8;
	Mon,  4 May 2026 14:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903794;
	bh=sXTBtk0o5g/ZoyuX/8o5YAG+uIozQxJAMsUGu7QNXiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdlhBatGw0OAevdjHflykTE/WH1hittjrasd1cCgp+HVfdbmT2eV2mONBglEi/JoS
	 eRUMdQXYlJwzek2PmAcqANzZgttYLDuMDQz72DkDlWHUTEaLdSZ11elC1S7KC0z6hB
	 +VAsHORAX/CU1dnJtg2TdnSNEeWaTzqvqhX0QGnY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 065/275] ALSA: seq_oss: return full count for successful SEQ_FULLSIZE writes
Date: Mon,  4 May 2026 15:50:05 +0200
Message-ID: <20260504135145.348961322@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DCD094BF281
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243403-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit bbc6c0dda54fc0ad8f8aed0b796c23e186e1a188 upstream.

snd_seq_oss_write() currently returns the raw load_patch() callback
result for SEQ_FULLSIZE events.

That callback is documented as returning 0 on success and -errno on
failure, but snd_seq_oss_write() is the file write path and should
report the number of user bytes consumed on success. Some in-tree
backends also return backend-specific positive values, which can still
be shorter than the original write size.

Return the full byte count for successful SEQ_FULLSIZE writes.
Preserve negative errors and convert any nonnegative completion to the
original count.

Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260324-alsa-seq-oss-fullsize-write-return-v1-1-66d448510538@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/core/seq/oss/seq_oss_rw.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/core/seq/oss/seq_oss_rw.c
+++ b/sound/core/seq/oss/seq_oss_rw.c
@@ -101,9 +101,9 @@ snd_seq_oss_write(struct seq_oss_devinfo
 				break;
 			}
 			fmt = (*(unsigned short *)rec.c) & 0xffff;
-			/* FIXME the return value isn't correct */
-			return snd_seq_oss_synth_load_patch(dp, rec.s.dev,
-							    fmt, buf, 0, count);
+			err = snd_seq_oss_synth_load_patch(dp, rec.s.dev,
+							   fmt, buf, 0, count);
+			return err < 0 ? err : count;
 		}
 		if (ev_is_long(&rec)) {
 			/* extended code */



