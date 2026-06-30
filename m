Return-Path: <stable+bounces-269878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HMgdOoxLQ2qKWgoAu9opvQ
	(envelope-from <stable+bounces-269878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 06:52:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD596E0550
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 06:52:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="hV/KgXS7";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269878-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269878-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 679CC301302D
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 04:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF73DDDB8;
	Tue, 30 Jun 2026 04:52:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEE386C16
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 04:52:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795144; cv=pass; b=JkdbUGzAbpZ06Ei+q5uEKfH60mLQlRfb9aVgVWJhQno5/iy9+Jzf1sioAnbAOu/JBrXk3zvsLlSmcx+IouO/rk33gkNgJWwTscw33MOwqMCvnTPjB/CbyDBX0cROZ3wU8vfTo1O+PafAUu35mHvgmXBBaHExLo8wRDZDtcDUdOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795144; c=relaxed/simple;
	bh=5Tyzaisr5mGbfjEU5rXfoq0BZD3jnlSX9RSNvWmwSSs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lDdzyUbVap5nCuVamRtdpteycmNDoYvuslXiOxF0Dc0ETb5OATI+mpfM9Hu5IZ56hdDvDOKACmH/rFMvQfTg18hzhLnBalnNOeq1KUVxEb91j0PPvpG5UEFGaFrMYKn4QsgdzOqL2t+2MQsEF1rR1u4w8WSoWibjWyzZMH4xqDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV/KgXS7; arc=pass smtp.client-ip=209.85.208.182
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39af6402933so26595441fa.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 21:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782795141; cv=none;
        d=google.com; s=arc-20260327;
        b=p+Kv4DZZaWxWmWPoP9TNwTSUWuTv6or8MjEwUpzXnrd4GMhowhMzOYfzpLRxELdMFE
         TCSvedgtTL6o7G4aILKJAfsquNcG2PJyFl86vvaZZtwgPlz+UGoyPIGfRdjDoiPSF7QD
         x2AAJ+E47m08igalvl6fJBlD4aRwUu88BgolaswO3zPvTqwT7Y0HrUhaMdw19eDBzDvz
         6wREDbtUJNgN/ccsAiDIIZEyGf0pA1NKnqqJiXwdfGl08H8ZNayBfEJKq4BfXErzm40z
         f2u9NKkERIUDEKA8+9+tFa6dmSsVlP4FGi2XkTbtuaBIBo12Qs4jnKQKzuRWBee2L11u
         MWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ihd90CtfnqycEvSiqZr6Hb8+VpZm2glxj7azajIlDCQ=;
        fh=9+8ija87vT2b2KzYq7hCy4+sxAPK7rZM4Ef40ZoxGEg=;
        b=E+wVaxuwL1iqUATi8k6WEem6aY0ShbhnYuFz8PchA3UqvlanxVnoJ/bHKRWhNCuuTR
         52t56k0n1kM3OV+fRTDPWsWBc6ZACm/sQMwyykoBc42R8ndFz7I6wT6h9Ydw4oBQV4Ir
         EnRhqUw9KA7kFIkpNIde5gJwtBWoY/zqWK8byUP88shV3AeUO0RAralgb/3x+VBMzt6l
         0cmCYyMVqr5BKzfEYrfhl4U0mxfLP3yH1VIngvif/XOI1/1yVC6XbSEpDag0y9iS9SIe
         zw9rrHIdjfpn9VRjMFSQRTHVgNveggxfjNuFQhjSjJCh8vYqhGE9KMoW4yLqPWGGywMB
         uqnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782795141; x=1783399941; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ihd90CtfnqycEvSiqZr6Hb8+VpZm2glxj7azajIlDCQ=;
        b=hV/KgXS72gA7Tnuw+FXMwBOPe3NF8bZ86OPEVjaTIVOathpJZbNRc9xp5lgHfnfOi6
         SLwaqLwcCGrkA4dGDhKbSmvNSbMcXEVCB1vMgQP6BrrEhBXIV4JrtVxKGclJ/Lnte2UD
         mLuEG1OOuKYgafu4a8y30USZg0KR8B5iO8gJgJZXNFnJf0+j81RXnTKrVmHhPOsvqWtE
         dOoTmc6L963N7SOME+VlE92JmHGIqXEjGYOI1b890bs3vnp3bD5kWB3ojnvuC+BXl7rW
         qV8CV/KLMXv7pcPSDg5578xaWdLp5BaIxMBDrB2M3Hj7wza3ApnVCf9IcJA5cUs8sPsd
         YylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782795141; x=1783399941;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihd90CtfnqycEvSiqZr6Hb8+VpZm2glxj7azajIlDCQ=;
        b=O0LmD6txcePnhg606RoDytGn1ai4AdX+VDP+vuxjlEJtUf9bq4TWlmmT2D8hLadlJD
         bf0LY0hEQrXSxufaH9d30ovcNW+btMp5paschqZ1yC7spnWq+Uj6ukFqIY2bujnbQgPl
         iT69Vx3CW4jAQzkwUewhGiOixTF0IUcTWfHV9sSE015HHPpVT7otXl5umFPLtH9t6RCw
         GKRpXSjFl70Aa7+b7nJlUrxkCHUTYGydIlBlUg+0kpJ4KHk0OwNTwkYKJ6d/dbfTHTqC
         xAgXBlXSJo8gMEv1pCe9siXeBYxYr/tfofkTrNrr2CZxaN3/ceEqiYNmPgqvF3uH/JVZ
         zHDA==
X-Gm-Message-State: AOJu0YxPzqdhmDJOL0xW6NKCZXah5CgndH0yaEkt8jFFgFeEY5DdkK7d
	3ZCa1CTn1iKPfzbXTX2p4z5p0nJ5rvCK2pesrAVyMBzq3Rcl6ornRfcn/ivcyMp7ByVREBGXmht
	PI0Lf/+yzzjabBrML5cZMxoimwstLaXqOCV8RbaC62fo9WD0=
X-Gm-Gg: AfdE7clFgghjKmZ0uF4B7LwoXvtG7voojNhpjHq8r35FGh3moxL/vWK9pbLNu9yNTpC
	exg8ryusdfcFau3bbNhFWfBIwuflpcYXqmzJ20TzYqbDLcEhfpLkud697WZiucRkA+uK+oA/hSP
	j8QIGPnWu2JEFvbhvevig6ZLZMhU4YCv0zaM+Cdm5uoAbIf8lCVC7S3ayt4i9L5Z3XQ6eYX0GEf
	u1/fSPqqwOT+H9bACld7a27lWeF3v12PNTh9m1awxI7LPZPzN27Eb1JdfnVQVpxIoV1gkZxeQAr
	ckwyWKvcYgd86SJncGqtWIwN9lAsoSrL2uP4/Gu+IT58GmRAPBpj27vo
X-Received: by 2002:a05:6512:251:b0:5aa:6aba:76f8 with SMTP id
 2adb3069b0e04-5aebdbbd837mr309085e87.30.1782795141202; Mon, 29 Jun 2026
 21:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve Yang <steveyang137@gmail.com>
Date: Tue, 30 Jun 2026 12:52:09 +0800
X-Gm-Features: AVVi8CeFkNsB9g3cMVwEg23dz9vvGrf-budlrJHsQ94Si_PmDWSoCTlOm4cXgNk
Message-ID: <CAMNbjovbZED1G_fuWjpTYRGnUrHddpYVV24P_S+QzyFHh_zVoA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 7.0-6.12] HID: i2c-hid: add reset quirk for
 BLTP7853 touchpad
To: stable@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-input@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steveyang137@gmail.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269878-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steveyang137@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AD596E0550

Hello,

I can confirm that the BLTP7853 i2c-hid reset quirk fixes the internal
touchpad on my laptop.

Tested-by: Steve Yang <steveyang137@gmail.com>

Hardware:

  MECHREVO XINGYAO Series / XINGYAO Series-P916F-PTL
  BIOS: 1.00, 03/14/2026
  Touchpad: BLTP7853:00 347D:7853 Touchpad
  ACPI device: i2c-BLTP7853:00
  Driver stack: i2c_hid_acpi + hid-multitouch

Broken kernel:

  Linux 7.0.14-arch1-1

Symptoms before the fix:

  The touchpad enumerated successfully and the HID report descriptor
was readable.
  The input device was created and udev tagged it as ID_INPUT_TOUCHPAD=1.
  However, the touchpad produced no input events in evtest.

Fixed kernel:

  A kernel containing upstream commit a991aa5e89365ba1959fae6847fd288125b209e5
  (HID: i2c-hid: add reset quirk for BLTP7853 touchpad)

After booting the fixed kernel, the internal touchpad works normally.

Thanks,
Steve

