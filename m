Return-Path: <stable+bounces-210584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAgADajgb2n8RwAAu9opvQ
	(envelope-from <stable+bounces-210584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:08:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5644B073
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 177E27C5F53
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4741E44A724;
	Tue, 20 Jan 2026 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zacbowling-com.20230601.gappssmtp.com header.i=@zacbowling-com.20230601.gappssmtp.com header.b="rRF837K0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E1441030
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931974; cv=pass; b=BDc66Hvwwvl7aGlVMnj4dceglXiaVB5xpOrubhiDFyLvfJtD51IDkqZeRoLge/Bqk/83bwFZapJO7FzBtHFwkjt7jx5dEDh2XDaaOIcMCnil0tQSCov7IbT96txzpJIevh8jyGgkjeT6FaDdc21HSFCUNnpKcjKXcv5pAfOso0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931974; c=relaxed/simple;
	bh=WC/xFoBoO3sn2X/CV79oG5iqmr1x8xkb9P+uVwkfO3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnM0nl6lzrAgSaS+3gIWVRwL3ovQQfsMrtIzk8D7S9sVWucQxrYsXwELRBrg5VyGbmkQMuFKLgRQAAuKvz7udzEQKu9Pmps4nb99vUs7mHqv7bCSULuZ5m3L+w/T+UXPd32rUzu14nG4ykyjpTcCHGUxlh7EUnaYrkGG7U0vzps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=zacbowling-com.20230601.gappssmtp.com header.i=@zacbowling-com.20230601.gappssmtp.com header.b=rRF837K0; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so8973780a12.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 09:59:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768931969; cv=none;
        d=google.com; s=arc-20240605;
        b=DlapYMNL5NP1RE9AdVee0URaE66Q1ycCd+D9sr7gC1KanYGQCuRp/fx6TUJFrB5gOH
         UOs8qM97Llf/xogx6eZiuDToIxlg5txodHyJejGdsw/eSPy6u3VIRcSTWoqCk/RZl1VZ
         lXGOGK8+xte1YTDmleMrqPCCWv90EybK6JnXPX1lOGuboyEdLgSQZAJbJeALeXMyYnpR
         q6kdxNKzXdwqvuob3It2/AXpacFODJ7VaengEYXextEj9nZWWxuiLjAcnsdH7hH1HmVo
         MFJBz3TkZ1sJIuToziGMQqL759dilCxY4b2yIaks/kDHlfXDSnlCTo4sPm9/OERelKE/
         ODcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9JhGkAN43azO3QWB0jgH+r1HKms8UT0OMbdM47HdBkQ=;
        fh=mKuq61JnTtOtAhdjIse5nYp5DZlu3shSbhWX6+kB1cQ=;
        b=hPhx9Xu5RPY4nGjtQ+wFA2j/I1Uuk/a7bAG4ZmHSfFB78tqvNCEDv7e4HjKHIXDty/
         Cvv+QFuh4wIGn15YNRKZHbAU40oOp0BzRgIygzgNWah7GxaKp2JSlS8pC+DZO0nqjFSK
         u5TwIi1nDo+/Iz/f82XsCY7yk2r9opW90CDmnWnZAUyUt/dGz4FT0lL+ECfPUnWI7Dnq
         1pjUFRbPtSJupwWghe9OIvMa6g0+WzDEcsbVDrAQDIMyDltzKxaNizbzjDANAlT13b3q
         vf/9r3JInA40KkaZaYSKqEdxRs1yxmlC7K6ahSmp5NV7sK2pRQKDCkFjSw+t3/h9zQ2+
         v26A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zacbowling-com.20230601.gappssmtp.com; s=20230601; t=1768931969; x=1769536769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JhGkAN43azO3QWB0jgH+r1HKms8UT0OMbdM47HdBkQ=;
        b=rRF837K0zVHUIuB1Zxzti9ayC78u4CGR6d/gYJVQ6GJjopAggeA/1lU9fAR5ok0lmE
         guF5Qbgn7b5AzCX6ca+CaOByNqhwm65yVUPIRZsALoLkH2qyOylkPKwUE1CXEtys9Khk
         xVM5BOuB8MwMoZRHViHdpQxnwRgiAXB7aoeRKLb5B0mksqDpBQqtfbOSaQzJiCOzDDvp
         mxxsUNg6uYUHtJ0s8A2p4YDnDe/yFCM9NhzQPeL88k6sU7ILaQ0VTNfPf1QlV1FFkNCL
         kju74Bq78/3zSTCDmEDZP15kiz+ljGgzcNr31SEy10Zz2ncruOv0zw3vekj6rH0JcYi+
         jiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931969; x=1769536769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9JhGkAN43azO3QWB0jgH+r1HKms8UT0OMbdM47HdBkQ=;
        b=nav7RI+lOPOwBXEs3JySMEZix+Hg6IIrcesVxj1h2z+j/uh8k+as3LKXE0eEOpmQCp
         zdhaLTIpvUvZ0i7gCfoA4TNbwAa/cLVmD8VWvXGmZHPEEVSK6fBbruBE5gkcTvZigsSX
         753PIZ9hdSIRGMwUlBA58+pOsQqZyDL0JNUNlDS+mYGsCOInXaFgRgzwnWR75GMIc+/L
         Xpyh+AnMEeqiw4Q6Q31/wGeJURV0rK9n7Qy+vEiAplRLSZJ8tzgHIfScccK7mbB3FT0+
         FPAUq/yGwS8KKKHwrFaoqQB1wlema63BggTCW8ft532joN3Iiq/zXRlA26bckpFaVHls
         Osgw==
X-Forwarded-Encrypted: i=1; AJvYcCVeWk+T2yb4dDbmBOfTZD8FFs4PtqaTlrxaEYarCYFJP5TdT7+AZhv9oNAngejlrMIzU3zP4RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+3X/8UtDC1nqtPvWyp6iW3wnNCm8kFWIcdB5GhMZ3IZy3W4Ok
	LZpNB4M3BFDFou+P0XLLqonWsaT09/4r3kAzR/BmiMvRgYFQVA3/iXzGDtk7iHslFQPYYK4GzjW
	hjZRBBeEqVKNd8ycA0hbooi5R3esJ64o=
X-Gm-Gg: AZuq6aIFul2syiOKsUFMD5/pKTKF3yDcfCUML6rQ8YLtPxfwb5Zgts0wejSP7kguoSc
	wLcI6WCzRay8ay1JwPLRrk14re7c7SOE9nz5APvnWyAZb+Khn2voxFIrDjO75sUzfoPu9d7Nbfu
	sHeAbeXjHAdjqMGXvoaIVHt3qk632Y0MlKyLbkL+RCyKxAIXgewrp+1BbqfBe5WqUNPHLHhmHOW
	dshi2dDU/sm5/0qZBM+YWLEakMk/6GzLL+YfMIei5AYlcW+zlRgFqZzC4HXQUB6JU5g8BEPKyy/
	3uNwvHz/kAvQdsrhQ6RdOVJSQB3E7fLEukMWhVPfpjVqV4fcrhIWxfQMs+x+SKmZVPE=
X-Received: by 2002:a05:6402:1471:b0:64d:1a1:9dee with SMTP id
 4fb4d7f45d1cf-654bb32c9d0mr13122410a12.16.1768931968732; Tue, 20 Jan 2026
 09:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com> <20260120062854.126501-12-zac@zacbowling.com>
 <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
In-Reply-To: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
From: Zac Bowling <zac@zacbowling.com>
Date: Tue, 20 Jan 2026 09:59:16 -0800
X-Gm-Features: AZwV_QhK5EMGwtubI6czQbnbKg5lb6w7VnH-ULqIt1MPvWyO9yZhd87LPW7qhGs
Message-ID: <CAOFcj8TD=Q-YSo1eFz7wRYApObrYxkp-z_9=_TY=QfTMB548Og@mail.gmail.com>
Subject: Re: [PATCH 11/11] wifi: mt76: mt7925: fix ROC deadlocks and race conditions
To: Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com, stable@vger.kernel.org, linux@frame.work
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[zacbowling-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[zac@zacbowling.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[zacbowling.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,zacbowling.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210584-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[zacbowling-com.20230601.gappssmtp.com:+]
X-Rspamd-Queue-Id: CB5644B073
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sean,

Thank you for the detailed feedback and for sharing your deadlock fix.

> 1. Would it be possible to rebase your patchset on top of this fix

Yes, I'll rebase on your patch. I reviewed it, and it's a cleaner solution
than what I implemented. My approach used an async abort with a state flag,
but your `cancel_work()` approach avoids the blocking entirely.

Additionally, last night, after someone ran an AI bot check on my patches,
I found two issues in my current patchset that introduce deadlocks where
your existing patch stops it from hitting.

1. In my patch #3 added I mt792x_mutex_acquire() around
   ieee80211_iterate_active_interfaces(), but this function is called from
   mt7921_mac_sta_add/remove via mt76_sta_add/remove, which already hold
   dev->mutex. I need to remove this mutex wrapper.

2. In my patch #6 I wrapped mt7925_roc_abort_sync() with a mutex in the
   suspend path, but roc_abort_sync calls cancel_work_sync() which can
   deadlock if roc_work is waiting for the mutex. Your fix addresses
   this more elegantly.

I'll prepare a v6 rebased on your patch with these fixes.

> 2. Could you please elaborate on the test scenarios that would trigger
>    ROC rate limiting for MLO authentication failures?

The rate-limiting addresses a real-world scenario we observed with MT7925
when connecting to WiFi 7 APs with MLO + Fast Transition (802.11r) enabled.

When wpa_supplicant attempts Fast Transition roaming between MLO-capable AP=
s,
there's a race condition between disconnect and key setup. The kernel's nl8=
0211
validation requires link_id for MLO group keys (net/wireless/nl80211.c:4828=
),
but during FT roaming, wdev->valid_links may still be set from the previous
connection when the new key setup begins.

This causes repeated failures:
```
wpa_supplicant: nl80211: kernel reports: link ID must for MLO group key
wpa_supplicant: FT: Failed to set PTK to the driver
```

Each failure triggers a reconnection attempt, which requires ROC commands f=
or
scanning. When these failures happen in rapid succession (we observed 3-4
failures within seconds), the MCU seems to become overwhelmed with messages
like this:

```
Message 00020027 (MCU_UNI_CMD_ROC) timeout
Message 00020027 (MCU_UNI_CMD_ROC) timeout
Message 00020027 (MCU_UNI_CMD_ROC) timeout
```

This leads to firmware reset, which triggers more reconnection attempts,
creating a cascading failure loop.

Reproduction manifests for me at least with:
- Single MT7925 interface in STA mode
- WiFi 7 AP with MLO enabled (multi-link across 5 GHz + 6 GHz)
- 802.11r (Fast Transition) enabled
- Multiple APs with the same SSID (roaming scenario)

I haven't tested with multiple virtual interfaces, but the core issue is
the rapid ROC request rate during the reconnection loop, not the number of
interfaces.

I had someone on the Framework forum post similar dumps showing similar
behavior with their Eeros mesh setup. I'm using some Unifi U7 Pros
with MLO enabled on one of the SSIDs.

So this might not be the right place to fix this. We may need to fix at the
upper-layers. I put this here so folks could work around with my DKMS
package, but a deeper refactor up multiple layers around MLO is probably
needed to really fix this. Fixing here at least validates things are more
stable (but I can't confirm it's really fixed, I don't know what is going
on inside the firmware, and it's internal state issues we can get into).

The root cause is likely in wpa_supplicant/mac80211 (race condition in MLO
key setup timing during FT roaming). However, the rate limiting provides a
defensive measure to prevent firmware crashes. Then I can maybe investigate
the upper-layer issues. Way bigger change, though, unfortunately.

Fix is similar to how TCP implements backoff to handle network congestion -
the congestion isn't TCP's fault, but the backoff prevents cascading failur=
es.

The detailed crash analysis and dmesg logs are in our repository:
https://github.com/zbowling/mt7925/tree/main/crashes

Specifically:
- crash-2026-01-19-mlo-authentication-failure.log (MLO key race analysis)
- crash-2026-01-12-2210-auth-loop-mcu-timeout.log (MCU timeout during auth =
loop)

If you believe the rate limiting is unnecessary given how ROC operations ar=
e
serialized in the firmware, I can remove it. My goal was to prevent the
firmware from entering a reset loop, but if there's a better approach or if
the underlying mac80211/wpa_supplicant issue should be fixed instead now, I=
'm
happy to adjust. This just seemed to reduce the issue for my MLO setup.

Thank you for offering to prepare an out-of-tree branch - that would be ver=
y
helpful for testing the integrated patchset.

Zac Bowling

On Tue, Jan 20, 2026 at 12:25=E2=80=AFAM Sean Wang <sean.wang@kernel.org> w=
rote:
>
> On Tue, Jan 20, 2026 at 12:29=E2=80=AFAM Zac <zac@zacbowling.com> wrote:
> >
> > From: Zac Bowling <zac@zacbowling.com>
> >
> > Fix multiple interrelated issues in the remain-on-channel (ROC) handlin=
g
> > that cause deadlocks, race conditions, and resource leaks.
> >
> > Problems fixed:
> >
> > 1. Deadlock in sta removal ROC abort path:
> >    When a station is removed while a ROC operation is in progress, the
> >    driver would call mt7925_roc_abort_sync() which waits for ROC comple=
tion.
> >    However, the ROC work itself needs to acquire mt792x_mutex which is
> >    already held during station removal, causing a deadlock.
> >
> >    Fix: Use async ROC abort (mt76_connac_mcu_abort_roc) when called fro=
m
> >    paths that already hold the mutex, and add MT76_STATE_ROC_ABORT flag
> >    to coordinate between the abort and the ROC timer.
> >
>
> Hi Zac,
>
> Thanks for your continued efforts on the driver.
> We=E2=80=99ve sent a patch to address the mt7925 deadlock at the link bel=
ow:
> https://lists.infradead.org/pipermail/linux-mediatek/2025-December/102164=
.html
> We plan to send the same fix to mt7921 as well.
>
> I had a couple of questions and suggestions:
> 1. Would it be possible to rebase your patchset on top of this fix
> (and any other pending patches that are not yet merged)? We noticed
> some conflicts when applying the series, and rebasing it this way
> would make it easier for nbd to integrate the full patchset.
> 2. Could you please elaborate on the test scenarios that would trigger
> ROC rate limiting for MLO authentication failures? If I recall
> correctly, ROC operations are typically handled sequentially unless
> multiple interfaces are created on the same physical device. In that
> case, how many virtual interfaces and which operating modes (GC/STA or
> multiple STAs) are required to reproduce the issue?
>
> I will try to prepare an out-of-tree branch with the current pending
> patches to help your patchset integrate more smoothly. Thanks for
> collecting community issues and fixes and incorporating them into the
> driver.
>
>              Sean
>
> > 2. ROC timer race during suspend:
> >    The ROC timer could fire after the device started suspending but bef=
ore
> >    the ROC was properly aborted, causing undefined behavior.
> >
> >    Fix: Delete ROC timer synchronously before suspend and check device
> >    state before processing ROC timeout.
> >
> > 3. ROC rate limiting for MLO auth failures:
> >    Rapid ROC requests during MLO authentication can overwhelm the firmw=
are,
> >    causing authentication timeouts. The MT7925 firmware has limited ROC
> >    handling capacity.
> >
> >    Fix: Add rate limiting infrastructure with configurable minimum inte=
rval
> >    between ROC requests. Track last ROC completion time and defer new
> >    requests if they arrive too quickly.
> >
> > 4. WCID leak in ROC cleanup:
> >    When ROC operations are aborted, the associated WCID resources were
> >    not being properly released, causing resource exhaustion over time.
> >
> >    Fix: Ensure WCID cleanup happens in all ROC termination paths.
> >
> > 5. Async ROC abort race condition:
> >    The async ROC abort could race with normal ROC completion, causing
> >    double-free or use-after-free of ROC resources.
> >
> >    Fix: Use MT76_STATE_ROC_ABORT flag and proper synchronization to
> >    prevent races between async abort and normal completion paths.
> >
> > These fixes work together to provide robust ROC handling that doesn't
> > deadlock, properly releases resources, and handles edge cases during
> > suspend and MLO operations.
> >
> > Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver fo=
r mt7925 device")
> > Signed-off-by: Zac Bowling <zac@zacbowling.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
> >  .../net/wireless/mediatek/mt76/mt7925/main.c  | 175 ++++++++++++++++--
> >  drivers/net/wireless/mediatek/mt76/mt792x.h   |   7 +
> >  3 files changed, 170 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wi=
reless/mediatek/mt76/mt76.h
> > index d05e83ea1cac..91f9dd95c89e 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> > @@ -511,6 +511,7 @@ enum {
> >         MT76_STATE_POWER_OFF,
> >         MT76_STATE_SUSPEND,
> >         MT76_STATE_ROC,
> > +       MT76_STATE_ROC_ABORT,
> >         MT76_STATE_PM,
> >         MT76_STATE_WED_RESET,
> >  };
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers=
/net/wireless/mediatek/mt76/mt7925/main.c
> > index cc7ef2c17032..2404f7812897 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> > @@ -453,6 +453,24 @@ static void mt7925_roc_iter(void *priv, u8 *mac,
> >         mt7925_mcu_abort_roc(phy, &mvif->bss_conf, phy->roc_token_id);
> >  }
> >
> > +/* Async ROC abort - safe to call while holding mutex.
> > + * Sets abort flag and lets roc_work handle cleanup without blocking.
> > + * This prevents deadlock when called from sta_remove path which holds=
 mutex.
> > + */
> > +static void mt7925_roc_abort_async(struct mt792x_dev *dev)
> > +{
> > +       struct mt792x_phy *phy =3D &dev->phy;
> > +
> > +       /* Set abort flag - roc_work checks this before acquiring mutex=
 */
> > +       set_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
> > +
> > +       /* Stop timer and schedule work to handle cleanup.
> > +        * Must schedule work since timer may not have fired yet.
> > +        */
> > +       timer_delete(&phy->roc_timer);
> > +       ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
> > +}
> > +
> >  void mt7925_roc_abort_sync(struct mt792x_dev *dev)
> >  {
> >         struct mt792x_phy *phy =3D &dev->phy;
> > @@ -473,6 +491,17 @@ void mt7925_roc_work(struct work_struct *work)
> >         phy =3D (struct mt792x_phy *)container_of(work, struct mt792x_p=
hy,
> >                                                 roc_work);
> >
> > +       /* Check abort flag BEFORE acquiring mutex to prevent deadlock.
> > +        * If abort is requested while we're in the sta_remove path (wh=
ich
> > +        * holds the mutex), we must not try to acquire it or we'll dea=
dlock.
> > +        * Clear the flags and only notify mac80211 if ROC was actually=
 active.
> > +        */
> > +       if (test_and_clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state)=
) {
> > +               if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->stat=
e))
> > +                       ieee80211_remain_on_channel_expired(phy->mt76->=
hw);
> > +               return;
> > +       }
> > +
> >         if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
> >                 return;
> >
> > @@ -500,14 +529,93 @@ static int mt7925_abort_roc(struct mt792x_phy *ph=
y,
> >         return err;
> >  }
> >
> > +/* ROC rate limiting constants - exponential backoff to prevent MCU ov=
erload
> > + * when upper layers trigger rapid reconnection cycles (e.g., MLO auth=
 failures).
> > + * Max backoff ~1.6s, resets after 10s of no timeouts.
> > + */
> > +#define MT7925_ROC_BACKOFF_BASE_MS     100
> > +#define MT7925_ROC_BACKOFF_MAX_MS      1600
> > +#define MT7925_ROC_TIMEOUT_RESET_MS    10000
> > +#define MT7925_ROC_TIMEOUT_WARN_THRESH 5
> > +
> > +/* Check if ROC should be throttled due to recent timeouts.
> > + * Returns delay in jiffies if throttling, 0 if OK to proceed.
> > + */
> > +static unsigned long mt7925_roc_throttle_check(struct mt792x_phy *phy)
> > +{
> > +       unsigned long now =3D jiffies;
> > +
> > +       /* Reset timeout counter if it's been a while since last timeou=
t */
> > +       if (phy->roc_timeout_count &&
> > +           time_after(now, phy->roc_last_timeout +
> > +                      msecs_to_jiffies(MT7925_ROC_TIMEOUT_RESET_MS))) =
{
> > +               phy->roc_timeout_count =3D 0;
> > +               phy->roc_backoff_until =3D 0;
> > +       }
> > +
> > +       /* Check if we're still in backoff period */
> > +       if (phy->roc_backoff_until && time_before(now, phy->roc_backoff=
_until))
> > +               return phy->roc_backoff_until - now;
> > +
> > +       return 0;
> > +}
> > +
> > +/* Record ROC timeout and calculate backoff period */
> > +static void mt7925_roc_record_timeout(struct mt792x_phy *phy)
> > +{
> > +       unsigned int backoff_ms;
> > +
> > +       phy->roc_last_timeout =3D jiffies;
> > +       phy->roc_timeout_count++;
> > +
> > +       /* Exponential backoff: 100ms, 200ms, 400ms, 800ms, 1600ms (cap=
ped) */
> > +       backoff_ms =3D MT7925_ROC_BACKOFF_BASE_MS <<
> > +                    min_t(u8, phy->roc_timeout_count - 1, 4);
> > +       if (backoff_ms > MT7925_ROC_BACKOFF_MAX_MS)
> > +               backoff_ms =3D MT7925_ROC_BACKOFF_MAX_MS;
> > +
> > +       phy->roc_backoff_until =3D jiffies + msecs_to_jiffies(backoff_m=
s);
> > +
> > +       /* Warn if we're seeing repeated timeouts - likely upper layer =
issue */
> > +       if (phy->roc_timeout_count =3D=3D MT7925_ROC_TIMEOUT_WARN_THRES=
H)
> > +               dev_warn(phy->dev->mt76.dev,
> > +                        "mt7925: %u consecutive ROC timeouts, possible=
 mac80211/wpa_supplicant issue (MLO key race?)\n",
> > +                        phy->roc_timeout_count);
> > +}
> > +
> > +/* Clear timeout tracking on successful ROC */
> > +static void mt7925_roc_clear_timeout(struct mt792x_phy *phy)
> > +{
> > +       phy->roc_timeout_count =3D 0;
> > +       phy->roc_backoff_until =3D 0;
> > +}
> > +
> >  static int mt7925_set_roc(struct mt792x_phy *phy,
> >                           struct mt792x_bss_conf *mconf,
> >                           struct ieee80211_channel *chan,
> >                           int duration,
> >                           enum mt7925_roc_req type)
> >  {
> > +       unsigned long throttle;
> >         int err;
> >
> > +       /* Check rate limiting - if in backoff period, wait or return b=
usy */
> > +       throttle =3D mt7925_roc_throttle_check(phy);
> > +       if (throttle) {
> > +               /* For short backoffs, wait; for longer ones, return bu=
sy */
> > +               if (throttle < msecs_to_jiffies(200)) {
> > +                       msleep(jiffies_to_msecs(throttle));
> > +               } else {
> > +                       dev_dbg(phy->dev->mt76.dev,
> > +                               "mt7925: ROC throttled, %lu ms remainin=
g\n",
> > +                               jiffies_to_msecs(throttle));
> > +                       return -EBUSY;
> > +               }
> > +       }
> > +
> > +       /* Clear stale abort flag from previous ROC */
> > +       clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
> > +
> >         if (test_and_set_bit(MT76_STATE_ROC, &phy->mt76->state))
> >                 return -EBUSY;
> >
> > @@ -523,7 +631,11 @@ static int mt7925_set_roc(struct mt792x_phy *phy,
> >         if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ))=
 {
> >                 mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
> >                 clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> > +               mt7925_roc_record_timeout(phy);
> >                 err =3D -ETIMEDOUT;
> > +       } else {
> > +               /* Successful ROC - reset timeout tracking */
> > +               mt7925_roc_clear_timeout(phy);
> >         }
> >
> >  out:
> > @@ -534,8 +646,27 @@ static int mt7925_set_mlo_roc(struct mt792x_phy *p=
hy,
> >                               struct mt792x_bss_conf *mconf,
> >                               u16 sel_links)
> >  {
> > +       unsigned long throttle;
> >         int err;
> >
> > +       /* Check rate limiting - MLO ROC is especially prone to rapid-f=
ire
> > +        * during reconnection cycles after MLO authentication failures=
.
> > +        */
> > +       throttle =3D mt7925_roc_throttle_check(phy);
> > +       if (throttle) {
> > +               if (throttle < msecs_to_jiffies(200)) {
> > +                       msleep(jiffies_to_msecs(throttle));
> > +               } else {
> > +                       dev_dbg(phy->dev->mt76.dev,
> > +                               "mt7925: MLO ROC throttled, %lu ms rema=
ining\n",
> > +                               jiffies_to_msecs(throttle));
> > +                       return -EBUSY;
> > +               }
> > +       }
> > +
> > +       /* Clear stale abort flag from previous ROC */
> > +       clear_bit(MT76_STATE_ROC_ABORT, &phy->mt76->state);
> > +
> >         if (WARN_ON_ONCE(test_and_set_bit(MT76_STATE_ROC, &phy->mt76->s=
tate)))
> >                 return -EBUSY;
> >
> > @@ -550,7 +681,10 @@ static int mt7925_set_mlo_roc(struct mt792x_phy *p=
hy,
> >         if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ))=
 {
> >                 mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
> >                 clear_bit(MT76_STATE_ROC, &phy->mt76->state);
> > +               mt7925_roc_record_timeout(phy);
> >                 err =3D -ETIMEDOUT;
> > +       } else {
> > +               mt7925_roc_clear_timeout(phy);
> >         }
> >
> >  out:
> > @@ -567,6 +701,7 @@ static int mt7925_remain_on_channel(struct ieee8021=
1_hw *hw,
> >         struct mt792x_phy *phy =3D mt792x_hw_phy(hw);
> >         int err;
> >
> > +       cancel_work_sync(&phy->roc_work);
> >         mt792x_mutex_acquire(phy->dev);
> >         err =3D mt7925_set_roc(phy, &mvif->bss_conf,
> >                              chan, duration, MT7925_ROC_REQ_ROC);
> > @@ -874,14 +1009,14 @@ static int mt7925_mac_link_sta_add(struct mt76_d=
ev *mdev,
> >         if (!mlink)
> >                 return -EINVAL;
> >
> > -       idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - =
1);
> > -       if (idx < 0)
> > -               return -ENOSPC;
> > -
> >         mconf =3D mt792x_vif_to_link(mvif, link_id);
> >         if (!mconf)
> >                 return -EINVAL;
> >
> > +       idx =3D mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - =
1);
> > +       if (idx < 0)
> > +               return -ENOSPC;
> > +
> >         mt76_wcid_init(&mlink->wcid, 0);
> >         mlink->wcid.sta =3D 1;
> >         mlink->wcid.idx =3D idx;
> > @@ -901,14 +1036,16 @@ static int mt7925_mac_link_sta_add(struct mt76_d=
ev *mdev,
> >
> >         ret =3D mt76_connac_pm_wake(&dev->mphy, &dev->pm);
> >         if (ret)
> > -               return ret;
> > +               goto err_wcid;
> >
> >         mt7925_mac_wtbl_update(dev, idx,
> >                                MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
> >
> >         link_conf =3D mt792x_vif_to_bss_conf(vif, link_id);
> > -       if (!link_conf)
> > -               return -EINVAL;
> > +       if (!link_conf) {
> > +               ret =3D -EINVAL;
> > +               goto err_wcid;
> > +       }
> >
> >         /* should update bss info before STA add */
> >         if (vif->type =3D=3D NL80211_IFTYPE_STATION && !link_sta->sta->=
tdls) {
> > @@ -920,7 +1057,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev=
 *mdev,
> >                         ret =3D mt7925_mcu_add_bss_info(&dev->phy, mcon=
f->mt76.ctx,
> >                                                       link_conf, link_s=
ta, false);
> >                 if (ret)
> > -                       return ret;
> > +                       goto err_wcid;
> >         }
> >
> >         if (ieee80211_vif_is_mld(vif) &&
> > @@ -928,28 +1065,34 @@ static int mt7925_mac_link_sta_add(struct mt76_d=
ev *mdev,
> >                 ret =3D mt7925_mcu_sta_update(dev, link_sta, vif, true,
> >                                             MT76_STA_INFO_STATE_NONE);
> >                 if (ret)
> > -                       return ret;
> > +                       goto err_wcid;
> >         } else if (ieee80211_vif_is_mld(vif) &&
> >                    link_sta !=3D mlink->pri_link) {
> >                 ret =3D mt7925_mcu_sta_update(dev, mlink->pri_link, vif=
,
> >                                             true, MT76_STA_INFO_STATE_A=
SSOC);
> >                 if (ret)
> > -                       return ret;
> > +                       goto err_wcid;
> >
> >                 ret =3D mt7925_mcu_sta_update(dev, link_sta, vif, true,
> >                                             MT76_STA_INFO_STATE_ASSOC);
> >                 if (ret)
> > -                       return ret;
> > +                       goto err_wcid;
> >         } else {
> >                 ret =3D mt7925_mcu_sta_update(dev, link_sta, vif, true,
> >                                             MT76_STA_INFO_STATE_NONE);
> >                 if (ret)
> > -                       return ret;
> > +                       goto err_wcid;
> >         }
> >
> >         mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
> >
> >         return 0;
> > +
> > +err_wcid:
> > +       rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
> > +       mt76_wcid_mask_clear(dev->mt76.wcid_mask, idx);
> > +       mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
> > +       return ret;
> >  }
> >
> >  static int
> > @@ -1135,7 +1278,8 @@ static void mt7925_mac_link_sta_remove(struct mt7=
6_dev *mdev,
> >         if (!mlink)
> >                 return;
> >
> > -       mt7925_roc_abort_sync(dev);
> > +       /* Async abort - caller already holds mutex */
> > +       mt7925_roc_abort_async(dev);
> >
> >         mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
> >         mt76_connac_pm_wake(&dev->mphy, &dev->pm);
> > @@ -1530,6 +1674,8 @@ static int mt7925_suspend(struct ieee80211_hw *hw=
,
> >         cancel_delayed_work_sync(&dev->pm.ps_work);
> >         mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
> >
> > +       /* Cancel ROC before quiescing starts */
> > +       mt7925_roc_abort_sync(dev);
> >         mt792x_mutex_acquire(dev);
> >
> >         clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
> > @@ -1876,6 +2022,8 @@ static void mt7925_mgd_prepare_tx(struct ieee8021=
1_hw *hw,
> >         u16 duration =3D info->duration ? info->duration :
> >                        jiffies_to_msecs(HZ);
> >
> > +       cancel_work_sync(&mvif->phy->roc_work);
> > +
> >         mt792x_mutex_acquire(dev);
> >         mt7925_set_roc(mvif->phy, &mvif->bss_conf,
> >                        mvif->bss_conf.mt76.ctx->def.chan, duration,
> > @@ -2033,6 +2181,7 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, =
struct ieee80211_vif *vif,
> >         if (old_links =3D=3D new_links)
> >                 return 0;
> >
> > +       cancel_work_sync(&phy->roc_work);
> >         mt792x_mutex_acquire(dev);
> >
> >         for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/=
wireless/mediatek/mt76/mt792x.h
> > index 8388638ed550..d9c1ea709390 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt792x.h
> > +++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
> > @@ -186,6 +186,13 @@ struct mt792x_phy {
> >         wait_queue_head_t roc_wait;
> >         u8 roc_token_id;
> >         bool roc_grant;
> > +
> > +       /* ROC rate limiting to prevent MCU overload during rapid recon=
nection
> > +        * cycles (e.g., MLO authentication failures causing repeated R=
OC).
> > +        */
> > +       u8 roc_timeout_count;           /* consecutive ROC timeouts */
> > +       unsigned long roc_last_timeout; /* jiffies of last timeout */
> > +       unsigned long roc_backoff_until;/* don't issue ROC until this t=
ime */
> >  };
> >
> >  struct mt792x_irq_map {
> > --
> > 2.52.0
> >

