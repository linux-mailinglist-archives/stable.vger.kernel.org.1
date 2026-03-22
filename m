Return-Path: <stable+bounces-227862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CXkE7ZowGlkHgQAu9opvQ
	(envelope-from <stable+bounces-227862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:09:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0EF2EAF4F
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 23:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B497300336C
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 22:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C6737D13E;
	Sun, 22 Mar 2026 22:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="lM1NhBj0"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C51372EDE
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774217396; cv=none; b=bo3E/SFhFegXcasVRAMQU/oSuNfP5h6FPEmB+/nFx6RrOQ3sPkjuOBPm029yXRRjCG7U/5nyKYINbY39wyusYdwSRXZBr4QMgCetsI9+gEmuzpdJLSX3a7PH95RqeQrHh7Ru9LSsDmRuekhxX7ZCkrCKsTN3UUxY3c19g1ufDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774217396; c=relaxed/simple;
	bh=2hwtz7ko/sn+/2Pn67hEoIQ7ueVgPh9I2hP9YwyrtyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4SHGSsC2S2A5GRIA6ji/aNbVbIwcEXm3KE4lQbe/nUfS2wqx/DY6u7pJIHq8Zn3/MR3fdgMB9sTTAz5scR/fG1GMZsGYsWOPwXo3v5NLZzMugck/4iS1QGjoYfL4XiyCVqMWlWF3EOvxcgEpEHqONYOvqGtDABSSwAtEH+qsQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=lM1NhBj0; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4e9694so5781657c88.1
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 15:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1774217395; x=1774822195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HEksHgroj9vtVfNrNfn3qqblz/mRdSgEMEkB3jZTqc=;
        b=lM1NhBj0jY+aUzAKXL67M4AanLCRPSoc3uIfwWzgCZDOvbD1IEMJSDSu8hh0i9Htci
         TU6XyNz5enb647gQjFT4jgA5t9NlGvuVjJyqYXUQmxdFckMT7gRylq0o7ouoTB/HN67p
         jfrMeCBwaAXRszr6DsoIIDDT7wfu3TalX1L9fHtVZHxM20Nao4NdwWAA1xWE7gJbWxQg
         EBuwFkowSowUi8IjMsJhVojv1QX5ILFqOsfU/7vlkymubF6cscAnmSPrn03XN2wjj7q8
         Po6irP7wNTXk9832yHyq/HD0xnDXi659/gbIo3r7dXdXNZU3DyDs9ICubjkIBT2dQ3NL
         AAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774217395; x=1774822195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HEksHgroj9vtVfNrNfn3qqblz/mRdSgEMEkB3jZTqc=;
        b=GS4aOzU9EYK441ZChqSgBNpGd7+nrpFxXTggPZ8Z9nO2JA/XsRefe3zGkXZor/8511
         5KSDr/maQRiUapC3Rv1ZUANXlidZPB5XYTAPfZlAeYpZW0GRIC/lA//hrtIF6aptVHzU
         OOBKuOKVIglmWDpaOnakJw0IRblFQD2fJogi3bSh4c7SZRUMftx0nKlC2YqrdZnrc07Y
         l2f5XpwIEJ2nkxkDWU01+7lEITn6ySQrtd5Bg8HQ4ZBl+j3IgQ183hUC2yHE5sv4uXAc
         aGGT+ap0jK6Z8gszdA8McEreTzfUrgyAsMD2MPD7MNRLwBNaJKUfizEM4LbHw2q10p4n
         VBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXja3s8DUhWybyqeR72bry9zgjI4+ku1N67cWJuCuNFl0F+2mWgv244ArPbvHANenlbR05Jl5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWkmydKcCLF6dqqtdm2ARnqErN55HxnzPRgokRKY6m1d6slope
	c1z1D8owy1t+5n+O/WJ4rGOCJkdRnfOizEsJSuLiR1JtrZVVOFFTviP/jOiYhEZOFQ==
X-Gm-Gg: ATEYQzwNv7qorfdpWG0atDQk+O6oNNNvPZWC0P4w3cVhtlQcTqWq0UDIjwKg1GOC9Gu
	+gcwuBASBHuYneSS2Qpu0wFfa6RCnBwUnTfFZjWeFBEF6+9jjk7K3dmz51rE6p/DulQtZcHKdya
	GQgIPcr9dgBzyZk6d8QOfluXI85O5cnrY7LvBZSZaDrrLs0LJ2iaeMozcz0Je5QgQGjVDmAgb7M
	dYaEAqi4HkeHxMxUFl6UdIIsSTLk86goAk+x8HgLUFLdbK8scXr2RdSmzUPJi7t4pd/TYAWmacd
	Wfs6TShMCO35N6EYtykNeqIwE3h/gSFsoFTLllPZe0rv4Rc7Jlt6CJzvxquTD/x6VewZ/2hIw9K
	JQ4MwVURcGmO2rgqsYSLZNVZPTREVrSVUOBFO54x8fesC4DLIs+zHN8rGhvkZgGkDs2rNmfucMv
	o+bkW1uiZy
X-Received: by 2002:a05:7022:e09:b0:11a:3734:3db3 with SMTP id a92af1059eb24-12a726cfc0bmr5304659c88.32.1774217394533;
        Sun, 22 Mar 2026 15:09:54 -0700 (PDT)
Received: from katana.lan ([108.74.4.89])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a7330d1c5sm7707766c88.0.2026.03.22.15.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 15:09:54 -0700 (PDT)
From: JP Hein <jp@jphein.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org,
	JP Hein <jp@jphein.com>
Subject: [PATCH v3 2/3] media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for fragile firmware
Date: Sun, 22 Mar 2026 15:09:39 -0700
Message-ID: <20260322220940.1462189-3-jp@jphein.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322220940.1462189-1-jp@jphein.com>
References: <20260322220940.1462189-1-jp@jphein.com>
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
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227862-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[jphein.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EB0EF2EAF4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some USB webcams have firmware that crashes when it receives rapid
consecutive UVC control transfers (SET_CUR). The Razer Kiyo Pro
(1532:0e05) is one such device -- after several hundred rapid control
changes over a few seconds, the device stops responding entirely,
triggering an xHCI stop-endpoint command timeout that causes the host
controller to be declared dead, disconnecting every USB device on the
bus.

The failure is amplified by the standard UVC error-code query: when a
SET_CUR fails with EPIPE, the driver sends a second transfer (GET_CUR
on UVC_VC_REQUEST_ERROR_CODE_CONTROL) to read the UVC error code. On a
device that is already stalling, this second transfer pushes the
firmware into a full lockup.

Introduce UVC_QUIRK_CTRL_THROTTLE (0x00080000) to address both issues:

  - Enforce a minimum 50ms interval between SET_CUR control transfers,
    preventing the rapid-fire pattern that overwhelms the firmware.
    50ms allows up to 20 control changes per second, which is sufficient
    for interactive slider adjustments while keeping the device stable.

  - Skip the UVC_VC_REQUEST_ERROR_CODE_CONTROL query after EPIPE errors
    on devices with this quirk. EPIPE is returned directly without the
    follow-up query that would amplify the failure.

The UVC control path is serialized by ctrl_mutex, so last_ctrl_set_jiffies
does not require additional locking.

Cc: stable@vger.kernel.org
Signed-off-by: JP Hein <jp@jphein.com>
---
 drivers/media/usb/uvc/uvc_video.c | 33 +++++++++++++++++++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h  |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index XXXXXXX..XXXXXXX 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -90,5 +90,6 @@
 #define UVC_QUIRK_MJPEG_NO_EOF		0x00020000
 #define UVC_QUIRK_MSXU_META		0x00040000
+#define UVC_QUIRK_CTRL_THROTTLE		0x00080000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001
@@ -737,5 +738,7 @@ struct uvc_device {
 	unsigned long warnings;
 	u32 quirks;
+	/* Control transfer throttling (UVC_QUIRK_CTRL_THROTTLE) */
+	unsigned long last_ctrl_set_jiffies;
 	int intfnum;
 	char name[32];
 
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -71,11 +71,34 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 		u8 intfnum, u8 cs, void *data, u16 size)
 {
 	int ret;
 	u8 error;
 	u8 tmp;
 
+	/*
+	 * Rate-limit SET_CUR operations for devices with fragile firmware.
+	 * The Razer Kiyo Pro locks up under sustained rapid SET_CUR
+	 * transfers (hundreds without delay), crashing the xHCI controller.
+	 */
+	if (query == UVC_SET_CUR &&
+	    (dev->quirks & UVC_QUIRK_CTRL_THROTTLE)) {
+		unsigned long min_interval = msecs_to_jiffies(50);
+
+		if (dev->last_ctrl_set_jiffies &&
+		    time_before(jiffies,
+				dev->last_ctrl_set_jiffies + min_interval)) {
+			unsigned long elapsed = dev->last_ctrl_set_jiffies +
+						min_interval - jiffies;
+			msleep(jiffies_to_msecs(elapsed));
+		}
+	}
+
 	ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
 				UVC_CTRL_CONTROL_TIMEOUT);
+
+	if (query == UVC_SET_CUR &&
+	    (dev->quirks & UVC_QUIRK_CTRL_THROTTLE))
+		dev->last_ctrl_set_jiffies = jiffies;
+
 	if (likely(ret == size))
 		return 0;
 
@@ -107,8 +130,18 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 		return ret < 0 ? ret : -EPIPE;
 	}
 
+	/*
+	 * Skip the error code query for devices that crash under load.
+	 * The standard error-code query (GET_CUR on
+	 * UVC_VC_REQUEST_ERROR_CODE_CONTROL) sends a second USB transfer to
+	 * a device that is already stalling, which can amplify the failure
+	 * into a full firmware lockup and xHCI controller death.
+	 */
+	if (dev->quirks & UVC_QUIRK_CTRL_THROTTLE)
+		return -EPIPE;
+
 	/* Reuse data[0] to request the error code. */
 	tmp = *(u8 *)data;
 
 	ret = __uvc_query_ctrl(dev, UVC_GET_CUR, 0, intfnum,
 			       UVC_VC_REQUEST_ERROR_CODE_CONTROL, data, 1,
--
2.43.0

