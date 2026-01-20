Return-Path: <stable+bounces-210587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEIeKZPgb2n8RwAAu9opvQ
	(envelope-from <stable+bounces-210587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:07:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8084B057
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 21:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF88D82AEC3
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 18:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168D844D02A;
	Tue, 20 Jan 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacecubics-com.20230601.gappssmtp.com header.i=@spacecubics-com.20230601.gappssmtp.com header.b="QP9g6WdU"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D3346772
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932378; cv=pass; b=ial26+OuRMn7P1jUP0+qF4BLFNyZJi/LuQ2KkIGq0ZiPrWCasH9DNg3j9uoYByQIMfnkTJQg3lVcjMrTrLPjxP7XHmZjADyMr0er+W3KIFaHRd9dB3GgTaOkx1wysRpwY14q6+BCAbc7234Qx5OSvtCkD+wFRDfpUKnsjCpICxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932378; c=relaxed/simple;
	bh=+WVy8t9iObXSrAxdFPpFwzWAYTmKkEnp49pf096B7dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdzDzcibY1l4/FqWdSdyXzayRLc/CYbL6Dmk7CvxqduU3AcIiy4xJF5slxBxAXsvE6TqJVSpVobqlZ7PkIbOijI410IbwTS69/A5kZGkycDJZpei8KXk0auoypNu+XddPtcIa1sedm8bXG9iHPFBMWXttoVmwk6MojP+fLH98T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacecubics.com; spf=none smtp.mailfrom=spacecubics.com; dkim=pass (2048-bit key) header.d=spacecubics-com.20230601.gappssmtp.com header.i=@spacecubics-com.20230601.gappssmtp.com header.b=QP9g6WdU; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacecubics.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=spacecubics.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45c719bb855so2984634b6e.1
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 10:06:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932373; cv=none;
        d=google.com; s=arc-20240605;
        b=NYuHL7QFvxBWsakMXxwyqfoCs8xZI+6w2K47A2tEiLiMWq5D9qGeZHAosLWcUnu33P
         ZRqSydjqNAbZqA2tf5vHijm8ZiAmyow17taz2/sRQn1nJl2/VIIecEJuSJLZD160A8zs
         NBGcN36GblELm0UDRoFFXxjiER1oCxoVtyjE06oEO8zd2ivRxo1azRkeW43+UHq7ERR2
         ggzXlPRSvS3vygLTtcQ/q1jFu88IfafbfTk46GecJrDl/8+m5Bn+QCpTGPd+MBRELZTK
         huj+j7cjM5J/ubMvDl9/beZd6/y1lJAFHzFkoUR22jA0aM1/+9sIuD4v9Q66GfY6XM2k
         ch0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jU1YTZG+X0wStTp0k9xMvuSOIPuEZ5Eb4/d51lSbyEo=;
        fh=2mP+pJggPNCdSHANLJ91cUFqhCjso7LAPKRkrBNbUSI=;
        b=ZJ3DTyzaRMVRBUvAigIK0793RyQTZZ06EOrbvGcwl0qwWWi7iSWSNIiWrmstSS/no4
         eOQiq3arr80mZeVNPpIz91nv4VQBZhoNQp/8pw3OD20IJ+P+/MADVvDzMdi0TacjRMHq
         rvdck+5HM8Nk1W/iZeeouuUXs3t4k/5Uj7VrSYQCuyF1u3110bmctzSRneW+speYhKLu
         9Xki4SQNjjzm2siOwrURAyR/TC6o2pEDquYEGOu/4gHX3yFZ5J9QPwZSFqqcRistHFIP
         7/FHQPxSngo1MKy0bZLioi5JovqDo9gHlb0qwmfWcailW7gMlmRVLCzkjFF7wMUQRgGG
         g0AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20230601.gappssmtp.com; s=20230601; t=1768932373; x=1769537173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jU1YTZG+X0wStTp0k9xMvuSOIPuEZ5Eb4/d51lSbyEo=;
        b=QP9g6WdUuGwYavuVpW041Wm7z5b/+cW0ZIq71EHCoewECdjkM5MUTiydBAW4rMbv5d
         pI2/uXWZL8qhbs8QIhoLd3aAoMMA4Pawwk1E+KrsVNDecTwcvEyFjEG0DRSzv70jEMSD
         KcBRQwXKBo0IS2K/2L1hAEEUjtgoATZXjqYk55dlOdsb9sBppECXFOW1v/aRkcuS37Zh
         sxdYTIU5NKD6lzT1KrYxBGOBsK0On75Jg4L5Vj1tqk0sLk1ILV2qFBLhtVpWYFbfniAs
         ihnd8EOogXDDQwye3uTPRjZx1teFJBoo9rMM6LeUsssEZ0Op+JwXkzTd80C8jpkzGHti
         ZhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932373; x=1769537173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jU1YTZG+X0wStTp0k9xMvuSOIPuEZ5Eb4/d51lSbyEo=;
        b=Bn2GuqWUnMuSr7YiAs1EXRtfJANvoBLk3tL9m93bMD7FvK03tcFjaqPr3WvfK7h+np
         D4n76RkyANp90SBZ39dFhDT89WaSlqSzQxLEqBHh/VdniF28lHQLyAoqz9APVE3v1Vvh
         SkFKxHD35dpokYrEXHCQcLhvfWcJgq1EPbr/77gpmftMS9f9Lm9UZeAf4DZM+yyyQbph
         VI5PR6ld540cYy2sQX6NjNJaqN8C16xI4xHgwD+qqdmZfLiSKy01nAt5DC45s5a2hh5v
         MakPqto9rkSfu1BzxF627p86seLV5Dz68ogFbonoZiQM1XXFy665slRpFpiv7xxqHvW2
         V+2Q==
X-Gm-Message-State: AOJu0Yw5+HjAedLcWRK91PjBTPJbiI5hzXSfOoCCr+RRrFnSW1LPy5Gc
	kquuBw3V9pqya5DDnsj99p6oOYwGULkEhY6CbSBb+e3H801atQzPFe+GDOPygwYhey/skDUtJGw
	za6AUcgiOjSTYs4SsJziPcn8bi80dNCEzn5TzBF1Z03UWhVay3fESAB0=
X-Gm-Gg: AY/fxX4fEflfD/fvIh++Y9WJVA0NpNx3taI+5odVW72RGRVkUgXipds3haGJJz58Kvx
	D5gEhb8S64TpzrJroCrrcX1FicY8BIucoPxp5XVBf3EQELn/D/Eg8dlCLG7BoH9RFiEQMqJj12d
	AdKZbtFmy6we9I+jNQTMEndWmObNCsVn7sxAAYjNT/Y/CRCkDCG4eZofbfckN6b3jBgyLH7qoht
	oCadAIjMKBGyqGOhl9KcF930plnnC56TTy863FsZpryEe8J5OWRhxvYjvrplKrKazQh7AUV
X-Received: by 2002:a05:6820:81d1:b0:65f:6d6c:530e with SMTP id
 006d021491bc7-661189c3857mr6740724eaf.72.1768932373358; Tue, 20 Jan 2026
 10:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGLTpnJhAgNThT=gWcpLEEFvNBwav+N=4Kf1yQK2O7T823MzEw@mail.gmail.com>
 <2026012000-sulphuric-carton-2253@gregkh>
In-Reply-To: <2026012000-sulphuric-carton-2253@gregkh>
From: Yasushi SHOJI <yashi@spacecubics.com>
Date: Wed, 21 Jan 2026 03:06:01 +0900
X-Gm-Features: AZwV_Qggqcz14bIBH7MRDeKQooIAqZWP6b-2SPppn-jjc2nX8QwjXvIG_o1i-3w
Message-ID: <CAGLTpnKv6SCs2v=ZPJ6AuQh5uWMw3JnuKP210N2jCa6NND-2tA@mail.gmail.com>
Subject: Re: SPI NOR: Request for Inclusion in v6.12
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[spacecubics-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:email,spacecubics-com.20230601.gappssmtp.com:dkim];
	DMARC_NA(0.00)[spacecubics.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yashi@spacecubics.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-210587-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[spacecubics-com.20230601.gappssmtp.com:+]
X-Rspamd-Queue-Id: 3B8084B057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Tue, Jan 20, 2026 at 8:00=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> That seems like a "new feature", why not just use the 6.18.y kernel tree
> instead?  It is the next LTS release.

I understand the policy against new features in LTS. These fixes are for th=
e
S25FS-S family, which is an older part, and the original driver does not
handle the SMPT and dummy-cycle behavior correctly for this family.

I don=E2=80=99t have any issues using a newer kernel with the fix, but I th=
ought
it could be beneficial to others using this device.

> Also, we can not take patches only for older kernels, otherwise you
> would have a regression when upgrading to newer ones.

These changes can safely be applied to 6.18.y

Best regards,
--
            yashi

