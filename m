Return-Path: <stable+bounces-223397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBqiEFxcq2mmcQEAu9opvQ
	(envelope-from <stable+bounces-223397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:59:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFF6228748
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D18D3031B30
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 22:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E610F36074B;
	Fri,  6 Mar 2026 22:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXXzEdhm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46434FF4D
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837975; cv=none; b=F8R84KJRwrgYcsOdwX9IT69Ix/ojylK/Yr1EiVI/wZZouU21pnTy9hUutkTtlo6Mt7hyJWm74KyL5+HMuKCBu3aZAaX/qQ70/e+mU0reyxy17l+goZls58Srzm+qfHThZL7vE3lQwwzTak81yIyCy+TlM8lNA3k2QYYPisgQIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837975; c=relaxed/simple;
	bh=4gdZG34dcUZ3EuvSE5lG2OYC4lyaxRv55cEcPosU/Iw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=m44pRsKXb2bk8A9OGR4lq4LV4JEPUmuFoLxghB7XffbHsPnlu8dzF+aEPHYoSBZ2QZWaim2W7+7v4ZBVGp+eAMSo1yh/load060bffQuoJY125Luvh42tXgV/mWDvfRxs7IYoL/UUXOKuvZEdr7s1wRwpP/Q6rK9xy/yftqixkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXXzEdhm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so63959505e9.3
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 14:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772837973; x=1773442773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gdZG34dcUZ3EuvSE5lG2OYC4lyaxRv55cEcPosU/Iw=;
        b=LXXzEdhmQPZu/hdoRMRP94caGcFGAMzFkKmrnB/FlMH09GKOW2kX3fSYDSzBSBo4CV
         vnZ8mQ48Axt8Az9+5aXmqkTAhA+z2wN7k1dMMJSaYA7sYQBEBoU0ABjzTK6hS/Da4Xr3
         arO0b42IaaKGSSBjLNtW2Osm4IhHioflbtMrFKpbJJVkQMQgDVjPFGZcCffXx6b52mWp
         eLrpvIc+Oyy1r8AZxJA6UQr+OSpNvgYroSZziNvvh39M3NVEo8GyA5uxvalkkJcL4E9e
         E4TdIe5+astxCE4g3+xmHet4l7OmkuyF/Pv6BOYGD1HJDPXCKiV850cGWzqjdz9Ssi1C
         Ygww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772837973; x=1773442773;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gdZG34dcUZ3EuvSE5lG2OYC4lyaxRv55cEcPosU/Iw=;
        b=lwbrdOAogZ5sZ/rnVIScAQMy/hCL/KuiPtW3XFGSc2DVKWTc1/I72J2SO//ma49aPx
         pDS8sE2mn/NmK/OnjelpnaVZBOrhzyyyxvIyjCzo9qgY4QV4VTKvT0NC/fsQe56O8GJF
         gXIuXt9KMh1BB5qghoxtWLF1YSfZK/R/3x0wuEVP7qnQ3PZyZ9VGO0KpcT69O9ePjacQ
         2Fjlqy8VjsYPVxfgR/zkGEgX+uoPUuXAxyLTKJa0Q4CPvMBEAoE7wsbHorEpfIxRr0s3
         v4k+OKUgzkMzRTseFiiXFYE5m/G3ZDymbXCDfU6C9M64Xy2OWYObQ/W/2bB+pyq7G+2J
         53AA==
X-Forwarded-Encrypted: i=1; AJvYcCWxSan/bStNuRDm0JZ/uYoN05tcPuI60LlK60U9fdHoDp2lWRk9fjmFq8Lx+x8L5lU5v6meCN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvMWIz18dzWDLaJQQvnWyoxirL6wK+4paywZqUm4NXTPzHlLJ
	tK0nmtK5lzcA9IETrdzio0h73IjgP67craNAWzM1gbBiqRFLo5bUUrGr
X-Gm-Gg: ATEYQzyuV7JRB4XHhtdF8xER9tznZrh9QGSWdYgFvFYYx/l5VCvLzoDg1YHiv7lTdjY
	44D08QDQ6plhRqQBzciWU/0dNxNSWo3ieo95tn7ev6rX3psHiipKk4jPvyDRRw0qHq8fa3OMj6h
	t1Y8iuuKCQot5RvYpIYkhz16B2k1N0KmFqWb+5XpCMmySyaBh+kphfJz4r8muUV2eMU2A5KH9Bd
	75eaqjBADdSdmZpKpRiiYufOKVrIe5oZJ21NwH2ih7LUUkJNv5I8nVtXa/kwGt7rIxplk1JeXXK
	8QGBtfDjyzc2CTaLjS7cKLSiYRbSWWPybWOd51R4/NMG0muDg6B+rUAGV8TMtcldO87Pw+MjjoN
	r0FnWjYcg3tlOgFxgssd9+RI5K/I5uln+ECr5Ea1jGTZyMXNDo78zywhFWvOaYOQrx+DNUsQIRr
	abonxpyoDF6UZ0DfOU
X-Received: by 2002:a05:600c:821b:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-4852693049fmr61205695e9.14.1772837972744;
        Fri, 06 Mar 2026 14:59:32 -0800 (PST)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm149218735e9.4.2026.03.06.14.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:59:32 -0800 (PST)
Date: Fri, 6 Mar 2026 22:59:33 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam Howlett <liam.howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josh Law <objecting@objecting.org>
Message-ID: <d32083f4-bc02-4e93-86b8-4008207b1c38@gmail.com>
In-Reply-To: <20260306145720.e8b6afd26aeb9b5caa277026@linux-foundation.org>
References: <20260306223219.2824040-1-objecting@objecting.org> <20260306145720.e8b6afd26aeb9b5caa277026@linux-foundation.org>
Subject: Re: [PATCH v2] lib/maple_tree: fix swapped arguments in
 mas_safe_pivot() call
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d32083f4-bc02-4e93-86b8-4008207b1c38@gmail.com>
X-Rspamd-Queue-Id: ACFF6228748
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,infradead.org,google.com,gmail.com,vger.kernel.org,objecting.org];
	TAGGED_FROM(0.00)[bounces-223397-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hlcj1234567@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,objecting.org:email,oracle.com:email,linux-foundation.org:email]
X-Rspamd-Action: no action

6 Mar 2026 22:57:21 Andrew Morton <akpm@linux-foundation.org>:

> On Fri,=C2=A0 6 Mar 2026 22:32:19 +0000 Josh Law <hlcj1234567@gmail.com> =
wrote:
>
>> From: Josh Law <objecting@objecting.org>
>>
>> The call to mas_safe_pivot() in mas_wr_extend_null() has the pivot index
>> and maple type arguments swapped. The function signature expects
>> (mas, pivots, piv, type) but the call passes (mas, pivots, type, piv).
>>
>> This causes the pivot index to be interpreted as a maple node type and
>> vice versa, leading to incorrect pivot lookups. In practice, this means
>> a null-extending store into a maple tree node can read the wrong pivot
>> value, potentially corrupting the range tracked by the maple state. For
>> a VMA maple tree, this could cause an incorrect vm_area_struct range to
>> be returned during operations like mmap or munmap, leading to silent
>> memory mapping corruption.
>>
>> Every other mas_safe_pivot() call site in the file passes the arguments
>> in the correct (piv, type) order; this is the only one with them
>> reversed.
>
> This all appears to be identical to v1?
>
>> Link: https://lkml.kernel.org/r/20260306200820.2819999-1-objecting@objec=
ting.org
>> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>> Signed-off-by: Josh Law <objecting@objecting.org>
>> Cc: stable@vger.kernel.org
>> Cc: Alice Ryhl <aliceryhl@google.com>
>> Cc: Andrew Ballance <andrewjballance@gmail.com>
>> Cc: Liam Howlett <liam.howlett@oracle.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>
> Right here after the --- is where people add their
> what-i-changed-since-last time notes.
>
>> lib/maple_tree.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)

Fixed on V3

Only the cc stable was changed so you don't have to do much haha

V/R


Josh law

