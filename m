Return-Path: <stable+bounces-252590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A/RINYmDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:25:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC6359AD30
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 002CA331130B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CE53C140F;
	Wed, 20 May 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k2sh8O0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662129B78D;
	Wed, 20 May 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301074; cv=none; b=nQN6AOE0mxgEZtbS32HAWPxz+2aVA0u0HfRyoK877pj2y0decaSRxhOoANfiWHT/PBf0hRB2kKWPxKIwjxWGqECWtm5RrpXNZe5z4nvvZuhD8pzEqxLtPhdh8K97iCTyuv27XB51pVaCy+pmUAIr5hpMSf8jFU3fpX2GAKFC13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301074; c=relaxed/simple;
	bh=CSgPiop/8Ln0wc30djhek9HQSnxNfIEa+TMMvoLyhlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6uarvJjv8o5R8q5R+QtHavM1bNNbSlAIMv6FmvO39i4rg2VBZDIgYfH7GX9V7PUv6lrNBYgPm72EYQ2rWnpSrQXNW1LN4oRrpwvjkd4sk2kIAkkB4Y2Qi+aiUQ3oi+qd9/BGgoI4eWi6yqBsClJWAts+KcjxXDdROJOBadeoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k2sh8O0j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAA01F000E9;
	Wed, 20 May 2026 18:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301072;
	bh=w5qyr8i1s2n8PkZmaQj3Gk2S6SJf0iIEuFY/qpBDONU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k2sh8O0jQCjwH6BVCNKU7eIcwAvmzJhTtEnETe5eDGS6eeIdeMsOjD/1QWe+hMxIb
	 nuNZhU4mabFhpdmw8BmHj2zZ+PvsK2S7DYf3tDAr83/ofEXFQx0W148/mphFHdrbZi
	 nnl2nvJ89e/odYz637HmQzgzsXkfX67V+8AsWVL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 415/666] x86/um/vdso: Drop VDSO64-y from Makefile
Date: Wed, 20 May 2026 18:20:26 +0200
Message-ID: <20260520162120.259094420@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252590-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,vdso.so:url,weissschuh.net:email]
X-Rspamd-Queue-Id: DEC6359AD30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 3c9b904f9033fb250db72d258bbdec791dc89405 ]

This symbol is unnecessary, remove it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://patch.msgid.link/20251013-uml-vdso-cleanup-v1-4-a079c7adcc69@weissschuh.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: d1895c15fc7d ("x86/um: fix vDSO installation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/um/vdso/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 6a77ea6434ffd..b3dfd60619e8a 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -3,16 +3,13 @@
 # Building vDSO images for x86.
 #
 
-VDSO64-y		:= y
-
-vdso-install-$(VDSO64-y)	+= vdso.so
-
+vdso-install-y += vdso.so
 
 # files to link into the vdso
 vobjs-y := vdso-note.o um_vdso.o
 
 # files to link into kernel
-obj-$(VDSO64-y)			+= vdso.o vma.o
+obj-y += vdso.o vma.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 
-- 
2.53.0




