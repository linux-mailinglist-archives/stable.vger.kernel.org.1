Return-Path: <stable+bounces-228040-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ENcBj5HwWlGSAQAu9opvQ
	(envelope-from <stable+bounces-228040-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:59:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC52F3963
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7204308F3D5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613813AC0D2;
	Mon, 23 Mar 2026 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IknSb3pX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC81E7C03;
	Mon, 23 Mar 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273946; cv=none; b=FMt3xpiwiULjeO8Tp8nqN5HhB461oLM3qGyO2eh0p+K4GMAbgczQ+vthOko9c0+FXrC2sO3fOWR7Ec/sGDhq1LOfLHoSDj5YTaQKZBqhG5zaMh++HoFpEQwH2ukBUClyEnBB7u124JoaY62L5Jz7azol29hvo84Oq1HQiPR9dXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273946; c=relaxed/simple;
	bh=FsjsrNjj20hwJyvtFCjRL7F4oeLeB0uHyXoQuuSwHao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4JlmLI2Aq3mJpGDL/B/o4xKLBUPGECQI9t/eZx0fWs5T4T/FjUhtyomtM0fJd/iQHFpVf5a/Qbd29XnoGn8atCxjd6pNsMIBGto3zObiHLviWPw93MFbCXoFV4OBM1ZIqTZH7imcrKAG2ewqV7MaeSFbIGnP3gr64CGpN+A744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IknSb3pX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1AAC4CEF7;
	Mon, 23 Mar 2026 13:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774273945;
	bh=FsjsrNjj20hwJyvtFCjRL7F4oeLeB0uHyXoQuuSwHao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IknSb3pXz8C3aXas30RZ8nhAWXLBYgPM6XGisYUO7RaFABdDraLB5pMrgve19ChF2
	 Qkp825XILKXWBeRawyLV+Ob5Eo3GJFDxU4FSc5AUS/V28waPxM508ymMApYfn10OHy
	 0UqJRfIe4T2UjGIgtB5qIvfETfhEAXZqThDnrocE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>
Subject: [PATCH 6.19 058/220] vt: save/restore unicode screen buffer for alternate screen
Date: Mon, 23 Mar 2026 14:43:55 +0100
Message-ID: <20260323134506.423771844@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-228040-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5CBC52F3963
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Pitre <npitre@baylibre.com>

commit 5eb608319bb56464674a71b4a66ea65c6c435d64 upstream.

The alternate screen support added by commit 23743ba64709 ("vt: add
support for smput/rmput escape codes") only saves and restores the
regular screen buffer (vc_origin), but completely ignores the corresponding
unicode screen buffer (vc_uni_lines) creating a messed-up display.

Add vc_saved_uni_lines to save the unicode screen buffer when entering
the alternate screen, and restore it when leaving. Also ensure proper
cleanup in reset_terminal() and vc_deallocate().

Fixes: 23743ba64709 ("vt: add support for smput/rmput escape codes")
Cc: stable <stable@kernel.org>
Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
Link: https://patch.msgid.link/5o2p6qp3-91pq-0p17-or02-1oors4417ns7@onlyvoer.pbz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/vt.c            |    8 ++++++++
 include/linux/console_struct.h |    1 +
 2 files changed, 9 insertions(+)

--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1345,6 +1345,8 @@ struct vc_data *vc_deallocate(unsigned i
 			kfree(vc->vc_saved_screen);
 			vc->vc_saved_screen = NULL;
 		}
+		vc_uniscr_free(vc->vc_saved_uni_lines);
+		vc->vc_saved_uni_lines = NULL;
 	}
 	return vc;
 }
@@ -1890,6 +1892,8 @@ static void enter_alt_screen(struct vc_d
 	vc->vc_saved_screen = kmemdup((u16 *)vc->vc_origin, size, GFP_KERNEL);
 	if (vc->vc_saved_screen == NULL)
 		return;
+	vc->vc_saved_uni_lines = vc->vc_uni_lines;
+	vc->vc_uni_lines = NULL;
 	vc->vc_saved_rows = vc->vc_rows;
 	vc->vc_saved_cols = vc->vc_cols;
 	save_cur(vc);
@@ -1911,6 +1915,8 @@ static void leave_alt_screen(struct vc_d
 		dest = ((u16 *)vc->vc_origin) + r * vc->vc_cols;
 		memcpy(dest, src, 2 * cols);
 	}
+	vc_uniscr_set(vc, vc->vc_saved_uni_lines);
+	vc->vc_saved_uni_lines = NULL;
 	restore_cur(vc);
 	/* Update the entire screen */
 	if (con_should_update(vc))
@@ -2233,6 +2239,8 @@ static void reset_terminal(struct vc_dat
 	if (vc->vc_saved_screen != NULL) {
 		kfree(vc->vc_saved_screen);
 		vc->vc_saved_screen = NULL;
+		vc_uniscr_free(vc->vc_saved_uni_lines);
+		vc->vc_saved_uni_lines = NULL;
 		vc->vc_saved_rows = 0;
 		vc->vc_saved_cols = 0;
 	}
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -160,6 +160,7 @@ struct vc_data {
 	struct uni_pagedict **uni_pagedict_loc; /* [!] Location of uni_pagedict variable for this console */
 	u32 **vc_uni_lines;			/* unicode screen content */
 	u16		*vc_saved_screen;
+	u32		**vc_saved_uni_lines;
 	unsigned int	vc_saved_cols;
 	unsigned int	vc_saved_rows;
 	/* additional information is in vt_kern.h */



