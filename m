Return-Path: <stable+bounces-235166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDboCLmr1mmmHAgAu9opvQ
	(envelope-from <stable+bounces-235166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1003C2F4B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E333830F5ABB
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45F37F01B;
	Wed,  8 Apr 2026 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xm+n4Q/g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E03176E4;
	Wed,  8 Apr 2026 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674739; cv=none; b=LTm4DS6T5qAlETdd5zdlLpEmVe8MJg7vBnaeue2VZuT7i9tRNX77WSm533KVhUD4umcL6a320zpZOrH08bbUpSBwGZahe39zA7CXgvc8sgcFvNHqm1F0Kv8Q+RbNfPsaDbkyDthKmhIuYukDzWpT5aZz1WkEWNjCAk+h8OtAQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674739; c=relaxed/simple;
	bh=4IgkMyQ79IxgTkjkpH8numRZmLlfvyodtiwFjCP3HAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk178DTj/rAOZYGSg470Hx0HXqg/TwgXvWQvUJYwcaClS5lbF/6vA5q3ODHMPxVMzHpxvVDYvpHBf+RqKy7Gko2yq7mIi10QJ2DSgctFT2C2emWj4zc6R/G4Cr2iJJD+Lc9jDv9EQCz1iLIMBFZ9xcdhLJP9+lkzHV6XuENuOd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xm+n4Q/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDECC19421;
	Wed,  8 Apr 2026 18:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674739;
	bh=4IgkMyQ79IxgTkjkpH8numRZmLlfvyodtiwFjCP3HAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xm+n4Q/g6pEpoHU/pXQOwTy/1/O28sOLZ4hCW3cI2ROQuSV6lG1jxiiohT0lmCPWr
	 pUOmn9FF2YI74KzvfovZYJe3Wsfbch57JS8CJg/ViaNG+TiF4I5Px5QZC9ijJ18va7
	 PpSnd7XWMdqU1kUteZxeOn6hf/A4t8YpdhxpUXUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Karsten Hohmeier <linux@hohmatik.de>
Subject: [PATCH 6.19 172/311] ALSA: ctxfi: Fix missing SPDIFI1 index handling
Date: Wed,  8 Apr 2026 20:02:52 +0200
Message-ID: <20260408175945.830149342@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235166-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hohmatik.de:email]
X-Rspamd-Queue-Id: 6A1003C2F4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit b045ab3dff97edae6d538eeff900a34c098761f8 upstream.

SPDIF1 DAIO type isn't properly handled in daio_device_index() for
hw20k2, and it returned -EINVAL, which ended up with the out-of-bounds
array access.  Follow the hw20k1 pattern and return the proper index
for this type, too.

Reported-and-tested-by: Karsten Hohmeier <linux@hohmatik.de>
Closes: https://lore.kernel.org/20260315155004.15633-1-linux@hohmatik.de
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260329091240.420194-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/ctxfi/ctdaio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -120,6 +120,7 @@ static int daio_device_index(enum DAIOTY
 		switch (type) {
 		case SPDIFOO:	return 0;
 		case SPDIFIO:	return 0;
+		case SPDIFI1:	return 1;
 		case LINEO1:	return 4;
 		case LINEO2:	return 7;
 		case LINEO3:	return 5;



