Return-Path: <stable+bounces-247949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFlBOeZEB2qgvwIAu9opvQ
	(envelope-from <stable+bounces-247949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:08:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FE8552B6F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE15322A31F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F2117C220;
	Fri, 15 May 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f3egFaEE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1E2EAB82;
	Fri, 15 May 2026 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860487; cv=none; b=GNwTxZ+d6/Yal+xzstEqlVp7+D4KvW9pFGF/KEpvvYQt+XSCW7i1iI7QYdGwzJ/LdVcDeSixeJSBLjsXH03RJqqlXYVZeCgZW7wVVYF6ndxW/GTAnobJkwZnGmNuqkaZbdB/EcByuHa8Tsc6rYaOlPyo39kke1cZcOkwitqTmd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860487; c=relaxed/simple;
	bh=Fvk9S0fgVDFfn7JhBx63fxMMnH75258kb8baZX7JnEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwQ5JXMJxGC+f6CIVZ4LW6ygYm9VlfJaez87hA0M3ClAVWYe5HVUHbfwdGcet7zcug1FI+x4N4OJ89+ALpd8mM9fzPIP24pSwXLAaGOZhlY2SIrmAkSrbalW/TsexztXethKvEmbrmY9zjven9SISkH0dxPC9RkGUBT+wTIeYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f3egFaEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA9EC2BCB0;
	Fri, 15 May 2026 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860487;
	bh=Fvk9S0fgVDFfn7JhBx63fxMMnH75258kb8baZX7JnEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3egFaEECO8En0cIYmOGWy9XClMD8wN/+q0qoWAxTarlx7zea1wzQZEW5SQbdUKY8
	 boL/FCUe+AiafP5JHmpYHwTumVJgQLlr4NdykZ4TlJy97T3RWYgChbhw2HbqM47Anj
	 gaYR4bHa4xBBm/569PRlYWDet4NHxCc/MAXSDAto=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Nemesa Garg <nemesa.garg@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH 6.12 066/144] drm/i915/psr: Init variable to avoid early exit from et alignment loop
Date: Fri, 15 May 2026 17:48:12 +0200
Message-ID: <20260515154655.077221759@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 58FE8552B6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,gmail.com,linux.intel.com,ursulin.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247949-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ursulin.net:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jouni Högander <jouni.hogander@intel.com>

commit 314f6179e370988ac00dadf373a4f6166eb3db15 upstream.

Uninitialized boolean variable may cause unwanted exit from et alignment
loop. Fix this by initializing it as false.

Fixes: 1be2fca84f52 ("drm/i915/psr: Repeat Selective Update area alignment")
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Nemesa Garg <nemesa.garg@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patch.msgid.link/20260413112345.88853-1-jouni.hogander@intel.com
(cherry picked from commit 289678a90b8cf81e3514c9d6c667235cd39c7acf)
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2624,7 +2624,7 @@ int intel_psr2_sel_fetch_update(struct i
 		return ret;
 
 	do {
-		bool cursor_in_su_area;
+		bool cursor_in_su_area = false;
 
 		/*
 		 * Adjust su area to cover cursor fully as necessary



