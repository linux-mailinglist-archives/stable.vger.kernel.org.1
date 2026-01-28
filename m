Return-Path: <stable+bounces-212572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPc9AJYzeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:04:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 939FFA505D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F16CB302CA3C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58121D6AA;
	Wed, 28 Jan 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FzPsr5md"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7039242D7F;
	Wed, 28 Jan 2026 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615967; cv=none; b=oc8uyCm6t65OnZLG6glIcfVo2vUrZBvuLhBSFfNBLdWai6UbYDq+K6Pih6hIKc5LDLbeXPFhuQ6SV/iH37sC6FDCZ+Hlka7vHgKKPRyPui/6oVk+LgSKbFB4AzQWURKjlTQMrCrmn0gH97q1o8KldqEhkEIZ3BSAd5cTWq/xBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615967; c=relaxed/simple;
	bh=gLhTdatZMa707N9CUnOpAs5T6+9qczLUpelEE8Bi9a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXcIv/4DlGwRl8Py46WCrkF7i3DptqS+a1434i7Vp0SmkKvHZe7+5RlfZfAfKatHIljMlpco0GhUSVUMXoA8o2kmMHUoCH1IInEysrKqSbSVRsyBY1fjJl4WMF/EyrabD8a7R2iOTo1230UXNUJ8hoLAqMcu1ISulpVf2XOILkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FzPsr5md; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2446EC2BC86;
	Wed, 28 Jan 2026 15:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615967;
	bh=gLhTdatZMa707N9CUnOpAs5T6+9qczLUpelEE8Bi9a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FzPsr5mdvP4oV40j6QmEkMjkPml8nKc5kh3pE4Ncp3b4WKZZ4AYojc1lXXzhrH8gm
	 7HiVhdbTWyiP2mWcMnlO3yg4J8xcrbavzsABkhbA+CMjw86rS3nUn9lOIKOLBL/0LJ
	 kVgp752q6HO1YTCWhCJv158pWB6QGebKHluAHyAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salvatore Bonaccorso <carnil@debian.org>,
	Karsten Hohmeier <linux@hohmatik.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 166/227] ALSA: ctxfi: Fix potential OOB access in audio mixer handling
Date: Wed, 28 Jan 2026 16:23:31 +0100
Message-ID: <20260128145350.425916649@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212572-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,hohmatik.de:email]
X-Rspamd-Queue-Id: 939FFA505D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 61006c540cbdedea83b05577dc7fb7fa18fe1276 upstream.

In the audio mixer handling code of ctxfi driver, the conf field is
used as a kind of loop index, and it's referred in the index callbacks
(amixer_index() and sum_index()).

As spotted recently by fuzzers, the current code causes OOB access at
those functions.
| UBSAN: array-index-out-of-bounds in /build/reproducible-path/linux-6.17.8/sound/pci/ctxfi/ctamixer.c:347:48
| index 8 is out of range for type 'unsigned char [8]'

After the analysis, the cause was found to be the lack of the proper
(re-)initialization of conj field.

This patch addresses those OOB accesses by adding the proper
initializations of the loop indices.

Reported-by: Salvatore Bonaccorso <carnil@debian.org>
Tested-by: Karsten Hohmeier <linux@hohmatik.de>
Closes: https://bugs.debian.org/1121535
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/all/aSk8KJI35H7gFru6@eldamar.lan/
Link: https://patch.msgid.link/20260119133212.189129-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/ctxfi/ctamixer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/ctxfi/ctamixer.c
+++ b/sound/pci/ctxfi/ctamixer.c
@@ -205,6 +205,7 @@ static int amixer_rsc_init(struct amixer
 
 	/* Set amixer specific operations */
 	amixer->rsc.ops = &amixer_basic_rsc_ops;
+	amixer->rsc.conj = 0;
 	amixer->ops = &amixer_ops;
 	amixer->input = NULL;
 	amixer->sum = NULL;
@@ -367,6 +368,7 @@ static int sum_rsc_init(struct sum *sum,
 		return err;
 
 	sum->rsc.ops = &sum_basic_rsc_ops;
+	sum->rsc.conj = 0;
 
 	return 0;
 }



