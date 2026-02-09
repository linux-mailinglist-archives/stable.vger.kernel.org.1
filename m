Return-Path: <stable+bounces-215128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cALzIeHyiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:44:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC94F110D42
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649583083A77
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86813793DB;
	Mon,  9 Feb 2026 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kohKeVsC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A7125B2;
	Mon,  9 Feb 2026 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647767; cv=none; b=QITvdtrO60jY+lnDU2b8PLZWa5Tu5zxLS2TslzOhHUgn65NcedRROgV3wIrdv/F/khqalTMGeqTi9Q+LPn2awftkwmcFZNceXAdB6IjXzycMqt54TfkIVHUlYL3WE3g+A8QflY7J2FLV7dQrX4WxZrysEqE/5n69iaGkPILK13E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647767; c=relaxed/simple;
	bh=fbCV7HOeR3O4BpCEcCes4Q5ST6K9Ia1cDYlxfTj51N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0mDE0qDRs30SA//PbhuRvCmrUnlYHFGohjyMsurSbTUHWLPPueGAO4XLEtXf32nUxP92nzjuzG8o/oGPZP2HzfEopTYfheVWKo2/tet1Ep9BdTAxLHBicsAV3U2igh6oX0vMCW1PIxJ2qI4q+OwIPkVVLKkf2ECxW/eWCMn0GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kohKeVsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF06C116C6;
	Mon,  9 Feb 2026 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647767;
	bh=fbCV7HOeR3O4BpCEcCes4Q5ST6K9Ia1cDYlxfTj51N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kohKeVsCYe263N4E0yNIElYG8C6tvpOw6mXcEXcZzPmxBhT1/9Nj81lXP18eHZT0b
	 b/FcuAloMNpJPqOWhs/KH4nUYM0KMjxDKc4+kcotrslASyaDqxXRf7jaOPVw4lAFFP
	 zO5jb/GMEQR0MPOiFd43Fr2VGigBZkIoYfV94X5g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Todd Brandt <todd.e.brandt@intel.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH 6.12 022/113] tools/power turbostat: fix GCC9 build regression
Date: Mon,  9 Feb 2026 15:22:51 +0100
Message-ID: <20260209142311.007633179@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215128-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yandex-team.ru:email]
X-Rspamd-Queue-Id: EC94F110D42
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todd Brandt <todd.e.brandt@intel.com>

commit d4a058762f3d931aa1159b64ba94a09a04024f8c upstream.

Fix build regression seen when using old gcc-9 compiler.

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/power/x86/turbostat/turbostat.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2798,6 +2798,8 @@ int format_counters(struct thread_data *
 	}
 
 	for (i = 0, ppmt = sys.pmt_tp; ppmt; i++, ppmt = ppmt->next) {
+		const unsigned long value_raw = t->pmt_counter[i];
+		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -2809,9 +2811,6 @@ int format_counters(struct thread_data *
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			const unsigned long value_raw = t->pmt_counter[i];
-			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 		}
@@ -2879,6 +2878,8 @@ int format_counters(struct thread_data *
 	}
 
 	for (i = 0, ppmt = sys.pmt_cp; ppmt; i++, ppmt = ppmt->next) {
+		const unsigned long value_raw = c->pmt_counter[i];
+		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -2890,9 +2891,6 @@ int format_counters(struct thread_data *
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			const unsigned long value_raw = c->pmt_counter[i];
-			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 		}
@@ -3078,6 +3076,8 @@ int format_counters(struct thread_data *
 	}
 
 	for (i = 0, ppmt = sys.pmt_pp; ppmt; i++, ppmt = ppmt->next) {
+		const unsigned long value_raw = p->pmt_counter[i];
+		const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
 		switch (ppmt->type) {
 		case PMT_TYPE_RAW:
 			if (pmt_counter_get_width(ppmt) <= 32)
@@ -3089,9 +3089,6 @@ int format_counters(struct thread_data *
 			break;
 
 		case PMT_TYPE_XTAL_TIME:
-			const unsigned long value_raw = p->pmt_counter[i];
-			const double value_converted = 100.0 * value_raw / crystal_hz / interval_float;
-
 			outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), value_converted);
 			break;
 		}



