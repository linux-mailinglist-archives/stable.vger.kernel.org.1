Return-Path: <stable+bounces-244286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOI2L/2S+mmZPwMAu9opvQ
	(envelope-from <stable+bounces-244286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:01:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 217784D5233
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 03:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E633026756
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 01:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A0B2264C7;
	Wed,  6 May 2026 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beVj47bC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A4E1AAE28
	for <stable@vger.kernel.org>; Wed,  6 May 2026 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029301; cv=pass; b=SMpzy7U6LIFZ70oVnpvHv/p6u6TVcJ5LqTGLm1K4CYKPD+KO5DSWqIPq+JJODPRJkbPxoNafoZbiNUUSpXvCpwnrQMIEmhrEey928lFM/xypnUATDDfJF2kbAc9duVGyPbdoTrHirB7gH2uiiKtq8wOkg6pzedIGJ1Lk9QNA7UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029301; c=relaxed/simple;
	bh=NwzorkUFHXdlT8TM8w+mRBafUN4j5T2DUosmDnooYsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCM4WwRerPNW/KuepmcBV4XskxdbAcx+oPyTft7GPVlEJphzPEUdYfSkwwZ0wYXdrJm5BThx871ykppSbpClvgODkKM9G0v+Lk7cvkhaiLmkVfbVTv/TYwgcPm/Ls/DtqMveAoDiFEVGL8DJvxXTQGX0PoDhVl03GuHQKEfpu30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beVj47bC; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso3840732a12.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 18:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778029299; cv=none;
        d=google.com; s=arc-20240605;
        b=knnISLHWGYUGgeoTMEcpXPKmi+e9V1O9LRRflP93Lhkd5s+NbkEcs0cW6A1WtXHgZz
         1S5WI+Irsnsb0M2Ua7Qko/kDpibsApFLyyDxlk/IR7pwz0bgfDQRlLLHJlttxk1yWBYY
         Rz+I/gpqZL0MluLb+hhok+pZEJzRs3sWYhnXjJuYtuhh7BxkiKBVgaFLvE5eR2BViVMD
         +Lu/OdaWnFTrNYIY47YiZ+thtbGiJCGe4ARLwMdhAIrwT1NyKizFLWlx3pMz/w+sj91N
         AdOlomPR1Pf8Qev8MHQxUT3ZQeSQKlsMettCZ8BlAe6qmw2b++33B72XwjYL7Tej8KLn
         hIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NwzorkUFHXdlT8TM8w+mRBafUN4j5T2DUosmDnooYsY=;
        fh=oQ341tbw/DUe30siWt7MiEUSB5AmSepfd1Gqkmwt+14=;
        b=iDTY54FGoZvHY6PrnbFeXg2JzX9HOkKk3qShYhrojboJDPB/JdY3+Lwk7Oc0DJHWVg
         ot71F2Tr8vHkORdHZSnVchSg6hXBqs57k79LH1IBj7pgGZuywSTDDAqbwgy9k4HYJjBN
         80GA5zTPhe+Sxn3W44MSC/htrAfRSP+/KCCfHVlcpB+9YRbxwxqNqjTtaW3fVqUO5Ifg
         dK0MZDyMLczZHiO+s1GRzTbySujqkU+mD8FvJl3F/dL3NfmMi0Jau2QxbG/Qgr5D2NCh
         FtElNq7PFHiESieEfmokMPi5QDKgZ3Kz011ikT0OSy+QGP/+JNoFKZapI3m7FSrJs3fX
         XsBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778029299; x=1778634099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NwzorkUFHXdlT8TM8w+mRBafUN4j5T2DUosmDnooYsY=;
        b=beVj47bCKpZ2igL1dl99Hc/2sxsY/mPakX8IJ3RQA/dM0Ieo1SUFcIE/cvQOuO56Gj
         ycKuna4K6/hIRMXoc3vKVdHWPY21fVCVoIMYzm/8YWwjs28qtBznb+ks+VD84QzKz/op
         /XTQsdNTH36ZP/P6/rgctoJz8dBX75n/XmmRFxhxvsXHCji9LeRKjn/uUhY1PviR8gTI
         vOh1z81mDfkxDsPG6zvoE8DXRzHc/L5MAi7jHUqenCUJRXiO+GF4a7W4q4TJ6K8T0K4H
         B9mk9J3P5dlRK0khuD1J24C8kYWQYH8GyuKZmkE4i4JCnRmDghXHTnGpgytAP+XsH2so
         8ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778029299; x=1778634099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwzorkUFHXdlT8TM8w+mRBafUN4j5T2DUosmDnooYsY=;
        b=EKlkUX2JYU493WhMNGti7JS6o4rGejS9i5eKf5ePg2C41ZjCRY8wS6r3c6yW/sYcQF
         IOUwwxM4ZWlA5wcdU6KlZpM0Y+38dUZRZzM7WapiKgukFWZu/fWB2Xdm08AgqK8eLnxA
         SYp7Uz4OI60m1cwSF4Dj2EKTqIF+4h2EP5GzjB1HGhYh9TCeDFkDKSiVgRMdhDeuwRW8
         pUGHELhe0s0CRzlERGYwQZheFo51focySvBlMA6Dvw8w3HRHIZZ8Bl+LRYD0nxFCFb9O
         auX/egWaxDS5WpgDFCrNg09Tc68zVlHkaCCsiNZ/xA7BHdjAY0Et3QOu3ymvNdgEfc7V
         /SAA==
X-Forwarded-Encrypted: i=1; AFNElJ9sRTOLryTqiIz3EPRxJei1sbq/wOUdjJorZ8DIA2LDG5tuRnRWMo7LQ5yG4Vb2iv6pBcoQ/Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZ7skSAAbTRqnjk/BMAMjjUwaQWfivBAH5+M6kRZZx7c7Mudo
	7jPNA5u4KleVgJ1XYjliR0XXPqitaMUsnf44Vacp2ORX4zK4VZt5XX7KPO/oDY1lv/F6ANQCCt7
	KuDvr8geEugvY/P43FOUUXlXUZg07yxI=
X-Gm-Gg: AeBDiesm5F9KI7Oty6qx93u8WHWMM4/hE1I/HsKlVhA4XbhgQqB7vULw982kQ15333N
	Tp9aJBrNCrVyC+a3m3G+dFL7XCl5Z1+POYrmr/5eBshrFX4GUUprjnpTgZRulh0Jt7zchhnE6xl
	myTdoQPOQP1hg3EJoTFmJKBlgpv40NWLI6LPpcY3i1IRNm34eWmsQbBBDblqDx7PUpRhf2C6g2U
	Vdm+S1oqR7IjYZJQymH6/wtln4F05cp+sycqWtWmdje0YiWrAkkTWNnVOr/OqNDxUW2VPWDi7ZR
	d2jlRIrZpZMYpMVVMBsC
X-Received: by 2002:a05:6402:561b:b0:674:74bf:8813 with SMTP id
 4fb4d7f45d1cf-67d648a2908mr225875a12.21.1778029298587; Tue, 05 May 2026
 18:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-mt7925-tdls-fixes-v1-0-dde847e21081@gmail.com>
 <20260503-mt7925-tdls-fixes-v1-1-dde847e21081@gmail.com> <CAGp9LzogKfGovfDw+=m4BkqWAakFTStXH20cQ_FA_5-zo+rmGA@mail.gmail.com>
In-Reply-To: <CAGp9LzogKfGovfDw+=m4BkqWAakFTStXH20cQ_FA_5-zo+rmGA@mail.gmail.com>
From: ElXreno <elxreno@gmail.com>
Date: Wed, 6 May 2026 04:00:00 +0300
X-Gm-Features: AVHnY4INobXxdEOMhemHPoV056iwAV8b_9YlbIjpzUDt0nGFCtcSzWUQppCzglI
Message-ID: <CAJ5_wsS1fMRvD0akfPB-FTcnk+j0pULHrzvOCgVVh1XVbmOmnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: mt76: mt792x: disable HW TX/RX encap offload to
 fix TDLS direct-link
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Soul Huang <Soul.Huang@mediatek.com>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, 
	Deren Wu <deren.wu@mediatek.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 217784D5233
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244286-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elxreno@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Sean,

Thanks for the review. You're right that the global disable was too
broad. v2 scopes the fix per-TDLS-peer; rationale and changelog are in
the v2 cover letter.

Best regards,
ElXreno

