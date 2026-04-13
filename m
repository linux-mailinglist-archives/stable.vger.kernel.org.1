Return-Path: <stable+bounces-235958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLO9CPyn3GkEUgkAu9opvQ
	(envelope-from <stable+bounces-235958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:23:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 688E93E90EA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D48E3006B78
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9C3A6EF7;
	Mon, 13 Apr 2026 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj9JS6R1"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BA82E4257
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068350; cv=pass; b=MKOBStNb+7XBHUgtPYiGRPUldUjT5Z9/nHmYLG55rK28NRD7LOLWcvvp6f34LoywqJQ2gAyML0LC0KnjUtoyxGnRZw/0d2Dh1OIi92Ked/x/2p0PNehhGlta6pgoLN24ccIcX8v8wVtwLehBVXbtnCnwbLIKkR/CqIP4kAkUpG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068350; c=relaxed/simple;
	bh=46HqDL6Ak4KSaYR2Y3K1vjaVcy3H4RP3peTsPTQf3w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH6q63sRb2g4jLr1SaB0XyNpa9boOJbwd7+SgviDqh6ssPllaUJy3bzo8HkdudWFeIOIewouyA0I1n2NmEILPau4GpgH6OI6+n7cucYkuXxnG2AfRc6fBklc6PIhvB6XKefWib5DypDeAPaJiAXriuKeAAvT30ah+XjkW1tN3p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pj9JS6R1; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-651bf4a4140so922246d50.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 01:19:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776068348; cv=none;
        d=google.com; s=arc-20240605;
        b=E8QnguNdFQSqAzvY2/ayr1DmoI5ZjYyzGr7tmQFkoWXkGYth8bTaddby9nKbzqs9s9
         69B0ARUQcQO6iLd6deO7sGFO2mJrrHFi0mam6XC1NZ4xPbciAMvXtD54UGTp52+zhLrl
         8iUkAfduDpR8bUXAq0UeD+RqlKTxUVqoJLe4P8SZ71A4DUJHRhfeCU6IGzMLNrz1RGQC
         n1poloKoZqXQ31JNPX4RA7PpjnX7u3tbim11tnn22sz2oS/9Bf7O945WyxLVDT0mlqYe
         /eOBzw7Ci3bT24R7ZEXADZ47F3/3r5Lj8a6WyQUtefEVH9ml1bK+wIjvoT8qcN+mRwi7
         uciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=46HqDL6Ak4KSaYR2Y3K1vjaVcy3H4RP3peTsPTQf3w4=;
        fh=MPZaZVo2u612cWEZmEChueCYyfojCc49uls6U4ZfHKc=;
        b=k87sdoskhhElnCZcUGXV4kJsrRlDAxpgonB3XRek/E+cEDDXnauttytx+veH189y7K
         okMNQqJUENw/hgRjeYwwqd4uFUy2GT5faftMuvtV5aEUjf3Ajirj+uHrkepJhSYtpZvp
         Rm2okQxgNxw2T7IsI/SAgEqS2+1ndh583GvmJhbr7PQaYa0eDrZ5EXyOqX0ss+QGJpiJ
         3QP5pmVlKUk6DbSId7x/JxHnOhAzxSkHCMc0qu4tJn085cjNbLr1n82LqSofSet8F7PB
         RF2hBuGZ3XtCdbqVHLNBR6lNB98BdhbatFSUX4tyfNPFOzjtGFTU5LpV4yjt0UuZK7u9
         iTZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776068348; x=1776673148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46HqDL6Ak4KSaYR2Y3K1vjaVcy3H4RP3peTsPTQf3w4=;
        b=Pj9JS6R1L1aV5FyJo1nN8RBxr8OUxFbIj2r7+iOA/49TRLja2nyS1ZoTDjrstWJR/D
         SrPiwl4NIh3lkSFMNux4ierow2tTfc9gNgQ1UhMfTkoNfCc+a7/e1XG/OowNS4ClIAoZ
         IvafDjfXFCsUhy9BIu4LCPOAn421yIVrjtqTCOQDb7u8V+p3bfCyQ7QbBrQVLBYErgli
         U3raVjCd6mC1/jzh1sozdPEwfyaasoFI8vLSL6C09loDuJu2tu0jEDGjustOYXppVa/D
         vNwzeLpQUpAxBfmwptAfdU1Kbd7Irpky4iGSd2iUgoqFyrwN0Fi34Sb2W3NOUe9w/6sJ
         K8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776068348; x=1776673148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=46HqDL6Ak4KSaYR2Y3K1vjaVcy3H4RP3peTsPTQf3w4=;
        b=ktevgRMS6mHnH0qzvkXTKhwLSNPssoNa0TURoUQUUujgRZbStGCtJum1gPX8ErnkGO
         yv57qnGm9/2qX2spQvF6cSdixZfuhej/V230nFpELV8VWSWzej9LozHzfY4z5lnqSQsu
         oQy33JvauaYldjD68p2GU7Ohl5gTSKGlrgnBdI8saBbMLx0R0aZCtCQIY/bUwugfrigl
         v7eDSLrHPiEnG0Ktd+ErDk+Fq/ulFLYg/drOMAe0BZBxiCRgbyJDl4kIaLRYPHoONDkh
         9j8369qI4Gp5raCelQHNpyHkebn5f3yLyfi/GluoUq4KosUp4Gweh991fNSif1vJFyCu
         Vf/g==
X-Forwarded-Encrypted: i=1; AFNElJ+KugYAew7ztSEuGHXydwOPPx+pPpsgE7h4DSAdz0SSJI7Y6Nmp1G0KQKzr+dUKscGRAMNecUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/7oKYao57cezGfbVqhdqO9NCnhG+QWbmYWr6RiC5mj8LW4xc
	4hHr/cM6P+/ECZMKRR6MoK7yhrJah6u5pvr8Axj0O62RsxfDr2g4gYNfO+O+rxfQxoUv4ss3PoT
	WucIQcMP8841+kX+I9eUVtMpqxjW8NUteuLjREEXAjw==
X-Gm-Gg: AeBDievthoEXtQ93YFxDtnq13NMMAh4qFEN9Dx2q/dT6l9ru47gg/70P/pqRhx6Z6RW
	k2zn8y0DzfkOCq72gqvYZ30vET9DEcR9d/8iscaOL8csmKt0fQ2CtdojdHbzQC/ZRBdxUYY3T0Q
	G99tSzeMYYSnzJCvaESY1GPtdqOR/BJ9uXM4OV99DeJmQyCG6+mu3Mk9TXQOjBaqybDfAiSumof
	Hqo8g5aigwWIXwRt+hQredBLPHO8Uzo96RA1qkON761GKeoMkt31eZTM2ae7MPMNGTVX7Icj149
	1Y+CvWYS
X-Received: by 2002:a53:ea4e:0:b0:650:13b8:5250 with SMTP id
 956f58d0204a3-65198a2c9a0mr8453117d50.8.1776068348079; Mon, 13 Apr 2026
 01:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412165311.2578501-1-lgs201920130244@gmail.com>
 <adyT6oW0UgvcEQbX@hovoldconsulting.com> <CANUHTR80npU59MrNq=1nYnb-r1ASKv_nG7=NF_G_Ko9-V-XaVw@mail.gmail.com>
 <adylDj3ah4U3QcaK@hovoldconsulting.com>
In-Reply-To: <adylDj3ah4U3QcaK@hovoldconsulting.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Apr 2026 16:18:59 +0800
X-Gm-Features: AQROBzAFTlnKKbTRuW98POx12UXkmxdQ6iAgqK8kqW6cFgZ4nnocojB5oLrgLik
Message-ID: <CANUHTR-i4wBn6DMoUuevwTKDbvhHW6Gh++nHjB3_2MUvuENr4g@mail.gmail.com>
Subject: Re: [PATCH] usb-serial: fix port device refcount leak when
 device_add() fails
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235958-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 688E93E90EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Johan Hovold <johan@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8813=E6=97=A5=
=E5=91=A8=E4=B8=80 16:10=E5=86=99=E9=81=93=EF=BC=9A

> Please mention that in the commit messages.

Hi Johan,

Understood, thanks. I will mention that in the commit messages for
future reports found by my static analysis tool.

Best regards,
Guangshuo

