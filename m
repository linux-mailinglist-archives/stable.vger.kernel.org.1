Return-Path: <stable+bounces-238035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PunM6oe32kjPAAAu9opvQ
	(envelope-from <stable+bounces-238035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:14:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D44005ED
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 280893028009
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47683542CF;
	Wed, 15 Apr 2026 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSJeH3e3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609812EFDAF
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229718; cv=none; b=hX00Dd1VFEuHgkA4TWp/B7GVSyBNJAByX+aUXGFtajlP3NZyWostyri6u1L83g5HfLMyv0OvWhYJoanKI2rzqQoUcPqmSP+gTW0KWIoA3ajiKhO3s/QGMqs585WTboelXJLhuRNzbeXmnFJEpGEDu4SeZ8X17WZS7/C+bqlgR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229718; c=relaxed/simple;
	bh=acWqE1tc4Ow5F1BA+F7RH5Eqve12kgs/16bnXdFmrs8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=rMVAtFThb9wJXpRbBh21YbTYgmGECRLPZyEA/AL+9b02xscoCi62ChiERDCDUM9AVIxIU8Mu6AejcJ7tlNe6AxaaHiXw797032Gp+T2KKM3cNaD9uUyNr6wHOU80ijM3se81DJkTzQDYKj0Ht0v3UCbVHp7lXFBTooICFlHzVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSJeH3e3; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a093c784b0so78260796d6.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 22:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776229716; x=1776834516; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=acWqE1tc4Ow5F1BA+F7RH5Eqve12kgs/16bnXdFmrs8=;
        b=jSJeH3e3/j4feaQ9TJqCn4oil9WQVlCvQlCpGe61xTPozXVEwQBTxt0637r31MnX/K
         WM2ycXN4ImQoZYF8okx6FuFiNPZjT1XcPRL+gt0/OSgEhWQFLqxRvYr+AJ0vshahmfFT
         8QeE21TR6oPW6i/L4QTc9VIdZPmJVJ94JBfFZngJwHFVctyklUES6r6jnblek76AJPth
         7Frsdmid6Z9/3ooCoWJeRbC1nUTqEG75AwekZx8ompn4g0b9dZHwZrQU5W9qWfeEUJ1W
         g7rFJyx7QAJir/ATmJgjk4QSy6Y0CeE1xHhjtkMkRRgWs+PvKW57t4Fj9wP01xS1JL+Y
         nJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229716; x=1776834516;
        h=references:in-reply-to:subject:cc:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acWqE1tc4Ow5F1BA+F7RH5Eqve12kgs/16bnXdFmrs8=;
        b=GYpESF2qykyRUHnb2iSC0zwG8JA63c0FK2jK+JMCYDrKysoTKXOH8aIFyiG9PmI/+l
         lAFEmWAu3QM5Tad+mRkWfvtQVr5t0kEBMJynaGtogu2bRJNs5xJ68n0HuXkkm7Oft8qm
         RxE/PeX73o9KX2QjUYfZQ+YeUgtLvPhKVyuDjaBQfU6/bK6rJnCtzhNYWyLWCwj5gE6y
         T2f+E0sHXAJ1Y82g+jMdovVV8273N5h1T19G7eFqc+HJiY75Et8UbOo678R5wJbHVMGD
         SW87kB63Z51YhoNnDsdc2kg5MubyEw813Q88iMeFjeX0PSfR/EHrMp3PAIFL3uNCMpxQ
         nGcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Xg/sLnIi03x7TClWla1vi18tjPn9woRZTQwICG/+hav1Ed4eofhs9wM3z24+SVskllczyUcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAxx9OiIklPmfraKUIzpP+c8wFBkv+k/bhnXDkKMJ7pNHug2gu
	4YtMg81dIy8rObIhu0MfN3vfmquumLDQR6rzKFnBVm0ALHXYV6/+Oh6Eo84FDp6w5S5gUQ==
X-Gm-Gg: AeBDieuaJXP/I1+CQZy9PNoqHTLQFuwFfdLWjUlcq1TTLI1qSGgmx3rjgalpLcZNofQ
	6UF4eU3tAuwSLmg3hinyorhRcqWOJeTwzwc2su/NqSu+HqKPwT8LQ9ztBvSttBhYIJBvFBkFL6P
	PTURf6qQrQATRJ+4yD84b/b9bY/kWZmUXxm0L79v5WLJnhPF6wXO3mNJ68RO4Ohg714SERAWajH
	lvPG1jt4Avr5VJN9W6OAx7iS+F0I8m8KAVk42I/UPDPjBAP02/3vV+L9VsXz0LlJVMO1mLmX6wq
	41iHnPPJ4cSdRMsj+MnpkILaAzZey1j3RlS+0MPTNu+1yTBDIjGShchmaR3WkJgyaVe+iUSalA1
	2n7b5UYkR5QfQPrUacu/VU6AXahs+SREX4i4ppRaUopa3U291jDTrzGCXAME253oSY8e6vAYr56
	+MgBF17CNgC59bx/FByQO08PK8YT3SBRIwrA+3n6y+K44Y0TJSCVu6V9m/f15nXsJRBwGBNHQ=
X-Received: by 2002:a05:6214:3986:b0:8ac:b2b2:b2f0 with SMTP id 6a1803df08f44-8acb2b2c5bdmr156438416d6.1.1776229716413;
        Tue, 14 Apr 2026 22:08:36 -0700 (PDT)
Received: from tdc4045031631.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c993a3asm3944476d6.22.2026.04.14.22.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:08:36 -0700 (PDT)
Message-ID: <69df1d54.050a0220.153b60.b34d@mx.google.com>
Date: Tue, 14 Apr 2026 22:08:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5011019757784256419=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: mcanal@igalia.com
Cc: dri-devel@lists.freedesktop.org, itoral@igalia.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] drm/v3d: Reject empty multisync extension to prevent infinite loop
In-Reply-To: <8c2f4d80-2f33-4cd1-a6f0-ac5f23cdb777@igalia.com>
References: <8c2f4d80-2f33-4cd1-a6f0-ac5f23cdb777@igalia.com>
X-Spamd-Result: default: False [-1.06 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238035-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mx.google.com:mid]
X-Rspamd-Queue-Id: 331D44005ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============5011019757784256419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

SGkgTWHDrXJhLAoKT24gMTQvMDQvMjYgMTE6MDcsIE1hw61yYSBDYW5hbCB3cm90ZToKPiBMR1RN
LCBidXQgdGhlIGluZGVudGF0aW9uIGxvb2tzIG9mZiB0byBtZSAodjEgYW5kIHYyIHdlcmUgY29y
cmVjdCkuCj4gQ291bGQgeW91IGNoZWNrIGlmIHRoZXJlIGlzIGFueSBpc3N1ZSB3aXRoIHlvdXIg
ZS1tYWlsIGNsaWVudD8KClNlbnQgdjQgd2l0aCB0aGUgaW5kZW50YXRpb24gZml4ZWQuIFNvcnJ5
IGZvciB0aGUgbm9pc2UhCgpCZXN0IHJlZ2FyZHMsCkFzaHV0b3No

--===============5011019757784256419==--

