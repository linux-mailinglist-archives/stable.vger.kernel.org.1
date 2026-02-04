Return-Path: <stable+bounces-213378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDTaDaVDg2nqkgMAu9opvQ
	(envelope-from <stable+bounces-213378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 14:03:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 994C3E623F
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 14:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA813049ED1
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FF7407578;
	Wed,  4 Feb 2026 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuCMxX8R"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D163A1A3C
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209936; cv=none; b=Fsr50+PnKjOXalSHjYyr6gHHqSOEmbzHH94tBH0or7jJsdgclvxOaY+wI52wmHMlv9q71n33Ph423fKn5XuQaPHjTILx/aE+qgH92sFjXiqGB1UlgTor+C7JOJFCQFKhyho7sF0VgdZ39NPRuBHiKymBMz5nOEcPf8DSJMSctYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209936; c=relaxed/simple;
	bh=57Q0kwm92dVcG0YliZgGBglpxNiTeV8kAqLQA2O64e4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ru2N0a700D6quXqhfUIwAp944Nz7zSpJXjT0PCLe2jq1WpiYthwahWc0JGEd1YGdWeaTiXnbKB4jNRNWgyl8w2J2DmL/jj5sMfNBIl8sO/RdIjgV69RMtpReiAsPblp8nARCajBJt+qXPj+MSGVaRA8S927wqansPqF+ppZjrxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuCMxX8R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806b88d8c9so5520135e9.2
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 04:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770209935; x=1770814735; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=57Q0kwm92dVcG0YliZgGBglpxNiTeV8kAqLQA2O64e4=;
        b=QuCMxX8RKYR+M/Jh/XF2wFy1LOGuzifnTqpzdg7sD6ibHC3881tM6giEoBh4NIkLMR
         RdCY//OcayqQOKvQWpXOSMLiZLqFwT/3ivlBgXX5i3GalwNrTqG20c/lhL48DlNNeNai
         4P2sp0vkEYUkM3WuI3O/lOfvqxw/RDSGAa74UDMlO3Huo6uAx7sjqIP2Hd/b/ClNtaUQ
         VfoH5abnWwm5YlTz4RMio+iLHBu2lY+PztK6sMy7uCxepZBjrcLiDDz9SZ92gPSv0Wpa
         SMYJtUV9Z8nsV9yL7srQs0K2J1iiVjRRFLf2293fDdSo0EALesy5JkqbWxBASFlrSY7C
         QAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770209935; x=1770814735;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=57Q0kwm92dVcG0YliZgGBglpxNiTeV8kAqLQA2O64e4=;
        b=kZMEDz4+/IYMkPaTfelrvZ77TgG2XpLXAxmM1SdBq9ZAn5hfHmKrcjJ7D+z3G6YBSZ
         KM0ivfIRkuNmmgucWjsIKP2ms8zJgOtn9+ankpzD0B5rIw22rCrumMmrZzRvhtZKpGOa
         +582s1c7kdjaFe8nxSEJV0bSEnyPDarN2U4dGP1VtXija6uvoAxW6LPqtFDGsgSrSJz2
         AFYiy/c7PuXMhBaRXJcwva9r4/X88pfs/OTwEZCdwOXHyhnxOqmYJ1/LlmugTTryvgvy
         SkQg0cECp647dDyPhZo61bjnzl3EtBhZi0cNDmh13KdAC+g0PmnRJQjlr2X8XMr2Qkn+
         x9/g==
X-Forwarded-Encrypted: i=1; AJvYcCVKG8SJD9w2ERAamftK/H3uOMJTcz3+CWBt4eSxZUN5He4HZ+X0PFcF7OhGcxshQhaXdI9/w3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQkgwAiNiSNp9iB2usWIzyezHBSdazu5eEl19lgPoDGb1EYA7
	Jtv2xwpUNqNOvoeeaKckNeLSD3kZDe3b8pAaUsi1E8n86WKqtZ4ZhLKx
X-Gm-Gg: AZuq6aIEevtS68SDdR6L2oSlILBj+uHRWzhZDRQk0DWK6HoKp+uyK6kOcn2wzREoNV2
	HpUkhVYkdMEaMu8Jz6CKYUwUDkxU55eMgYE3LIXuQ8FLigk4rwi+RIWKDKmJrFz/QGWik1g9y/Y
	mmQJqx0ARYp+kXBLwERGhVEFi7iemYlQCZqSamgfUdNyLaCnGlOfxZp+xyyDrLJSALWTv50u6Yb
	TnkdtOHjjcR4l4HNWTn2o40ccbnoDNa0Y9cEtYVSkd/2SWJhv9PKTOikg1QowkbopDgzQRXPVZK
	6q0v+lLfOQw40005/2Vy/pCJI/MG90e5uvLWjN0FJoH+34wLO7QSx0fTpsav7zSnv+7ZmJubPB6
	VvnRFYEdM+rOo+LtCqsWyTpi3qfFp2wptrEtQP9/x7XdayjIGLRPiODCzBK+UQebfPmruN9mXZn
	oHXpJLw45YLHromp4N4JntM0vt3QtGu2Xgxgnt1DTpwd9Td4XEj4eX8rd9LOZcOj6nfLcFEpppy
	wp2Cw==
X-Received: by 2002:a05:600c:3e1b:b0:477:7a78:3000 with SMTP id 5b1f17b1804b1-4830e981f9cmr23205715e9.6.1770209934567;
        Wed, 04 Feb 2026 04:58:54 -0800 (PST)
Received: from ?IPv6:2a00:f41:4842:718a:3ac6:8cea:3b72:7d9d? ([2a00:f41:4842:718a:3ac6:8cea:3b72:7d9d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ffc9f3asm19300975e9.19.2026.02.04.04.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:58:54 -0800 (PST)
Message-ID: <3aefbee8ca6159ef9dbc5356246eae266bb6382d.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: Fix condition effect bit clearing
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>, jikos@kernel.org, bentiss@kernel.org,
 	sashal@kernel.org
Cc: oleg@makarenk.ooo, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 04 Feb 2026 13:58:52 +0100
In-Reply-To: <618af8dc-7698-4335-9d0a-fc7ec36cce9f@kernel.org>
References: <20260203174241.2863219-1-tomasz.pakula.oficjalny@gmail.com>
	 <618af8dc-7698-4335-9d0a-fc7ec36cce9f@kernel.org>
Disposition-Notification-To: tomasz.pakula.oficjalny@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	HEADER_FORGED_MDN(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-213378-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomaszpakulaoficjalny@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_MDN(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 994C3E623F
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 12:58 +0100, Jiri Slaby wrote:
> You could use | directly in the if, perhaps with a comment.
>=20

That's actually pretty neat. Didn't think about it. Thanks!

Tomasz

