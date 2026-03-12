Return-Path: <stable+bounces-225076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEHIHG8gs2mpSQAAu9opvQ
	(envelope-from <stable+bounces-225076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6C7278E06
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 619C53097BE0
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E04347503;
	Thu, 12 Mar 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HIMLkj8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D57346FCF;
	Thu, 12 Mar 2026 20:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346852; cv=none; b=S8dtU5JHm3+P+pkw7ctaSBcKq947BLevUm+VPfbR9EDD6D7sDEWR3OUU0o9LJZSX5l+QwEKPuFP8nx+6h2eBkq+Fvwr04dpxflnzi50D6wt4+zmK2rFI3o7CrnQ3qBbHog8EOEZmWq7XA6kgfzDcfJTxU7GwpuzJd57umX/guYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346852; c=relaxed/simple;
	bh=uQBgpCbHg8T+Il26Uj4zAPrCPxi7cHogrmFgnspGlp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nc2qKrBAoqE8lwHfjhuMI9WeZIh5q6T0SEMtmSkc+eFIww6lK98mv3+La/7c5D2UjlQRwhqwM0mtITNFPADVBv9G7XN3l9OK4w5uD9jCu5nvLfGNHQbE15nree+5d5YfEjUCovdpp4/J3JSmsdY2HGlknw4seI/6KMeA91tYNUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HIMLkj8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66741C4CEF7;
	Thu, 12 Mar 2026 20:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346852;
	bh=uQBgpCbHg8T+Il26Uj4zAPrCPxi7cHogrmFgnspGlp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HIMLkj8kR4kv9P+n9fybPuV8+Nd4x8YWkKRLuxL9PeH+UmF6R/NCN1eTtKeUWQyBZ
	 iEwDSLq0r6BHkEZ3LtLh5mO/814FE6st8CMADc0cdzxiK8ttnCn1MWuKNrtZvPNWcj
	 zkzTAnqfCZQWhE2wERzHXzqgCZyPhNhkZLHCqPJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olexa Bilaniuk <obilaniu@gmail.com>,
	Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.12 142/265] platform/x86: dell-wmi: Add audio/mic mute key codes
Date: Thu, 12 Mar 2026 21:08:49 +0100
Message-ID: <20260312201023.386297535@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225076-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF6C7278E06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kurt Borja <kuurtb@gmail.com>

commit 26a7601471f62b95d56a81c3a8ccb551b5a6630f upstream.

Add audio/mic mute key codes found in Alienware m18 r1 AMD.

Cc: stable@vger.kernel.org
Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
Suggested-by: Olexa Bilaniuk <obilaniu@gmail.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Acked-by: Pali Rohár <pali@kernel.org>
Link: https://patch.msgid.link/20260207-mute-keys-v2-1-c55e5471c9c1@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell/dell-wmi-base.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -80,6 +80,12 @@ static const struct dmi_system_id dell_w
 static const struct key_entry dell_wmi_keymap_type_0000[] = {
 	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
 
+	/* Audio mute toggle */
+	{ KE_KEY,    0x0109, { KEY_MUTE } },
+
+	/* Mic mute toggle */
+	{ KE_KEY,    0x0150, { KEY_MICMUTE } },
+
 	/* Meta key lock */
 	{ KE_IGNORE, 0xe000, { KEY_RIGHTMETA } },
 



