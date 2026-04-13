Return-Path: <stable+bounces-236188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNadBGgU3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:06:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAA3EE4E5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 854AA302865D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106631D6DB5;
	Mon, 13 Apr 2026 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kdfmIlKl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C775523EA94;
	Mon, 13 Apr 2026 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096269; cv=none; b=FBxzBOtVX/tTrf8uBc79tD6u/wpeDY0og55eKfcIhuANcPZYhKg84q5jQgRzMMOwmEMlbGOK6ldEI5UW5fiZTLNikhmEsqstBuhOORqkDd4DJwO91K0GbZdLRa8HID1X1pTqGYXvKs5h5mw73tDQg1eM1b8IlUblDGORBBCnklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096269; c=relaxed/simple;
	bh=Otqw+p6WPLZZwE+kEo4giraKkmzijvj4En1gJQnEw2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGbD1h2WKrN12MpeqWfO+EH4ZgEbwc+WP99SZLSov6l0Sj9Qrhm7sNVtC9uWDs7mxoRRYe1kU7Liw/CHLhiK7g7XfkF5rmz+pQlsOSp1J1JVovs3lykFBmbREuODSQvlkNOAlyOYHQLZ8Vz9ZPcIi/P3x7CNGp957o8gQ/A2+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kdfmIlKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A54C2BCAF;
	Mon, 13 Apr 2026 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096269;
	bh=Otqw+p6WPLZZwE+kEo4giraKkmzijvj4En1gJQnEw2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdfmIlKlQBO1EmR5H4dadaBISaJOs1FjK6kkTGqXosjgZC3lxGEMaY492N75O6zq6
	 u44piyIHgDKQCFOFHTvua+pvFLum0D2G855fNEpwjM0ZrHTE8OVdCpn1xjuPeYQpKO
	 JUubF6gnuUEYIpcS/6NPpzQR3BP3oypC/NMdqr60=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.19 06/86] ALSA: hda/intel: enforce stricter period-size alignment for Intel NVL
Date: Mon, 13 Apr 2026 17:59:13 +0200
Message-ID: <20260413155731.809575309@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236188-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,msgid.link:url,suse.de:email]
X-Rspamd-Queue-Id: A2EAA3EE4E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

commit 082c192c0dd03f685514c9ce2eb0a80fd28e2175 upstream.

Intel ACE4 based products set more strict constraints on HDA BDLE start
address and length alignment. Modify capability flags to drop
AZX_DCAPS_NO_ALIGN_BUFSIZE for Intel Nova Lake platforms.

Fixes: 7f428282fde3 ("ALSA: hda: controllers: intel: add support for Nova Lake")
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260408084514.24325-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/controllers/intel.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -295,6 +295,9 @@ enum {
 #define AZX_DCAPS_INTEL_LNL \
 	(AZX_DCAPS_INTEL_SKYLAKE | AZX_DCAPS_PIO_COMMANDS)
 
+#define AZX_DCAPS_INTEL_NVL \
+	(AZX_DCAPS_INTEL_LNL & ~AZX_DCAPS_NO_ALIGN_BUFSIZE)
+
 /* quirks for ATI SB / AMD Hudson */
 #define AZX_DCAPS_PRESET_ATI_SB \
 	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_POSFIX_LPIB |\
@@ -2552,8 +2555,8 @@ static const struct pci_device_id azx_id
 	/* Wildcat Lake */
 	{ PCI_DEVICE_DATA(INTEL, HDA_WCL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Nova Lake */
-	{ PCI_DEVICE_DATA(INTEL, HDA_NVL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
-	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_NVL) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_NVL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */



