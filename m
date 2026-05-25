Return-Path: <stable+bounces-254162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKt3ObVjFGoxNAcAu9opvQ
	(envelope-from <stable+bounces-254162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:59:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE50B5CC00A
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEDC43004DA5
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B803F39FA;
	Mon, 25 May 2026 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3KtyEiz"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9E34C808
	for <stable@vger.kernel.org>; Mon, 25 May 2026 14:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721136; cv=none; b=R+xiM8UVyJZHpLSTAqLRWHC2dVcb8opMfqFCUn4nLvRE/lDipOPZM2a2pTNuId8BjaiyfA/nxtcJXhbTGS+yPwBEYkVR+z4hYXXHfRoanchXmJkhYdtK2RQ1J2qmX/lhQwuILsRTs6Ms7G3FdEQhHMj6xv+4fZv+U5t4UpK9RpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721136; c=relaxed/simple;
	bh=mQzf0udB9WF5zu5/FBlJF1x0afDQDwFSq0CE/SAXcyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOkW6XpsHL13A8Gke0HQAnPhJs2/Fz1/aFMDU6eGi+9pUe90/2a3WccONQD5bBrsYfBKd3FTN4P1BlTCUrCHI0QnRWv5woKOaw24n+AKPMtkTJAjiGTNVznXVq2T02qynPis7G4bKhRoLFiaaQOsdcshYOeVSDmLu/AEIMOF+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3KtyEiz; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69d8ff0ca12so1763035eaf.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779721134; x=1780325934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3w98fzDAZ74VeWHLLU7AbRT+oeZljBSAiHlsaRVO9E=;
        b=g3KtyEizZ/6jhK9oDFuA6uIqn1NwPBU8z/nOKUt9F5x6P5SdNpILrhgTb3EpVTVyge
         LwSgKmueTlBk+a/HTq6uARVzSq4KY7ZZyDZvMmjU3vZHDkqOH4i6kGnrMTj75P8BMEV7
         YLEwoNW5/VQzkI47bLw8t1WItL/wKoGD1yeRqncLWhbWf1pgH4PIUV3rSgb+5iyrqNP/
         WOkT3XuvbkwnEadFdmkDIxdHNH/eNhKZK2vmpD49PkuMwJjOtSvn0vfPMVbRuMP5A6nN
         F4oIqbESl9wBcak9a4jMa+zFzTVIXTdYNcIpcKY2NONxnHuK2VHjzUireLueXb1ZwteV
         3oEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779721134; x=1780325934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3w98fzDAZ74VeWHLLU7AbRT+oeZljBSAiHlsaRVO9E=;
        b=ATvATC/+FLaUclvUFoGKQvSTGt/Y08bzTXKXKpOCjNv8+WHqhK/NonnEBgZew6EBco
         my/BpUJ4LWF2dgowSN8IJsBAHwIUPJTcP8mVYyNQv+SrbqEGPFdiep/fH6kQX2gaoSAc
         peW84n6l6EZgedxAQU1aVp8Rb9jquPhVbcWYnifInlVcclD4nouPpW8BnNqVpFjdCniT
         XFMdVkXld2wwzd+naxFLjAObuSw9Hca1uz+MiWgp7ePBWVEvxPYJpHnydIoqrF1+l2bF
         JvgglmGbyyW0BwX0QF0aHt26tKo59tyAsZ8bSAxmm6w8w42YcI59n6xxoEd3Gif2XJJS
         PhVw==
X-Forwarded-Encrypted: i=1; AFNElJ8Tk8mcVtjUSY0DfmAAYggpHmgA+tp5Rq9Q7Hw4Pb03i5DRJZ1gA9HiX1Dd4Kcj8cnd5fKpB6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8X/jI8iukXKJPkldBsyxkWayFKNq2DHT9UTumwUMeCTNMYLzk
	3xv0lo0prux+KOuzI5YdJiRY9RgcDPkALm994pEpxJdlKeXImF4bvHNyxVvlY3i4dJk=
X-Gm-Gg: Acq92OFq9ibDEiZn/GIIQTMFumc/rHAY0CKt9TeGq7PgHfrVswvesUlC/x5gmJlYpnw
	JlqOeZ0ntbm2DXUP8l9XFMKELDrLlHvMmhFtHu+s4X66aUiRtlsnbKinCOcqJKzfeuk88MlQIsq
	3NqC7ZLNK5QAojg8DM5QplL+149S0zmH2pbPo5NmaxflaW2V3mj5kPlWyx4d7B6tR5+cFN6z3Lc
	72SccRsZ4RdEn9iDPg8eb6UVWhDBbneS09QGZ+kPo1GMM249exZF6Gaz/UINizyQshKxdwteiFy
	4N8Uc9aBfRH0XDxVIfKwZGSfilwynGgmS72HUkecpqe7OStw3+YHOuviWwCFwH7pWfEEukarWKx
	CPxDSSJr6xKrGa9ztIELbeMywOSpkRz7wZNjIknAh5yrDfvLIzZ/WyqVwr0vkbFj4sdsZplv6V6
	xvGUQJDgpJJva3/EJBTNZ8iiAyeIvYlYvDHo2h9ykYE3UY0mR5UU6bE8Rz+VIdwHWqZq5HL7itG
	HCKZz+kDzwGb/T+8Fi8idV8/ADiYeAHZU3WI0CTSyc3yvI=
X-Received: by 2002:a05:6820:818d:b0:69d:8f9b:f2ef with SMTP id 006d021491bc7-69d8f9bf5d1mr5767643eaf.29.1779721134579;
        Mon, 25 May 2026 07:58:54 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d836c6d9bsm5294101eaf.2.2026.05.25.07.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:58:54 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: johan@kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 2/2] USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()
Date: Mon, 25 May 2026 09:58:32 -0500
Message-ID: <20260525145832.2941-2-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525145832.2941-1-adriank20047@gmail.com>
References: <2026052525-devotee-reclaim-7673@gregkh>
 <20260525145832.2941-1-adriank20047@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254162-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE50B5CC00A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

build_i2c_fw_hdr() allocates a fixed-size buffer of
(16*1024 - 512) + sizeof(struct ti_i2c_firmware_rec) bytes, then
copies le16_to_cpu(img_header->Length) bytes into it without
validating that Length fits within the available space after the
firmware record header.

img_header->Length is a __le16 from the firmware file and can be
up to 65535. check_fw_sanity() validates the total firmware size
but not img_header->Length specifically.

Fix by rejecting images where img_header->Length exceeds the
available destination space.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/serial/io_ti.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index a35409bd766c..afe29fdf9536 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -844,6 +844,11 @@ static int build_i2c_fw_hdr(u8 *header, const struct firmware *fw)
 	/* Pointer to fw_down memory image */
 	img_header = (struct ti_i2c_image_header *)&fw->data[4];
 
+	if (le16_to_cpu(img_header->Length) >
+			buffer_size - sizeof(struct ti_i2c_firmware_rec)) {
+		kfree(buffer);
+		return -EINVAL;
+	}
 	memcpy(buffer + sizeof(struct ti_i2c_firmware_rec),
 		&fw->data[4 + sizeof(struct ti_i2c_image_header)],
 		le16_to_cpu(img_header->Length));
-- 
2.43.0


