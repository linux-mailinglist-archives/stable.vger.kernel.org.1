Return-Path: <stable+bounces-175637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8EEB36880
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C4D7BF1B4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353235A280;
	Tue, 26 Aug 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RCh29D6h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DBD3570D5;
	Tue, 26 Aug 2025 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217572; cv=none; b=rEupEUxwcjDnmMjFOAud3UNRzsD7u348tSUugnvBgwAuGUUw6uIcZ4DvnwSvnDUQFKSH4KrdnRpDlsxY4Oy4mR+aGv6Qv4UUTsa8LeGQgwLxSzgeE/oCKP5fjIkDUbKUXutny7YZ2Zkx7Vdjqc4xTMN/u5pvZe9Tt/qwas1Oq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217572; c=relaxed/simple;
	bh=lmD0RitzxqnMTsnF67BHZDh3ecmpfMYHyF6Q3Z8qPSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ2cc2eL4ZHa7zA/SKtKbN1cvVTLyeZ2fcRJP5QWfDNZRjaej6BwoV6avCPlDxpSW/uVRa7pGzAAFF/jGTa9gOyZp7ygsBrWtuXiTYv49cgwwMot48S/7nc8oGABstsN6+BeUywpFr+XMspW3yM3BZQEW/fwPTShI9TroMwMf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RCh29D6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD4DC19425;
	Tue, 26 Aug 2025 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217572;
	bh=lmD0RitzxqnMTsnF67BHZDh3ecmpfMYHyF6Q3Z8qPSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCh29D6h0PI6CXReC6t7AvaUtzzR+s/TOky6NLG3c3pvzr7b823eGpLi4ZNkmnyIg
	 fKD/ir8aSPYSuhCbN+AsqDgMFNuIF8dX2BW+ie3kKiQrVD/3zQ4TO2gUO/XO7looqC
	 NPTXG6cMQgL/PgD7bD6nrT7rGL1aydQaOrzKiMm4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Youngjun Lee <yjjuny.lee@samsung.com>
Subject: [PATCH 5.10 193/523] ALSA: usb-audio: Validate UAC3 power domain descriptors, too
Date: Tue, 26 Aug 2025 13:06:43 +0200
Message-ID: <20250826110929.209478271@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit d832ccbc301fbd9e5a1d691bdcf461cdb514595f upstream.

UAC3 power domain descriptors need to be verified with its variable
bLength for avoiding the unexpected OOB accesses by malicious
firmware, too.

Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0 support")
Reported-and-tested-by: Youngjun Lee <yjjuny.lee@samsung.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250814081245.8902-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/validate.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -221,6 +221,17 @@ static bool validate_uac3_feature_unit(c
 	return d->bLength >= sizeof(*d) + 4 + 2;
 }
 
+static bool validate_uac3_power_domain_unit(const void *p,
+					    const struct usb_desc_validator *v)
+{
+	const struct uac3_power_domain_descriptor *d = p;
+
+	if (d->bLength < sizeof(*d))
+		return false;
+	/* baEntities[] + wPDomainDescrStr */
+	return d->bLength >= sizeof(*d) + d->bNrEntities + 2;
+}
+
 static bool validate_midi_out_jack(const void *p,
 				   const struct usb_desc_validator *v)
 {
@@ -285,6 +296,7 @@ static const struct usb_desc_validator a
 	      struct uac3_clock_multiplier_descriptor),
 	/* UAC_VERSION_3, UAC3_SAMPLE_RATE_CONVERTER: not implemented yet */
 	/* UAC_VERSION_3, UAC3_CONNECTORS: not implemented yet */
+	FUNC(UAC_VERSION_3, UAC3_POWER_DOMAIN, validate_uac3_power_domain_unit),
 	{ } /* terminator */
 };
 



