Return-Path: <stable+bounces-213653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFmuEithg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:09:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7CE8044
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D94731F751D
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FC141C31B;
	Wed,  4 Feb 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aiTNt4pf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FD3D413D;
	Wed,  4 Feb 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217056; cv=none; b=ZzSGmo95EPeoD/lYAHL+1f6/WklhmmDPW7AmRE9khJYZmVQW2hj7yktW3+jUT2VZxlUH4MIlhhUhoWMhqWvP0hdEZr8Dche3dL1CowuWBOlpB/TKJxZZjIVX/d07Yr3QeZ5T1s/CSVJgVEKMITK4EYtc0gKWptWPryQInd8GD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217056; c=relaxed/simple;
	bh=f2sviqn/z2nOYbwBzXVNvj+I9MjN82kGL4zs6QE+kP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgzdbfPOsB6MB4RX3fMmz5x1rnkTSol/pktTcZAKbGf8imt2PUH7QlyJnbyuCPcV3H2jSdKbT+LtQqnZzfStcLYt1RlBiTLUyNa5zDGFJp7a6d50qUT2JRTaZ7gsrR3UprdMXhrVVqG+a3gr9Ri9WUZTtqcFdHPGTr137kjG4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aiTNt4pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D45C4CEF7;
	Wed,  4 Feb 2026 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217056;
	bh=f2sviqn/z2nOYbwBzXVNvj+I9MjN82kGL4zs6QE+kP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aiTNt4pfTm5M0iS4JKIFhPB6VPFiaa/rT5jP+GpUrgEbcsAPBpymUpyHHCW1XTWD9
	 /rzSmkVO2ZU2DDIe4l37RqK/PC9lxpzbHgfS2D1DKLol3VMz/lx1R0/qO8ZKqlwG9F
	 KvbwrJ7CvGtLz0lV7CbpgkLQ4aWA/iJqZoACeV6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salvatore Bonaccorso <carnil@debian.org>,
	Karsten Hohmeier <linux@hohmatik.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 111/206] ALSA: ctxfi: Fix potential OOB access in audio mixer handling
Date: Wed,  4 Feb 2026 15:39:02 +0100
Message-ID: <20260204143902.203601117@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213653-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,hohmatik.de:email,msgid.link:url,suse.de:email]
X-Rspamd-Queue-Id: A9E7CE8044
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -369,6 +370,7 @@ static int sum_rsc_init(struct sum *sum,
 		return err;
 
 	sum->rsc.ops = &sum_basic_rsc_ops;
+	sum->rsc.conj = 0;
 
 	return 0;
 }



