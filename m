Return-Path: <stable+bounces-247043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBSFB237BGrxRAIAu9opvQ
	(envelope-from <stable+bounces-247043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:30:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA7053B71E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 00:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9510430209FC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7539769A;
	Wed, 13 May 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=markus-kramer.de header.i=linux@markus-kramer.de header.b="Y7QpTBWv"
X-Original-To: stable@vger.kernel.org
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB105372B3C;
	Wed, 13 May 2026 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711398; cv=pass; b=uw7ppQqQ+cKPeCLMEn/IMlF18N3GQXE1AO6hNmJ2T+TEqtMcAzdr9fXnPmlSPtyVtEfQUmXnb+8U5cUMjzxdmE7XL9YXkaS/S/bhpF6yS+ZAfmJ0wKkrE8hs3+eelokncI+fV+BJcARt8d6qh8VBRA1PRQAH4gpqRyjIJ+nlxbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711398; c=relaxed/simple;
	bh=XPYG8f6X3agucnqnQH9p8A70G2UfOpiLftTI2X/gs7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOj0RTnahLQldFySxbFdQOyvt70yFhr/5sm0Pqi3IrrKhqbV0xiSsFsAYby4LJRmLYqvUdoE61HOVVloqIzKwNcrp7DplQjyfpzAeDBnE5y5Gj/wVhct0koHGTqAPffMmWn5VabLGFdvTIWcC79gHTlNLQcOaQAy3KKtY+1en2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-kramer.de; spf=pass smtp.mailfrom=markus-kramer.de; dkim=pass (1024-bit key) header.d=markus-kramer.de header.i=linux@markus-kramer.de header.b=Y7QpTBWv; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=markus-kramer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=markus-kramer.de
ARC-Seal: i=1; a=rsa-sha256; t=1778711378; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ecbotbO6Y9626ui30ovfCeA9ExzdZ0yBWNmtsNAkgN5S31dEtu9HHMXk5pGM+1LzMrMczxgNaEpadSrxkS7DH/j3TD4BcA4EKqoxY/shGwD2e5yGQmSnMZxxhi8T+Ix4jWpUuMqo8X9A/SlOA1msLbxRjZM6HucdYf7HAF5GnAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778711378; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Uuz/iCbKUjHtl+HMQAc9fDLbvMD3X4bXHgkahE169Uk=; 
	b=JOENk2NXp9jdtMegqDhVCmZXWpDxLbyt9E/9LzMhn2qzVspatiBPcBJwuB4Rm7lWcUDBSTrRo8HgaqONz/2yqaMMq5JfC38kPhVi+Eu6Xucg40/nOj5VRHQHjakVNswlx5GRd6sHprUNgq+tqAkNdL51mymZj8/hdPCYnZLSv70=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=markus-kramer.de;
	spf=pass  smtp.mailfrom=linux@markus-kramer.de;
	dmarc=pass header.from=<linux@markus-kramer.de>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778711378;
	s=zoho; d=markus-kramer.de; i=linux@markus-kramer.de;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Uuz/iCbKUjHtl+HMQAc9fDLbvMD3X4bXHgkahE169Uk=;
	b=Y7QpTBWvDVxzUJquAIDwzek1Fm8fI4vqxXIACzpumDH8RhQTelJ9xrFwHaJOR8bv
	e74JVL/xf97A+5fJfPJSe6IyUoqBgXTL9sx68eiJc2BY6LOVJSUNn6IiNYBZnRlphmc
	JOiF6a6hEKvA1S/TRRMXC6Gq139uhnoZl19IlawY=
Received: by mx.zohomail.com with SMTPS id 17787113764091020.441744321745;
	Wed, 13 May 2026 15:29:36 -0700 (PDT)
From: Markus Kramer <linux@markus-kramer.de>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Kramer <linux@markus-kramer.de>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book5 360 headphone
Date: Thu, 14 May 2026 00:28:18 +0200
Message-ID: <20260513222818.14351-1-linux@markus-kramer.de>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 7AA7053B71E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[markus-kramer.de:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247043-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[markus-kramer.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[markus-kramer.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@markus-kramer.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,markus-kramer.de:email,markus-kramer.de:mid,markus-kramer.de:dkim]
X-Rspamd-Action: no action

The Samsung Galaxy Book5 360 (NP750QHA, PCI subsystem ID 0x144d:0xc902)
has severe audio distortion on the 3.5mm headphone jack. Applying
ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET corrects the output path
configuration, consistent with fixes already applied to other Samsung
Galaxy Book models using the same ALC256 codec.

Cc: stable@vger.kernel.org
Link: https://github.com/thesofproject/linux/issues/5648
Signed-off-by: Markus Kramer <linux@markus-kramer.de>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 55bb98e2e..4c610842c 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7504,6 +7504,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc870, "Samsung Galaxy Book2 Pro (NP950XED)", ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc872, "Samsung Galaxy Book2 Pro (NP950XEE)", ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc886, "Samsung Galaxy Book3 Pro (NP964XFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
+	SND_PCI_QUIRK(0x144d, 0xc902, "Samsung Galaxy Book5 360 (NP750QHA)", ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc1ca, "Samsung Galaxy Book3 Pro 360 (NP960QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1cb, "Samsung Galaxy Book3 Pro 360 (NP965QFG)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
 	SND_PCI_QUIRK(0x144d, 0xc1cc, "Samsung Galaxy Book3 Ultra (NT960XFH)", ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS),
-- 
2.51.2


