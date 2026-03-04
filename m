Return-Path: <stable+bounces-222998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDQ0Ox7ep2lnkgAAu9opvQ
	(envelope-from <stable+bounces-222998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:24:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA011FB916
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 08:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC78F301BCFE
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB15235CB6F;
	Wed,  4 Mar 2026 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRSp7Qh/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F84351C13
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609026; cv=pass; b=LnIfVVPhBbCj0aPE2He7S5CWiLAtxeSPSfRZVui41fInStlVryed7QkkQYZuTseCZ7m+hpVRI0WNrgT5OVRe4V2jccOz+pYwrVLFVFSM3Hjd3XBCAwfidsUosDbtPV4o6Xu/DKLgrAbDSg4/XAEvUptFc+EDVi/EmTB+bFzh2ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609026; c=relaxed/simple;
	bh=w8yUQbtJsEkCj9oWcla6ivUT68glsDXwhJhpf+KWMOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YU2he4lNYpV40Q63A2Jtzz4g2EYC2CFOzcNmmZy54wDKUeELXRfGqC0KnfaWRINrJLEVGNnpR4YkC/hQDqLvW/H0anqPGqOSqHjmYyrar/lSsiFJ7+u1AZWwlf6G7Q20+lX4sJ3+jiSXKV93G7Du1/s/TYasNvXGije0uaRQ/M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRSp7Qh/; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-89a0b376fedso10709576d6.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 23:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772609024; cv=none;
        d=google.com; s=arc-20240605;
        b=Dv+8fu6sbY64SwJZ7QpCRTQ3DMlZJpZCd/IQxujX11GqjnBJX2hqKX206kB6EPlU5X
         Y7a+ka+PcJmVpv17ANSqlufv5Dz1KBBwd0vYgvl9UxhKN+Fut1pkS1kkAIZoyNMw8O/t
         b34sPdSBbOgModHIh8+VrYro+b/9t35rmhBoqfUNDxwS9pwiDYEHFBBq1jIS56tdFLBa
         YBxffd379vDEs7tQ8QWswBtkjcAQS4ojGMqxkBVs5cY23AlxWmDwptq2Wws4Hcb9h5V7
         qHg+ItrNJ8vAZh143z4W5QSwICJhB/iToLMCqjeOJl1S1+1t2ppHuKPhhk9NLA5wFUzR
         xngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w8yUQbtJsEkCj9oWcla6ivUT68glsDXwhJhpf+KWMOU=;
        fh=3/vL6mVMBrUJm9R9tE9CSRJ2X0tdweGroAcCR24MUIA=;
        b=jGY+sqtC4RaVKF+tYDqSLrfTsPLu4hXYDLHhaTFh8qKm9c8ZmwXPnT4PeiXt54GHhx
         cZahnxHW2+zUVfPcdcXSK01nE69WX+ZCirPRw6skq9zOw3QmFwF44c4PcOOOzBA3r7xd
         8UfH/aBntblakgNYBQ3EofHzymwB5xdBKpVq5AmUoLiwEsmu4WMqGw8Cg/7jv/U+qKRi
         LYMrQ9Xp8032TOLqhsnh8uAa+r9Z5iUOwrJ/5hV0LLFBbdCfFhnA8YQ6jW1uX9pDpKdM
         HF4ujHnaIReCXQO+FNKrtWHuyJH8tiSg4BfGrFP3Db2HO5xjqgzc3Lo8Gkan3JqILaiI
         EYrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772609024; x=1773213824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8yUQbtJsEkCj9oWcla6ivUT68glsDXwhJhpf+KWMOU=;
        b=MRSp7Qh/O2/KZAeZmNsBXMp2ueRKf8yYXqYIFJC0an+0/1kk/1Yf1dffhhIiu6m8V4
         Z41OFoPiA8P+Ndfq9NWHuREyqtAAIOEQUq/Tt+8JCjsRBiJVXdQpgb30S7GLdWSUM8BR
         PvfGgz+hRqXy9zwIawjv0AK7MhsRaN0y0w55C0gIdBvJoCQ0AP8ggnADAUQyugecg6EC
         wkgsZi/ZRz4sdgxObWAIUd0/6BJ0r+aCbTnOAbHk1NO7Y70hzqjmNc5Kb5AGGJ9x7qUm
         sS/sIil3Ou1SXbrlFWEunhDSL23GHt969tI73imI0UICmi0maA7CTrTuQ/+FyD/8yfZ5
         70vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609024; x=1773213824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8yUQbtJsEkCj9oWcla6ivUT68glsDXwhJhpf+KWMOU=;
        b=Liv5f36raDQV8q+pGB3peSZauBw6V0hsUF7MYYgFCaGSobZDyp6sZBI1HsEGb3s3jt
         AujBJJRbmE7EkvEHkG8x/jJug9LVbl+aHwd4am24k5t8Nk3ftiO7a4v657fChsV06I8R
         BYQhUtg0drR7eA3HaqpFU/5BJVh8njwoUmK8XTGVP6eGUHem0BtuUCOI2up7M7NDNCBb
         0QOhxkc5xNz70BplgfQhzwhdCg8rXJnbz02+kHhh7ltxn5rprwibnBleJjhplo7xjk4k
         DZoxURR/sBxJ3ZhpeuTwwm0lZ1zVbwzxVZFwBpzzlJHe92NXyi55o3eE7XIt4eAMmgPH
         PGlA==
X-Gm-Message-State: AOJu0YydYsqm+RhxFHIcF4pE9pqe6GhcPSH6KQ7uj8W/H8mMKPCL6AFk
	l/2tQQZE7/2Qjcn9NxIvj5yu95es4fmeFBxlYiYBy7CaLGxp+jILxsdySaoMh1Sj2r5+wfVyVTk
	/NLskgg30ZuLLYuewNxL0rvOAA0PGaKnaULRaDz0=
X-Gm-Gg: ATEYQzyLpkwqQtwYSxjT0ZR1z8xGrg76ze7veikLjPdhKdA7MiPvsX6vnN0dtF/qIob
	VeIpbS7GNNOIk2iV4Qj3WqbwRV137tyfwu8qMUSKRH6QoikdyBcqFe8d4ui4Gb3wmyDMOdmBW0i
	MAiQxNZEOBNB+3BwYTDk/ZZHkBK2lG467OqLpJbiruP8m+TJMyHOnQr+5DolEdf2crnGSTi9fSX
	H107cARq1ECJGsQ8QWhyCgd1oyyAk9Ujfe0fVkoFJXSBgPsIEyBsmDPGOzxjewpb2N+0ksaa7JT
	2jFczbOUK4bVaZz809LPDn/sHKy5wwKjJ65l2zEOAJJ7R7COZG3xCVl3C/SX4zr1VAUG
X-Received: by 2002:a05:6214:2583:b0:89a:c8c:3121 with SMTP id
 6a1803df08f44-89a19cee158mr13714996d6.40.1772609024455; Tue, 03 Mar 2026
 23:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301011749.1671856-1-sashal@kernel.org>
In-Reply-To: <20260301011749.1671856-1-sashal@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 3 Mar 2026 23:23:33 -0800
X-Gm-Features: AaiRm50CgErMZzS_ze7kCt_8oImY4S0b0P0oRP5fkeSHF9z9hr1Wm9mnfCaQPkY
Message-ID: <CADkSEUj-2N8TrsEBMogJ6PtHRsGPxVnxuJh5pmOijVd1KPfG_A@mail.gmail.com>
Subject: Re: FAILED: Patch "net: arcnet: com20020-pci: fix support for 2.5Mbit
 cards" failed to apply to 6.18-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8BA011FB916
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222998-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi, Sasha,

On Sat, Feb 28, 2026 at 5:17=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
> The patch below does not apply to the 6.18-stable tree.
This patch applies cleanly to 6.18.15, 6.12.74, 6.6.127, 6.1.164,
5.15.201, and 5.10.251, but I was notified that it failed to apply to
all of these kernels. It is not in the latest git tree for any of
those versions, although my other two "failed" patches have now been
merged. Was 6.18.y perhaps also affected by the <=3D 6.12.y issue with
the patch with \0 in its subject causing merging to stop?

Am I correct in assuming that the patch did not make it into <=3D 6.12.y
because patches in those kernels are backported from 6.18.y? This
would mean both 6.18.y and older kernels may be missing other patches,
and they need a new RC.

Ethan

