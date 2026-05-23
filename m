Return-Path: <stable+bounces-253894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP7gFjo2EWpeiwYAu9opvQ
	(envelope-from <stable+bounces-253894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C015BD34C
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 07:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F484301C973
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 05:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE985312837;
	Sat, 23 May 2026 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xaf6lhHH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C133126CD
	for <stable@vger.kernel.org>; Sat, 23 May 2026 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512817; cv=none; b=EEu87sp/ANTde05bqRtvGxG6CPFnmXRtdmLNx440VjKTDbFAAK9HpDGAkm8hM0g9GWKHG81rYSvzoIDsr+a9AGHBEMKqe4VyrXhy1VbN9C/vLM7/0FYTM1XFv3VVSGU7tMzhOwIyLPf0tvvk2wOQEkxIr9GDMTJZzlwLCeST0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512817; c=relaxed/simple;
	bh=6e1rj9pQmI2NVnlVXO7bywMrIJiFKSD9Je58nrGA+q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pw2AlbqWZZHacAdO/enVBmf0l/GZS+NWVftQPQYo9/12DDMsCeR9Zngfl+QGpJmQIdY7tPnW0zArneG5h6Ds4uLigT8uKgQYNbXj89pzEfn/oeWwZKKX1p+ix4ADh52MazTCDBKWZtqAt3BfTzJQcZzK8znLeHSz8JnwfNtXOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xaf6lhHH; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304545e6c7fso1388786eec.0
        for <stable@vger.kernel.org>; Fri, 22 May 2026 22:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512815; x=1780117615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMrKJOvw6kEjwpBuF6gaRm9aW0Ujd/cJV12X/xp77Po=;
        b=Xaf6lhHH9Es8HN/J95veREZ0NWfGov8ZXSPbEhac6pZgNHsjwDxHL6Q1/qrKrnGVRy
         uNSMSdm5LkMSIbsf5Xoj/FHOsUHHzp8WDyf2stQ0bDO471a+A6VvtTxoDcOv3TYQkONK
         Fs1pck2WXWIJyUib4AqpjliZvs1TAXaegkSssTNeV8s1k9nIYA1vsbkrOndlSqlL0XCo
         XVqlH7OWstbMDB/8mjPTHOjkLXTqkQW0KC28TkfP5lDWqrFyzWp/SPgP3QIr/yYcHeKs
         UJ+5xucWkGzwvzuGxppDFPquShaCQbqUJH6Ey9dJbfTIJQDgPFqHF54IGPzBVojleQ9z
         Ik8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512815; x=1780117615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMrKJOvw6kEjwpBuF6gaRm9aW0Ujd/cJV12X/xp77Po=;
        b=WvNivWBj+LV8m6FwNRm0qN1gpQgvl3rpvJ43KsPROjeDqMLWP1rxq3M78uoDWS8+SA
         wNvknnlvCFwOlxVbtYBYLs7oAZDWlrxxIutcbCq6/NDSStKMAGekzjmNlIWqg9AHxQCy
         1g+6N8/DP/bKABeMqCT++MxuKTvg/6ISvbmgrsCKzMkFhqZpmS4d1sEJxvpjaLkLEMgG
         FarUpyqq4cOCbWKggPyhYTXuCxwByni6flPBo+DscTak2x6vJRxj5mdgf2ycErm9srtw
         nbzkLilI0xxpHI2ilBkhcqbeC71whK7XKLH62v4wYFWPq9jvn3i4U8xYWFF0BtfT4Hml
         RZ3A==
X-Forwarded-Encrypted: i=1; AFNElJ9yweqQG+yFIaV2nTtoWzwdfrXi8FrTvyqY9vEGpJWKrDhPXQTF4M9YTN6mRBxVJujLy6JR0M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8n+0gLb380ObqxWUpuMG1330xZcvg5LMvs2dUagczDAieOby
	vVzpTxctFfwWzu5TfDOZmBLHc4SI7eTrn9mC+dX2yNSW3YxrMJ/9wGgP
X-Gm-Gg: Acq92OG/+DuWcSohPsG4PnJjeB+QCbjXiMzaKJEaE5Khqezdhy4u56H+79+HZHMOkL2
	N64hpF5Kw1QDQtJrQRXYVpDSoQfKQijq5fcMKmyHne+SPv37JLDZTEYw8YQLn4zE7C1soFfczHF
	hQE4FwW4xr9gA8CH/4UE3VCN6A6p6V5WKTHF/qvGEuAewO9j3wVsn/plMlMJym6BA5fFNzPqop2
	YLtImns6rRFmj79JhwmqU8JCv1Oy4Olrp4V9mO8vCCLpd6ga9L7DjlA6l43x12fFycmAI+43e34
	+ihD73U1j5pSeq/OUnCye2zxkImmw6Hz+yEqZuHRAhYTKiHOW+MUNGZQYW17JFU9nGO/suH0ukz
	eDin0C8eeDxRgyrcwBjAeodYqxlL7+fJVE5phFAHGCEfWvkAapG/OTj8T74VFdcoMlQ9a01yPkU
	yNXIjXb16Tz7Dbu59QEKXjoMjJRjtyfpA5bcXm8+XWxF2Cz4JsAKhas45bF/4/HE+Fl18O93JHQ
	0SMKTIy1+QfQg==
X-Received: by 2002:a05:7300:434a:b0:304:2e9b:8f57 with SMTP id 5a478bee46e88-304491337bemr3631797eec.34.1779512815376;
        Fri, 22 May 2026 22:06:55 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:54 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 09/11] Input: ims-pcu - fix DMA mapping violation in line setup
Date: Fri, 22 May 2026 22:06:27 -0700
Message-ID: <20260523050634.501509-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253894-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D7C015BD34C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In ims_pcu_line_setup(), the driver uses pcu->cmd_buf as a transfer
buffer for usb_control_msg(). However, pcu->cmd_buf is embedded in the
struct ims_pcu allocation, which violates DMA mapping rules regarding
cacheline alignment.

Use a heap-allocated buffer for the line coding data instead.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 23e576500890..3b119bc81c85 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1790,11 +1790,16 @@ static void ims_pcu_stop_io(struct ims_pcu *pcu)
 static int ims_pcu_line_setup(struct ims_pcu *pcu)
 {
 	struct usb_host_interface *interface = pcu->ctrl_intf->cur_altsetting;
-	struct usb_cdc_line_coding *line = (void *)pcu->cmd_buf;
+	struct usb_cdc_line_coding *line __free(kfree) =
+				kmalloc(sizeof(*line), GFP_KERNEL);
 	int error;
 
-	memset(line, 0, sizeof(*line));
+	if (!line)
+		return -ENOMEM;
+
 	line->dwDTERate = cpu_to_le32(57600);
+	line->bCharFormat = USB_CDC_1_STOP_BITS;
+	line->bParityType = USB_CDC_NO_PARITY;
 	line->bDataBits = 8;
 
 	error = usb_control_msg(pcu->udev, usb_sndctrlpipe(pcu->udev, 0),
-- 
2.54.0.746.g67dd491aae-goog


