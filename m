Return-Path: <stable+bounces-212170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GABuM3Ytemnd3gEAu9opvQ
	(envelope-from <stable+bounces-212170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:38:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE21A41BF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB51F3027037
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F52D9796;
	Wed, 28 Jan 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BmgC1Cqz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1554C2D6E63;
	Wed, 28 Jan 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614622; cv=none; b=qWX4T9Hxy8VlsuVdx8xLqlqp6SxP4suOAfgoHepge+8rGIY1ieMYmICi/hAjbS/8Q8e+47VSMAFOAZE9OOp6Unx9G031SVcH03yUW3sFzU7vBbh9DW+Q2FSgCTe1+jL39u1wod6VVQOIKV6XSOZaWZjImLYBaGUSGRPIlO4CG1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614622; c=relaxed/simple;
	bh=4itAfcKe7aVQWIgA2CaoUYjmnseGxyc9yLKab413vvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKlEYN7ce3NM2xCMF4upK4/Z3Xp6weuq4i54n/WV9eH2nVQcePUluVw/UKqZG/VzW1G4er+KY7fQfTD0BtDh6DdRsetj49L72NeTl6MhuCT64wpKbI1ZpSdwsi7szLvcPRrpEedFkq4M2j1xvY1/GcO/bF8x5UBPeoU/pySxPoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BmgC1Cqz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A41EC4CEF1;
	Wed, 28 Jan 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614622;
	bh=4itAfcKe7aVQWIgA2CaoUYjmnseGxyc9yLKab413vvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmgC1CqzcKhJjcSAmlprtPzJumJEFPlwczXmisnzt5tNi6266uZ1n4th7vsPQxze+
	 vCQax+sOMUwazHhm3rE0bs1xxFjhkY234hVIHb7CXDz8xnRS5NzWzhABmhFFNqjWXC
	 SRUJjAZQSP+s7bfjqDZ87zL9IFoLpyzgusTGq5IU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salvatore Bonaccorso <carnil@debian.org>,
	Karsten Hohmeier <linux@hohmatik.de>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 192/254] ALSA: ctxfi: Fix potential OOB access in audio mixer handling
Date: Wed, 28 Jan 2026 16:22:48 +0100
Message-ID: <20260128145351.708049563@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-212170-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4CE21A41BF
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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



