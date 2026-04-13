Return-Path: <stable+bounces-236668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHHRJaQe3WmSaAkAu9opvQ:T2
	(envelope-from <stable+bounces-236668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53E3EFE75
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB603286CD8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A773090F5;
	Mon, 13 Apr 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XgckuaFy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564CA2FE056;
	Mon, 13 Apr 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097497; cv=none; b=Q0o4fo7h4pbmoujYlTqgITTO2GHJ9izoP8tXklcn1596VKvuMGwCSn9AeWqPSsnk5u8i3vRA0dKHqo4HbsvudNtXhosH4uOPbsziTohLV8apJlmC5sry2V3XNJpEssLrzTJhDGqeygqJP3BfHnIwW8/bz3j4GmDqMmQGWOvBDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097497; c=relaxed/simple;
	bh=byshTumN3VAZty13dbfoa9Skz8S/JIz40EFjizIhz1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdwx7tNarAientOPlq4iALGECQ++GZcCsrRsbW0A8+l50CGze1u3yJMn3lGUxMyCvBH1MmovQ0xLY0y1dBJxAPxJLxkrbnjLviBAl0mHP0xP5pb7/AijmIHY8j0+d5l+vN9/X6T0ctlMCAM/UGJ5texRM24ovskJjatakq0UHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XgckuaFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DDEC2BCAF;
	Mon, 13 Apr 2026 16:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097497;
	bh=byshTumN3VAZty13dbfoa9Skz8S/JIz40EFjizIhz1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgckuaFyZykfa7FrvYjCcdQudgt+idgZfbtt4ef3tSsjCncAPiMWFrIiwCGAeIZ3e
	 bwZMQXk1610jb9/HBEQZ4atKsYeN4Ldcf3My6Y7FtP7LOPy4alfPqv0q3Pni/fqR7k
	 O4gJRREN6AXr+XqqC9Fodq7GymaPxX0wTJDdyVNE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Casey Connolly <casey.connolly@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 126/570] ASoC: detect empty DMI strings
Date: Mon, 13 Apr 2026 17:54:17 +0200
Message-ID: <20260413155835.163178470@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236668-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 4F53E3EFE75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Casey Connolly <casey.connolly@linaro.org>

[ Upstream commit a9683730e8b1d632674f81844ed03ddfbe4821c0 ]

Some bootloaders like recent versions of U-Boot may install some DMI
properties with empty values rather than not populate them. This manages
to make its way through the validator and cleanup resulting in a rogue
hyphen being appended to the card longname.

Fixes: 4e01e5dbba96 ("ASoC: improve the DMI long card code in asoc-core")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Link: https://patch.msgid.link/20260306174707.283071-2-casey.connolly@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e406c896a511a..af8554e96035f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1665,12 +1665,15 @@ static void cleanup_dmi_name(char *name)
 
 /*
  * Check if a DMI field is valid, i.e. not containing any string
- * in the black list.
+ * in the black list and not the empty string.
  */
 static int is_dmi_valid(const char *field)
 {
 	int i = 0;
 
+	if (!field[0])
+		return 0;
+
 	while (dmi_blacklist[i]) {
 		if (strstr(field, dmi_blacklist[i]))
 			return 0;
-- 
2.51.0




