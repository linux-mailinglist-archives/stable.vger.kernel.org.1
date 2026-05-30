Return-Path: <stable+bounces-256930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBXnGkYMG2q/+ggAu9opvQ
	(envelope-from <stable+bounces-256930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:11:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE960DFBC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 548EB30041EE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F149433F8C5;
	Sat, 30 May 2026 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mVh20xNM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20332BF24;
	Sat, 30 May 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157472; cv=none; b=E12laP1oUbwIeqP20sEEUWPK8N6uCFdbpeyz1nwQS6Q2MgqXOZgFW53UOVyCUR/iHIFj022PWhhZzyq/7KlstruWM74qiJs/gh3/1d5/PsQPB5i75WrX+bqoLn1ANuJceDhohJhGyHu2hEf/gfLxH8hO/26X3ifvdY5RHO/fOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157472; c=relaxed/simple;
	bh=xN7ijb5xDukfhd7kalFEVjLbt2ulgE/y5Dgm5JY8tXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDm1TDCZbmR2WDFCqWhAdGIDHSez8kgmAe0GAQjSHUjJ9D+GqcLaEjAXMMJtuyzcNhngOXmntyz9A6smw370X3ucULdiIaScSP1DqrrBfPLW4KmecnzBJZT+PWQbUDMsLnGWD2vk4bZfxS3xbM0hjCrY4GWgcV9FlgaTQwAeGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mVh20xNM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CE11F00893;
	Sat, 30 May 2026 16:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780157471;
	bh=sP1/6Dbl3yp2DgO9579g/oIAcBknr+o/GwgzEgffQj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mVh20xNMdHpeQqIl6tEHCp0+dvNqnDYnkkxKirSp0GxSlLn34RSIiNYCNx1f8PDhw
	 +eq5JWZ+RR85BjDFwsaMezZW/JtZBrj+z3+nXTnIQnPz+C4VZUoyZsK1e0xKsCZe9C
	 bYj83f+aMoJBANscr9UagYw5RM/ANfkVsHbza6hQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 001/589] ALSA: asihpi: avoid write overflow check warning
Date: Sat, 30 May 2026 17:58:02 +0200
Message-ID: <20260530160224.616308935@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256930-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,arndb.de:email,msgid.link:url]
X-Rspamd-Queue-Id: 17AE960DFBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 591721223be9e28f83489a59289579493b8e3d83 ]

clang-22 rightfully warns that the memcpy() in adapter_prepare() copies
between different structures, crossing the boundary of nested
structures inside it:

In file included from sound/pci/asihpi/hpimsgx.c:13:
In file included from include/linux/string.h:386:
include/linux/fortify-string.h:569:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
  569 |                         __write_overflow_field(p_size_field, size);

The two structures seem to refer to the same layout, despite the
separate definitions, so the code is in fact correct.

Avoid the warning by copying the two inner structures separately.
I see the same pattern happens in other functions in the same file,
so there is a chance that this may come back in the future, but
this instance is the only one that I saw in practice, hitting it
multiple times per day in randconfig build.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/20260318124016.3488566-1-arnd@kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/asihpi/hpimsgx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index 761fc62f68f16..85a354cf082ff 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -586,8 +586,10 @@ static u16 adapter_prepare(u16 adapter)
 		HPI_ADAPTER_OPEN);
 	hm.adapter_index = adapter;
 	hw_entry_point(&hm, &hr);
-	memcpy(&rESP_HPI_ADAPTER_OPEN[adapter], &hr,
-		sizeof(rESP_HPI_ADAPTER_OPEN[0]));
+	memcpy(&rESP_HPI_ADAPTER_OPEN[adapter].h, &hr,
+		sizeof(rESP_HPI_ADAPTER_OPEN[adapter].h));
+	memcpy(&rESP_HPI_ADAPTER_OPEN[adapter].a, &hr.u.ax.info,
+		sizeof(rESP_HPI_ADAPTER_OPEN[adapter].a));
 	if (hr.error)
 		return hr.error;
 
-- 
2.53.0




