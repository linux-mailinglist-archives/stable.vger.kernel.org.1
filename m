Return-Path: <stable+bounces-253417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB6UEkVVDmrl9wUAu9opvQ
	(envelope-from <stable+bounces-253417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:43:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B860C59D607
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A246E3040DA2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FC22690F9;
	Thu, 21 May 2026 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chDufqv5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16592257459
	for <stable@vger.kernel.org>; Thu, 21 May 2026 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324224; cv=none; b=hU3Qh1jjKET1F0sKt581NMz/pnZGBfgu875i51fBwdyK7Hydb0ZM6NqUog3keZc+0osXlOJWN5gmUmpG4xRkYYPnEXTv9TfzUmECSmYYXmLQb9n4DgqG7GnD2bAuVCnanAEtz/A65/44U2feOl1x8OwNrgwk+6qNNq7x0I+vvr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324224; c=relaxed/simple;
	bh=IEIzvlRRqDl+bWvL9H8iIJCwiKrUdTUr0U3EgaWDVWo=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fIxEBLK+2R6b8VB9gSXKOXCUiIZKLVvU0ebdWhvzQQG8Tb7PKF1P3KH+qiuR0oeJULWmhNcuwbv5v9rjNJ8hUOevVbuMOcv9dOpekz/PNUTj6ZWurnxKdyp6+4nGPHoVtbzpot643FzUzRc0xPjdKd7Ut8wJWUaZBbm1Jt9gMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chDufqv5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso1082421566b.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 17:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779324220; x=1779929020; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+uQ3Q0GrDaAUefTv9AQLXze2AquCr/DP4u2vUROxGQ=;
        b=chDufqv5kulo53fezyEyTxtb2SL3xMz0aYVAukaG4fJKB4kIZzLE5nFXg9LquI2Smw
         z6Uj2B/GoNAeoWLyWXzMfEtGm5kEEQ/Q67fSv88ueH10oZFldfQqNNbD4OiP2W3Ogb9H
         sQhm6u8ic3wJHdyU5xARAvYMkQnN+RpJywI/2xiRgW/Ti1GJg+8ygjX9bQz44mbgHfgD
         lUjfnitFCq6Qzca4B9iwfPefsMQmuJYHEjdo4AnAvn1P+zFgwMJTCRcr8GvRciRaIjsL
         A/2A1f2VV+YrPPP9upn0DC3NriKPWSqHb6fsHdyGpTURNh80goha954gjX+Qs3qOzFz0
         1QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779324220; x=1779929020;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D+uQ3Q0GrDaAUefTv9AQLXze2AquCr/DP4u2vUROxGQ=;
        b=HXnReGGDB3jkxdpXymjtcO/wg+FX3X5a4P1jfkXANXzYYyi6GyrQOJJaHIP62SlDyS
         8f3pAtV8+WDC2B4Vmco/WuIcVDIv58WfdxN9TCMpbOYDNZQBIyAUhScj2vBKOgTKaJH3
         4kVQPKNnEtGvCb07zDdxboK0WbiMj4ZidUBDYQMigEVvy/wsnVjImOYgy6YMPZL+oFmw
         0yHNDttKSBgY7J5/qhJAX1c3MkuBgqRRDq3kjHQfu7bznz7IwWt0I7oit/Qd56LmXNKd
         VCGZ0DDnjNQl3V9sOYJiAlMh5ZmNbJfWi+UGEARZx5fro25jGuduEUOa652xCKI46Bq3
         KSxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QyXcoJA3v8RugeBmOFGadWao7x5f9FwoZtWyUt3cXBqj6NLQBVhdXLT0qsf9c7RvT/oPVp10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKg0ClLEtx403PuhCia2pzLfALjjErmoe23HI8xy3r/Eg8IKQ3
	NUGr+NK8fYpYUy1Kl5594Hj7ZOUFtf5Kzs7g4xzQDVixUbToOKeU2YmB
X-Gm-Gg: Acq92OHEfqk9ny2SPNLuzhdSdT1YlA2vTfYBvRWW3xqiv6mSHQC3a49x6ThuH5MdgFT
	ILEODnezkcIjDZ1I5E4SSkpTcuF1qK82PjHt0pNM9THxijZ5b/FxJDoF91jylzWCtcQxfPSWhwj
	q7rBzj6zQ3CpKM42v0hYx2MAcb3s2Oh/qZmlIh8Kz5dwyKYk22/b9ETLeCu2QzFcaY/qVMnErm8
	ZRGOaDq/e8X1FxQuTruagcqfUh91dqAHEGC0Fe4OPjlkoLgH0vyG6a/4cCxI0vCnDx+UtJ9x98z
	5n9IgwOwapMetugFft/R7ZYIRRoqpG7pGy5ABqb9aMCwz4gg9G7TiM08U+pi4S/tA1BDfga2zUR
	0CdSMqY1BR30H0bRpXckVrqDJf+ur0FFB86U3eSb3oxVtqyBuaLMvdwnDWiwj619+t3kbWOg7q/
	jhOf8xRqyYgBZXwJLKd9QVaTFYtyUSnLgu1qpzFYvF6bPiOOC8nCiUtnFcCITIQ0Q9oNdglgdYp
	JULBKztPEja7/KgX+tdH463iFvzGEGU7LuMmxQk6uEfcibXzwTRjW4DDxg29UTJcPYicFd65OVr
	79c59NRFw2Q3bVh9ZKBaPjczOJRq
X-Received: by 2002:a17:907:3c95:b0:bc3:c6f5:1d47 with SMTP id a640c23a62f3a-bdc12f857c9mr22479466b.11.1779324219917;
        Wed, 20 May 2026 17:43:39 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dea94bsm919213866b.33.2026.05.20.17.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:43:38 -0700 (PDT)
Message-ID: <6a0e553a.010ccaa2.2ab173.fc09@mx.google.com>
Date: Wed, 20 May 2026 17:43:38 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: d.bogdanov@yadro.com
Cc: mlombard@arkamax.eu, martin.petersen@oracle.com, bvanassche@acm.org,
 ddiss@suse.de, target-devel@vger.kernel.org, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org, hossu.alexandru@gmail.com
Subject: Re: [PATCH v2] scsi: target: iscsi: validate CHAP_R length before
 base64 decode
In-Reply-To: <20260520180204.GA15940@yadro.com>
References: <20260518121811.385350-1-hossu.alexandru@gmail.com>
 <20260518235040.48647-1-hossu.alexandru@gmail.com>
 <DINMKOIB4PRJ.1Y571RHF6NAQJ@arkamax.eu> <20260520180204.GA15940@yadro.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arkamax.eu,oracle.com,acm.org,suse.de,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253417-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mx.google.com:mid,yadro.com:email]
X-Rspamd-Queue-Id: B860C59D607
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026, Dmitry Bogdanov <d.bogdanov@yadro.com> wrote:
> Yes, the length of Base64 decoded string is not deterministic.
> Moreover, length of Base64 encoded string must be divisible by 4. Which
> is biger that 4/3 of decoded.
>
> | MD5_SIGNATURE_SIZE      | 16   | 21,33333 | 22       | 24                =
   |
> | SHA256_SIGNATURE_SIZE   | 32   | 42,66667 | 43       | 44                =
   |
>
> So, that formula is not correct and will break all iscsi authentication.

v3 (sent about an hour before your email) already handles this. Trailing
'=3D' are stripped before the comparison, so the check is applied only to
the data characters:

	while (r_len > 0 && chap_r[r_len - 1] =3D=3D '=3D')
		r_len--;
	if (r_len > DIV_ROUND_UP(chap->digest_size * 4, 3)) {

Using your table as input:

  MD5 padded:     "data=3D=3D" -> r_len =3D 24-2 =3D 22, 22 <=3D 22 =E2=9C=93
  SHA-256 padded: "data=3D"  -> r_len =3D 44-1 =3D 43, 43 <=3D 43 =E2=9C=93

> Alexandru, may be better just to change size of client_diggest variable
> to match it with chap_r like for initiatorchg and initiatorchg_binhex?

That also prevents the overflow. The length check is preferred for
consistency with the HEX branch, which validates input length before
calling the decoder rather than relying on a larger destination buffer.

Alexandru

