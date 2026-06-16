Return-Path: <stable+bounces-264005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xJe/OeZsMWoNjAUAu9opvQ
	(envelope-from <stable+bounces-264005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:33:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C84691268
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:33:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=oq97h7DH;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264005-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264005-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3583431AD84C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497537C912;
	Tue, 16 Jun 2026 15:27:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921641A682B;
	Tue, 16 Jun 2026 15:27:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623630; cv=none; b=M9Nd0wGCkSbds69eu9C/qL6rACShh4Sm3mdxKgk1dYGHzwDQtQeeJrZcUP3pqacc6RySwddPOc4qilcyasendGqho1GcfM75OWjUEdlWFXrmTUZX+xlbHlH3xbX5ENUtkywUFfBXDDft+4D6SO0kzPFB49alvidM9gE2dvMbiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623630; c=relaxed/simple;
	bh=iAvno3QvKiFhxvZeGa1zFeD9w9T2G/zLSJbkpb7QvO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJGmutZxgHSdHrQZv8LnXpA5OICcx+U7hnHbvEIlOlc8TfNbLSKyf36xmVtGg8Gj/Cvgbq66UCx39nn5/BhExjKMTY/m9AiCrpLXBXIV5MTvU519BacI+Q1/H2sfEk+HeF1/c6beyCDfwzhxhTcqx78scHcGlSmatUva5q8DXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oq97h7DH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660EB1F000E9;
	Tue, 16 Jun 2026 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623629;
	bh=8YMGb7Mbmo6vTaGX0/GM7b8k1ngEIaISIV+tv3t5Lwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oq97h7DHnWHD+ZaZzts6c8omZte9G2HVOi+BAs47SlszgAhrYan19eFeqD2Rjb8Vn
	 kKUYFIfnhzT++gfRJaw/achSeeUext1ty0nErepq8dNYg2RoHRq7YIFKLCh2Byf+C5
	 s1BynaxqwPHbTmgbl9rnn3a6ht0zdRrMvmiXY0XA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH 7.0 178/378] accel/ivpu: Add bounds checks for firmware log indices
Date: Tue, 16 Jun 2026 20:26:49 +0530
Message-ID: <20260616145119.752063585@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264005-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andrzej.kacprowski@linux.intel.com,m:karol.wachowski@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59C84691268

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

commit dd1311bcf0e62f0c515115f46a3813370f4a4bb1 upstream.

Add validation that read and write indices in the firmware log buffer
are within valid bounds (< data_size) before using them. If
out-of-bounds indices are encountered (from firmware), clamp them to
safe values instead of proceeding with invalid offsets.

This prevents potential out-of-bounds buffer access when firmware
supplies invalid log indices.

Fixes: 1fc1251149a7 ("accel/ivpu: Refactor functions in ivpu_fw_log.c")
Cc: stable@vger.kernel.org # v6.18+
Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Link: https://patch.msgid.link/20260529115842.135378-1-andrzej.kacprowski@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_fw_log.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/accel/ivpu/ivpu_fw_log.c
+++ b/drivers/accel/ivpu/ivpu_fw_log.c
@@ -98,6 +98,11 @@ static void fw_log_print_buffer(struct v
 	u32 log_start = only_new_msgs ? READ_ONCE(log->read_index) : 0;
 	u32 log_end = READ_ONCE(log->write_index);
 
+	if (log_start >= data_size)
+		log_start = 0;
+	if (log_end > data_size)
+		log_end = data_size;
+
 	if (log->wrap_count == log->read_wrap_count) {
 		if (log_end <= log_start) {
 			drm_printf(p, "==== %s \"%s\" log empty ====\n", prefix, log->name);



