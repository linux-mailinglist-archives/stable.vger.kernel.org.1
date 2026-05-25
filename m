Return-Path: <stable+bounces-254161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIZkLidkFGoxNAcAu9opvQ
	(envelope-from <stable+bounces-254161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:00:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC165CC054
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F9330160F9
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD853F39E4;
	Mon, 25 May 2026 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YivPG8Uo"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5F3F164E
	for <stable@vger.kernel.org>; Mon, 25 May 2026 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721136; cv=none; b=KCem65J9ke27Ag2rOXlEv8NMrj1xNpEPU8Y6MfK35S84NkHknwzh3lTIWSPd59nlpnxxHvI9S4QhtOPJR73n3TR/M/a1h6qMY6aphyqeZpQ2o51friT7KySa/P2vpHswguZip2vuqn3GdqsGr4uxKYOd4khoB0TnbRzQ5kdyGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721136; c=relaxed/simple;
	bh=1G9xTvbWN4zhQVAulm3EMPJCyftvg/OHp6rmyal2nv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxHYhzHtA8L5EiPZRcKZNOUZVCpNZc6FlH+wriDrI5JoBEKgqYBys4Hl9kwX1P+kcm2DyXW8ViQ3QzXqB5WjV36HPJ9vvKIVa4flDTica7kT5omezqgmT+TGCuDtW//+xvTVjGnMtl4r34W/IVaqOvZ2mKCJoXVkBg3LI/+K/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YivPG8Uo; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69d6e5c4bcfso2398184eaf.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779721134; x=1780325934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpJ6gjVoHQOCUdI1c6bQp+ts9mCjVdeuH8wkuVrl/+I=;
        b=YivPG8UoemGJh2Sm7mKT2QkdGUpB4ZdFT8EGuhnk+RYU14/WVO7WQYoXp8bIrKWmVP
         Vt6bDdkzCf1awdJyXFtbnUPmMNtlnEenmLEcwONzSixGfzi9ajAFRQY90MK1Xb5ScMMm
         v1KDSyGzqNfRKorT46dBKOVqAeccPyOuQat0FHCDcARX2NG/vbccNAPGwbPFbE44ajaF
         uvwTl2iKEmwAz4Exa6k4grL1UGsTMz54DpDN7EDKxcEnFH2hSjDtZKFcj+nCVAt8U9dU
         Uv3A4ta02UpRA98ykWriqaUZhl3kVts4O8qn+AFHQRRaeXebb5JFHLVCcdCpuomlRqIQ
         o/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779721134; x=1780325934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fpJ6gjVoHQOCUdI1c6bQp+ts9mCjVdeuH8wkuVrl/+I=;
        b=Zzp79Z8e4bmh8Z9FqPUmk34ou0LUJA/3k5s+Ouubh3TFUCbvRhnMhQKGLCPis9Uw81
         HaXJGJKERNKnsf3+doRpQREk50H7OAjSO+AOc/hbxRKWWAjjGmGR6ash6GigwFB95KdU
         87b8/iIVy0/IkV4V62L3hM8atWQllMJx9KVTlASHiBtivI8vcg5szXoJbg6mYkpUe/0u
         xL2RfSUsqr1GSdXw3YCx2SD1Qfr8hoPcr3Xgdiy6ai/dWaBOy4j/vmtU4NYmSn+snsU9
         dbEfgoAeVibbIAtSXV1IKi1mG88thMV/17Hpm3zQlDcHXeF0ilC107zuaNWoGs+lVBR4
         FO7Q==
X-Forwarded-Encrypted: i=1; AFNElJ95Xyi8bAU+BEgwK1BtfBzhzUBVDXIcPa9pDtzRzOiH2A7zZ6SQ5J6GllyBEDXRjNx31kizLvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6jbkJKMS25J7+C85cRQQBZok2EKs6gRBykXmrBKKNR9OW9wT
	ALvbg0KklCvEDsgXvCMqbv4o1YEutuWM4s1UP+HoRgwMf4Dvyq24GWm3
X-Gm-Gg: Acq92OESp5OfM3+8krRJQuX0LPn4KFOHZg9qHd2JFTCwtCojWPXZilrGHp1I9yLm1zc
	swyonOFmJ0h60yotkvCdXnrKwk2EPGfJhj+bE0gJIVmQtC6likRJiC65BAqpPH7xdXJtpU068Lg
	7JyIcFXDdR0auzPYd2+zvMsgJzgyzNCu3hcISlDQyNLsn5bVG7Bt/WbsQLIcDJycjSaTaaLp1ZY
	/7GHnrdE8rwIL4SERuRe5PVQ7MbwEWuunAklLO3zBHLBCUiTiHidkox9PZMkHKKnNEbrvONps5m
	2ps4obMVi9+h/jIWhLBLA3yMT906sKwElKe4L1kHxTz+2X2Tfel4ux6rIelINZKiN7tyK9taSM4
	4lW2vUmgOs2yggubV9O30o0CF58FB1kcSEVFEjbKrvMwYICewSVcoXoRIs3oGY/ZUgGGa4RnQ2j
	BKBOAw70lTU37ZnIZbS4+cfObpCWhe8MwsZdBls7qPnQ9oCBptRQZGiz9qSiLV9SAFwqjQKyooj
	LT5wuUuxNNPgr3bGnK/hxykkTiuUh1QsIvMYlboRqmxew9absgpMauH1wDdqbywllVK
X-Received: by 2002:a4a:e902:0:b0:69d:a2f1:e0f1 with SMTP id 006d021491bc7-69da2f1e1a7mr3937673eaf.49.1779721133662;
        Mon, 25 May 2026 07:58:53 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d836c6d9bsm5294101eaf.2.2026.05.25.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 07:58:53 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: johan@kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 1/2] USB: serial: io_ti: fix heap overflow in get_manuf_info()
Date: Mon, 25 May 2026 09:58:31 -0500
Message-ID: <20260525145832.2941-1-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026052525-devotee-reclaim-7673@gregkh>
References: <2026052525-devotee-reclaim-7673@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-254161-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2FC165CC054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_manuf_info() reads le16_to_cpu(rom_desc->Size) bytes from the
device I2C EEPROM into a buffer allocated with kmalloc_obj(), which
is sizeof(struct edge_ti_manuf_descriptor) = 10 bytes.

The Size field comes from the device and is only validated to fit
within TI_MAX_I2C_SIZE (16384 bytes), not against the destination
buffer size. A malicious USB device can therefore set Size to any
value up to 16383, causing a heap overflow of up to 16373 bytes
when plugged into a host running this driver.

valid_csum() is called after read_rom() and also iterates
buffer[0..Size-1], compounding the out-of-bounds access.

Fix by rejecting descriptors larger than the destination struct
before calling read_rom().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/serial/io_ti.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index cb55370e036f..a35409bd766c 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -773,6 +773,12 @@ static int get_manuf_info(struct edgeport_serial *serial, u8 *buffer)
 	}
 
 	/* Read the descriptor data */
+	if (le16_to_cpu(rom_desc->Size) > sizeof(struct edge_ti_manuf_descriptor)) {
+		dev_err(dev, "%s - descriptor too large: %u\n", __func__,
+			le16_to_cpu(rom_desc->Size));
+		status = -EINVAL;
+		goto exit;
+	}
 	status = read_rom(serial, start_address+sizeof(struct ti_i2c_desc),
 					le16_to_cpu(rom_desc->Size), buffer);
 	if (status)
-- 
2.43.0


