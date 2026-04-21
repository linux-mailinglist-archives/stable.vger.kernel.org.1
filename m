Return-Path: <stable+bounces-240091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEIlODk652no5QEAu9opvQ
	(envelope-from <stable+bounces-240091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:50:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CE438600
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BA2A300D34D
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74C3876A1;
	Tue, 21 Apr 2026 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGyex/uU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17D2AF1D
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761397; cv=none; b=A/IQU+WHdDornUQ/PwBd+EDTABdL41JyeUxhFvu4r9f2IZD5KH8I1QGAgdm81tEwnZ3jkQCMiAEd/SakeGKb7X3smEcUuT9j9w68RWSBGPI133vIxAkN3mlmR0oPJjDjbacg4EE1I8h0ISZi+B5RUBp84j11DMM/bKLI/6f6jyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761397; c=relaxed/simple;
	bh=ilTd8G6rGzWSYiPXW0gzw/K+PrTHWdJYsdsOd+dPDUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXetbjI12GRp8M6Hob7RuksU56yknfq9SVPnCkESrcrGMiQdhfq1kBkCzt4183bZ9M4I8ViPQaP7vGKAdjADnw9n4CcXhHHYPYcakS2Bc4JFUD7Rix7VRaEqCAH2+rVILOQRa/1zgu4PCq3S8xwK2aMcKO2ButYiqSvvZT8jWxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGyex/uU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b150559bso31023375e9.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761394; x=1777366194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6n++iIdotMt6CGRY5H4br6XbDJigW7PJuq4uyuIolAg=;
        b=EGyex/uUeAITQJUif3DYxYdLL0Gs8QZVjc3MlML6wHCcsZ7MzTESRyFRNi5r+LbzkJ
         r5bFGYScuHL2bC0cfphqVtcFQw1rgkUo++uAxNNxXue7/xQb9G0HQY6YO8D7Gztw8Al9
         DxLeHiu8KM6hVHPg/8ubRBCjT3WcepRQq46ojNmL57GYFagjRwGQnP1p1XNIRnOjpHnu
         DJKhZr0XA4F6lD2uEQAxXIHVP1gEN3G3NQn1calC7WKy9X93V4Y31CwTALescYiWjWiV
         N2Ujyw21RSCrEaT3pdO9C3UuXtiyWg49xvWqzdxHqVN2cKs1v5BXoOTX/SG4iBWHduBp
         YOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761394; x=1777366194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n++iIdotMt6CGRY5H4br6XbDJigW7PJuq4uyuIolAg=;
        b=EpSHm4JoEYP3+QDoPggK+Vyv3dg3YP+Uh0CNKpqaaBQHxz2Kr4/81ycPTYLWtfL99y
         azsA7zEtUopK/wO2QeJRMYkgwk0PNOnLmnhm4QibmGMSe8EcLifyzU8vYqwoDtq6mlIK
         onNLooQKYGYSGaOV4WEeoHv4zXQXr831nd3ca9TRkl8s+emdCpzJ0GuMgTcfbRKKYHy/
         BgUFdMEdapp+vHu/DS0kZZ4NqfOObadqEm9gJa7xe1QkSqoehKFV3bPCauUhXk9rhP9A
         HSsOn0yu1wQFAJZqojuNfINevKcOLiGktdJL9iOA0D8x+FcDa/iQ7OyK9YYvAFaF6vNL
         e/GA==
X-Forwarded-Encrypted: i=1; AFNElJ++/UE5Xq6v5dVRb/pfjHi4QLTar+Xi0pbud0nI3AsuzLiPdjVlI+Oxl13JnTfZe/0zDTKbzxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWgqM79K9S/WDiwyWesgdd1Cb+75bs9bd14J/05+M0640apQNx
	A+R/4e6tWsYNGhr6EsQN+MYDmeXJXZK3TSnH3MtDPkUEF3ho9tBAq/Te
X-Gm-Gg: AeBDietAEzVmpJvxwPI24rl7rw8+tvuiLqZpL1lFUDilI4Q9MXnY8DNx+sWDHT1/F4O
	TpJ4SLM9Nzcm2a9BdtI65QUb3P6H4pTggD83QeQuHqeOnQNHM/YhdFm80ScMl3N2wt6tKWnZrzJ
	jUoL9nAg7KPEuj0pqTA4HMI5GxZA9s4YLkEmjuIjXDq2rdoyiV6rOs7C2cEeZtI4pt5fLBYVA0x
	4TpVNju5yVyu1sJDBmhGHE3mRs2aIHJbEs1cePdF54K661h8atYTbvhEbKDbBSF49gMXNOghMVw
	3P0/kum4zUF5oYOOfNzXnMSPbLs4tMsY+zIhCJvs6cloT64V6bvi30jwoxIYxXV2Cd2WK2+Y27t
	trn+sr4GmrJm5SJzqUASm2yla5w6OjKjax6lc0/rZwOSL4Otj9WCQ/TvYixfr4f7XxwQIN8m6xs
	nt1Y5yQx+1WZ8g54wC3x3GypwOaUbzHYQpElS5llnwkkS+ELrYVxDemhyzRIsKgC8NS40/H9Sqp
	XjlsyiqYWLhycL/Z+r5b5xY
X-Received: by 2002:a05:600c:c10a:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-488fb771613mr189503025e9.18.1776761394058;
        Tue, 21 Apr 2026 01:49:54 -0700 (PDT)
Received: from Friday (dsl-197-245-177-193.voxdsl.co.za. [197.245.177.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c68asm110715915e9.3.2026.04.21.01.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:49:53 -0700 (PDT)
From: Spencer Payton <spayton681@gmail.com>
To: alsa-devel@alsa-project.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Spencer Payton <spayton681@gmail.com>
Subject: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Victus 15-fa2xxx
Date: Tue, 21 Apr 2026 10:49:18 +0200
Message-ID: <20260421084918.14685-1-spayton681@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240091-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[spayton681@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E9CE438600
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The mute LED on this laptop uses ALC245 but requires a quirk to work.
This patch enables the existing ALC245_FIXUP_HP_MUTE_LED_COEFBIT
quirk for the device.

Tested my Victus 15-fa2xxx (PCI SSID 103c:8dcd).
The LED behaviour works as intended.

Cc: stable@vger.kernel.org
Signed-off-by: Spencer Payton <spayton681@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 4b6266536..98f218844 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7154,6 +7154,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d90, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8d9b, "HP 17 Turbine OmniBook 7 UMA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.53.0


