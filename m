Return-Path: <stable+bounces-230669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCibB2GUxmkyMAUAu9opvQ
	(envelope-from <stable+bounces-230669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:29:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F134612A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB2DC3062D8F
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448AB3F2110;
	Fri, 27 Mar 2026 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sISg4eQI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418673D3497
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621740; cv=none; b=WBZmMR0Rtht65/FFousjaI4CJqktRoJwzhi1A59sLefpXHGNKyToQOyTnfxEL46PFD0oTRdmPqEzZiHpGGYjsLcTEnf27YmV0RIcEqj5zgH/TQuyGjbQ6YbKjnK78BFb8npmpHvY8q923sPu3Tfz2+O0iOuLFiaeaGVlmZmA8gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621740; c=relaxed/simple;
	bh=itCE97GetdjhJ1mCFZ8r6FCd3SfvCLfAVih8FSZBw94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+HPr75UNyRKTDmlrRFcoXyIMaC2mX0Chahju7pdTlSa//a7XYjS0OtavRqt/h204e/N60fd63ACe1Lwrq073gpBR8uz3i8cVs1PK2vprQF5Yt5pi7jRo9BmKlR4Zdyj6cj5tT0CUYnpOzyxopykkibk23oPB5tPhwZVu8yDyG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sISg4eQI; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c2af7d09533so1692550a12.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774621737; x=1775226537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUSU1xSC29TgfkGjkqsyqB9Aeajan9NX1aSuNMNNxok=;
        b=sISg4eQIZxvdsxRv8e4V/1ROJ6EHij691xGx7tD3pNKWovPfI+EJGve+CzrTka9aRo
         Qtbydh10fpkK20aQEUHYKTaok8xmt6ZbX34qYEPToLYQw07SZD0XmVjts4AwlBLeQkFy
         qvF3/FrDEhSqlbuXk4zSiI1VMF5BNTWrj54fwjVw2TL1/Lw9azFKVktexJSi7XcIRjY8
         am+fj2Ono7Y0/BOgtky+HT2BHmsdDKKMB3ykNc1FuI54Y5TIJU6c04YK1jSAyIGCbRYQ
         8HwPbjbEfZDEazjQY7/TmjPDSNliYVyKUHv95XBDsv5bH96AfjbJdDyJlPiTxsAsRlTl
         63Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621737; x=1775226537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cUSU1xSC29TgfkGjkqsyqB9Aeajan9NX1aSuNMNNxok=;
        b=DPfFlyvZbNHw9vtXvxb6R32yRyKMWjKViIvV2SYJtJ9fByzJ4oLSl19BgC7IdDMGcy
         7Ee8HdBi/0TdwYhKs7gQBLkJWM9aBXn87+U2J0Q+u5SEOJMZTHZKLVyO9Tyi4rheurjy
         TOxLgPdFwtxcvjwUhbONJja6gbGueOxa3ER8zeXZOF9iSHIdIlD2keC1ynCXrC7DywI+
         MfnIKxG1X6Nt3cmu19Ejx4egAvWqaUjgb7dH3l6muL+LeUywFJmYC1IQrUlwNyo35MWx
         UJILnO/PHXuV3seAbY+aPt8GYTbcpf8kCRLADCwAedQhmc1Nn9Cun7O5j7dH7cZjgQkh
         lCUA==
X-Forwarded-Encrypted: i=1; AJvYcCVwElILe1Qo67nd/dpn8V/amg1WP81xTUWxBpBjQeXT29ZuLC1bqmV2auwHd86b42WR1FzopKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Z0md8rZSHQsMes/ksSlZicz0NLJrLdGWuAf3RtQeE9uYqAlo
	Kbyr/vKixowXUBVEvFfg6GYMBdzuULrzcfI1Msc7uwW6WYwz1/O/fO2G5Cg44g==
X-Gm-Gg: ATEYQzyy8X12LUO3bqhdQwayBHYYz08cYuXpZEtY3piUmMgOnajOxWAFDtLSAXtI9fe
	qUi7xDgP5VgJzN8USZYAnTmbd0UsjnSoKMu0SWoNsQO1FvOZ7dJj4kWqDDfdJCrc7QTXiMkfGs9
	UIoEn03AcDE/s399AG6+S06iudMXCJKGKnAXG8b+/Az4JsdAkQsXfTZ8Ra9FGLjyW4sssURkp9B
	SXqxxIixFdYBLElGi/AQzNOSZV4PfVlEsNA+iQipvO7WAmQ4OvGxDOU/c1z3symBUf2leZnAyM+
	vbhsYMy1XaIzCp2w8EwajzuxrhecA6hqfX6hNAdLulyAZycy1Zq4lwHCF9azQG5km14YGSD83jN
	wRTUI9U2oUmToeZ9DNjWC8Y53RbnFSER30WRn2PNJtkQxCXsBi6QG+qJEFuJsXQ4+KLHtrZRiZi
	PofpjsjQ2w5Xc4/iM+KjIsPzWVO3WdDTYq/xV6J6OtACBG
X-Received: by 2002:a05:6a21:32a5:b0:398:8766:4d0a with SMTP id adf61e73a8af0-39c878aa568mr3193205637.19.1774621737176;
        Fri, 27 Mar 2026 07:28:57 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e2:1a2:687:d90c:7dc8:7860:bbd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76737f28d6sm5557230a12.6.2026.03.27.07.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:28:56 -0700 (PDT)
From: Sourav Nayak <nonameblank007@gmail.com>
To: nonameblank007@gmail.com
Cc: greg@kroah.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	tiwai@suse.com,
	tiwai@suse.de
Subject: [PATCH 1/1] ALSA: hda/realtek: add quirk for HP Victus 15-fb0xxx
Date: Fri, 27 Mar 2026 19:58:05 +0530
Message-ID: <20260327142805.17139-1-nonameblank007@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJ9UwXAYD2PwdBnt=hFKkbKUTm9kY8zXacAgE6zXDKOLhBKmKQ@mail.gmail.com>
References: <CAJ9UwXAYD2PwdBnt=hFKkbKUTm9kY8zXacAgE6zXDKOLhBKmKQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-230669-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[nonameblank007@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB2F134612A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This adds a mute led quirck for HP Victus 15-fb0xxx (103c:8a3d) model

- As it used 0x8(full bright)/0x7f(little dim) for mute led on and other values as 0ff (0x0, 0x4, ...)

- So, use ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT insted for safer approach

Cc: <stable@vger.kernel.org>
Signed-off-by: Sourav Nayak <nonameblank007@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index ab4b22fcb..7f3e88999 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6954,6 +6954,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a34, "HP Pavilion x360 2-in-1 Laptop 14-ek0xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8a3d, "HP Victus 15-fb0xxx (MB 8A3D)", ALC245_FIXUP_HP_MUTE_LED_V2_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a4f, "HP Victus 15-fa0xxx (MB 8A4F)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
 	SND_PCI_QUIRK(0x103c, 0x8a74, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.53.0


