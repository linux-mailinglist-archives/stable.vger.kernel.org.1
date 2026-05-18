Return-Path: <stable+bounces-249182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEe0CgiYCmpy4AQAu9opvQ
	(envelope-from <stable+bounces-249182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 06:39:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD21C565B30
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 06:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83BDF300361B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 04:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D6A382393;
	Mon, 18 May 2026 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HAZP68dX"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896571EB5E3;
	Mon, 18 May 2026 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079172; cv=none; b=LqsLE+45ma8Tb/5TO/GMgY4MFRRkvsyB+Pv+3Bm1Qa0GXDAZ9icDqvoGnY4qvpMt2jCSHSiYTdSxNdwkhY2W1Dgp0L/9lWi467uyYnX2Nkxy6Nid+M/zj3d021hUdAqDjq8M1bDwVnzYbumAHRZCc6FvFL+mhqhYvpxXmoprrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079172; c=relaxed/simple;
	bh=OzaLGagXIHUtFy4JrSoMFMJIG2DLcb6UhsO9uRYB6g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOgjKLCEKDvlAcUWBF16f7NzegWg+Os6a05ANywTWngqj8GxCLmmHpfUQ+d7o8hSkhvU1/4fx+Dh9kKcjePIbGJ8KdB/Ab2M04Yxm+ibLIh9is6QQ6CCkf/J8C9cZbpCde/AbY4pNlS/DtQ3xuVwAix3VFKN+5sGHIfWZ3mW410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HAZP68dX; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4gJlSp4Hxnz88ZL;
	Mon, 18 May 2026 06:39:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779079162;
	bh=OzaLGagXIHUtFy4JrSoMFMJIG2DLcb6UhsO9uRYB6g8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HAZP68dXuFErFiaB+INOgkEdsO10jvzRmFUKyFdzVCGCu6WxdgVZDQbVFwGsSllig
	 9NQjT+wBml17Kn/LBOgncXFxxGdvfo/Q3AWutV6IQHE42mPtxff3NCZnZP+mmCXUif
	 2UcRag51H4m6H0R/ESavFG60Ke4im7Mhu2GR1yOl7r5KPfs7CCSNEZm7YDyQTILFZ1
	 IQ0PmHwzCGqDyJhZet5DZY93hYCzWW32FR17QQeIU51rpwXRPDTvNPjeN3MyMkBVi0
	 9byMT2qUOCvH54YxBAwmTk/BME+dkyNLvAJasLLMo8CIVNbKmuMoUYBsYzC3FWgUFG
	 n0/c7NztsIfKg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4gJlSp3bmFz4y9R;
	Mon, 18 May 2026 06:39:22 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gJlSn06SVz8sbH;
	Mon, 18 May 2026 06:39:21 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id EEDD761859;
	Mon, 18 May 2026 06:39:19 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <e31f3922-a3e4-4993-aad5-d3973e8fd88e@leemhuis.info>
Date: Mon, 18 May 2026 06:39:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Bluetooth: btmtk: MT7922 "Failed to send wmt func
 ctrl (-22)" after 634a4408c0615c ("validate WMT event SKB length before
 struct access")
To: Brandon Arnold <brandon.arnold@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, tristan@talencesecurity.com,
 chris.lu@mediatek.com, linux-mediatek@lists.infradead.org,
 gregkh@linuxfoundation.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
References: 
 <CAM07e=vYJE8khJmbsn75SOYye44o8YV8TZsRyF1mFRuUTMCgUw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAM07e=vYJE8khJmbsn75SOYye44o8YV8TZsRyF1mFRuUTMCgUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177907916034.1224972.6526818772537645703@mxe9fb.netcup.net>
X-NC-CID: PkYu26wWqt6EFZ70ruyetuywmOlLLQScmB9N8nSUyoxWkDceoy4=
X-Rspamd-Queue-Id: BD21C565B30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249182-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,leemhuis.info:mid,leemhuis.info:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/18/26 01:25, Brandon Arnold wrote:
> #regzbot introduced: 634a4408c0615c206885e60ea05f489c426f64b6
> #regzbot title: MT7922 BT controller never registers (wmt func ctrl
> -22) after btmtk WMT SKB-length validation

Thx for the reports, there are quite a few similar ones already; the
problem is known and the fix (see the link below) should be heading to
mainline this week and from there go to stable.

Ciao, Thorsten

#regzbot dup:
https://lore.kernel.org/linux-bluetooth/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/

> Hello there.
> 
> I wanted to report the below information about a commit that I
> confirmed broke my MediaTek MT7922 adapter. The commit is also built
> into the main Arch Linux package, so it affected me during a routine
> update (see the BBS link in the report below). This adapter is the one
> that came with my Framework Laptop 16 system.
> 
> Apologies for Claude's verbosity and language but I can confirm I
> attended the bisect and revert of the offending diff. Thank you!
> 
> Workaround in use: pinned to the Arch Linux pre-7.0.7 kernel.
> 
> Thanks,
> Brandon Arnold
> 
> Commit 634a4408c0615c ("Bluetooth: btmtk: validate WMT event SKB
> length before struct access"), backported to 7.0.x stable and shipped
> in v7.0.7, breaks Bluetooth on the MediaTek MT7922: the WMT function
> control step fails with -EINVAL and the HCI controller never
> registers. WiFi on the same chip (mt7921e) is unaffected.
> 
> This is NOT a v6.19->v7.0 mainline regression -- mainline v7.0 is
> GOOD. The regression is the above commit specifically; it is absent
> from v7.0 and v7.0.6 and present in v7.0.7.
> 
> Scope / affected versions
> -------------------------
> - GOOD: mainline v7.0, linux-stable v7.0.6 (commit absent)
> - BAD: linux-stable v7.0.7 (commit present)
> - Independently reported on Arch (different machine -- Lenovo
> IdeaPad, MT7922 USB [0489:e0d8]): BROKEN on linux 7.0.7.arch2-1,
> WORKING on 7.0.6.arch1-1, identical symptom.
> https://bbs.archlinux.org/viewtopic.php?id=313561
> 
> Hardware / firmware (primary reporter)
> --------------------------------------
> - Framework Laptop 16 (AMD Ryzen AI 300 Series), board FRANMHCP09 A9
> - BIOS: INSYDE/Framework 03.04, 2025-11-06
> - MT7922, PCI [14c3:0616] subsys [14c3:e616]; BT side USB, driver
> btusb/btmtk; WiFi side mt7921e (works)
> - linux-firmware 20260410; BT firmware BT_RAM_CODE_MT7922_1_1,
> HW/SW Version 0x008a008a, Build Time 20260224103448
> - bluez 5.86
> 
> Symptom
> -------
> The firmware download and version handshake still succeed (identical
> HW/SW version line before and after), then:
> 
> Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
> Bluetooth: hci0: Failed to send wmt func ctrl (-22)
> 
> No "Device setup in N usecs" follows; BlueZ reports "No default
> controller available". hci0 exists in /sys/class/bluetooth and is not
> rfkill-blocked. Reproducible deterministically on cold boot,
> `modprobe -r btusb; modprobe btusb`, and full USB unbind/rebind. It
> fails even with btusb enable_autosuspend=0, so this is distinct from
> the known func-ctrl/autosuspend race.
> 
> Analysis
> --------
> 634a4408c0615c reworks btmtk_usb_hci_wmt_sync() to validate length
> with skb_pull_data() before casting the WMT event:
> 
> - wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
> + wmt_evt = skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
> + if (!wmt_evt) { ... err = -EINVAL; goto err_free_skb; }
> ...
> case BTMTK_WMT_FUNC_CTRL:
> + if (!skb_pull_data(data->evt_skb,
> + sizeof(wmt_evt_funcc->status))) {
> + err = -EINVAL; goto err_free_skb;
> + }
> wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
> 
> For the FUNC_CTRL response from the MT7922, one of these
> skb_pull_data() calls returns NULL and the function returns -EINVAL
> (surfaced as "Failed to send wmt func ctrl (-22)"). In effect the
> length the driver now requires
> (sizeof(struct btmtk_hci_wmt_evt) + sizeof(status)) exceeds what this
> controller actually sends for FUNC_CTRL, so a valid handshake is now
> rejected. The pre-patch code cast and read the same bytes without the
> strict length gate and worked on this hardware.
> 
> Empirical confirmation (mainline, no distro patches)
> ----------------------------------------------------
> Built faithfully from the running Arch config (only LOCALVERSION
> added); no out-of-tree changes.
> 
> - mainline v7.0 : GOOD (commit absent)
> - linux-stable v7.0.7 : BAD (kernel 7.0.7-bisect; WMT func ctrl -22
> count = 1; hci0 device setup never completes; bluetoothctl shows 0
> controllers)
> - v7.0.7 + revert of
> 70d37a8b9229 (the 7.0.7
> backport of 634a4408c0615c): GOOD (kernel
> 7.0.7-bisect-00001-ge33bfb5d7480; WMT func ctrl -22 count = 0; hci0
> device setup OK; bluetoothctl shows 1 controller)
> 
> The reverted tree's drivers/bluetooth/btmtk.c is byte-identical to
> v7.0.6 (git diff v7.0.6 -- drivers/bluetooth/btmtk.c is empty), so the
> v7.0.7-vs-revert pair isolates exactly this one commit.
> 
> Reproduction
> ------------
> 1. Boot a kernel >= v7.0.7-equivalent on MT7922 hardware.
> 2. `bluetoothctl list` -> no controller.
> 3. `journalctl -k -b | grep 'wmt func ctrl'` -> -22.
> 4. Revert 634a4408c0615c (or boot v7.0.6) -> controller registers.
> 
> A straight revert restores operation and is offered as the candidate
> fix; alternatively the length checks should be relaxed to match the
> MT7922's actual FUNC_CTRL WMT event length. I can test patches, or
> provide full bad/good kernel logs, btmon/hci traces, and the exact
> short SKB length on request.


