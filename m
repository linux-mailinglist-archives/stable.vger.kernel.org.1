Return-Path: <stable+bounces-217584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BQPGjl1mGnhIwMAu9opvQ
	(envelope-from <stable+bounces-217584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 15:52:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF81688AF
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 15:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E633058557
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EC834B18F;
	Fri, 20 Feb 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkDtq2sK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D32C0F8C
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771599117; cv=pass; b=d8hFNTxvnF/C98JLwPnCARTqn+QQrp20cuBK5NuMf/x+3xt03c5smXfESZ/qbEJs9oof6XYjq1q1D3mHabXeXwHlBccwF757pDIHR+eyKj+LoJato51DYsCbRGBOxl+XWMwWFhM5BORY+rITDMA0BkDaxgONHbuyKB/pixqyyqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771599117; c=relaxed/simple;
	bh=CRC9wX3iNFw/rKwvWg64N9r6jXdqwQPIuFwNZXF8S+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qk7Gk3xkgaXbEgrtQ5zJzv8UIRxzthigbXJuVwNeM0XgNG1W2ECzgZjB25laRl/uknDiQ44Q6RsG05+Os40CIB7RCAe2u5/hVutlJ5cziZEzbanqLeUixPCsQAbW2oRgLuhsJsS/B1RQx7vjJxx1Fbh3FXG+8oFgsyntwfb5PoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PkDtq2sK; arc=pass smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c70ce93afaso196823085a.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 06:51:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771599115; cv=none;
        d=google.com; s=arc-20240605;
        b=VPyyWjv9kzIQE3Roxwl59uRhJ9/OIyY/5OgaMYbqAmXIeJYJmvqPMWC0spsKDRXiNN
         o9p/8VeAGrlMIfzvn8XBYfgBv7mdTzTGGeqGzGl9gENMJ/DghEvWxO51LYr/rmqaAY4s
         KMe5W1CEN6gv49OTwzZtpD3ub/gKXM8B5iH8500iN4lnULu5iUaro54jpN2NAOnKTO1b
         vVHRMA5t/5tsb/KN4J60n2Ii7F3mjiMFmt5kRmA0avxlr55WvHoqyI9SH95e/Z0t0aV4
         t3i9toaDonkMb+zEZKN0Z/NxoxvxCJoo7W2JF7ynqSbplQ3BHtgDmodLglxtUpypLrBI
         hnGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CRC9wX3iNFw/rKwvWg64N9r6jXdqwQPIuFwNZXF8S+k=;
        fh=cwUxRcz8g7Ey850fWcDpIgaxMRObh//K4OpDDyJ9Rwo=;
        b=Fn85CvWJyiFSIwvrtXjv6zDLqsi8iQFxR4aichrv1hy7BIWMxukhmMKs69vbuXiU7U
         kVWs7lDz9saESmp+ZweNxS45rX9e+NGtUzC/2V5fPmv+/+BMuoWFMT5FWbfxXvpaZld7
         hcwPWlMatnqudVrmwwmFHLwMyRBfuGade1fIBdPOvtQMDD0nkKRT81KN6Rdszs1QsevN
         09VP/849LCzDy33VQLCL51/3bRgZg45PMxlFDnN4th4ftDKQTsEprgaSduOIBGoIxH8j
         6zpU7IuoNWD6J/dpyksUSJ/QUlXnepzfluipSrWoXN8I0PgiCSqKHTLUYwft51NyaQhR
         Tg1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771599115; x=1772203915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CRC9wX3iNFw/rKwvWg64N9r6jXdqwQPIuFwNZXF8S+k=;
        b=PkDtq2sKVDqyq6oI6vGMk7tFkPg4JTurig6QBub9nOzV0t0NN7F8Mkkx5HUxKl8oQJ
         V0ijQECV3y3Ci0Wf+oWsVLba9T2OVaVChMi4uZctakUG8btCmNBgym/OEB9oYUkQvw6V
         XA9IDy+eWE6ITEj3OJ1ujIfWyLFG1sAcrx4nVjOZqmlvHq+kNF7rkT0lvNLi76fUkX4L
         f+7Wa/Y1mZPoG98wjFu2w+sVow3f8ENxVth3d3Gn2E5xrKwL6rAMJQtlvp2BNulRZBck
         X6+QM0FbAimbgNXbkJ0B6Qfg+utHDhbnUruAEDZYPkhnSmX9WuuJUm0GhSMHaJChA7an
         BDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771599115; x=1772203915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRC9wX3iNFw/rKwvWg64N9r6jXdqwQPIuFwNZXF8S+k=;
        b=wgDHr8MJHpL8AGTg1sOMhGOhCZqtCzHsN/S5BoxyF3JriQ/i7dOsDFGEyUiNCKwY8G
         UAdRUW9f5EQqnjNxsfHU3BlV5SPX9kw0qr6K15eRrJBxp3XKYV6UaDBxHcd4dbIfCRDu
         UgTkf7qjmOHlJMrPhyzmv6nPwE10aMOo7diIpxfg06IKP3t0hjA37YVrqpdK835v3wR4
         ARdl6D+Nd11EY7/LV6PwORpgijT/bvQdNpqRuV7AdDsQ7eoalFpITyIugSaNrix1PHoH
         XXoH9EO0brtCtI3xhhlhN9CcHC1ZrX0o17Ch7aRVVqswxKB2t97+9Bw3vMqdkttw0oLN
         weqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw3ekhIUIbs/nPv1alAdBGiaOykI/G89NB9UlvALC7yKDnEjkuy/LFkZZHWJ5rxMjd7IoFPEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE51DDRqIdg0dROaSOrMeUvnEY1qblV8P6iIuhwZ8Oed9uW5Bp
	IAkjsbO/amMZ+w70rF7JH38WrGHzXl4AYqA5QtJyPhtLwtJdyfV+Mr/ls79SSZrQH4xboPZVVsS
	y+OQZv034fToA6vBxmcpDRHvw1IeW7ClTmomPlcn8
X-Gm-Gg: AZuq6aJx881dpi9tgkTN+UJJGMwo9XuoWGWmMlroMWKmHcIpHlrVZ0pZ23rs8ttyR7x
	dTKzaALSHLpF6emCX2Fkg7wI8WNOOrdgkjb7RfwWmc2p5pGyonjZmQ6z06anL+P5PW7iXRPdFQd
	5R1LngiKdSoFIU0nPhY71HafAdYVhSY9j2AUjESH8uOs4dxW7zIbeSdkFBW/c2pGLcz3ezoGbZy
	MuPLRG61kmHGrGrQ/mU0KYjacawAnhYl10PFyA2/KVhiCuBkWtdl/0VxyOFOwGmJEn2x7ypzIS/
	x9IF+55hEsY7aAIRpBfC+1FqGumD5ZGdf8gbdz5LnbjJQhRl
X-Received: by 2002:a05:620a:2995:b0:8c6:ab8b:29e3 with SMTP id
 af79cd13be357-8cb740a50afmr1032496685a.44.1771599115069; Fri, 20 Feb 2026
 06:51:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213095410.1862978-1-glider@google.com> <CANpmjNPJV-aQKnQ7Mtr6e8_12UR3C2S3abJx_ePFWmS1WV_UVg@mail.gmail.com>
 <DGJT8E07A37R.2GC7KEDWEI7R@tugraz.at>
In-Reply-To: <DGJT8E07A37R.2GC7KEDWEI7R@tugraz.at>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 20 Feb 2026 15:51:17 +0100
X-Gm-Features: AaiRm521oqZ4C18Oc-qFEQM1txdUhdvqiUI1K2F1OhtYJjScl8iiQRwoFqDDN0A
Message-ID: <CAG_fn=X=Jvm1bPo=B1f4oo9eSAsHN0QBcu34oi7cMC+Q6--ZAA@mail.gmail.com>
Subject: Re: [PATCH v1] mm/kfence: disable KFENCE upon KASAN HW tags enablement
To: Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>
Cc: Marco Elver <elver@google.com>, akpm@linux-foundation.org, mark.rutland@arm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	pimyn@google.com, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217584-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,arm.com,kvack.org,vger.kernel.org,googlegroups.com,gmail.com,linuxfoundation.org,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glider@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E1AF81688AF
X-Rspamd-Action: no action

> But this requires adding __GFP_SKIP_KASAN as allowed in
> __alloc_contig_verify_gfp_mask I think. Unsure if there is a cleaner way
> of doing it, or if changing __alloc_contig_verify_gfp_mask could break
> something else unexpectedly.
>
> I would be happy to try to submit a patch for it :)
Sorry, I was working on a patch when I saw this email.

Let me send it.

