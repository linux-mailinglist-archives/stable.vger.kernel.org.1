Return-Path: <stable+bounces-249456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKDJAcTnC2pXQgUAu9opvQ
	(envelope-from <stable+bounces-249456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:32:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC4D5773CA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 453293019BB5
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 04:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBEA2D978C;
	Tue, 19 May 2026 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY4YuZ0w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB11DE8BB
	for <stable@vger.kernel.org>; Tue, 19 May 2026 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779165117; cv=pass; b=sTMynsKhjQMUBiGVX5Kyiauxc/EeslBxjcVtjlNYiC9ZuSGn+cT+C2nzc50HO403IdkJ9zu/K9oOAUY+57J0jeWOTmkNPT+zzV6drzXtuU8bvh9FogFqKQNGMEK29hOGceKI97R2BDQNZkNmDWqHMwnZ6KrbiBfTy8y9J0Qsmes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779165117; c=relaxed/simple;
	bh=LB2eeG1SpolST48Ht8N5ZVmPK5SGJL8UVYCuIxMFohc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t/+uRx+1jpBEM3z7Y7MlaJvvh7a4UGfn87zWO/ou4Cz3+uht1rK+ytiEltjsz6r8L56/L/BMNB//DX3hv1Hgt/nD6iIKpFXYhIY5BybujBxG5pXfl/02YVc2wyMDvKsWZ4ymrFjhc+yXtAJ/hoZP/dst9KKwT+XdW+kfJ7k7Qvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY4YuZ0w; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44c350a5b87so1748279f8f.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 21:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779165114; cv=none;
        d=google.com; s=arc-20240605;
        b=FfxOll5ovbg6ZXU2pMe9eaukCIqWXr385lqvpdtLXGM/kEijguAVmu+/i7YOfPsGEW
         CSptMUtgaOh+v2cCfQszA9GzL5joTMpbhF0KagO/0VHQVmpdntqbhhtElQSNZSLC4OPt
         +0CPklujxv0WMqtpsHNavKoPUa8G9r0ix8SodbbVTGIoGYsrUHRbZeXfD4bhktbgPooq
         vLc//ZqQCnXDKMYQ9JK8en3s9HiuX/IY9kd5ABwPq2tHl2SQnl1fTz7pdqkmv1ljm3iv
         dbG9UWZ68/EHgdkjQJR/1Z/XR09XB7LtPZ4lCrq08I8EF3SRWvI0AZDvRiK4lXIjtjuo
         NfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LB2eeG1SpolST48Ht8N5ZVmPK5SGJL8UVYCuIxMFohc=;
        fh=BdX8wGZ+dTUX4YJ607sr5iji1+wspmhQp4GX6HOWhhw=;
        b=Ple3OnlUBu90Qmn38wAYlJTkLBQJQpGte4AnVZ3+Pb/GqXcxnwpruRTrg9aXxhk089
         rXSwILwN1UClMzjNFCXwGi2xus/IUA6L+casOXcuareMMU6zK19E/p9y+XcPV89gv2VV
         HNWb9VreoOd+uE6Z2UfRzSdOeBJERdYCWw6jIgNANXf8SgJ7SWOFbuw/tuxShVWc0UVb
         /w7/UnaZ4Tzm7Ek2n2LSLjgzfi8rg66UiNVXAiETSULNRygMqj4obv4svc1R9w2vz+VR
         RO3guWDop5xkwPmzUnykRSHdCGP5ZQ15pMOJtZl3uG5QJn1qeivsek4UWSPpWt8xQtRe
         Etqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779165114; x=1779769914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LB2eeG1SpolST48Ht8N5ZVmPK5SGJL8UVYCuIxMFohc=;
        b=TY4YuZ0w9Ef7EPQM7XJxtmopK1cr5oF036YqWHApUcnslpf1aJaV3+BSZodLfPvigX
         Q/CQHt6Us/Yj+Cke7mM+3tD6nNJ+srv52mgS1DRhXz8e7qgmZeAJ6CQ9fuYpH/DQxh8b
         T4ZnoXGCbtX81SJcS4BsDCe8q9T5+1mh5RIb+Vaf0q2iz/f7l8BSpMwVyEjeylvxn1CZ
         8u/b32nsTimLNzqophHb5E0UEjCak53l7hK8GXGaV9/yH02xLNr5E7CB6PEyzKShLnGp
         ku5dKq+K9MKK/7KjN4uHthIBpGSiAZ8xfJxRM4N+NssYEyImPLseYP4lFXZw4gf2LNd7
         gqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779165114; x=1779769914;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LB2eeG1SpolST48Ht8N5ZVmPK5SGJL8UVYCuIxMFohc=;
        b=Exo2a2EbEVNkbGcMMxveZgoaKNkjE8Ccm2RKL/TFEf7lo1ipADlbvmfdH3QvFS3CX3
         A6jMBSVwT6nCvfe16sSBw5mYhGk16KMEPhA9G/gnQDPauzY+ak+rPGvgaXR3y61nueb4
         Ysx07mO/zn4LIMXXRPsPlSeU+WvBTiurCT0rId2wXr/otBX3HjDOGxUCCmeOvA/VNnwF
         CHszeaO36nRQwMgRF1OMVsu5vIh2lusNhafTXyn5UVe19FGaWzzPm42F8IXcDJY0615l
         4Mxle+nD1UeNIKXr2Y7vTeFtHFRhl9Xey/4GKyYeFe7HauhaffQKuP6MIkjdb6DIaCCq
         Q3Zw==
X-Forwarded-Encrypted: i=1; AFNElJ8+NQgRkM5MtK5qWWu2PQeHAVRqnoIt/KAAyJAVW+G5LCFeFT5iHRWZ/eh30EbQLDIPWRtLKNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfBadkG1KPkvSMpLyXIOWK3U1CiL0fCrjEK2tt7kBJ+s8uwT8
	sPGilWSm9dh503G4Ic0hqM2DgMnGgav5oJJkZ1HCT5jgMc+iGLfWkc4JIVZ12J5C9ONnZ+eeg3J
	oD5lKeWhFcNVU+Wot9aE/u2mpNH4/gTo=
X-Gm-Gg: Acq92OEJ3LZzpqgKTi/BEoIgMM2+nEsRRBma9tdz3Nc9hyd0L0/Qm4Kwc1kL8MNQRVH
	jdLms5QgOTq48uZXoUZERJH3QdkSuPu9Jyq6GutL8PAKtCu9WXwE92amBsGQBMKXMG46mgCIVb+
	jBN5ZjAXKHAHZKyZ80cfs+xhRM6gnGfaIJncfgoF7rR4WPJuXcV62eNVp3ShQQwrtc22ErxyhzL
	hVd/psxsjzpMBDWySdRBB+BJ0ZrGIQjf3DpPRYJ0VALYbC4yj5RbM06Go22mmnjh7Ha1Cdd6Dry
	TjE6CZS4bFxq5EHiJo8g
X-Received: by 2002:a05:600d:10:b0:48f:cfae:b654 with SMTP id
 5b1f17b1804b1-48fe60e5537mr217793815e9.1.1779165113908; Mon, 18 May 2026
 21:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Baley Eccles <baleycod@gmail.com>
Date: Tue, 19 May 2026 14:31:42 +1000
X-Gm-Features: AVHnY4Li5nUZrvw8vcm2bYlGMK9IhnqMjGOljLZnXZ-_QnQCztFbvk2LXkdu2tc
Message-ID: <CADCSNFD0Ut-jJohTQFczjBgaVf=mBrc2rq4hJQncVZpF4bCoxw@mail.gmail.com>
Subject: [REGRESSION] Bluetooth: MT7922 fails to initialize after "Bluetooth:
 btmtk: validate WMT event SKB length before struct access"
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249456-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baleycod@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4DC4D5773CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject: [REGRESSION] Bluetooth: MT7922 fails to initialize after
"Bluetooth: btmtk: validate WMT event SKB length before struct access"

Hi all,

I have experienced and looked into a regression on a MediaTek MT7922
adapter. Bluetooth works on v6.18.29, fails on v6.18.30, and reverting
the bisected commit fixes it.

Hardware:
MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter [14c3:7922]
Subsystem: AzureWave ASUS PCE-AXE59BT [1a3b:5300]

Good kernel:
6.18.29-p2-gentoo-dist
Upstream base: v6.18.29

Bad kernel:
6.18.30-p1-gentoo-dist
Upstream base: v6.18.30

Failure:
bluetoothctl list prints nothing / no default controller is available.

Bad dmesg:
Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
Bluetooth: hci0: Failed to send wmt func ctrl (-22)
Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
advertised, but not supported.

Good dmesg:
Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
Bluetooth: hci0: Device setup in 129909 usecs
Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
advertised, but not supported.
Bluetooth: hci0: AOSP extensions version v1.00
Bluetooth: hci0: AOSP quality report is supported
Bluetooth: MGMT ver 1.23

Firmware:
/lib/firmware/mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
/lib/firmware/mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin
/lib/firmware/mediatek/WIFI_RAM_CODE_MT7922_1.bin

Bisect result:
624fb79dadc1b65757986a9d0fdde5c0cf3fe179 is the first bad commit

Bluetooth: btmtk: validate WMT event SKB length before struct access

This is a stable backport of upstream commit:
634a4408c0615c523cf7531790f4f14a422b9206

Reverting 624fb79dadc1b65757986a9d0fdde5c0cf3fe179 on top of v6.18.30
fixes the issue and Bluetooth works again.

Please let me know if there is any additional logging or testing I can provide.

#regzbot introduced: 624fb79dadc1b65757986a9d0fdde5c0cf3fe179

Cheers,
Baley

