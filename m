Return-Path: <stable+bounces-245095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOCuBu5cAWr2WQEAu9opvQ
	(envelope-from <stable+bounces-245095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:37:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4595507DBB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 06:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64BC63013A40
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 04:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E56371076;
	Mon, 11 May 2026 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgciqqKi"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A7225A38
	for <stable@vger.kernel.org>; Mon, 11 May 2026 04:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778474209; cv=none; b=tLjNWx2gX8dI5NjhS4V0q9oIaBbHPSK0oYtYWAIIw9TIFwEzcrYR0YuCZJNJEqtQJseb0tIQSoDyKolEmOwrNKI9mkMbsXObHLDUq96rz/lT+Bn2RnQ2rIE7DK5wJnjMBcrx5ypPGfoBzvLcfyxxUiLgFkYbx2ccJ/sQkwcjGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778474209; c=relaxed/simple;
	bh=xz4Q2/bvZnl47FmwyqOLbYEmF0mtTjZCnGvYrSSP7PI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c/MGupTtLboWDM14s/J9jEG69w9K/JRL98hB8pryeEkHRygbmfRs5r73rYfmrCG8gmr6NKJe+PEbjFlfeh8w/us+fbT+G1wilBfKH+Hlvr2bw1XSDlu+VTN4VtkqkhaDaKq/KY8P8fqvYR1dwW8OYs7HIhQD+KlFh1PPknOTRWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgciqqKi; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-130b2295ed0so10833538c88.0
        for <stable@vger.kernel.org>; Sun, 10 May 2026 21:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778474207; x=1779079007; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNmK8eiOPDvhAT6YZbtLUE/AFt3/E5twms2XcUfuzaE=;
        b=pgciqqKin6UtQWqck1Jh7ycyPoC+R+U+xeFNYyvVYotk2JBrrbz9Vr7S5Vz0tjsLcN
         Tp13d8BnHNs4WhFVW5vmnG1ogCxgb6BLbbZdlpmbu72GhPLg9O5P+1ktFwbFGQoaA53q
         IDTLn4rEcSkBqp31E2Ek749Pvmdogq5aZPVKHnN8rCARFThJGOcJZrxmNOQdoZipz3Yu
         /LxFzLkV5hjD4NOkl7CAY9uNico4hmLnpNUBSekiQ+n/STXP8/vBMPvK9NZyIZwjmN7+
         XG4QOO3Y1iq2+y8MkdAdAZh0YMUg04M9lV6VGjI+/UMXH1XmcJY5EpF6mZ9znYCh7KdO
         N4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778474207; x=1779079007;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNmK8eiOPDvhAT6YZbtLUE/AFt3/E5twms2XcUfuzaE=;
        b=Y9l43IFkSl6FMmCra4AzwD7KCsMaNQphveK0saliCmJf/YPnbVNmdRfKuP8WZg8Na9
         mVbZIzL7HljkJcnglm3TRwif9bTETop4zycik5SwxS1WOHj8KN0LsEvEisJrd37fyDDT
         3pPa5JnaitHtvcTQC9oHXikAtuRKQGSiJjtxgeK6gXmSGXIEELyBeAFN5D/aFrXOvFqD
         FkH8awIlxBMCSk5/VAqlmvBxvulFH2ggY2BbG9SC+RTzZKUFw6WMkZfuPtBfiuS8wCE/
         n2b+P6kb+FT9ZdQP/9GzkzV8ihhdZvEZCeTtZmwkDEuujSLxH3S5vHEQlVxUHCPWx6bJ
         zATg==
X-Forwarded-Encrypted: i=1; AFNElJ8xVl5ahoOTUcbzB0WraOGZ8Lg2iECOJuqEJgdTAqj+AjNrYkMXYwCAdM9GNzZAND69UkDzUK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPxDagYsGcdUBKSXJ8UmKJal6ykRQAxQ2UJEa1qCvKt6vOSFmG
	9Tao/mRfz7R/6zc9kq3nYCNStCc9POu2AcyuU/PsdOqHsaCq7Llt2WL32UYohlpP
X-Gm-Gg: Acq92OH3NrkiBEgZtPZDVGDB1iRT/eGkSJTmR6SrU7Do6x8Q87LBCVtPjQLXsi2kZ4n
	50aiudn9UeBbLiuL6J6Gvy+6QsJEnVvyQ55VaR1eGVnv9h2JhM92k/1RBUjjf8wv9nQT3gtnyD4
	nSgR6nqlnarubY96b9vlEXhJ9zr/+YzFtqv7cCMjzBDKoU7hnjTHh03sZPJJAtPPmHzso8aREaV
	ydxL9zPYyhhZFY3LxmbsuzNrMheS2DlO4hGQ8dTzpyXXVI++gTHqrM0LRNOqFNNR9YFJNpJXrAE
	ueoA3p7cT+QRIP+ntOkf4sodPpX9CMmeIufiD45x5qOtH4YUN6Ua/DNSBY42tjSetk+JdqEbaaJ
	rrImbLEBB2pxxptE/8mWXuE8xAIhr8Re6E8WNtKQx4N0KgHtXGSrAPG58NjnwCzmAW++Pr99vcq
	b6qJMrzcMyKitvgTaqL5fsbKRIqq9s1+MrZRT/GdbIDagN0QYrQnn3itATAaMq70zwgFhOdRtgd
	w==
X-Received: by 2002:a05:7022:3d05:b0:11a:4016:44a5 with SMTP id a92af1059eb24-1318e917705mr10856939c88.24.1778474206475;
        Sun, 10 May 2026 21:36:46 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865700asm12975784c88.9.2026.05.10.21.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:36:45 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 11 May 2026 01:36:37 -0300
Subject: [PATCH RESEND] ALSA: usb-audio: qcom: Check offload mapping
 failures
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-alsa-usb-qcom-offload-map-errors-v1-1-6502695e58bc@gmail.com>
To: Takashi Iwai <tiwai@suse.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3654;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=xz4Q2/bvZnl47FmwyqOLbYEmF0mtTjZCnGvYrSSP7PI=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFmMMbe8jqiunxW+xvtLrMf7O23v5Kw3BdZIFxsm77+0b
 aLxwtbOjlIWBjEuBlkxRZbVSYss93Q9uFoft8IDZg4rE8gQBi5OAZjIZCFGhtuX84Vj9kRL8Bd8
 LxDb5Sv6bumK9celLG0CVW7fbylVVmX475r18NtVoaBph2qcd6g03Wi7YBG3/+KiuTPfGb39z5K
 0iw0A
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: A4595507DBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245095-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

uaudio_transfer_buffer_setup() calls dma_get_sgtable() and then passes
the sg_table to uaudio_iommu_map_xfer_buf() without checking whether sg
table construction succeeded. If dma_get_sgtable() fails, the sg_table
contents are not valid.

uaudio_iommu_map_pa() also ignores iommu_map() failures for the event and
transfer rings and still returns the allocated IOVA to the QMI response.
That can expose an unmapped IOVA to the audio DSP. For transfer rings,
the failed mapping also leaves the IOVA allocator state marked in use.

Check both operations. Free the coherent transfer buffer when sg table
construction fails, free the sg table when transfer-buffer IOMMU mapping
fails, and release the transfer-ring IOVA if iommu_map() fails. Also
return the existing event-ring IOVA when the event ring is already mapped,
matching the pre-split helper behavior.

Fixes: 326bbc348298 ("ALSA: usb-audio: qcom: Introduce QC USB SND offloading support")
Fixes: 44499ecb4f28 ("ALSA: usb: qcom: Fix false-positive address space check")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/qcom/qc_audio_offload.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 5f993b88448c..a0009503b2c5 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -565,6 +565,7 @@ static unsigned long uaudio_iommu_map_pa(enum mem_type mtype, bool dma_coherent,
 	unsigned long iova = 0;
 	bool map = true;
 	int prot = uaudio_iommu_map_prot(dma_coherent);
+	int ret;
 
 	switch (mtype) {
 	case MEM_EVENT_RING:
@@ -582,10 +583,24 @@ static unsigned long uaudio_iommu_map_pa(enum mem_type mtype, bool dma_coherent,
 		dev_err(uaudio_qdev->data->dev, "unknown mem type %d\n", mtype);
 	}
 
-	if (!iova || !map)
+	if (!iova)
 		return 0;
 
-	iommu_map(uaudio_qdev->data->domain, iova, pa, size, prot, GFP_KERNEL);
+	if (!map)
+		return iova;
+
+	ret = iommu_map(uaudio_qdev->data->domain, iova, pa, size, prot,
+			GFP_KERNEL);
+	if (ret) {
+		dev_err(uaudio_qdev->data->dev,
+			"failed to map %zu bytes at iova 0x%08lx: %d\n",
+			size, iova, ret);
+		if (mtype == MEM_XFER_RING)
+			uaudio_put_iova(iova, size,
+					&uaudio_qdev->xfer_ring_list,
+					&uaudio_qdev->xfer_ring_iova_size);
+		return 0;
+	}
 
 	return iova;
 }
@@ -1054,15 +1069,17 @@ static int uaudio_transfer_buffer_setup(struct snd_usb_substream *subs,
 	if (!xfer_buf)
 		return -ENOMEM;
 
-	dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
-			xfer_buf_dma, len);
+	ret = dma_get_sgtable(subs->dev->bus->sysdev, &xfer_buf_sgt, xfer_buf,
+			      xfer_buf_dma, len);
+	if (ret)
+		goto free_xfer_buf;
 
 	/* map the physical buffer into sysdev as well */
 	xfer_buf_dma_sysdev = uaudio_iommu_map_xfer_buf(dma_coherent,
 							len, &xfer_buf_sgt);
 	if (!xfer_buf_dma_sysdev) {
 		ret = -ENOMEM;
-		goto unmap_sync;
+		goto free_sgt;
 	}
 
 	mem_info->dma = xfer_buf_dma;
@@ -1073,7 +1090,9 @@ static int uaudio_transfer_buffer_setup(struct snd_usb_substream *subs,
 
 	return 0;
 
-unmap_sync:
+free_sgt:
+	sg_free_table(&xfer_buf_sgt);
+free_xfer_buf:
 	usb_free_coherent(subs->dev, len, xfer_buf, xfer_buf_dma);
 
 	return ret;

---
base-commit: ab4a88fdef2813446e3af179a708d024622ff4fa
change-id: 20260422-alsa-usb-qcom-offload-map-errors-ddbb6dbf758a

Best regards,
--
Cássio Gabriel <cassiogabrielcontato@gmail.com>
-- 
Cássio Gabriel <cassiogabrielcontato@gmail.com>


