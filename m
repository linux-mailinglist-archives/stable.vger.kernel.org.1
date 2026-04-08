Return-Path: <stable+bounces-235132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PkFItmq1mmOHAgAu9opvQ
	(envelope-from <stable+bounces-235132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC23C2D7E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68EC931AF78D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276D37F8AC;
	Wed,  8 Apr 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v1tbbhWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD6337B81;
	Wed,  8 Apr 2026 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674652; cv=none; b=Wp3m7wmHCPoo1Arv/310TQuUvqzlNc3pPyvmBItclrg0+zJIpj/MvY4xJL2m+jlPGqfZV3C9uSJHdjURJ0MDjhbNXfiIXBooECyp74oy+Ft0JeeAsNBgWHRPzZ4ItAAa39vVhbo9KwzQX4GF+RlNNYa4DSITVQLHAxTH1zaWMUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674652; c=relaxed/simple;
	bh=xy1gW/Rf33a0l/WK5XlieSN/lPk85gAHmbe+gT/cwrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8XDjtwsCAQRhXwQxvA5gR4E1QMHQD0KBpTmc5ykf/l1FYmZjeAL0LbwVW1CFhUl5c6gkpgvm0up5cm2PinAWMl5hus6XdCLDg4IPl20BWEz9QFxMScsB4GN9Mb/wSp8gJjD7ttgSlKLXzFNcjMAWeW1VaTrPYVoiWtbmT64R4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v1tbbhWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7E2C19421;
	Wed,  8 Apr 2026 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674651;
	bh=xy1gW/Rf33a0l/WK5XlieSN/lPk85gAHmbe+gT/cwrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v1tbbhWVCirheIgffQHWFVgxzxdpZcTAkkG+9UD7S+KQEuzwDzCNas03MH3MJD1w4
	 YU1lUvvoxm+8uR76Me9DJ0cs5M53yKYSehBZNDayTSxahdf1sw04ZGi+b81p8FUYMm
	 cFaQ/PAgj72fDBPEmoiN23IufGnmHibEqiiC0pdc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.19 173/311] ALSA: ctxfi: Dont enumerate SPDIF1 at DAIO initialization
Date: Wed,  8 Apr 2026 20:02:53 +0200
Message-ID: <20260408175945.867231254@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235132-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 79AC23C2D7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 75dc1980cf48826287e43dc7a49e310c6691f97e upstream.

The recent refactoring of xfi driver changed the assignment of
atc->daios[] at atc_get_resources(); now it loops over all enum
DAIOTYP entries while it looped formerly only a part of them.
The problem is that the last entry, SPDIF1, is a special type that
is used only for hw20k1 CTSB073X model (as a replacement of SPDIFIO),
and there is no corresponding definition for hw20k2.  Due to the lack
of the info, it caused a kernel crash on hw20k2, which was already
worked around by the commit b045ab3dff97 ("ALSA: ctxfi: Fix missing
SPDIFI1 index handling").

This patch addresses the root cause of the regression above properly,
simply by skipping the incorrect SPDIF1 type in the parser loop.

For making the change clearer, the code is slightly arranged, too.

Fixes: a2dbaeb5c61e ("ALSA: ctxfi: Refactor resource alloc for sparse mappings")
Cc: <stable@vger.kernel.org>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1259925
Link: https://patch.msgid.link/20260331081227.216134-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/ctxfi/ctatc.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -1427,10 +1427,14 @@ static int atc_get_resources(struct ct_a
 	daio_mgr = (struct daio_mgr *)atc->rsc_mgrs[DAIO];
 	da_desc.msr = atc->msr;
 	for (i = 0; i < NUM_DAIOTYP; i++) {
-		if (((i == MIC) && !cap.dedicated_mic) || ((i == RCA) && !cap.dedicated_rca))
+		if (((i == MIC) && !cap.dedicated_mic) ||
+		    ((i == RCA) && !cap.dedicated_rca) ||
+		    i == SPDIFI1)
 			continue;
-		da_desc.type = (atc->model != CTSB073X) ? i :
-			     ((i == SPDIFIO) ? SPDIFI1 : i);
+		if (atc->model == CTSB073X && i == SPDIFIO)
+			da_desc.type = SPDIFI1;
+		else
+			da_desc.type = i;
 		da_desc.output = (i < LINEIM) || (i == RCA);
 		err = daio_mgr->get_daio(daio_mgr, &da_desc,
 					(struct daio **)&atc->daios[i]);



