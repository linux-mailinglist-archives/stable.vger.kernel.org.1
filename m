Return-Path: <stable+bounces-242323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNA6FUmK9GnQCAIAu9opvQ
	(envelope-from <stable+bounces-242323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:11:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ABD4ABEA8
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C905301BA76
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FF839526B;
	Fri,  1 May 2026 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwgoRfh1"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44129D26B
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633857; cv=none; b=F9FfWmzsIlMe8Pwh5kDIVRv0r4nM3h6mDUy1RmtyPo4YBkKujqhqBsi0BLlIJ7DBCODMsJcgIwtAN3GjtJVDe1witR8jRbFWZtrwuDm5e40PSirto/vlk1byqZlr7JghW3Ey3E75YhYIeKryRM0JAEsu9vIS6PxYUwkzUjco1RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633857; c=relaxed/simple;
	bh=3Wcuv7vWXril4wnR8nrnNGWz346GKjDN1CfiXRWaVXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FmS1o7KmYzbVqwx3XZUO+yNZByzz9w19xpRRF4nVmGP0qHRpr7S8jCtox3nzbXlYLgt8C6XC5sfddrHFMruXVVHpVD4oQowg4zH4ILcsIOAd9Cqv8ozcRCfUHSgo76z1wxZ43PWIVBykJElzlwx8HXT4P5k0DYtvNpOW3Vw1/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwgoRfh1; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12ddbe104ccso1932200c88.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633855; x=1778238655; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p8/WVfHESUffqanqnB+tvboreu3xWHPzbWiU3q5ebRc=;
        b=qwgoRfh1kk3G23t+6ZpOqk7PiNtmaK8YnrASu25n/sMJcaB7K9s+v6pOFBrNRDRdgG
         tVhO9WJN0L/RFybt2GgKd0klvcE4k21VSAAcr2RO+++jHTMW0M/HmiThgjqzsKFjFYCp
         ioipJ3xUIuVzC7P4w1wTRhCYcv87e9d9ER1j/nJbPMm1DljaWcW0nFImxqRqCaYTlwGJ
         Pv7t/rBvx7GwlWTqplPFXodfBEsMpSoYHPws8myzo81FQ71UYWF+nm3dSVnhWCbk4NBt
         K6TsGnD0dPkB+9ED8K28j8KQYe25hViBHt12DOUlIdciTXnFWvEquUGHEDMaPP+lSKNG
         KX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633855; x=1778238655;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8/WVfHESUffqanqnB+tvboreu3xWHPzbWiU3q5ebRc=;
        b=iDGFjIOPReQOp0UCVeITGY8YczxhLR1M57aW97m9AX0FwHR8CjRh/wMxaxxH5IFAvU
         bNoN35EigbZ2WwRzwVlTvWW7z8QEdLPsSBjJW7t9do30d/0EYxU1ZepzijkyEKx+9nkf
         rVxJaSTZG966+boZ33zkTM1n3mgrkJOUezS8i5xORz8mdGO7SB2gtgc9y+GgX5/XlPnV
         geMkJ0Vlb8qsqtDY0SD6BttiRKAtigCc6RUNWUIJrv3Qyrj8NubiDzZQYPNefXD66MqG
         WQN0TEbi8ydsytq4kRw9gW0L+CHYDAiBjeV1wPctjnznEr8zKzPpG91FoaT6Dx+PfhCt
         qk7A==
X-Forwarded-Encrypted: i=1; AFNElJ9lZ3d6X7s2Z9c7Hro8Nv3804pX4CTT4Z82cf+qHum3fOwE6AowIFZuCtum7ZOULdWZxWh3K1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxveOWDXtb5AVudcUG2HXFG+wmPTPQ4FYHkm1nwrXT7JG5B3InT
	rEV+P8TuXVDMkb1raFrUBeIB5i6givNMnCc8k1Ah/AikVLDFDMeCZnA3
X-Gm-Gg: AeBDievm7MmRrsjxlb2H80MAxQu4wRG8KrrEc0b+LB2/IQaFcr6GSSoVmKNBHfH1N0C
	c1+KV6NMKuyZHIGLgh6vnO2/P37kolQ7Z2NS715RnmC6fP2pf4cVjliIsOjUy4Ubz1gBwRmX8MG
	mxt0stIk7RPgdpXI82AIZDXENOBLmv9vEIekDe5SsANlo9OKMbbSjfYE0sIPAjYqBcPxXsQXXc5
	WlK17bVtcOg00hjL21j8bNxCKFJVkoWxvCv6z7NloQsg7MBj9NFyBEjSnGDuF7nn/jdiVQtYaSX
	IWWnH/iad7ZDtpA13tGoGBYhlFq6AgJq3iRL5I9jGTJm9FAbF27K7uDvZiHN1kz9EZhW/A6Djjj
	wXoMv4dC9Pvw/MYWv7R/KDH9NBwMiOoONQQawXyuVMXz7WzixQp8z3Qvu0vtabkgrUWTwnFtO2q
	8PPRw9CrBYbE7pWtj1LqsTfkb+3KVH4RnQtMqa/cVyD9EIX3OMI0H2+yYvNeUUFeQCSS6i06CqS
	apnT2/oVkpDt156jLSfQBMgh9dqqvU7lg==
X-Received: by 2002:a05:7022:1a85:b0:11b:923d:7753 with SMTP id a92af1059eb24-12deac47e55mr3671481c88.3.1777633854634;
        Fri, 01 May 2026 04:10:54 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8279e57sm2628939c88.3.2026.05.01.04.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:10:53 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Fri, 01 May 2026 08:10:46 -0300
Subject: [PATCH] ALSA: usb-audio: qcom: Check offload mapping failures
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260501-alsa-usb-qcom-offload-map-errors-v1-1-ea927afd42c0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCQAxA0auUrA3UQat4FXGRTDI60nZqYkUov
 bujLt/m/wVcLavDqVnA9JU9l7Fiu2kg3mi8KmaphtCGrt2FgNQ74eyMj1gGLCn1hQQHmlDNijm
 KMHfC6bA/EtTMZJry+7c4X/72me8an98urOsHUE9eJYQAAAA=
X-Change-ID: 20260422-alsa-usb-qcom-offload-map-errors-ddbb6dbf758a
To: Takashi Iwai <tiwai@suse.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3601;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=3Wcuv7vWXril4wnR8nrnNGWz346GKjDN1CfiXRWaVXg=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJlfuqzO8G9h5Z947LPZmziJD2uVMuKFc/4kalTL1AWkH
 VMROK7YUcrCIMbFICumyLI6aZHlnq4HV+vjVnjAzGFlAhnCwMUpABPpCGT472Kx8WvbDn6bv4km
 hvy6u1mV18ycvGHp8oQOnTNPeuNrGxn+8MmFcRs4KrG+q5paZWDo7DfTW51vC/vpTdmqzGoGjdu
 ZAA==
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: D7ABD4ABEA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-242323-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


