Return-Path: <stable+bounces-249154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMrAOXBOCmqQzQQAu9opvQ
	(envelope-from <stable+bounces-249154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:25:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D985645B2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 01:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4CF1300A768
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 23:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3263603E0;
	Sun, 17 May 2026 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpdxvxyw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9232E6B4
	for <stable@vger.kernel.org>; Sun, 17 May 2026 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779060331; cv=pass; b=oR1BwQ277xMsT+Egrw86CHShs+R5w7lg3gLkplkVAdxLEGNrR+b1riIjzwRs3vgW63LXvYQxM9B0HkZxRjF+NTHDgreeuynxytbVWCWYC4jlw8cMb4m5aL/tFvrseT6l0QKW347WCRNd2l7vroFZLsBLfuiZNr7v7kZJ7z6k2M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779060331; c=relaxed/simple;
	bh=oQMlYsX+VgifZz5u10HC4ZEMVQVuCOrZ67vfrQ1RB6s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=vGf0wavEKTtSju+8MWA5cyKD8XL7WnSPQ09LK16Yx+PbX6kPK+HMSUEmxHboK1XJvhgTPFWcerSq9HelJgF+pMEJ1TwBEXH4rBsvb3CPH6ivmZPA1dnsPAkQ28smElAV7Tuo8kmzN564sZKtlY+IIJR6h2UoN+lKJlMeQbTEq00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpdxvxyw; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so6998886eec.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 16:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779060329; cv=none;
        d=google.com; s=arc-20240605;
        b=E9HdJ9fezwvZdse0AFACTSE5Y1P6ScSQDI0Dh0oIU862j4Q0Y1/pguVP4RXAk2K236
         ncjbG3UPgdBBcFvs2w2uQYUABk3S2mbcewRXSQZshwJ2o2vguKYetm4JnccE6F/zGSLC
         uhiIGc/HqBKI28t1Bc70NSwKaLc19MgcuX+nYw5Cj/jwzJS7awStm0yn7s3b8pkCam4t
         OMkAsDXVVxwC1l+Ar7cBAtoXQpCJ24N/Oei6gZn19PNv2ImUXskQZyv5joS8VdqznAUc
         yiuyoiyGCAur1kjU090lNNhbII6d0GXM9CUaFBPITLUVwiP7rFEmGdbjHPPZkmsSkM9T
         NfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=oQMlYsX+VgifZz5u10HC4ZEMVQVuCOrZ67vfrQ1RB6s=;
        fh=x+XBfUetiqtoM2ihGwm/VApDWP5GmBTn8GckWxMqmNo=;
        b=A9ZQYRF0Rnl9lNq3XGdOzbI4fnM0+s05n2TfWOkUt1CtDgH/56AN8wtYH6T+nXzDeN
         0x7K5Esyjwup+la3OmAhTnvB4eieKhtM2ECbcK654B9VlDe8T1hPNeoJkR2uq2EnDH7U
         wXDQdxPQ9LOSNHWoSUEt5mH8zLDhgkNVexG8XZF1umI38+Xc69ucl+h3ePsRZJxS366Y
         DN7DdvAEbGBe9eWp8HjY0yX3Wl2ffbJ4zR2mK1sqbgLt27XeL8UWAfB9X7+4cUriWd4U
         kYP5bRIkJgxnf/YozWOVLflOBxylVvZ9JXIsUtQIOzzGw/B44YTCl2NP5YEmPrUken1e
         zMjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779060329; x=1779665129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQMlYsX+VgifZz5u10HC4ZEMVQVuCOrZ67vfrQ1RB6s=;
        b=MpdxvxywM23tEMa+p+S4FucznTx6wftW6GqyRn4MkXbXEdUFpEvvyKIMdRHNNKhYxp
         uEasM96n93LnExhAgxWcBhfMicoaKlP6+3YTD+BtTQBC6YzgzXqonPf+qdC2IMVTIDrY
         XISthFKJQfFCmgagd4h0PJUYZiQd3PikvTF+hJlrjh06g/XsihcMq7zDjULrMEcmpcXQ
         zm/3NjqONKIsvGj4uCaByzXeZ7umLdCW6cn63NOcb0wH80hOh+OM3H6dApdS7wCONW73
         FTV0lTqOGxlslippL1cIFWeS+32Smf7A7HArwCZnCUJ/LzAFjX/F5kcWn6RS6pmPKZWj
         Gy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779060329; x=1779665129;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQMlYsX+VgifZz5u10HC4ZEMVQVuCOrZ67vfrQ1RB6s=;
        b=kZgi24Hh/4Jd9FluxAKa/b4JaoOcN7Qm+b2It+ms+Kn/RowNjpkcPj0MIo9tQ+HhyZ
         pabdXugrsxcg53CyuqZfewsRXCnYXEhTxGQtVtE5CpuCctiPMqU4qZLd0UpVND4bztkO
         yrpCfldoK6KmPPXyn9EbYWd/WIN1/hUPF3Gvr2n2pgSrIdsBxXjW4cNez3KX4Rqe63D+
         UHb5GpLHEZ+dWolsee9cEZxoAzsLlHEnUUSh6kqoHdyDqPMJyiGj+bBLH01tOx3Wda9G
         I80kapEfemz/gLfEtbDBXOtllLfFAyxeJTAb4aT7PzqlI/tu7h+LamQ21kfoRbrvdDaj
         WsOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ju9FYYMja0LkxPPPELI9otP4gcaD3Q8I5St8tj6MrMULJVbmKbyquwbaZHT70p9YB/DiohPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHr5iDJlkQD0b+a16/VeVYlMZGyhqZSflSX2j/5WPN+RimARx
	TTY3egvoqrr9UtoSI0IGxGYg6DkHLKEprubax82ow10XRGnBa8vXnHMgffNELN+r8c3qExTPIqU
	NXtOUnz/4SNbxl4vUqXnpmBjXC/QSi18=
X-Gm-Gg: Acq92OHQuNa6lveFckbrLDQwQ5gDLXs1JgOugyBm3BwXXmrlmtyduwyff66IcME4wwf
	lSBCM5NNT4etkn6eDCA0fP0CDCSXAAFK0moBVf9tos/tQUG9i8AfPPx6cFrkjsWwz1RjkC8zT6f
	VAtP1jwlnM8Ks3HGbiyzYry9sefj3G/SylvouU82kjIdUb9UAX5cFfxxaYgdkO3zWwn2v5z5xTl
	5JTMEC+VW3j33QNHOi24RrRDoag3lsa9Y+kLRJdJYHXtCPNP0sC6TgdRdFr6ZYJvLETZW/zXpoq
	ZcC1IL+QTa9iz4au0z96L4Gijz2ob6i38F+2zVH6
X-Received: by 2002:a05:7300:e125:b0:2f5:6d9c:7156 with SMTP id
 5a478bee46e88-303986814f8mr6045988eec.17.1779060329249; Sun, 17 May 2026
 16:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brandon Arnold <brandon.arnold@gmail.com>
Date: Sun, 17 May 2026 16:25:17 -0700
X-Gm-Features: AVHnY4InOi6pS-JhDeB7XWvzVJUHUwJqjaT6X2kyEDvJ9oU5Qy6fDU_IKgrEFzo
Message-ID: <CAM07e=vYJE8khJmbsn75SOYye44o8YV8TZsRyF1mFRuUTMCgUw@mail.gmail.com>
Subject: [REGRESSION] Bluetooth: btmtk: MT7922 "Failed to send wmt func ctrl
 (-22)" after 634a4408c0615c ("validate WMT event SKB length before struct access")
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, tristan@talencesecurity.com, 
	chris.lu@mediatek.com, linux-mediatek@lists.infradead.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 62D985645B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249154-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brandonarnold@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,archlinux.org:url]
X-Rspamd-Action: no action

#regzbot introduced: 634a4408c0615c206885e60ea05f489c426f64b6
#regzbot title: MT7922 BT controller never registers (wmt func ctrl
-22) after btmtk WMT SKB-length validation

Hello there.

I wanted to report the below information about a commit that I
confirmed broke my MediaTek MT7922 adapter. The commit is also built
into the main Arch Linux package, so it affected me during a routine
update (see the BBS link in the report below). This adapter is the one
that came with my Framework Laptop 16 system.

Apologies for Claude's verbosity and language but I can confirm I
attended the bisect and revert of the offending diff. Thank you!

Workaround in use: pinned to the Arch Linux pre-7.0.7 kernel.

Thanks,
Brandon Arnold

Commit 634a4408c0615c ("Bluetooth: btmtk: validate WMT event SKB
length before struct access"), backported to 7.0.x stable and shipped
in v7.0.7, breaks Bluetooth on the MediaTek MT7922: the WMT function
control step fails with -EINVAL and the HCI controller never
registers. WiFi on the same chip (mt7921e) is unaffected.

This is NOT a v6.19->v7.0 mainline regression -- mainline v7.0 is
GOOD. The regression is the above commit specifically; it is absent
from v7.0 and v7.0.6 and present in v7.0.7.

Scope / affected versions
-------------------------
- GOOD: mainline v7.0, linux-stable v7.0.6 (commit absent)
- BAD: linux-stable v7.0.7 (commit present)
- Independently reported on Arch (different machine -- Lenovo
IdeaPad, MT7922 USB [0489:e0d8]): BROKEN on linux 7.0.7.arch2-1,
WORKING on 7.0.6.arch1-1, identical symptom.
https://bbs.archlinux.org/viewtopic.php?id=313561

Hardware / firmware (primary reporter)
--------------------------------------
- Framework Laptop 16 (AMD Ryzen AI 300 Series), board FRANMHCP09 A9
- BIOS: INSYDE/Framework 03.04, 2025-11-06
- MT7922, PCI [14c3:0616] subsys [14c3:e616]; BT side USB, driver
btusb/btmtk; WiFi side mt7921e (works)
- linux-firmware 20260410; BT firmware BT_RAM_CODE_MT7922_1_1,
HW/SW Version 0x008a008a, Build Time 20260224103448
- bluez 5.86

Symptom
-------
The firmware download and version handshake still succeed (identical
HW/SW version line before and after), then:

Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
Bluetooth: hci0: Failed to send wmt func ctrl (-22)

No "Device setup in N usecs" follows; BlueZ reports "No default
controller available". hci0 exists in /sys/class/bluetooth and is not
rfkill-blocked. Reproducible deterministically on cold boot,
`modprobe -r btusb; modprobe btusb`, and full USB unbind/rebind. It
fails even with btusb enable_autosuspend=0, so this is distinct from
the known func-ctrl/autosuspend race.

Analysis
--------
634a4408c0615c reworks btmtk_usb_hci_wmt_sync() to validate length
with skb_pull_data() before casting the WMT event:

- wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+ wmt_evt = skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+ if (!wmt_evt) { ... err = -EINVAL; goto err_free_skb; }
...
case BTMTK_WMT_FUNC_CTRL:
+ if (!skb_pull_data(data->evt_skb,
+ sizeof(wmt_evt_funcc->status))) {
+ err = -EINVAL; goto err_free_skb;
+ }
wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;

For the FUNC_CTRL response from the MT7922, one of these
skb_pull_data() calls returns NULL and the function returns -EINVAL
(surfaced as "Failed to send wmt func ctrl (-22)"). In effect the
length the driver now requires
(sizeof(struct btmtk_hci_wmt_evt) + sizeof(status)) exceeds what this
controller actually sends for FUNC_CTRL, so a valid handshake is now
rejected. The pre-patch code cast and read the same bytes without the
strict length gate and worked on this hardware.

Empirical confirmation (mainline, no distro patches)
----------------------------------------------------
Built faithfully from the running Arch config (only LOCALVERSION
added); no out-of-tree changes.

- mainline v7.0 : GOOD (commit absent)
- linux-stable v7.0.7 : BAD (kernel 7.0.7-bisect; WMT func ctrl -22
count = 1; hci0 device setup never completes; bluetoothctl shows 0
controllers)
- v7.0.7 + revert of
70d37a8b9229 (the 7.0.7
backport of 634a4408c0615c): GOOD (kernel
7.0.7-bisect-00001-ge33bfb5d7480; WMT func ctrl -22 count = 0; hci0
device setup OK; bluetoothctl shows 1 controller)

The reverted tree's drivers/bluetooth/btmtk.c is byte-identical to
v7.0.6 (git diff v7.0.6 -- drivers/bluetooth/btmtk.c is empty), so the
v7.0.7-vs-revert pair isolates exactly this one commit.

Reproduction
------------
1. Boot a kernel >= v7.0.7-equivalent on MT7922 hardware.
2. `bluetoothctl list` -> no controller.
3. `journalctl -k -b | grep 'wmt func ctrl'` -> -22.
4. Revert 634a4408c0615c (or boot v7.0.6) -> controller registers.

A straight revert restores operation and is offered as the candidate
fix; alternatively the length checks should be relaxed to match the
MT7922's actual FUNC_CTRL WMT event length. I can test patches, or
provide full bad/good kernel logs, btmon/hci traces, and the exact
short SKB length on request.

