Return-Path: <stable+bounces-238659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNZkENg75WmTfwEAu9opvQ
	(envelope-from <stable+bounces-238659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:32:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AAF42576E
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CBB73038AF8
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2926E30C343;
	Sun, 19 Apr 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeYA0Uzv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814F28850C
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776630694; cv=none; b=aH2/Tx2l4LfeGMdqiN48LHL3vwv/L84QDnqIGOJbvl9qkLTD1GA09ktDhZpmtCgtb/3fbF3HD7Tcnc+RwkQIeyFixh8uciUEKexrz6lrBhZ8dxddFiy6SaxdnX2RZZKJLO/ovUMXD1VbT6sxYBEE8cb6S4q94+8L6PMbidsFe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776630694; c=relaxed/simple;
	bh=FWL9iHDXSYoluckJLB911JktohnLlx+Aco9CRYvp9OA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4rQN5vIuEClO9rBzy0ipFuXdc0e2+A8e8u8Iz5gd69xQfTMQ7M6g1d7CI+zqo///13rTmLMCQza4l+JHzam49yiWlD9+CrQVQsTmLl++CK2ROw6SP84kKVGkFQvj/86XSbWmUXRmuyHZ0XlJ/p4zP3L93UcAa0RstdY0hYjwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeYA0Uzv; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2d8fa0fadfeso1187891eec.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 13:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776630692; x=1777235492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adKZuyxQZ1V1TuZoH3DUI0I4OUtCX6ISr2mcieCFENA=;
        b=NeYA0UzvCEP/CZ/zLr1rpcWe/E+FTlnyr0wmDkQAyEAlTOxqsngZKziEtZ0YMcGg3p
         a0R1gRs8kSokBOeABiUFIaCJtjuUfncgdIy4J1I7kKP1HAd3ZevGKnVu3gwNP+9nUa6i
         E/oCcsJR4BpFvG4odaZQLrWb+paEeGBdXn1k+hla5kr4UeOx9W88xytWfkY/Zeaqpt6L
         6BxIMie81iqyMxI0Ri85J51yC9CnporLktnIkmwGam02XgkvPsxotKhxOVwOlXSbTCxi
         yVwtPPWuqIztaooWlippGGTyOa7qh0CP/anhpJSdf4qMERYVUeW9KtOLF8Hv9JrcKjcX
         ESQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776630692; x=1777235492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=adKZuyxQZ1V1TuZoH3DUI0I4OUtCX6ISr2mcieCFENA=;
        b=Xr5VOXShu3MUsYw+30IxlcYAAOdZqH2FALYnrF7TGXZ7bJOi1C5r1ulTI7P86DAdKG
         9HI3ktAFY2qJCMXCy34pWb97J00g/k9lmlZ04Nz1Dka3Lb1qpxCPV6I5C3x51KLCVwVD
         XlQ2P2l+EvmwLO+fuF2nsh6ex4weypzzBwgTn8oXTOjS4W5E2MUeqpqRc4qCcEcHFv4M
         PpZEWTuv7PX0CDI5AaY1reNyEgqbiH3DSsv7v2lCnd4JUeo7y98pAtJKLsczDlOS/o3o
         wmrF3Ag58oNcZu8WTIf6rvffRZ5V65To4bHWjRSa1Pyup6PmkdnDvgVV/rbnALzdfI6E
         bKCw==
X-Forwarded-Encrypted: i=1; AFNElJ/WTlW0gIToR3liwPO599s9Ox/PS7y9cZceKJvO9062GtxX66cMwHybmDp1jjQJgrGnslxEG7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Qg5psKjw4bzg4+xY3pzeaeFP9B8fuwgOJ5kjwnupIyrWi2hd
	jUDIBDHglKSfAnMOBdRutDCeoohV1GNpaUBINAGx66JVjdGv1igkPazp
X-Gm-Gg: AeBDievZzaqcgERH3B07gO88WOCDeB1BftGmbh8O0uHiq9HRbm+IRllBljSkrvPtznT
	pwhoHEpf5LNH/L1ABRZahYR7X1uyvlMv8p6sBOzVOi3GZrxqmXnZ7IcxrefDJq0aHmeCfg1Z684
	82qY/P5jpsuHkChs4ov9FnO86cUJWsMoIKWoKlfcRSy6Ea0AJvmnQDXo4z7mTWlNq356UK2Ys+F
	vtB/p1omiIqUpB8Z8H8tYmRlGZInFj9V6wXcuLiAA7NuXEF5VwZLKjdDrQFEwM9vjkGlzEA0Iku
	k8G30OF8dmPqUo4uNdjnzq0Amuv5F9Wuu1CLUPp9IHTG+WsyN1I5P8WrzIuNw0VlpCMpRemFWlW
	ChOzd+Wp7AzxWelDWlgYPM8epyB329CKIUobYGaTCwwZbpZ4Rde9KOnrEfh0lLVuqX+69q1ZVhc
	w5Ex/szh0IBoHOUwjzrN70Pw1AWKFYgENLv5DZWp9PtWiXmhZJtx1R2t0jzgMw1vt3dVXBSIszj
	sBngUD/dzOxBA4=
X-Received: by 2002:a05:7301:1909:b0:2dc:e6fa:317 with SMTP id 5a478bee46e88-2e42dbffd65mr3036275eec.11.1776630691763;
        Sun, 19 Apr 2026 13:31:31 -0700 (PDT)
Received: from [192.168.1.18] (177-4-160-195.user3p.v-tal.net.br. [177.4.160.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm11419096eec.13.2026.04.19.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 13:31:31 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Sun, 19 Apr 2026 17:30:30 -0300
Subject: [PATCH 2/4] ALSA: usb-audio: Propagate errors in
 scarlett_ctl_enum_put()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260419-usb-write-error-propagation-v1-2-5a3bd4a673ae@gmail.com>
References: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
In-Reply-To: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
To: Takashi Iwai <tiwai@suse.com>, 
 Chris J Arges <chris.j.arges@canonical.com>, 
 Detlef Urban <onkel@paraair.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=FWL9iHDXSYoluckJLB911JktohnLlx+Aco9CRYvp9OA=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJlPrWd2H2+4PG8yo8H0aN5O7S9WC6UTizm+r5Lj4W34+
 EFj2ZGwjhIWBjEuBlkxRZbVSYss93Q9uFoft8IDZg4rE8gQBi5OAZiIXxsjw9UVi8Pv6xom/DCe
 k6HXo7TXRsYlQbxykXTHoUohjRmWGxm+KRh8sHjdPmcvO9uzXVp9u179EQ+q8Di/6LlM9ibbsDP
 cAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-238659-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3AAF42576E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

scarlett_ctl_enum_put() ignores the return value from
snd_usb_set_cur_mix_value() and reports success whenever the
requested enum value differs from the current one.

If the SET_CUR request fails, the callback still returns success even
though neither the hardware state nor the cached mixer value changed.

Fixes: 76b188c4b370 ("ALSA: usb-audio: Scarlett mixer interface for 6i6, 18i6, 18i8 and 18i20")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/mixer_scarlett.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
index 1bb01e827654..673eb8d8724d 100644
--- a/sound/usb/mixer_scarlett.c
+++ b/sound/usb/mixer_scarlett.c
@@ -680,7 +680,9 @@ static int scarlett_ctl_enum_put(struct snd_kcontrol *kctl,
 	val = ucontrol->value.integer.value[0];
 	val = val + opt->start;
 	if (val != oval) {
-		snd_usb_set_cur_mix_value(elem, 0, 0, val);
+		err = snd_usb_set_cur_mix_value(elem, 0, 0, val);
+		if (err < 0)
+			return err;
 		return 1;
 	}
 	return 0;

-- 
2.53.0


