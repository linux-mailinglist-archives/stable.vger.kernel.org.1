Return-Path: <stable+bounces-249457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBtVB9PvC2oDRgUAu9opvQ
	(envelope-from <stable+bounces-249457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:06:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7891657757B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4255B3025729
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8720C23BD1B;
	Tue, 19 May 2026 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="K5koFewW"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891BC30B517;
	Tue, 19 May 2026 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779167169; cv=none; b=Z9nFuZyd+gvF611rBkjcII0wmAfNGr9P7LkX3niibglPT0NluMzWlA4/95Y/qbgMlufhMGOCNm2Xf6XEFAcPL2fSdQJ1uRJfHG46wgquV2Ukvw18N4G8nV0Wlp3jsMhvefhYUYV+VSKxDNJS2OTV4yLs8teKSfKMmZSj4WfCTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779167169; c=relaxed/simple;
	bh=FAiCEhzhtFbXPSs7rpt5n/p1t2w9wK7VlAtkJJg+KxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKQ/h/6P65Ndy+agKBHaS/sLqz2DlBgfvgswcl6WtsRlIardW/HuT+roqbmOvT7DuilotZBHec7Pmm3li0l+839g+YUUb9vDqemuFtxuieR+FJ/yL4miGm+UOr7hOiZs2S++bOLtmlGZPScXlxLqfGJ5IZko7IpCLmHc509Zi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=K5koFewW; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gKN0z3wSZz94yW;
	Tue, 19 May 2026 07:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779167155;
	bh=FAiCEhzhtFbXPSs7rpt5n/p1t2w9wK7VlAtkJJg+KxY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K5koFewWjOv2W8vANcfdXTMyEtXNYiUyZ95mUequ8KmkWT+fgzDTFAXrIehrfI23b
	 tpJMxJXRrvVJ7+xn5vN2JaIrLvqj8VkZRjgBgbIuNdmizmU7cJ/7Hv4VMJquKzpXFA
	 qtIBP3sZqn/hWy6MGytcy8e0K5GDF/UCrxcuxvicfvI7VCEje9HMTNwevZZC+uy6xI
	 /F7xPUTaUjgplsY4uSpTCo7RXmzjbxzOAhnD6NDTAh8OIOpu5JYk7prM5kb/RO5gdL
	 tNDEgc4aRuVXxVkYJSAeOKxO1e/YIndepX0zm5SWrK/trrflexI7bgCDKojglYwwT0
	 PIqNktQ2AJ3Rg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gKMzw5nYDz7v62;
	Tue, 19 May 2026 07:05:00 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gKMzw1QcXz8sbH;
	Tue, 19 May 2026 07:05:00 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 311F861884;
	Tue, 19 May 2026 07:04:59 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ff4c4ba2-dc26-4b05-87c2-03cc70afdcc5@leemhuis.info>
Date: Tue, 19 May 2026 07:04:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Bluetooth: MT7922 fails to initialize after
 "Bluetooth: btmtk: validate WMT event SKB length before struct access"
To: Baley Eccles <baleycod@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: 
 <CADCSNFD0Ut-jJohTQFczjBgaVf=mBrc2rq4hJQncVZpF4bCoxw@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CADCSNFD0Ut-jJohTQFczjBgaVf=mBrc2rq4hJQncVZpF4bCoxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177916709967.849087.9352424421516320279@mxe9fb.netcup.net>
X-NC-CID: vq9DJS+14lEdcttPEpzaRJbmdMSDWX9ZqxtKYJX+AwMCHyCP/iQ=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,leemhuis.info:mid,leemhuis.info:dkim];
	TAGGED_FROM(0.00)[bounces-249457-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7891657757B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 06:31, Baley Eccles wrote:
> Subject: [REGRESSION] Bluetooth: MT7922 fails to initialize after
> "Bluetooth: btmtk: validate WMT event SKB length before struct access"
> 
> Hi all,
> 
> I have experienced and looked into a regression on a MediaTek MT7922
> adapter. Bluetooth works on v6.18.29, fails on v6.18.30, and reverting
> the bisected commit fixes it.

Thx for the report, there are quite a few similar ones already; the
problem is known and the fix (see the link below) should be heading to
mainline this week and from there go to various stable series.

Ciao, Thorsten

#regzbot dup:
https://lore.kernel.org/linux-bluetooth/770d36b07311bf88210c187923f243fb9f126f04.1777058551.git.pav@iki.fi/

> Hardware:
> MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter [14c3:7922]
> Subsystem: AzureWave ASUS PCE-AXE59BT [1a3b:5300]
> 
> Good kernel:
> 6.18.29-p2-gentoo-dist
> Upstream base: v6.18.29
> 
> Bad kernel:
> 6.18.30-p1-gentoo-dist
> Upstream base: v6.18.30
> 
> Failure:
> bluetoothctl list prints nothing / no default controller is available.
> 
> Bad dmesg:
> Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
> Bluetooth: hci0: Failed to send wmt func ctrl (-22)
> Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
> advertised, but not supported.
> 
> Good dmesg:
> Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20260224103448
> Bluetooth: hci0: Device setup in 129909 usecs
> Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is
> advertised, but not supported.
> Bluetooth: hci0: AOSP extensions version v1.00
> Bluetooth: hci0: AOSP quality report is supported
> Bluetooth: MGMT ver 1.23
> 
> Firmware:
> /lib/firmware/mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin
> /lib/firmware/mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin
> /lib/firmware/mediatek/WIFI_RAM_CODE_MT7922_1.bin
> 
> Bisect result:
> 624fb79dadc1b65757986a9d0fdde5c0cf3fe179 is the first bad commit
> 
> Bluetooth: btmtk: validate WMT event SKB length before struct access
> 
> This is a stable backport of upstream commit:
> 634a4408c0615c523cf7531790f4f14a422b9206
> 
> Reverting 624fb79dadc1b65757986a9d0fdde5c0cf3fe179 on top of v6.18.30
> fixes the issue and Bluetooth works again.
> 
> Please let me know if there is any additional logging or testing I can provide.
> 
> #regzbot introduced: 624fb79dadc1b65757986a9d0fdde5c0cf3fe179
> 
> Cheers,
> Baley


