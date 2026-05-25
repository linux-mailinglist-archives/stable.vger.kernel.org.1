Return-Path: <stable+bounces-254057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMnKBRWyE2rdEwcAu9opvQ
	(envelope-from <stable+bounces-254057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:21:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C25C5662
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA1E5300900C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 02:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7729F28A3FA;
	Mon, 25 May 2026 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzAWbejO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7139276050
	for <stable@vger.kernel.org>; Mon, 25 May 2026 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779675666; cv=pass; b=WBd0HUrtb8rprZY41gO3vqLGXGO68Ejh6am1/DQQxK4bUDc3qZRcOF0Gx6gAvPTuiUh22wgAbGYgUX+G5Pw811mZE0Xzlz/3PDQJhmA2omAZIxhACTVcvp3qsBF/voEs4ELrV2Y90nO0qJQ0d3dVBnJbtUlrKwVuIzyvrUB3at8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779675666; c=relaxed/simple;
	bh=9OF++De0qbfSaGV9kKcaQ7PVSfEbE8hrcqNBVw2etnY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Zzth2uo/J0kDex5PABXoN4DMoWORI/3W0NyVTzJcM/ltT/VJ+7Tim7+7pVifNNx5Q5x2ZHhlWOYceVlPVl8dTvZD0qNTrVQKjw92+NVHKdKW1w/W0rg+X4hrd4pjz54Qo+Gvba1V5+T3LsTTt8ZK0POr3GNVEjxWm0xfxwbhZVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzAWbejO; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e615efd7d7so1685853a34.2
        for <stable@vger.kernel.org>; Sun, 24 May 2026 19:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779675664; cv=none;
        d=google.com; s=arc-20240605;
        b=jMx8lPKVo0j0DyjYBNnnb6cirxc/D0vUIt8Q5N8c3FLHLTNwuNR7oTDeLxA5MHuIIU
         01QgmlzRzZopBfFf8ao2pmuV3S6INyHmuk85cqgSzdmm+DgqN2dR6GRmuMiZZAy5cvr6
         MJBF0Q1emSylLCReTZMwDfecZBjZi36krBX0jjqzZ/dThZw/TCcgI+Yw6m8w7UKF6gdT
         Yym0yMxOTY+A9D11DpqPNKM7WsLMaqT080RDsRypZPjzEbtC99z2nEZw7pXTp5NFAyEi
         9VBCv1ckhto6pLDOcAAstiCG+FXMI1LRJR9yJ6sh3s5y92UQ5428w+PRfpdf+JC3X6/2
         gE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aw1fhyGrsU8/wH2/4vYCJYAjvuo5aa1sDViZVMzFnqk=;
        fh=rZUJXV2yHIQUOYCX9RQ6L8vmUE9JbXxB/NvCM0IAh7M=;
        b=LcSDAPOGb5gbpD1BnCutthTqq+it7p0UfcNcLCIv2+lbNF34bmRVMAreWzk2ZWjP05
         2fNqX2wxgx5FffuzvzES2g7vB7GIoMOzurKmp4dx0EtGcah5DpgvUEwAtCaUx23QJGQF
         bJPJ99VdokepgoqmjuohHvd8PY4qJdIQsxkEi/RccsOwO/wVZPz2gGOekSm5qDtYYI0l
         PqPj6aZ/FYh+MCSlX4swAvH4rZZolMyDwSWmMkz6IhYDs/XgilT/j9dmobEuvmFOXWUW
         iNSCCdqYhCz3Nfz/t7KKrsuw/3FOT/B5257u+66gimDl1JGsUK2bcP87CR2W3oyxp7pp
         mbbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779675664; x=1780280464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aw1fhyGrsU8/wH2/4vYCJYAjvuo5aa1sDViZVMzFnqk=;
        b=NzAWbejOlyQtXRCcNbi+JjCoZF1YSI9gz7P0VkyZyMbKiyT0ExzLaDX6xxcskgmcGp
         3qN2GML+rlUHvaO0ImYe3/aX+BRlYqIbZCHRH/9HW4+wK2cjIinbJnpovDA+QIGO02ud
         pVchsJcpc0K//dozybhXY2i60RqFVqarhdjJ3PA5EtagpmjhIKbwL5z0uwd727taasag
         bD0sdT6l/89YSw9KHoqYSeGTj9xrCVz49iDdYbjj9Kafry+6/Snyj54/ntU5Y2Ei7dau
         dRZFSM+H3jMSFMZMSo9CUUI/MjGm13Kb8BOn8pQ3ODggqlKwzpK9umdVdOfJp0b7yyRf
         vOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779675664; x=1780280464;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aw1fhyGrsU8/wH2/4vYCJYAjvuo5aa1sDViZVMzFnqk=;
        b=c/XXMM4fiyL2W/NKtf3BQYEmuC/3YeTFc4GT6nAU5WDoPOeVfZ7ampEjbmYzblb20+
         IxAkkpqh41/eDOuBYY6xu3QASuDhCcKRityU0pUNmfRdRA5CWz9TqR3pLLnA5RfH3oI+
         MvsJsPDaZsWnldD6TC9pkEz/MGYrLT7MPZIoqNRkeT8W4ke24d3aYijOlY3qHuFc5aIL
         Kp1zki1jvl5xlVmEHk6EAhdzwT10z4Ni6WWB3Rc6xP3WNBekILn7sTYYxWZBaEKLmbiF
         4x0Cmqdq4eY6mBEZDIvJGkzRxy82bY1cWUZ0QRLzM934HREyyCbGiuVwUv/2JBV3mEOJ
         R9aw==
X-Forwarded-Encrypted: i=1; AFNElJ/6BQFPwqc8dYain0bVtgj6RsnyANcYDK/04vnT6msYu238Z/coM7jAoTrzH9eaRPZmoKWn5pY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VYbzc82xh5kgc1kvQJAofnv11v9Sc86SUe7jrq+GXFqPVhpc
	fx7v1t2MczB1dyD4AlKJ27LM4Wy0KEelrwihKMuNYrE4MBKhIVypOhYNaAne+KuDamSq2mfW8v6
	bOPjzo6gfTRqhFGsbmxlYsmSJ+vtNTDbvgNc+Wc0=
X-Gm-Gg: Acq92OHvzKDcpuunDChVDaDGVlLPCnVmNDpLQPws0sjIu0scpPZr8RSoyUfkIUbmV+7
	LGgWHWZIf4/M3lOzGpmvcWyHnHU05JzI12fi1ViaBfbPJ1h5XV5k1t/3qG0I93y32rpOo+ySW0m
	jbI0gJBkTQt2VIQXoNNgl4zTIJJmxF3ZVrtur/9Q+YjnEjCcPkwpUQnOLlID+hcaWEPFur2Uz4A
	v2uoKPtCikUXdT8FrpwvLekTwLaP9YG+mA7YOSRNIrDls2BhaC+nFJtMoCfJs69+3dnt3WP0aPd
	cfE+/TByzFnLWdy0+O3vBtQybAFO6nbDDTXKlT3QJjCvcVUfmEerBRLFrgvYute8IYT20vpa4g=
	=
X-Received: by 2002:a05:6830:2404:b0:7e5:f831:50a3 with SMTP id
 46e09a7af769-7e5fef1a50cmr7856308a34.17.1779675663643; Sun, 24 May 2026
 19:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adrian Korwel <adriank20047@gmail.com>
Date: Sun, 24 May 2026 21:20:51 -0500
X-Gm-Features: AVHnY4Kfxoj-dhzRCkEkzc8-pfd6J5A5tN96IQEGMkQHqb1-0MgBCW-JEdx6GJI
Message-ID: <CADgB2mF95N09=gOvBZ+4ePSQ-0wCynx-rbu=aiyQecT=iDdyRw@mail.gmail.com>
Subject: [PATCH] USB: serial: io_ti: fix heap overflows in get_manuf_info()
 and build_i2c_fw_hdr()
To: linux-usb@vger.kernel.org
Cc: johan@kernel.org, gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254057-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 845C25C5662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two heap overflows exist in this driver:

1. get_manuf_info() reads le16_to_cpu(rom_desc->Size) bytes from the
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

2. build_i2c_fw_hdr() allocates a fixed-size buffer of
   (16*1024 - 512) + sizeof(struct ti_i2c_firmware_rec) bytes, then
   copies le16_to_cpu(img_header->Length) bytes into it without
   validating that Length fits within the available space after the
   firmware record header. img_header->Length is a __le16 from the
   firmware file and can be up to 65535. check_fw_sanity() validates
   the total firmware size but not img_header->Length specifically.

   Fix by rejecting images where img_header->Length exceeds the
   available destination space.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/serial/io_ti.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index cb55370e036f..afe29fdf9536 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -773,6 +773,12 @@ static int get_manuf_info(struct edgeport_serial
*serial, u8 *buffer)
        }

        /* Read the descriptor data */
+       if (le16_to_cpu(rom_desc->Size) > sizeof(struct
edge_ti_manuf_descriptor)) {
+               dev_err(dev, "%s - descriptor too large: %u\n", __func__,
+                       le16_to_cpu(rom_desc->Size));
+               status = -EINVAL;
+               goto exit;
+       }
        status = read_rom(serial, start_address+sizeof(struct ti_i2c_desc),
                                        le16_to_cpu(rom_desc->Size), buffer);
        if (status)
@@ -838,6 +844,11 @@ static int build_i2c_fw_hdr(u8 *header, const
struct firmware *fw)
        /* Pointer to fw_down memory image */
        img_header = (struct ti_i2c_image_header *)&fw->data[4];

+       if (le16_to_cpu(img_header->Length) >
+                       buffer_size - sizeof(struct ti_i2c_firmware_rec)) {
+               kfree(buffer);
+               return -EINVAL;
+       }
        memcpy(buffer + sizeof(struct ti_i2c_firmware_rec),
                &fw->data[4 + sizeof(struct ti_i2c_image_header)],
                le16_to_cpu(img_header->Length));
-- 
2.43.0

