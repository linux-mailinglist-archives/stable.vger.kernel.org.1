Return-Path: <stable+bounces-244731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMNsE++6/Wm4hwAAu9opvQ
	(envelope-from <stable+bounces-244731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:29:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C53C4F5073
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBAA23010DBE
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 10:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485BC3CCA11;
	Fri,  8 May 2026 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPnlh6Cn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A053C9EEE
	for <stable@vger.kernel.org>; Fri,  8 May 2026 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236117; cv=pass; b=NPcBaxl1hr8doCpyafPwxWZOiKkBRaCmVkhNu5AOdsZ9pG5T5ingl5yZDRmPC7K36EvPvyZcOGsrEn9xUvk2D6X/13GW1PCbs5DEpwOi0DOFRlOktWY7taJBS37vl5leGuMqr78qMcb8NI4TK0jovFExD3R5uv9wnW+wdhW6iIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236117; c=relaxed/simple;
	bh=7QeX/53HK9m2gOdXd40B7Bolr5AcCoEf5Z0poV83zKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXUXpSa1huIttLxPGLao2OtKosMMU6VbpdCnnIf3BmJWeQDgBD2yYA9sRf3ysQpE42JbEtiDuUZCiEUCnmu+/3qkEgAd24tDYN3tG/HPV+w4+eFzrMNZhWhks4QeNx7xXg2Hv3R/j1i4p+DQSN8gRW4M6H9Id24kmMp0tv5Z7Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPnlh6Cn; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bc16b9fcad2so19180266b.2
        for <stable@vger.kernel.org>; Fri, 08 May 2026 03:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778236114; cv=none;
        d=google.com; s=arc-20240605;
        b=W8GJJG88w5vbm1Nuw8v7zZ4tt87fv62+b0b0j5EIF6bQyBfEchUfgp2cavO+c+2N8Y
         Oj90+SCOW+KeaZq7caWw/i/eU1o68c8P1vY8V27OO16TrF3k3Hfbq88rfAFPsjAbVlBe
         iiDvozuSwz5rirdP7XY+HXvfUjVXXAhzQXeLoNWCbnVppyL3PG0hFyVsrYMxsbQNAf8C
         PUPPwZSx/kAfo5G/64IEvGlUSw6xFOpD10aaAZ1POxnVvFXnn0VfMFAPIm7rZoi48vav
         tgHtQYVhl8cDA91mC+2otV177P0cQix3xoWQxeiTFbXFSOPbRXwnC/KnUZYNU06GtExb
         nwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=12Y8fVLdKpzd82Q4v7OKrHFhNw6Yj/bHN3xdcs+5LaA=;
        fh=vWFsIbqo/f5VznxfraKStgdTZRrK1z+bKt1A0FXItoo=;
        b=Yk5KuBeVmsd9rpkKiTHJqvKMBSj5bXhbpiaZdUJpVEwx+uq1QJHDYYgltR0Amdx9Gk
         1KnDSvVqlMEXOF88TPJY7G1ZydMSJbUzK7YApQ2lwVKOTR6CFArEV+9o2XPJa/4nkEuz
         Lox5J1YLzii0/f+8FA9cWtNFyDMiORb0CS1mF6uAa8speki09I9gNeHctdS09moyHQEX
         AFQsEg6kDdsc6Sz24sWL93kf9d5XLxSujqRnhqi8K/ScrWfYsXuS+B4eEgV9kQ2x3vKK
         iM6P+uHFZnA+KX1O7U+vpsNQGiVt22OBnMWvm6DHOBZrphPOgX62EXA/MTIhXszynGlm
         KwOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778236114; x=1778840914; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=12Y8fVLdKpzd82Q4v7OKrHFhNw6Yj/bHN3xdcs+5LaA=;
        b=hPnlh6CnZ0F/xDxUMaz6bo1Vf+5C+g2N0dZOXfmRvzTfXIksr39ifo8xmZsMoBdpO9
         cTxg9Hz8NoU6apsxjI5DZTkznCtyXlAQETdTiQGlD2GFCtwUKryzwlXDr+OG3Gzdr++7
         rjAUCxSZ8QqfMBnhxM+G5kIPJVBeGoB0knXGIjkvIrGl5fPbVl6p8KK0D93mOUH/o9sS
         bTbE5941uxLp+9Gi6gSiZ8/NUZ1ibLYAFnaPTEYKvrYYPQVJekK3Uib/RfRfoAW0t8XM
         oQHVy1xccab5J1WgWEfEulw1sVxt7vwzKWBhGt5Ivyz9O3MKeeO6Wq4HzDRc2vSJOLFl
         GW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236114; x=1778840914;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12Y8fVLdKpzd82Q4v7OKrHFhNw6Yj/bHN3xdcs+5LaA=;
        b=P0Emx2NAM/xfwt2Mr6wl931DpZpSQn/aj5f1zk/1xdrEl7bt8cIkrxfVWKeg6OjHMz
         7SXPUxO1D655OEV5nLIw9QvqsofifWxpJ8leilhT8TwfD+1Ma+FY5OLkropqD5VnQFJb
         AeoEs97wBe0A9IxPxquQOh+u1PGMJct16Xll4J2fhaTQZuAMvQFbdoRkXZLypT6dTtQV
         lU+HIIQsKKqx3FG8Q1wL2KRwmCLT+zy7dXbmYDl3srIDxjIDfzrvWcwhwGGA1s2ox7D9
         3spdEo03e6UVS/ZKZZVt5iaIkZ+u1jvx8DRPFcCcfdy32gkQt6ahebPcCxNbWPwCd59n
         lABw==
X-Forwarded-Encrypted: i=1; AFNElJ8fThu69grj2muQMK7/5M2fDmz/s9cgkBdmVR+Fxlzx9uVC6y2bBV5v9+xqgFmQFD+Wvsi2KWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOSxvNBoLOjCQig14cECCoDnxrtkcrv5TZR7aa0Wh3dwPrsN7
	6KZUN1p7MHOrcox7g6kIplR5xM2VeAXNRDmhO0ZuTul77BmqJ141z7+2OykzIU9lwXJzMTXLVoG
	CHqfCoBtxk6DgHFvJfzT3U3nMvgxczWI=
X-Gm-Gg: Acq92OFceVchHWvDfCqmGh4IJ+XCE9jjbY1kh8qYRBNKT8Tr6XdI720ambsSrC/9d9n
	9h+WG7qfGPEqf3o0KvCip5cqT13MLnunnXH2Up+/AvJYqMHO88o36KYpbFO/WTftl2Sv1ymNp7e
	AmZulHaKs7i8b2AVLZ4+BA9tbHZi54exXs7s8q+2XQHvbzXTS+gi8ERWlBmkvjxlrsARyULP5JC
	q/qEXJTFb3WSZCl2eSN2jaEYJnUaFWsb7mWzR4MRwgTFLLAOHOkCnhmimMoYMUCQKf3Dhzd4sSH
	Ci42yqw=
X-Received: by 2002:a17:907:7243:b0:ba7:faac:103f with SMTP id
 a640c23a62f3a-bc56d80c35amr275931366b.7.1778236113866; Fri, 08 May 2026
 03:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <afo6uBv68GDevbMD@decadent.org.uk>
In-Reply-To: <afo6uBv68GDevbMD@decadent.org.uk>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 8 May 2026 11:27:56 +0100
X-Gm-Features: AVHnY4L2r8PM1XIh91EhsG31cYS_1LA59F1sRo6vRnUsDnkBNsUbLSouaUcXT4s
Message-ID: <CADVatmM8DECzSBq4pCUUrLksa0YEBck9xDmKVYZw4cagv26GCQ@mail.gmail.com>
Subject: Re: [PATCH] parport: Fix race between port and client registration
To: Ben Hutchings <benh@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: 1130365@bugs.debian.org, Paul Menzel <pmenzel@molgen.mpg.de>, stable@vger.kernel.org, 
	linux-parport@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9C53C4F5073
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-244731-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sudipmmukherjee@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 5 May 2026 at 19:45, Ben Hutchings <benh@debian.org> wrote:
>
> The parport subsystem registers port devices before they are fully
> initialised, resulting in a race condition where client drivers such
> as lp can attach to ports that are not completely initialised or even
> being torn down.

Thanks Ben.

>
> When the port and client drivers are built as modules and loaded
> around the same time during boot, this occasionally results in a
> crash.  I was able to make this happen reliably in a VM with a
> PC-style parallel port by patching parport_pc to fail probing:

<snip>

>
> Fixes: 6fa45a226897 ("parport: add device-model to parport subsystem")
> Closes: https://bugs.debian.org/1130365
> Closes: https://lore.kernel.org/all/6ba903ad-9897-42bb-8c2d-337385cc3746@molgen.mpg.de/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ben Hutchings <benh@debian.org>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip

