Return-Path: <stable+bounces-254068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL6+GbDGE2r1FgcAu9opvQ
	(envelope-from <stable+bounces-254068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:49:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D95C5952
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 05:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF53A3008787
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 03:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A222BE035;
	Mon, 25 May 2026 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sukvwes6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB231286AC
	for <stable@vger.kernel.org>; Mon, 25 May 2026 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779680941; cv=pass; b=u5h//1Zax2dsI6TdsOJ8dZMxDt3OqcL0bde8N1ajsA3w67W/126/SDI8IdBu0ARCIArnaA9kbLUrbYkoglXCHJbWprCraCv8KcLGJwxGBXWJ20uRxorLXC2b9KqBLCx4Jl6K9l+pmsrgLNh8k9KWJvyRmAcYycXwWZHnmv3fz4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779680941; c=relaxed/simple;
	bh=rTx8D4UcJdlhVCBQDSERZhHgU/k80RnRK8QBKWN0RYQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P/7xSY9vhTfZn9uORxALzo9ihwuc1ywyKVNwp1ESuMxbHdxOFUSNY8cTBMbu9xyLn4z8zzdHY4Zn76rTXNLLIOi9wwXfgmIvXZFthm9pdgifKZ93FQc6rB2fzVjQJ+cSLaqzzvKhXcKAa6vHl070yReNShBuwpjfj5A8mFA33uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sukvwes6; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7de46b8e432so8591721a34.1
        for <stable@vger.kernel.org>; Sun, 24 May 2026 20:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779680939; cv=none;
        d=google.com; s=arc-20240605;
        b=g+4EpQXi+FVR8T43GeUhRKFofr7hibR4q67bYIbhkmQ5QpguVFLhSvfWOt5f/REFJ6
         GD4S/kEXiADl32K+9LSgO9xfR2cAGb+rL6UlEN8eGEBRKf2AAE3cF9xe7V7nFliM5AbQ
         2UhPOkxPSD0cSXl9UUTcF5B59ItLgfSHFqFsZUWyRaB62gUh57siN1Nk2zizBYJUo12O
         e7nrpSCL6WkSsXknRiqDLfRIk/MR11EgrvlibrX/G1LSK/h83llrO/oVi0nGcIQHYAUX
         EB6ysgWnWK0OMeFnKAmUc2eKkx+7cIZOfrjyJ3jACC2Eiqi4ub94oHDv0JSdz8wGdpjY
         en5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ZwqZ3s+fz2IowxtGp1OrH7H6BgIiCMLMrlQiYx/q52M=;
        fh=WMMg1o6j6m+Z2f+YLGhjD9wXeFLZAdZdbp9W3OE/ZoI=;
        b=IrVA48VkA2rLDF1tsWBS+V+lZyiTHd3X9+YsuiBV9IfYK4MkSH5xuoNkEYcVOXTfgT
         YZ1hP7KdNdIPlIZegPnYYnbyUSGPWbKtN0X7Y5RamyEhsGVRp8WLOVffFSmY4cLct4qV
         /vPdNI0FigzcjPh3yDjKJzngRe4Y2jJxEG1mjLPA9yfnIeOYslI29Z630QHOYaFNuIJK
         1gE1dXGwqvuBk8KAa7k+xVHh+bFnF2omnhQXsr2c3vf6s7BmbKki835w+CUVmJyS/pDS
         ro//cnbVxSibVF9+fd+lhTriDn6ZIkK7UTyavSz2Zt1SYEBIvnCFtamaLblS/uEQ3IrH
         jZUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779680939; x=1780285739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZwqZ3s+fz2IowxtGp1OrH7H6BgIiCMLMrlQiYx/q52M=;
        b=Sukvwes6IiejQaphXiNRU0fE+/KzjU8ousbRSoejT8m+fg9wO3dKt0pUZhkJzrycuy
         6ToWVpWz8NjGOzH6r0GbNJL/ooy8NYtwAiu5Sow08Y+PFb6L2DaUKe/2Mjxk/suDUJ59
         Zp929TuYlEBsnngDx5gXUDDg/XBBLzbFQv9K6bvFqnQubLyktHzbvMfhlZ92DvCgfEFn
         1MvtNyO44NVwBaQtBOuBYOrNHdMFuwXYD11GsZ+2OX68/UIWTg+ZxQRmReGFqX6XiU/q
         fwCG7wx+potISTPVgALYZ5AEP2IMKAaHk2uGrMCf8DwH+ifTXumHUDedfuhFnepZ9OM+
         CaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779680939; x=1780285739;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwqZ3s+fz2IowxtGp1OrH7H6BgIiCMLMrlQiYx/q52M=;
        b=WU4+rIPeyEfXt3qFzMUo1vMs2iB+mfy7AUvsGKgvi98sPI1UmIoqjS/dRExE7i/Okj
         35QyakKWvrDRiw+K9Fi+zHPEry3+rDvHlOzdGa+QrP5vcml913uJxI8B/qkf7WGT1Ddv
         Q4YRZUxLMVRz15hVwmA9DeueeF0UhopX6Uo+oSl1h9iPtINxcL69oPrpYY35rUzOz3U9
         RedEujA/iKIM2HrbYF7WLNZy/yu6+1Y99iCkRRuAL2qKCv4hHTZxpsVzGbC65ra/1UWz
         hntFVWMmLHLeVfkf/tOXPayGiL63EfeH1peq2nHCuPSAMlpgpk2he0xhhM6yZ5A+bQzJ
         77tg==
X-Forwarded-Encrypted: i=1; AFNElJ/zpmPB80RfY+FdnvkzupuscCrZDrXz5lXfIDawCjTfe4Sk8s+O7ZzUivsxUFNUTmOFiFyuMfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwvmkvDke18mfXL2vxK+DoRcvyPq38LUC+IbS6xPUe/8Tvor0
	GE1yn4Gy0MsOK33JmjXZ2ZKLyqZ3ZoZfzhn2eOXnl+LwUsI4EPC6AidllQibVieqqDxuxmIhdQ6
	1azihNXNZfN7RW8LJ+4HQq1xxNp98xL8=
X-Gm-Gg: Acq92OHTrfH91NiCEHGqXCftDXGr3eMIMYd++Ya0Kzy+wyhtLkgj8qFH7Yl2d3vajdO
	36gL1aRDPPCWE1zC/NRFiHA1SW45EM4U/OGowaWBWSLhSJIUX1M2USx4cyS7+785O42eNc6k7XI
	RQO8+edQqBgU7w8MUqjTX6Q5/lLQm4TmAWhNeK5FmIw3isQaEIV08gZGobMzsvrSWZUokQKGVWZ
	XIIxYikmPqbgf4HXYXmWqf/XLbA3eGwHohUBe9sz173ozzaEoNtVOTyiBbTrRqI2RWcYcJqvE+G
	HXbW1IEIliiPGtkr9B20oI0Q4NAUA3BE/J7rHOQYdjmZg9QGmVouSyrZXJT2RKTyr2Cz6eHd2H/
	xpIVdc+7f
X-Received: by 2002:a05:6830:4988:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7e5fed893demr7562326a34.9.1779680938801; Sun, 24 May 2026
 20:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adrian Korwel <adriank20047@gmail.com>
Date: Sun, 24 May 2026 22:48:48 -0500
X-Gm-Features: AVHnY4ILZevoNw-otkjh-DMkD3-TgQyfRZJgzVhQd76nn8nhr2Wf1aYMaGwk0N4
Message-ID: <CADgB2mEykL2CH-5And2m4_k+2Pc6UkWr=zxHGMyXsB5CRJvcLQ@mail.gmail.com>
Subject: [PATCH] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254068-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D34D95C5952
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gaudio_open_snd_dev() opens the ALSA control device file first, then
opens the PCM playback device. On two error paths the control file
handle is leaked:

1. When filp_open() for the playback device fails, the function
   returns immediately without closing the already-opened control
   file handle.

2. When playback_default_hw_params() fails, the return value was
   previously ignored and both the playback and control file handles
   were leaked.

Both leaks result in gaudio_cleanup() calling filp_close() on already
freed file objects when the bind error path in f_audio_bind() triggers
cleanup, causing a use-after-free detected by KASAN:

  BUG: KASAN: slab-use-after-free in filp_flush+0x23/0x1b0
  Read of size 8 at addr ffff88810d5523a8 by task bash/306
  ...
  gaudio_cleanup+0x59/0x100
  f_audio_bind+0x4b0/0x590

Fix by closing previously opened file handles before returning on
each error path, and by checking the return value of
playback_default_hw_params().

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1
implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/u_uac1_legacy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_uac1_legacy.c
b/drivers/usb/gadget/function/u_uac1_legacy.c
index 01016102fa17..5bcd3afd6366 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.c
+++ b/drivers/usb/gadget/function/u_uac1_legacy.c
@@ -226,12 +226,20 @@ static int gaudio_open_snd_dev(struct gaudio *card)
                ERROR(card, "No such PCM playback device: %s\n", fn_play);
                snd->filp = NULL;
+               filp_close(card->control.filp, NULL);
+               card->control.filp = NULL;
                return ret;
        }
        pcm_file = snd->filp->private_data;
        snd->substream = pcm_file->substream;
        snd->card = card;
-       playback_default_hw_params(snd);
+       if (playback_default_hw_params(snd) < 0) {
+               filp_close(snd->filp, NULL);
+               snd->filp = NULL;
+               filp_close(card->control.filp, NULL);
+               card->control.filp = NULL;
+               return -EINVAL;
+       }
        /* Open PCM capture device and setup substream */
        snd = &card->capture;
-- 
2.43.0

