Return-Path: <stable+bounces-249345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLOrHvFEC2qsFAUAu9opvQ
	(envelope-from <stable+bounces-249345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:57:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFFC5714DD
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 514C8309D490
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882B3495524;
	Mon, 18 May 2026 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFbqnw/Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89699494A0B
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123217; cv=none; b=qBLp0iMbyeaGtFN9ufnhacEjIaeFBW1y+V4DFEz1RgSuC/UGZOrAMAqIsbr2xq83KRr+JMKo5nBZf555r75m81dRB/ZRubS2WMDWoXYvC2EZTkYvekyzr0YHF4JfCDlv9ciu9hUBXTSHQK9HXV6cfWlqJ9cF0wNdvQ6/FCnoVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123217; c=relaxed/simple;
	bh=NBZHuKv2ldtGIWJAnz+NCfK2xasjAlOHK3ocGE6MaRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMBypa1XkVg232r0l3xLphj6hrurc/MOCk84Y9njgdb3syuk5atVFrCr4QNXGIRDfHG/gVfvoS4lf9yOzESKjBaA9ISbwOSWvi5QtiITvIEkW+D5adfcq0D7uG/NbaFRed94U8AJL4aMz86Iwfmdy0WRA0lPvLfhYJBKdfPGr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFbqnw/Q; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bdc947aa88so16703497b3.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123214; x=1779728014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taXFjdWmYy69nXOR8QvrAj+hN3E0MfqomsmbUhRahH0=;
        b=sFbqnw/QVvvac7icwqA+B83l9++wx76rwbXAuqWO/ojKzdMas9pJCpQwc5fFaG9yBF
         EpktwLP1DXu53HAdD+Rt/vXkh+Tl6iKvbGHylxqTnlsk6QCsVVVPVmWuWHXZ3udTi4a/
         bNbEo3XgVtulBKKnaXSOHTRgudEuDJOaxbU5O9Cc5ec7BdjM4TeH9n2ndSrTc+ac/zi6
         AIaONSvERsb9IBsXntp/ubp5tyOG283t6h4KQB9WgaXIHlL4ZkA+TG2/fofRh2/pNRBd
         w9X5Ph5q7PAB6lKJGHarV1Yd+FHGOOc5dTTRuqEOybjtEasiImQwkYMu2t4/Tw+uqoVy
         PJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123214; x=1779728014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=taXFjdWmYy69nXOR8QvrAj+hN3E0MfqomsmbUhRahH0=;
        b=R3mH5VMA2eAxlwR6zt6B5oVbcYBeGrvmxNVdDUlUsu7VIbeRg0dQ9oYlEZyyCXlBRl
         GWuaRr9ElMFoxls/bRDj/fvWrYOtn7j42imYYy7Hlob8ersH90/cJ8pvIfDIkA3k/F3Y
         Qsv9i/IduE2qPyrB7zSG1QY2TeqPlqnum9fNTc8B6PGREkBx8BfuBClmix6KXhi1BBwV
         JwyNJsq677UUBfDzFD2b3mF0mVSuOK0z5xYPmxFOYbk2l/lT5+iXQq4FovRP5d5HUEnL
         qDroac1InZ5wisgQTwauJ9PJJrv0mo54ex3fikY1SPQMiKeisEA5b00Xs/VjML7DAmjL
         t9Uw==
X-Forwarded-Encrypted: i=1; AFNElJ8Vm6CnDrHsSMpM9k4VtYfyVrTWHM05duy4FioQVGlDZGaE6Jt296SezKIXQfInM9XVf2+MX4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwST82yNH1vPs8dcQnX1jwx8tMLnbBRFHY+h73Da6xI3l3c818Y
	P87OlRonXfWQiN6VjTd5EZw4P8Fi0pZJfwzwAc1Hcc2y8Ntgu+vm+TZG
X-Gm-Gg: Acq92OHRMiY3kqGALYYd+aJfgfA78xR2ecbBcKlhLvrFtbSqYkQSlMjU12v2zTVFoba
	JsERwr++RCHwnhewMgKer335YgxUCQDfFU8zqq0ZijPinUd6fVmyGcbVKr9Q/CcCZAhf7MAXewT
	Ar13n3KGYnSj1P2kxaBJ3yf+ypR5Zus9HnkzeOqHEAe9Fsi7lFBRCPkujtMsc7+9Aqht5DwytJL
	69vqxJWFGgaaLG/fFiWJQE0mmp9sn/PpwwSlq2p/43e0Lo1X8MaFCYr3P3RLDB+wY+couydPfTJ
	or2pKD/eK1I2k2FPP6snrVQMzkXetNeecviKNVon8QWvQ4z+vfhwc71YcW5F5kE6mtG8C8syWo1
	WS+vc7INgXX4cQFmAcKK69S7vTEwvVWkJOYOwraFkmBWtP3DLg8wZfXp0v8neAdCP+Qj4EwgZKX
	KIydt8ATaW5nwqhYcMjUV9bbysGW6KTqVPPc6Mh+lN3LiYhlgm+FQUXrD4sz5idEzKj9GvPhIDC
	nk0jLdXvsj2RhrW9a4HWiyibBE=
X-Received: by 2002:a05:690c:38b:b0:7c5:f6c:d132 with SMTP id 00721157ae682-7c95a967084mr182102907b3.17.1779123214581;
        Mon, 18 May 2026 09:53:34 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc965ab98dsm24232957b3.0.2026.05.18.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:53:34 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v7 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Mon, 18 May 2026 10:52:17 -0600
Message-ID: <20260518165218.35388-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518165218.35388-1-sebasjosue84@gmail.com>
References: <20260518165218.35388-1-sebasjosue84@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249345-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CBFFC5714DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

afu_ioctl_dma_map() accepts a 64-bit length from userspace via
DFL_FPGA_PORT_DMA_MAP ioctl without an upper bound check. The value
is passed to afu_dma_pin_pages() where npages is derived as
length >> PAGE_SHIFT and passed to pin_user_pages_fast() which takes
int nr_pages, causing implicit truncation if length is very large.

Validate map.length at the ioctl entry point before calling
afu_dma_map_region(), rejecting values whose page count exceeds
INT_MAX.

Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v7:
  - No changes.
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v3:
  - Move validation to afu_ioctl_dma_map() at the ioctl entry point.
    Suggested by Greg Kroah-Hartman.
---
 drivers/fpga/dfl-afu-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e7338..097a97eee 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -723,6 +723,9 @@ afu_ioctl_dma_map(struct dfl_feature_dev_data *fdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(fdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
-- 
2.43.0


