Return-Path: <stable+bounces-216604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBmYJU5QkWlthQEAu9opvQ
	(envelope-from <stable+bounces-216604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 05:49:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E196B13E048
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 05:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC663015721
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 04:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC47A1EDA2B;
	Sun, 15 Feb 2026 04:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcLzK6+D"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD28287E
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771130952; cv=pass; b=WChV2Dez+Hla2haRU9gNpO/fk5a7kRVvv4t25Li1xcHnbwzNDuHMiS5/Ov7ZtsI5ehtnSmmrczKq9K9g+fWJORZhk03cZqRVjuX0cqorPU8gMTM13V1GqrmoXLdmgB1y0YDlqWwrW1B57qmBKiTT7dGh3JZ+A0BfQPyG+PUb5pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771130952; c=relaxed/simple;
	bh=obFW8H13dPPfEr+JeR9XPxAPCJYFlgK2qQ62j8RdJW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLe9C90Uu3vWSloyShMFBXmOerRmG8dg2SNpS6KkcvqTJ9e75r0hgDFY6CFgHHzSXz+uVnpJz/3XXxqE8TKRuXD2tuzRg4h/Xflv8vs/qgR+d/6UmBJL9osioPzmxF1j41vPStRDVlfc1x7y5NN/z8ky0PhE12ucuG2z/NzU1hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcLzK6+D; arc=pass smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c711959442so275304685a.0
        for <stable@vger.kernel.org>; Sat, 14 Feb 2026 20:49:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771130950; cv=none;
        d=google.com; s=arc-20240605;
        b=LIykcWgwziDDyNzWdDrawvHXzNGUoVuGyzTxwqWb0Y2O5kSIvmr+c5FUh5OshglI/B
         3p3hDCMeDmlsKKqS1uHhrB9nHMhaeh8y8hxRjdyI4GSFnM2Se5kG/6eqIUF7U0VHj24k
         KWvTEfnbBF9A7nyZZ1/dVXRlJbSpo8RQjzhUPYNah7zQNekxYz8DmLtOiygfgZkYfhMa
         fJxjvOM0zWc7RniqqwyHizKQ9Lay3oY6iWNanUKqC9eJj/wjS/q0PKi+mj/Ei89u//30
         wjYyXSTh2dsE40+eMO7+MgS3+03dL/IUsEaOhcmZ4DooZYpdAGftsb90dP3aw5Mmc/XD
         ObDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=obFW8H13dPPfEr+JeR9XPxAPCJYFlgK2qQ62j8RdJW4=;
        fh=xUB0Odl/WFPAmdS/fu5LnGq9n/k1pNC9XDejVDpAqJA=;
        b=WUyMSHrPT0SIQTvfTIej7NOwpZLx9UYUDYrh0jooEl1c8yY/G8cb/EJMHVBRz4Xiiz
         nZMPBAaucnb0DJJNFm+9ZH9cV0MsJBCJy7Ein+WSMspF06QmJ2TsriofoRMt3iVasbd9
         +4TKbq/JDShV8s97I3NH2sZHY5BCuer5NFkRho1Dmw72lA2xznpAqMZg33Y2wL+ts7Fb
         0APpHE3ElA1Ru29cMupMM+Yk9z8fFBh/OLpaK3CXIgU1AEGHiIwKKssdIW2gJKujwbOm
         W5I/FGjVA45q8UX3BAzBkyJ9TDRkKkr27PzK73+OrfEgjOR7qWit17/XT+ESw+FUB5l3
         da4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771130950; x=1771735750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obFW8H13dPPfEr+JeR9XPxAPCJYFlgK2qQ62j8RdJW4=;
        b=ZcLzK6+DzpwR5iEzNV6Ju41DPERvVpQB9o9wLorlA+8pwglCF2U+h9yx3lX359Xki7
         G9ADnGJ+UKoKPlT3HK0MUs2jfoASbdJMcUpT3dWTOP7wwt586MNad/1c32R2gkEYg9pP
         fXJ1h1RbMab4BhcyyRB6sDO2oa7b8vvaZAGSh/zrOt9MpKw578RCYVitKaX+ekFycIiA
         dK2IJ/QqgQAuHufPy3Uf275ev0Q8t13oNA/4DzoreTV15cuYfzi6LpPehy+3JkI2B0Ym
         h2BuveHIvntjCaZRJBnK1F4n/WEEjeUiYn3FrGeMR0mINMkjEvMYKYJ9PmOoopBHGkLx
         kWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771130950; x=1771735750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obFW8H13dPPfEr+JeR9XPxAPCJYFlgK2qQ62j8RdJW4=;
        b=l6d/lwPx8SzaDelbes4dCd0deh7+MWM2DCNrUBCdXZ6enhKIr6tXoBQ6zT9eaQcEJH
         q5XXcO3PC+lZb/X+rVeXZY6+W7P9k7obhmirIjERszU652RINUeSXD5DkvLIfB8WUCw6
         lrMpSznCY2Cs9Vd3QpIVAkCOmcJrNQBZ7m4vw5sDQDqrg6E4E8zhetk6UQW0NtEKm3fI
         rrWwjRyHuCA/sMHNiibSc8LFE+6WNrJlwWMJjoy1W0d//cl18XPNlEAjxJ9DvTwMWZky
         vlCRDk73OIvsPN0sBWe8gqrjuhbgPXLTNNu0+GFH7KXV7aaf+POeTaRQoa58txU6gZn0
         D0Iw==
X-Gm-Message-State: AOJu0YzkAqwuTZPrf5e1d81I7i2EW4ZSOEsQgUQFe6Igfkoot8zFELVu
	OI8EoVRaDNMX9nLaaRno5hWFtwmNL9Q5KsGfOmpFOUzInOxh2p15ID40+eOVVhLd8Jd7GzYllGM
	ycIyEuYrMlhZhKeD2u6GqmMKHQkVkFgo=
X-Gm-Gg: AZuq6aLbhVpynHaOIKhOuXDtVPGuh9MttQoVV3Vhj6xRYdyEdQ2Zz1UO4CE6+h7ty4z
	kGFQbxN7o1zRyq8YfUzqHLY1T2NOaP+CumLzngkC8Ti/AYWBQ9xQ+f8FBzSRatGxTjyi2yLU9IP
	zLhjt+yRuavnsqnxwpcTsAs6lVUe25fSPz/Ee38QzW03omW+aWKaXeAdrUPwEymn7ObWY0uwj8M
	fMasXLrKRqBvL4hC8hgOlZ9GBC66Q3ExnV1hOQvRy/69spwn6Kh5wQATBDzJK5JH1qXucIJ+7jk
	tG3U/8dUJYm9hbfGF2nNUXAqquyUNnjedScF3JE/FwxyFSHXS/pp9M6IritKxEHHC2NKj0hFxZR
	qnNws
X-Received: by 2002:a05:620a:4002:b0:8c6:b05b:1f33 with SMTP id
 af79cd13be357-8cb4abd3776mr667404885a.9.1771130950497; Sat, 14 Feb 2026
 20:49:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213045510.32368-1-enelsonmoore@gmail.com>
In-Reply-To: <20260213045510.32368-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 14 Feb 2026 20:48:59 -0800
X-Gm-Features: AaiRm53JG2_RQ8el4XLNsMmJwgtbcjprVqC-Et4V6rlfDIreQvJEi7nA1Xe3jrY
Message-ID: <CADkSEUj+oDTN9BPG=9LhHv8EPZE6KyQHXGYTkHiDRk8w4ZVXAA@mail.gmail.com>
Subject: Re: [PATCH v3] net: arcnet: com20020-pci: fix support for 2.5Mbit cards
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216604-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E196B13E048
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 8:55=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> Use card_info_2p5mbit if driver_data is NULL (see rationale above)

That rationale got accidentally lost when I was editing the commit
message. It is that driver_data can be null if the user adds a device
ID using the sysfs new_id file, as pointed out by Jakub.

Ethan

