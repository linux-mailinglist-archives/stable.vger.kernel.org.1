Return-Path: <stable+bounces-239507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDkpDyZl5mlmvwEAu9opvQ
	(envelope-from <stable+bounces-239507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:40:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D73431CC0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7C5335A86AF
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EFA332916;
	Mon, 20 Apr 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cSLQqqh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAA2D77E5;
	Mon, 20 Apr 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700430; cv=none; b=YfCXICOcdIFJhXNi8wC3FLD4bdUE0IPnndJtiR+EM1WxCZUayep/vylcHtQfkmtD0QrgYYKX/4UeNB02PwZxO/4iPamMoOHYdqBN1IouM2IOD3pIPIHX7Z57G80BUnRxJ6zMnJWLzM+jmecaldI8FkVJNOQW/WsviVB0pZlqVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700430; c=relaxed/simple;
	bh=yoJqo52KZjh3bhnidofb7s7oSzNqOyTAeB1s8qTa/Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDNPQHj8mhuiP8zU/C6/NJrJrqR0QEx8ObIAVds7ua8norxHH0B0nV7DnR8ehK+Ubhcwjl2SHZp5lVocOPg9C/K7a/C97GRN5tTNR7r9MVZBM0aJcO79Tn/KSkBjjFyxfeQhFq79W4BX6pebqL6+PHgPRovN+am77sREOom/RMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cSLQqqh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A946C19425;
	Mon, 20 Apr 2026 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700430;
	bh=yoJqo52KZjh3bhnidofb7s7oSzNqOyTAeB1s8qTa/Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cSLQqqh0xwUMoQLqsxS0Po4gPHOc9k2gMv9EAhOd61ssidP30L9ZX1YFBAbLzUY3D
	 X0yNCQf+a/yrPB2+ckD9k1mVyk6LTlRmm9su0vWgX8yUpJY1Tq1Si85y8iihBthtw/
	 wVo//II+a+QPuTd9RzcHLD7QcNoAMYbT/rjxKpvk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bernie Thompson <bernie@plugable.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.19 169/220] fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO
Date: Mon, 20 Apr 2026 17:41:50 +0200
Message-ID: <20260420153940.111792709@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239507-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,plugable.com,gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,plugable.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1D73431CC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit a31e4518bec70333a0a98f2946a12b53b45fe5b9 upstream.

Much like commit 19f953e74356 ("fbdev: fb_pm2fb: Avoid potential divide
by zero error"), we also need to prevent that same crash from happening
in the udlfb driver as it uses pixclock directly when dividing, which
will crash.

Cc: Bernie Thompson <bernie@plugable.com>
Cc: Helge Deller <deller@gmx.de>
Fixes: 59277b679f8b ("Staging: udlfb: add dynamic modeset support")
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/udlfb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1018,6 +1018,9 @@ static int dlfb_ops_check_var(struct fb_
 	struct fb_videomode mode;
 	struct dlfb_data *dlfb = info->par;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* set device-specific elements of var unrelated to mode */
 	dlfb_var_color_format(var);
 



