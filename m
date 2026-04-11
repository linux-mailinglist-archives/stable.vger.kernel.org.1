Return-Path: <stable+bounces-235754-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBtdKjWE2mnI3QgAu9opvQ
	(envelope-from <stable+bounces-235754-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:26:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6223E104C
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 254B3307586B
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AE33BAD82;
	Sat, 11 Apr 2026 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/mvTsqc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09743B9D9C
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775928346; cv=none; b=HQklrp8H7XUAGxZ0129DoEMkb73Lu5pePGsHCRxektfhGjM21LrfDjgtCglUb4ChqVEpz2DsoFZaTlYduv8BTtrWgOAtW8/drzENX5e9M2P7QVb85E3stmDuf11Pq9fRwleHzkjVEsd8ErCoMIqi/V+ASkhKvn9MsedTusSMJSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775928346; c=relaxed/simple;
	bh=KdralG029H2u+bNJZQyAjwLWPHETALP7imWuvr8/ZbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4hczBXsopQNkkQq5cKrzN27uxiFtT3lyCcziUVfdbCOJxSxstmK71u2fX/MZBuyNutNVYVP7X/mWRSDsIRNC9W7Rng709f2VEGsNVCu7o/zB4bKhxXMpBTSvxcwWPPliLmVbYQ5a150Q4ECJ5us4HoEHCXxyisjXlsIA6E3cZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/mvTsqc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488971db0fdso30152025e9.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775928341; x=1776533141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/Ve6bKcmlBngm5tknnjpg5f1HUx082Ha3h37VFikdo=;
        b=V/mvTsqcHaCanMTaAjSssVSwKqTvXeORKtoV/f3cdIrpILUCdeco/IIUl4v0ZB3LEz
         APMPwUArzlNQpWVALbHlXNd+4yqJB0/YdFoEooN9ppAG/SmjHf8ILhKpvfe81WeQcXQJ
         RCsHlZocWNq8k34iyKDejWxky98GENbLIUzxGccONNxSm+qGPPVL8bAokluRgYy2v/Yy
         X3l1IzX15Wr5/TgiH7BbcEVYS/jwhwjI2I9xsOdkC+m2BBlA3K7Y6QbMFHwZHLWAwu90
         HgQgMg3ig8N3y8ZUSgO/wTYr4V7vmZ5rxjs7HnsjTQryYj75z0huTZ3CNZFakU3/Dsdo
         4ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775928341; x=1776533141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M/Ve6bKcmlBngm5tknnjpg5f1HUx082Ha3h37VFikdo=;
        b=pA8ps4Mrwwk2lGO1/4hkeb1peewzrwAWDVOIzRD9SvPEmWKc80oUKV4ZKGA903ZPyQ
         KTwlk4eO9ckwwW+6O3F6JKcsCRRyqIpvN4Gv8Wcq42SWqlY+5crqKEgb5B0MkUkDK7c1
         ruVc1D00YmwANUBISZD+tzWj7kN9kXVnNKOBw40f4gdZ6zPAT/9jQEsKAL4kSy4nC4nB
         PM66gmMAitChORDq2Z+6vke8XWv0zpdvqaZAoqJuP+UnwSz2lOYYc2fPEt40mBECAivq
         n+EUJDBVI1VNAkg3AUeYogQfYC5zvgzbETGMFzvGcsXfZrb/8PdttH6l8PuuWlbeqQkm
         pZ/g==
X-Gm-Message-State: AOJu0Yy7m0Z0ZiGO5EYmq22fMp6vk08mNN0hYsRsn8Xt/kI/qBSfLN6I
	/yZpHKpFE3ijwGpvHE3ITZqR6POv1uipcx48iIhj/EeoV0BE5ZiKAl+W
X-Gm-Gg: AeBDiesQr3ffotQzT2TqIJ+0Is0fw68Fjv7C0SB9lanji5sEhrs79dTOmOG64v2yoFo
	n8z30ISsrXDpekbfSLG1JlKUNacplu49TrqwABj3GlU6WDLMM2drh3txCD8br3hdUmsou5y0cPu
	SkgyJYKOOTrTuO6ptPXvDUlOzPd1B+F46ekKVb3TRdjPM9SMXkkeN/J10j5kcVn03FvwViO8MQn
	tfPwTYOic+XLrRO8wybPxA6u8YEoYmy24Q/qVx9/mp0lMA9vRCUqdkb2VVQ/BD7OdI9FBHP1D/v
	lKtNTjCd8b71IgV1hLVO29/Ia2xmDi+TSsYXHk8Nw9uqpbIEC5E3gBta0VYb+67xZsxppiYMI9Q
	OoqVkZ1MdzE+xxAnsb143jT394rp9qK2EWpf//VY1fVybF4xrXEgKDY0lY0brj2dXJw7RVsh6HR
	7LnwgXkVY8kDG6aUIQ67GEiziBXbtwMKf/g+7jRw4=
X-Received: by 2002:a05:600c:64c9:b0:488:c40b:c8b9 with SMTP id 5b1f17b1804b1-488d67b8d4emr113636355e9.3.1775928341046;
        Sat, 11 Apr 2026 10:25:41 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm64176515e9.5.2026.04.11.10.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 10:25:40 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 4/6] gpib: Add ines_pci_xl_interface
Date: Sat, 11 Apr 2026 19:25:09 +0200
Message-ID: <20260411172511.26546-5-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411172511.26546-1-dpenkler@gmail.com>
References: <20260411172511.26546-1-dpenkler@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235754-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B6223E104C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add new interface initialisation struct for 72130 based boards.

It is basically the same as the ines_pci_interface apart from the
name, attach and line_status fields.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/gpib/ines/ines_gpib.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpib/ines/ines_gpib.c b/drivers/gpib/ines/ines_gpib.c
index df299a9d7f4d..118e6c7b0ff1 100644
--- a/drivers/gpib/ines/ines_gpib.c
+++ b/drivers/gpib/ines/ines_gpib.c
@@ -603,6 +603,34 @@ static struct gpib_interface ines_pci_unaccel_interface = {
 	.return_to_local = ines_return_to_local,
 };
 
+static struct gpib_interface ines_pci_xl_interface = {
+	.name = "ines_pci_xl",
+	.attach = ines_pci_xl_attach,
+	.detach = ines_pci_detach,
+	.read = ines_read,
+	.write = ines_write,
+	.command = ines_command,
+	.take_control = ines_take_control,
+	.go_to_standby = ines_go_to_standby,
+	.request_system_control = ines_request_system_control,
+	.interface_clear = ines_interface_clear,
+	.remote_enable = ines_remote_enable,
+	.enable_eos = ines_enable_eos,
+	.disable_eos = ines_disable_eos,
+	.parallel_poll = ines_parallel_poll,
+	.parallel_poll_configure = ines_parallel_poll_configure,
+	.parallel_poll_response = ines_parallel_poll_response,
+	.local_parallel_poll_mode = NULL, // XXX
+	.line_status = ines72130_line_status,
+	.update_status = ines_update_status,
+	.primary_address = ines_primary_address,
+	.secondary_address = ines_secondary_address,
+	.serial_poll_response = ines_serial_poll_response,
+	.serial_poll_status = ines_serial_poll_status,
+	.t1_delay = ines_t1_delay,
+	.return_to_local = ines_return_to_local,
+};
+
 static struct gpib_interface ines_pci_interface = {
 	.name = "ines_pci",
 	.attach = ines_pci_accel_attach,
-- 
2.53.0


