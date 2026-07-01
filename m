Return-Path: <stable+bounces-270098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SI0ZJRmqRGqUygoAu9opvQ
	(envelope-from <stable+bounces-270098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 07:48:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5AA6E9EB5
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 07:48:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="FJTDNI/L";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270098-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270098-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBABD3004DB1
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 05:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AC538F94C;
	Wed,  1 Jul 2026 05:47:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFB35F607
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 05:47:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884860; cv=pass; b=OZHvfsdqcYLZFNWjWDqFJ16Sc/sy3DsPCCCj9XKUgrGy9X2rCBZSDOAk7nN4QR61ivh1qIa49PIzNy/tLCOeyPI4XNmso8npb7bwJhOChQ/Tzla8J7RDO1cZB6/P+KBmdkVzOonjKMsou69l91nRP+Kh7uSlyXxr2ghun/KjTkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884860; c=relaxed/simple;
	bh=Z8MMvzWc5l7KrAoeoQfilkzZ8PvRt5ywLENhSc4mJS8=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Q2AW7lmcfVb0bmuGWFiZSuhJSfyLaeRJ808Zc08Fr90sOXbHp16o7hPq2MtrfNVtfk2BkoR+0NM8oTXxJ421jIjQqsBcUBlbFK+YCQAGa6MEuiOATE0EDrRIiI+F1qYoqAaBj0ZrFJM165EEDCufvXviUEnwdyZzWC25oo1OmU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJTDNI/L; arc=pass smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3078e0dcd67so376872eec.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 22:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782884858; cv=none;
        d=google.com; s=arc-20260327;
        b=rW3up5FB1SjGI4bt3YJQQrB3OAP8qJC74f0Es6C0GDJWpAAvwynjt9tCHF9H4QXQ8I
         NsSalc+8zcnfhu9zuLUgu2lggeWTpvSPrgJg67qWjSzLp7lSdnyITwag9oqp+m+rX0Rw
         4gu9gasqT/bqlsOi7P16n3dwVZj+huXBJ9xfMuNilPMW+c+tIK1ShpQmGulkmBT/IM9s
         HvNZ1E/nxORgPPao8xHmIpuXt4lkTNbxf7FO7jVJq+pYzBFUrApmdC4e05NkIcfYIEbY
         uoUQ6+0ExsdnjoMKAuE2fmZQ0ZoALGvy3CUTK4l85ACd4rkuhyrDEXzcxBQnvMF2f4Q+
         a1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:dkim-signature;
        bh=Z8MMvzWc5l7KrAoeoQfilkzZ8PvRt5ywLENhSc4mJS8=;
        fh=us6/l3yClQhDWIFPXICVPWSVd/fcM1GWQLnvRHgEO9A=;
        b=KxiC8P1PiGG+x/mx/Um/K7xBMSbzo+2qfO2NYzgkBmSKITWyqW4Gda7suRLhmV7BG3
         0RczletxuP87uVZUIfLiyS8bQ0BnZInvJXLGDovlwKIgbM8INzwPrh5HcHRVyrRTW8d+
         98iM0/LPb62RLX84V5/iRErwOqsDuKglo5yk6QB/md12fo6shLIh++Ymc6SIc/4Aiy2X
         fyibEOWbvJOqAK5SJqdu0nzMGfIDsqnSkiB83PShs/ULtWHA3Vqyv0lfanoLbu8LlXvR
         0jEZTYmg7JZL18LKugABiyZEjUgn5dOCyeGM+5XT/oKY1VV9vv3nodjH+47A99I+EKIm
         d5Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782884858; x=1783489658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8MMvzWc5l7KrAoeoQfilkzZ8PvRt5ywLENhSc4mJS8=;
        b=FJTDNI/L8zlf1BM3MrRJoQCu3XXVyobtZdJkWXVsboMpWBvLVcgGJTPlsVmkloKOi9
         wAjFHazK8UqGadxWkkrf86d2kN67GNpuX3Yv7unpcjAsVwyxrvKDCZ6viFA7dHuk8Iz0
         yMw9u6xrDD9tgptMH/RRaBn/OPW+ZBVXDTynvX9/PYhkY+8dcxFVcLqIIm8ICTm4o7Ym
         5yltIm1EuVXJppQHDPaAJtDrR+kUfdOZe4D5AkXoCKfSGGO2gRiys1F9oaH4SgnPw78u
         3lqUil8UYhEH3t6JcnamvtG/GI8yhUsQRHQ0WnQLjxBtEsscNmjnSvI95r1rK/UFSlkG
         cC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782884858; x=1783489658;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z8MMvzWc5l7KrAoeoQfilkzZ8PvRt5ywLENhSc4mJS8=;
        b=b7SS+fQ7GsPXsy3Au1JgeJnYcqS/11cC7r27WQfyF/Jt16ZVH0QJ7PSK3l4dHx0Tuy
         xqNaV2/0rXkovE1DtfiCH8qDTmog/m5PbhFwut7KjEBbVWL0nU1nz1QM2+O9qR0fUI6S
         y0uQCYQR8bU+1HlRpctNahNqAg/c2CFWZF1GCpJ4CrYAA44Bk7/S67DOGWcg43T5xdku
         NID5pNWdQyfw9XWE933Ku06C/pSVdUqpDU6xkBgR3tqI9qo+VzH/0+FhT8cEVSm4GqD5
         LSsu+hNYLuTrtBT4RnWkDxlXv0pWpe42UcHrpPMOiGUM8ZGGABl+jHwUiFfOK7zW9p2m
         V0fQ==
X-Forwarded-Encrypted: i=1; AHgh+RoE8EF6A3yYGnjk9a93JQLK2eKtFpLiQg2OBfj/Ajur7AabDmkcmiX60PPma20ygVOTNn53pf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddW6CUo1AgQMZAagLcka8y0Z79GMHXXOI3lfqzpMO9dfvToYr
	wFBWtWrQxvP1PUzFilIi36sFO2PW0Rog+s+KYsm8Mplx50+3CpE6rXxPJH/P5Fx1ZqHtFQduJ7R
	ERKHMtZV+k9RE3zXc2jjERlbfHGAghtkNIYaT
X-Gm-Gg: AfdE7ckF4j5UjOHA2sdg2HSTq96IH0ysUJmb7TTxzAIhExjp030liNc0jM4j72TeAEi
	ZEMWsf/9ikomId96G7f83DJX6nWPcr7uQNVwbzS0txyWW3OtMn/GMMHVQ+HBOh4H5jzpm5ESck7
	u6mTMRMP2aSwghffmt88qQSCzbd8hSjrqI7KlxTyJHJtWULuVoMiO9HuxFDf515ZFZrQsJYodku
	viP8CgGOwGRukNx25ShwCNIVDka3BPUXRJr668Lohe2f/VL2up1lEBFa9Fjztj69E0+bZZvr6Fw
	KQO2QxOIa03bIGzlyfEcPAak+ahXb/PcwPXI+jpc
X-Received: by 2002:a05:7301:3d12:b0:30c:ab4d:3818 with SMTP id
 5a478bee46e88-30eff3717b4mr332767eec.36.1782884857858; Tue, 30 Jun 2026
 22:47:37 -0700 (PDT)
Received: from 266303231514 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 00:47:37 -0500
Received: from 266303231514 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 00:47:37 -0500
From: synicalkid@gmail.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 Jul 2026 00:47:37 -0500
X-Gm-Features: AVVi8Ce2w6HVBExRenKsbi_-y9dVoqyjDGIg97rIfoQiaAI2nB7U3QLk6igUakg
Message-ID: <CAD_8ym9gtjYJPPBRtm=birBj3CWipgY=k5=YwSqEMfaETkibYA@mail.gmail.com>
Subject: Re: [PATCH v4] wifi: mac80211: fix monitor mode frame capture for
 real chanctx drivers
To: lucid_duck@justthetip.ca
Cc: linux-wireless@vger.kernel.org, johannes@sipsolutions.net, 
	oscar.alfonso.diaz@gmail.com, fjhhz1997@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270098-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lucid_duck@justthetip.ca,m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:oscar.alfonso.diaz@gmail.com,m:fjhhz1997@gmail.com,m:stable@vger.kernel.org,m:oscaralfonsodiaz@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[synicalkid@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[synicalkid@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F5AA6E9EB5

Tested v4 logic (applied as v3 diff, functionally identical for the
real-chanctx path) on bare metal =E2=80=94 no VM, no hypervisor.

Setup:
- Host: MacBook Air (kali-rolling, kernel 6.19.14+kali-amd64)
- Adapter: Alfa AWUS036AXML =E2=80=94 MT7921U USB (0e8d:7961), mt7921u driv=
er
- phy1: wlan1 (monitor) + wlan2 (managed, connected to 2.4 GHz AP on same p=
hy)
- mac80211.ko built from linux-source-6.19, v4 patch applied, loaded via in=
smod

Test:
Injected 802.11 beacon frames from wlan1 (monitor) while wlan2 held
the sole chanctx on phy1. Used scapy sendp() + concurrent sniff() on
the same interface.

Result: 3/3 injected frames received back on wlan1. No crash, no kernel
warning, dmesg clean throughout.

The managed+monitor coexistence case on bare-metal MT7921U USB is
stable with this patch.

Tested-by: Glitch <synicalkid@gmail.com>

