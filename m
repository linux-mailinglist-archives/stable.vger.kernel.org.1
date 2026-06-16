Return-Path: <stable+bounces-264084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fw1CArhuMWrLjAUAu9opvQ
	(envelope-from <stable+bounces-264084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:41:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8746914CC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:41:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Zz8ZCtKN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264084-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264084-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35F3F3027E43
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A524449EB8;
	Tue, 16 Jun 2026 15:34:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7844103D;
	Tue, 16 Jun 2026 15:34:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624041; cv=none; b=kFckPzny2++Q0JNHLhe1EitdYbEcV8ikuynb0INiefK8wOgqAfNDN9GoG/TLKrAGZDIbDjGaWiqMXkp6m6TwMI8ROt63F8sj2F2WVK8ugw48u7MHt2TVTi58UOO0GomJXuEwssxOGLqtcoujCK/10qZezFDd8ZPHo9GMl+nRUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624041; c=relaxed/simple;
	bh=sPUisYzHzQnGa7mpr/6pLvzRcsq2WZ3GaUvY3+QMqF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=copO809dP4mJu4etR+D6ARTWtl4Kt/TbWGc50GZb58RPpo165NTPUkeIY31FgieJrPUz8g7b7a5AVciwP5XxhWl8icrNv7hhLEKHFPUqobPG6JmDI2hvxi6+xTgpJ7n22qdND5hdsTVqtX42yDfw3cK8lpUGjsTngi6k9zn8HP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zz8ZCtKN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3E61F000E9;
	Tue, 16 Jun 2026 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624040;
	bh=pUILRBKow2w3XypTcST4gqdzaV2cJX0nAvMB6ddJC9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zz8ZCtKNfj0PWfPbHaiPyqP74Vhx32Ziu6eaqtsM0fQFePcZFhxB+fRw87dTNB3Xy
	 wLwgyroha3HJ4MmjV9RwZ+CZV7LodlxtGjw+Wjq/obWf58WzF9csNn37o54k4oWBZ4
	 jvbRcUUuPHprkeSED9Cnmek0wc/E8fFQt4t2jil0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Muhammad Bilal <meatuni001@gmail.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 7.0 261/378] accel/ethosu: fix wrong weight index in NPU_SET_SCALE1_LENGTH on U85
Date: Tue, 16 Jun 2026 20:28:12 +0530
Message-ID: <20260616145123.830130420@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264084-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:meatuni001@gmail.com,m:robh@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C8746914CC

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Bilal <meatuni001@gmail.com>

commit e703843f242b28e35ac79408de571ae110c740b5 upstream.

On non-U65 hardware (e.g. U85), opcode 0x4093 is NPU_SET_WEIGHT2_LENGTH.
The BASE handler for the same opcode correctly assigns to
st.weight[2].base, but the LENGTH handler mistakenly assigns cmds[1]
to st.weight[1].length instead of st.weight[2].length.

This leaves weight[2].length at its initialised sentinel value of
0xffffffff and corrupts weight[1].length with the user-supplied value,
breaking the software bounds-check state for both weight buffers on U85.

Fix the index to match the BASE handler.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
Link: https://patch.msgid.link/20260523210840.92039-3-meatuni001@gmail.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ethosu/ethosu_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -601,7 +601,7 @@ static int ethosu_gem_cmdstream_copy_and
 			if (ethosu_is_u65(edev))
 				st.scale[1].length = cmds[1];
 			else
-				st.weight[1].length = cmds[1];
+				st.weight[2].length = cmds[1];
 			break;
 		case NPU_SET_WEIGHT3_BASE:
 			st.weight[3].base = addr;



