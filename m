Return-Path: <stable+bounces-243834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECsXA/mv+GkdzAIAu9opvQ
	(envelope-from <stable+bounces-243834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:40:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3944BFDFF
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D4D1305459A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953A3E0C50;
	Mon,  4 May 2026 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iSOiB2FQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98453D905D;
	Mon,  4 May 2026 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904897; cv=none; b=a1scQ1FVhR4OX508l6nZ4YfjxvPadENWQy6r4AYU97UzjZXtb61LDS+Ujrjaz8RHFoOjeAi78K373Lpbe8aFEJEIKG7SLXkf/GXpQ8IvrmK4H4Q/cLVLymQgu+XgjjKxtdpJwMegjnMCmBQLlguo6VEi1JTGpgWbdD8BMFIzBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904897; c=relaxed/simple;
	bh=TpU+DYM9HfbyjI3USgPfD+/Snccb1z3EfriDArBMZy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF1P8NkKNhWZq4j7nuwduprVXup9R0TjqNI4dCqr8lSNGfIxOyED8QQjnJpgbpDoOi64CINb7flfAPhwlUAJY7rfaBCHp9a6ZVWTFP56ZrEwK8MPtbXzdfAhuzjWzMoWruj/Xcai3QeggVqwG5TZf7TzmLuxL6m1u0vG5a1m3QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iSOiB2FQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CC9C2BCB8;
	Mon,  4 May 2026 14:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904896;
	bh=TpU+DYM9HfbyjI3USgPfD+/Snccb1z3EfriDArBMZy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSOiB2FQPlbVfkl4s8oToH1eW+N7XsvMvj0KUBID1bOaITcq12F9KvC6Gcl8sQbR3
	 aTJ+r1QIJRuP5mmQ10nJ0v9ORut91XEVsALzSLZsVhUH9pKY0zWO+rA4EqKJdddA7M
	 uINTOqH10cnG3DyrHQeypQL8EEKRyYXV0Uu8+KCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Douglas Anderson <dianders@chromium.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.12 207/215] driver core: Add kernel-doc for DEV_FLAG_COUNT enum value
Date: Mon,  4 May 2026 15:53:46 +0200
Message-ID: <20260504135138.378131810@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: BE3944BFDFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243834-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,chromium.org:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

commit 5b484311507b5d403c1f7a45f6aa3778549e268b upstream.

Even though nobody should use this value (except when declaring the
"flags" bitmap), kernel-doc still gets upset that it's not documented.
It reports:

  WARNING: ../include/linux/device.h:519
  Enum value 'DEV_FLAG_COUNT' not described in enum 'struct_device_flags'

Add the description of DEV_FLAG_COUNT.

Fixes: a2225b6e834a ("driver core: Don't let a device probe until it's ready")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/f318cd43-81fd-48b9-abf7-92af85f12f91@infradead.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://patch.msgid.link/20260413195910.1.I23aca74fe2d3636a47df196a80920fecb2643220@changeid
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/device.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -507,6 +507,7 @@ struct device_physical_location {
  *
  * @DEV_FLAG_READY_TO_PROBE: If set then device_add() has finished enough
  *		initialization that probe could be called.
+ * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
  */
 enum struct_device_flags {
 	DEV_FLAG_READY_TO_PROBE = 0,



