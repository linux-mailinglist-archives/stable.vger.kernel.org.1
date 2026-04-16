Return-Path: <stable+bounces-238273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mODkBrig4GlukQAAu9opvQ
	(envelope-from <stable+bounces-238273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:41:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA340BB69
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AE8F30C0729
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B326B392812;
	Thu, 16 Apr 2026 08:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcGbp7+T"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B206157487
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328652; cv=pass; b=Xz+NjQv0yCdDoaf6jOmgJzz/8DFjDXeAVFaJ7znoGkSl7kbnP1aabaGBiOmw1SaAdt7YKdnBa5aC5tgu41MW4ZCsF8Eb8G/VpzFgCD53+5ia/Z9vykfGTp6g/9y+7h1+F1ulgzUfHbqxMWQ6KJsRQQtZd8UOEFXwwMtrjRLtwSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328652; c=relaxed/simple;
	bh=odwrunGrUaB0OlhzyNWFIRUSSKD3Z7u6GtC4cX0FT0s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tWf7V8BH3X6g3eF225e22wiJTYSKULPnZKM6f0ysNW5ggAoJybnpXg44/m4p9AN0gKNrd76Lm47g/ZnZ89jVW4fBmefpFLOGZ2wzZxIY4ALBlOiabjc/MAPTuQdtbgMuy2xKgLMU6QlKQtzL6lscp9yXaAFT229XHYgYJd3EWPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcGbp7+T; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b4520f6b32so8652399eec.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 01:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776328650; cv=none;
        d=google.com; s=arc-20240605;
        b=AnRnVCH5DNql5xGykmgAsMRGjdNXkoAwiAI2gNua8faYadnVDaGv9ilaib9PRNZlVA
         o6Uo1uncExfmF8Aop48ykB1d/KNUZm6qeUeg5wpzzfwM7hQeS231MFPU562UZWalvTt0
         hnqICSMiUio/yHvHxnuJ6p8AXu8ssNaBptUb5A0X3i2v/4Gb4lnw9yeK78JM0DdwN6Nl
         S83H3RWyQbj/t2mqmpCL6tof58xlY3Y8RoPaURjGTM+/ao8YHWUJ+GcR3GAB/owBw02B
         A+sS+z6sgdUCYhmtHgGZ4w0nqN31j+nRX6BOpkukjwZn4DAnfNPR7PSnNgmLYsQzl5vF
         547g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=niJrpeUEqFaIUms760ilKReu25zGDrsGDl3wAsfo6f8=;
        fh=8jalxgpoK0t1uFESqewYMJfjHeWk0jzool2wLDDGhOI=;
        b=igHpjRJzATlScE08YcJbMj2RadBTAyWoMiwk0ydbiP8q3vKbRWryh/MlNSX+QUncIY
         /EBq9mrhKrU8IbJp8GzKfziMfo5I4Gt7XORmOWTUamcLN2oMVQ9awv3hUVwxWdBjdPbk
         McekTcHtq7tLhCH/ejhfPBG/ANogbDxm2+dSLQMaYB6CpHN1clEUfOrNJ9Q/iLY9LkEy
         ++1GvJSUlSLca7zRi8+ZGR1bXLw0bmhTO9xc/budmSLgLPlZfY+K5CeURMiaBuZA0CZo
         /VcZs1ffOfylBADGo+fL5dKooKMoDCxt3ZTLlHxRbzsQ+49/Fe4k9Ge8lIgwv14Y6hjY
         pRLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776328650; x=1776933450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=niJrpeUEqFaIUms760ilKReu25zGDrsGDl3wAsfo6f8=;
        b=EcGbp7+TbIGF39ilVpcJE5sYX9HgIEcXT56Ri6/OldLmfR3iBiY1T/d3pbxFK4ioBX
         23Ox8QYS/T02SDToDYfQXyZ+EZys0RgXiKfahA5cYPesQNRtCyEyXpjTUVpUEwM0UBjT
         dfkkF5D4v1/vIHXWbHXSTi7h4m2rd9uehSgzhyDtaOup+PAE1XZDo/sMiTGBMeWjk62x
         FzZ6/IFMgqUNR4iytDvrwZiCt0sNKbto0papl1bfhaShvH0GzQzNv30DPR24Ky/LBUN0
         enN4HTXk+WIBFgsAmN+EfN/tG9pZUL0PxQ38rZO/7J0c8UM8aZyR0iRn3JqudkCpZX5q
         iNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776328650; x=1776933450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niJrpeUEqFaIUms760ilKReu25zGDrsGDl3wAsfo6f8=;
        b=iq4h0iwEebw61EM3izNSzyb29l/icTx4zi2ryB/CTuX0uqbon7LFLpA/+hnfKUYIwd
         r/YLBtji2choDEfRJer05JZ8XCkNzser2DAhxwnh/WU9DZKMEZugXbfQCyofAHlcvsII
         HX6mBoxlXfCmpxhH8/B9p4TTz4U8SCPCmiMPmjXNjsuwDJ5JzgXa+eZACkEIYn684Jc2
         +fUD7gx2+dWDW7Q18/Fh0mARUlCBa0/97+SAOAUvdu1xglGr0ji5aeoCudOgMkJfIasy
         m9kirpBKPEYeZID6Te6mCNtZ4ro3mzt5mys/IToC2hzCdqyj1FvFQQXWMcucY1qKodNR
         cIFA==
X-Forwarded-Encrypted: i=1; AFNElJ8/yp84+qTPVUSzz0H4QCDZB2rPrNVLJN3QFwx1jEzrdtp5dxv/F+0Bqri1MFndvxwdf6PBTCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hVJ0e78Nm0uXUVGAYnbXAC6jdl8IdPm7bO3ZuNJ0JuxcYLun
	ebgeiy2iRjt0LSP0RbjbWj6Te3DZtJFcpDuXD7YEoePy39x2OZLpm8FQcISOmYdWscPtN3BQJiG
	Mu+mMEJIGsmwhEAl2nGrWmd565ss/87U=
X-Gm-Gg: AeBDiet7FO5WRyUkVHJdgyyDGRdEBuNha8T6J4t2G9ZH7ElI0Fl2Bc//donvGbHFwov
	egoiJp0iRZEjMSS7QmTniKFq+og8l03QHM0aTwH+KFzaNpEte4Bd8bLBXZIb0juX1n5fDxYphRe
	tC/Xc76Ir9nAkXktjrnOTeAZKucy8v2yYIBTaAiWD2rRppHQe33pqu/XrSE9JulH3GAmqzGkvwG
	M7s1/L2Wh8XgN0nRmlQ+sIkWU/BbY723+NE6TEr17UTqJSOy5QVzKmYwtm4aYwgkIW2hL6dRi7X
	maqfxqk9U3YvrAUD2e/LRT27Uu0zVw==
X-Received: by 2002:a05:7300:ed0f:b0:2ba:a2fb:403f with SMTP id
 5a478bee46e88-2d58955d055mr12288054eec.21.1776328650277; Thu, 16 Apr 2026
 01:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sheroz Juraev <goodmartiandev@gmail.com>
Date: Thu, 16 Apr 2026 13:37:18 +0500
X-Gm-Features: AQROBzDoQb0IILDg6KGa5fE_DWshl8rJPN8rQSR6tc82k-mIlH91jQJ-yk5uLgk
Message-ID: <CADPJysx0mCpzh7b=kJC_OsZGvME9inx7EYo0imYwniCFO02FLg@mail.gmail.com>
Subject: RE: [PATCH wireless v2] wifi: iwlwifi: mld: stop TX during firmware restart
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238273-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goodmartiandev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 00BA340BB69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Miri,

Thanks for looking into this. Unfortunately I don't have the raw dmesg
logs from the original crash events =E2=80=94 I didn't save them at the tim=
e
and the journal has since rotated past those boots. I do have the
system configuration details and the memory profiling data that led
to the patch. Here's everything I can provide:

=3D=3D Hardware / Firmware =3D=3D

  Machine:    ASUS Zenbook 14 UX3405CA
  CPU:        Intel Core Ultra 9 285H (Arrow Lake), 16 cores
  WiFi:       Intel(R) Wi-Fi 7 BE201 320MHz
  PCI:        0000:00:14.3 [8086:7740] / subsystem [8086:00e4]
  Interface:  wlo1 (renamed from wlan0)
  Firmware:   101.6e695a70.0 bz-b0-fm-c0-c101.ucode, op_mode iwlmld
  Kernel:     6.19.5 (when crashes were occurring)
  OS:         NixOS (rolling release)
  modprobe:   options iwlwifi power_save=3D0
              options iwlmvm power_scheme=3D1

=3D=3D Observed behavior (kernel 6.19.5) =3D=3D

Under sustained Tailscale (WireGuard) UDP traffic + active SSH
sessions over WiFi, the firmware crashed with NMI_INTERRUPT_UNKNOWN
approximately every 10=E2=80=9315 minutes. Each crash triggered
ieee80211_restart_hw().

Two symptoms were observed after each firmware restart:

1) Massive skb memory leak. Memory profiling (/proc/allocinfo)
   showed the following after a single firmware crash cycle:

     10.8 GiB  16546157  net/core/skbuff.c:586  func:kmalloc_reserve
      3.94 GiB  16546144  net/core/skbuff.c:679  func:__alloc_skb

   ~7 GB of skb buffers leaked per crash. The TX path kept
   dequeuing frames from mac80211 and pushing them to the dead
   firmware (iwl_trans_tx() returning -EIO), allocating and
   immediately freeing skbs in a tight loop.

2) System freeze when TSO was enabled. With TSO/GSO active on
   wlo1, the crash path through iwl_mld_tx_from_txq =E2=86=92
   iwl_mld_tx_skb =E2=86=92 iwl_tx_tso_segment =E2=86=92 skb_segment =E2=86=
=92
   skb_release_head_state caused an RCU stall =E2=86=92 complete system
   freeze. Disabling TSO/GSO via ethtool prevented the deadlock
   but not the skb leak.

=3D=3D Workarounds applied =3D=3D

  - ethtool -K wlo1 tso off gso off  (prevents system freeze)
  - systemd watchdog service monitoring journalctl for
    "iwlwifi.*restart completed", then rmmod/modprobe cycle
    to reclaim leaked skb memory
  - net.core.wmem_max / rmem_max capped at 2MB (limits per-crash
    memory consumption)

=3D=3D Current status (kernel 6.19.11, linux-firmware 20260309) =3D=3D

On the current firmware (linux-firmware-20260309, same ucode
version string 101.6e695a70.0), the NMI_INTERRUPT_UNKNOWN crashes
have stopped entirely. I ran heavy SSH + Tailscale traffic for
10+ minutes with TSO re-enabled and no firmware crash occurred.

I checked the kernel changelogs: there are zero iwlwifi changes
between 6.19.6 and 6.19.11, so the stability improvement is most
likely from the firmware package update (the linux-firmware
snapshot changed between my 6.19.5 system and the current one).

=3D=3D Why the patch is still needed =3D=3D

Even if the specific NMI_INTERRUPT_UNKNOWN trigger has been fixed
in newer firmware, the code path is still unguarded:
iwl_mld_tx_from_txq() does not check mld->fw_status.in_hw_restart
before dequeuing. Any future firmware crash under load would hit
the same skb churn / memory leak. The RX path and TXQ allocation
worker already have this guard =E2=80=94 the TX dequeue path is the only
one missing it.

Let me know if there's anything else I can provide, or if you'd
like me to try reproducing on an older firmware version.

Thanks,
Sheroz

