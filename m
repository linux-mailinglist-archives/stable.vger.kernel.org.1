Return-Path: <stable+bounces-238668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEBqFkBW5WmOhQEAu9opvQ
	(envelope-from <stable+bounces-238668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 00:25:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3B7425A50
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 00:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 761613012E95
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 22:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32E29A9E9;
	Sun, 19 Apr 2026 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekiMwlWS"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B485282F19
	for <stable@vger.kernel.org>; Sun, 19 Apr 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776637487; cv=none; b=XxuR6UuuvU3ZaFR5+YSl8HX8SwibJ0lrl8IjkM0EnlEIDbLzdn3WKOldm0bAg9lcbMulaEAZP8pHn8Wy8EOl8IHaOgsI2/kAuf/37tOMOa9RbWnDsHA/eym6Ek5Ys0JETkibt0Wsy3nzbhsIOTrqrEn5f1J+o9D5iQ73AXYWgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776637487; c=relaxed/simple;
	bh=HokyC2nDUbRTJYDs3PhWlBf/ZTkZR5B5P0FWV4QeBLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ba7JzouOLtTIuemQIwjJCCs4LzXBWx3gkVObxxkhsfnaHTt6I1Ikwa1Kt3ald/jweihCjkVMC8OxM6zOsyxyl70f2C2d0xuWbOHBTj/x+cpGNSt8Lrxb4W+4lrKjKbJW/7awpGmS98/REFzn2iyNUQx2xGteaIj83ZLnIN7DCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekiMwlWS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a10d130b37so2344139e87.0
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776637482; x=1777242282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HpNJcvd4vFonahhQxxRKSX+/5Qv/TqiQwoW9F6azc/c=;
        b=ekiMwlWSHWkdNYZO2uvYuT7Ef7GXktYnaT4gnlpbBPKXQPBbz2CMLsq4QTBO6JM7MM
         9PR+jjofyRZqmScMVuTPy9ViueG/4LyG91jd6pjRmrNNZYQy05BLNXKe9+lfRMTe7+CK
         W2occPBGCeoumuRDhxV2JOo8+LSY58rWuK8T6IrvnSJyFwlp74C/yNDPzOsyv9kGFc5R
         lUmIOt4iAd3E4UZfu2rM2sPUXUUN+ENYjl0la8+WdafHlvqNVaSOuLEDMpawe4Z7+3+E
         EYPV4MqFVoS0XWwlPOaHiSyJXi6MlZJCrMKSDtUlrILnZ4kEL0EeazoDwl0sE43mnJ8B
         dXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776637482; x=1777242282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpNJcvd4vFonahhQxxRKSX+/5Qv/TqiQwoW9F6azc/c=;
        b=oEJFQX0586uiUW4OTPy8YJEBacEVF/B6YqyBD5GfcT+mH9VQNabJuCNvDj4IXbdxxQ
         7f8caoq63/59xk5iblJixVQjp160j+/ogr2tLBGC6lqf9JVdb8BMSw0rLPEOnLqE/4YV
         lBBOo5cfHllSDrYCY3wMzCt86Omj7zFl55Y1IBzzmv9l5Bgewl1sRngGTd7mu94ATxTv
         9L9n9+IxIuJPCC/jae/dM6pV9N+vb2/wzXZb3UkPxe0qgPXUMXwgMkf7ZrVgH13E4mOG
         Ie2f2bwfz3mzJFlgPpoKwaxT6cH9x/Ca/AxVpMbYRfgZ17OZHMcyjQTwoFA1p/PzU8AZ
         GO4Q==
X-Gm-Message-State: AOJu0YyvqeALbKpuDhd4rg6trB0LiVbxmYuyJ8Wf+/En1Vj667Lx2oVj
	phMIWEkdNYGb1/GQRtKlAKoMoVsY6GTyra0BAF1hrhnE5D1gQ91YSGkl0GWtv42pBnZ0pQ==
X-Gm-Gg: AeBDiesbUYuyf7MJ5ur5janRWE98wuW+jm7B4oGh1hnJrif+vco6ppDbr5PcqQmpG/v
	RGd5A+SzfnFC5f/lhJHL9M1rBlE16uAvJZrWbMdXEe55Lg2zP1BU//zLFaYFg8JoPAUaw2vdtkF
	L6jlYHveMTkvknxC3f1cTikA5o3ztNUp2m6JG1tePSA8UdlXEw28f4u27ftH9YSnhFN6huyK/e5
	p4LuJTV8VPJcYT0Cnr0D0fyQmt4FQNG7jCrb7pL+MpDPxXM39dEWeBJy44eDpM/tnN1aJFNECvW
	u6YcbgnFqbPuEJtmsk8Ul+7MXMkR+VmAhVtD9gGsih1eoLA5wKrxaI2EiQQQjTKA10LvPmyU8sN
	E7yf/BCzPCh1Sd+rM03Cd0jwH4GZl/GYVttYryhycm9mVJCEwU4DmuVfHmi1E5iGMd7yPJVVe2/
	YjQUHHZJ7esOjHxfDzPvsEbPRdYHtI9cR6p2/EAGDyt1FbSdvzbK0wl9VOxVXTww==
X-Received: by 2002:a05:6512:3502:b0:5a1:3d08:cfab with SMTP id 2adb3069b0e04-5a4172a9d81mr3298109e87.23.1776637481976;
        Sun, 19 Apr 2026 15:24:41 -0700 (PDT)
Received: from localhost.localdomain ([85.143.146.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185ad0fdsm2554297e87.13.2026.04.19.15.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 15:24:41 -0700 (PDT)
From: Rand Deeb <rand.sec96@gmail.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH 5.10.y] ata: pata_sil680: fix result type of sil680_sel{dev|reg}()
Date: Mon, 20 Apr 2026 01:23:55 +0300
Message-ID: <20260419222355.5842-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238668-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.dk,vger.kernel.org,confident.ru,linuxtesting.org,ispras.ru,omp.ru,opensource.wdc.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[randsec96@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,omp.ru:email,linuxtesting.org:url]
X-Rspamd-Queue-Id: 9F3B7425A50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sergey Shtylyov <s.shtylyov@omp.ru>

[ Upstream commit dafbbf5c57dd6ae01d20b894bc2200e9d9834c4e ]

sil680_sel{dev|reg}() return a PCI config space address but needlessly
use the *unsigned long* type for that,  whereas the PCI config space
accessors take *int* for the address parameter.  Switch these functions
to returning *int*, updating the local variables at their call sites.
Get rid of the 'base' local variables in these functions, while at it...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/ata/pata_sil680.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 7ab9aea3b..fe60f884b 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -47,11 +47,9 @@
  *	criticial.
  */
 
-static unsigned long sil680_selreg(struct ata_port *ap, int r)
+static int sil680_selreg(struct ata_port *ap, int r)
 {
-	unsigned long base = 0xA0 + r;
-	base += (ap->port_no << 4);
-	return base;
+	return 0xA0 + (ap->port_no << 4) + r;
 }
 
 /**
@@ -64,12 +62,9 @@ static unsigned long sil680_selreg(struct ata_port *ap, int r)
  *	the unit shift.
  */
 
-static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
+static int sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
 {
-	unsigned long base = 0xA0 + r;
-	base += (ap->port_no << 4);
-	base |= adev->devno ? 2 : 0;
-	return base;
+	return 0xA0 + (ap->port_no << 4) + r + (adev->devno << 1);
 }
 
 
@@ -84,8 +79,9 @@ static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev,
 static int sil680_cable_detect(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned long addr = sil680_selreg(ap, 0);
+	int addr = sil680_selreg(ap, 0);
 	u8 ata66;
+
 	pci_read_config_byte(pdev, addr, &ata66);
 	if (ata66 & 1)
 		return ATA_CBL_PATA80;
@@ -112,9 +108,9 @@ static void sil680_set_piomode(struct ata_port *ap, struct ata_device *adev)
 		0x328A, 0x2283, 0x1281, 0x10C3, 0x10C1
 	};
 
-	unsigned long tfaddr = sil680_selreg(ap, 0x02);
-	unsigned long addr = sil680_seldev(ap, adev, 0x04);
-	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
+	int tfaddr = sil680_selreg(ap, 0x02);
+	int addr = sil680_seldev(ap, adev, 0x04);
+	int addr_mask = 0x80 + 4 * ap->port_no;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	int pio = adev->pio_mode - XFER_PIO_0;
 	int lowest_pio = pio;
@@ -164,9 +160,9 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 	static const u16 dma_table[3] = { 0x2208, 0x10C2, 0x10C1 };
 
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	unsigned long ma = sil680_seldev(ap, adev, 0x08);
-	unsigned long ua = sil680_seldev(ap, adev, 0x0C);
-	unsigned long addr_mask = 0x80 + 4 * ap->port_no;
+	int ma = sil680_seldev(ap, adev, 0x08);
+	int ua = sil680_seldev(ap, adev, 0x0C);
+	int addr_mask = 0x80 + 4 * ap->port_no;
 	int port_shift = adev->devno * 4;
 	u8 scsc, mode;
 	u16 multi, ultra;
@@ -219,7 +215,7 @@ static void sil680_sff_exec_command(struct ata_port *ap,
 static bool sil680_sff_irq_check(struct ata_port *ap)
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
-	unsigned long addr	= sil680_selreg(ap, 1);
+	int addr		= sil680_selreg(ap, 1);
 	u8 val;
 
 	pci_read_config_byte(pdev, addr, &val);
-- 
2.43.0


