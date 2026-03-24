Return-Path: <stable+bounces-230239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIfnMT4Rw2lKnwQAu9opvQ
	(envelope-from <stable+bounces-230239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 23:33:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D2E31D5B9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 23:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE741316C394
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 22:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3DC390990;
	Tue, 24 Mar 2026 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okvBS1fC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6633C6603
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391116; cv=pass; b=SMe4FA7BjhagFE7OdTeSmmhE5jKb/AS71B7kh3Gj7b2cDfAebOo1INwpj3sduzv1BR02oDDSiZyZLFAENFEZGb2uLNSpwl6CVE7PnRFjQrKT6jGMtY0raA51M8ZDgHGixe69xkrKE805l8V4P7UQYSxYyXkOC1nVR/vrstS9Slc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391116; c=relaxed/simple;
	bh=cVVW2ha6HCIT46QsTAfIiwKEzYzXDEkzFSaX5xyMGIA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=S+B62+eKfj/iqDNw0oAb7d+NMfg47aF3NlgEQn2UF3+0WwxYVx8dC7nsTijwDXCgAnIUQ4gtmMLC1cL8jbkWnptIRdpZzDC24xNJANziU9RBKGr2OhibJFRtAY8HTkLbhBkHtfk0u1gcckqoMfflt3XWe2Q0Pv1tpvA/9A0kldc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okvBS1fC; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64e9d72d5f4so1746388d50.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 15:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774391114; cv=none;
        d=google.com; s=arc-20240605;
        b=jX4e7/731cnW42+9yDd6OgjPEqVlDFzsT2Hf5NqLBKd34a9mGRgmZ6UtlV6qdwqKfo
         rmdzeUVfEPL+Y4hqvFtBRkGIyFVVgxX9qfavLHyr6SRRtuuoLw8ug6K09P8iAzvJsnv4
         NLk/OXJumWM9c6U8A7VIkMpAqlAdzcwy+9eiFPSdGqzgjhPxVfxvde1RoPawrLFhkSUq
         uBfAEJ3foCq3YhgENQ3BMTrawGw/Hzdd1luYM8Aj218LSQ8eWHRMLhbDhdr2ILyIz3HV
         m+Yfp8Y2+Jb7futOR34CXWSlOLqu1eN4WsCrpHtzQSDoMJewa9/LnWB1tVh/Y+ApEGko
         r6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hBubRKOxFa8+TUhQB9IiR2ogwU1UNo++A0f2JpOj1ds=;
        fh=rQIcFjtb/S2BAPMCL67ZTVAweHnZurFJ25VvGqyNx0E=;
        b=GVntmoaCbi2tVakVluLgnl0z1sBILl6yM8WZj+4w3NJm91S7lF4RhlGjKAJxQSU16f
         FUFmquAGzPWwIv0mAURYCwgB+1gR53QG28bAqm98tOPOpoI/HDrHL+Wg6AXaBMBeA4r3
         8IWjbzazF6DKUWr892UGU8OXlNbGTtoxI0D/mO7iNSOJeHJ3dsN2vwcrkyP8rDFAonOi
         XJ4ud97RM5wbL6sR4phlhH6osVYtQqUTdJ3mFeanbTMg1m8P4CxJ6X5DcwzVFRki4dIJ
         CTFMW4KrHGlYhYU2sIbGueCcJOw3vpTH43EACTXwoWsuatQV+JDZwBXsjjtBPllrP7Qy
         rtRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774391114; x=1774995914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hBubRKOxFa8+TUhQB9IiR2ogwU1UNo++A0f2JpOj1ds=;
        b=okvBS1fCR4Vy5iMG6ccGLb70RkLcIydcZIsliDSFs0loSH5KySZFkce9bLOnQN3Td+
         85wC2g4wNK7GwA88n9dCdAIu6JeADWPcghLRX2rTnxtqsAt/Y7HoA3A6or4sZymKgMCW
         9d2wOnxMWHfcVjDLdo4fKjjJbQbRw8hB2nSU+vEuF4YbxJmY/wC/ZSnerwtMlAs5QIv4
         ttiA/viD2qR0l8OnNirAhB/csfw2Q2y2nFnH9R5FslSoniybLrNL/prEhZgEE6dZwUHs
         g0Wm6a2FAovOrmli2j3Dhk+Q8ym0H0MxCfrPhlE4TLCKZ8U6RV1RpGMk284XWGPHNceY
         ZpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774391114; x=1774995914;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBubRKOxFa8+TUhQB9IiR2ogwU1UNo++A0f2JpOj1ds=;
        b=mP2PWpgWJHxGvrNUqZiEiwGtBbr8A486P74HzgjVxbrAm2r6NJ0Jg/BVf9rMdixIiw
         XgNhI/KLNewB8c5qrRdfa5pPxYZUNGtlMj4NBghS8oFw/meoINFKSWHGPXkY5rmpa1J+
         HeEPUvtLCOW83Dln770+pK/6wdeV0XUElhcHdSUpvmcs+qum2w9H27qsuRDafM2reuIi
         CFpsRvMNja/8TAuR6CFVHqySgiRp0EyXHrgKWCvQJ+7VKppiw9aXzPCvx1JuAHt8/uK4
         bur+4zcTjdWiQ7mmIYH2yqyduWyD/e0nekqqbDwr/br1/KXRuOiiZiwVsrv+ev2IJ9iO
         29Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXt0LdJDP88QKhhPyg7uEDLCdizJ/IBMhdUslcYgUHxATyJU5OJEszY3nZ+WZlXsMFAEHI/fHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcP8uc7GfXB7/u7kcd8vK1+Yy5MFIcaCn0bxwRxRfEPYKKXuvj
	SsI+gAbE7wtpp9hjuckS55Y/OwDENp5KwTICsG9Nef4wJ+eQx4fCo+1e18gSVW1GDqlm/XxOXuQ
	lU6tnc35tX8+WcLYig+GkOeoZkmmxaRc=
X-Gm-Gg: ATEYQzxhVmp8CeRV2nKX8axoBqclMboKadvkikLurAt7kx2MFGvk+9NhUPlyTnCgKoe
	rj3niOoXe12vWkYo23FkeyFFN49L122F7XBopYj+LeA6VEX65PaAEF3OnCND7EI6oXuTUmXGQ1X
	1cD6KyTyNu76CpEysyDXirsjw6/6mNt8jRLXa7yCIEb8xpKCOfQ4u5gH0/AlxqZ3v5oj9dK7cFO
	VuGmKI6Bklwld1PH7Uq2CnYOTvTWIK+K3DS4tBjtA4Qbxdw9S8N1Q6DG81e07CBYugrILDYM65f
	9xJ2u05st72t09MZRol5ppFb5qD2fs2WzFhBnzNlHw==
X-Received: by 2002:a05:690e:d50:b0:64e:db50:37fa with SMTP id
 956f58d0204a3-64ee61202ccmr1255436d50.47.1774391113892; Tue, 24 Mar 2026
 15:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dima Art <artdima93@gmail.com>
Date: Tue, 24 Mar 2026 22:25:03 +0000
X-Gm-Features: AaiRm51CLy4vtH5S4-6GasknCYNqe_7K8c1FGm-ZCj3NGZ-dWqwhIHUS6kiYQto
Message-ID: <CACHgFRk+WSTAhhm4BbWwfqUMVCTJL4uTLK9+=8D6odKMq8BxAQ@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Victus 15-fa2xxx
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230239-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[artdima93@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 30D2E31D5B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The HP Victus 15-fa2xxx (subsystem ID 103c:8dcd) uses two TAS2781
amplifiers connected via I2C bus at addresses 0x36 and 0x37.
Without this quirk, the amplifiers remain uninitialized causing
mono audio output with no bass.

Tested on HP Victus 15-fa2xxx (HP-VictusbyHPGamingLaptop15_fa2xxx--8DCD)
with kernel 6.19.0-9-generic on Ubuntu 26.04.

Signed-off-by: ardima93@gmail.com
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ alc269_fixup_tbl[] @@
+    SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx",
ALC245_FIXUP_TAS2781_I2C),

