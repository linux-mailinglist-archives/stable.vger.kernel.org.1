Return-Path: <stable+bounces-214443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGQmJSSAhGl/3AMAu9opvQ
	(envelope-from <stable+bounces-214443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 12:33:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0416EF1EA6
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 12:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727A6300D977
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C73AA1AB;
	Thu,  5 Feb 2026 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1R8NPXJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECB3659E4
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291166; cv=pass; b=G+QG6blbBYRJHjyQeYVNQYL1JDodFS9mfW2oeYMbheg00kN04rdiAXH0uolQSDC5M1qYlfFxBvFoZbTC5jUQ86HlbeGLPmLkLAU/qyddwa6zG0DbWoYlFxS/Yr5P4+a65zkFZU1srIB9RgGozt4v+Mf5DC5po9U5xoypblvn4Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291166; c=relaxed/simple;
	bh=HUFONjuQLtbcVub/kPg3eEuVXzFRYkS/YmMcr8CvBmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cnl2HK+cSCr7M7nmwnKKWcDPhdkoQXaNJbjbKeAs2zMhQeAEyW63wr3VxILauzPzBiMIzqhcNeF4qD8BzEY34KgSyh9deVgytVMCA6VWQmbuCfknSaipHTwyY2beUIEsZazWRRWBFSbVBD6mBnlUJn2W03BzceWjOd27L5G5FSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1R8NPXJ; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso127908766b.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 03:32:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770291165; cv=none;
        d=google.com; s=arc-20240605;
        b=PA74Os/E5F9AnfKCwsHxCL3Z8EcriAQyXctzSg5fy19Eakmm3WxKl8brqpw5Wr+/4o
         OgtKGYzv5J5hJGGuMvfabbtfqUBdWMC+nNCQLceH/0nti5gYVLyf5PIQgEA+/dnwer7z
         2QZ1E+isxbDL1MQLMpexoZkyihvBJeZxJmTPJ+Lufn7Rcru1YSSXU+SVIXClbI75l5Ma
         Yt6VcxC7s0LdD2zsXthqJta0IBS3Q6z9NYnPfp9npR5ePQySyaWWIzmgYfrcA+SO5Ykb
         KhjWr0jrIkgGfG0xL6jFKMvc6T5rxg2tXDdpQvi+7ZXqvg1dmm3z7H7/vZ3qNxq5xszl
         iDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HUFONjuQLtbcVub/kPg3eEuVXzFRYkS/YmMcr8CvBmw=;
        fh=xeIZHBfxxJDariAGwE9zoSKCsxY/OeBrRiEPwBI+f2E=;
        b=gvyEYStnVfrPRme1Gmj13KEHsICujZvHKQtajd9ygtIMHKkZJonqHGIBAbmFPILTES
         IEGWMzytdxqZhEn0yH5DHfa6RMJY0NWmqOr2JYRlPVKU/aB7PBebTSGzlS/aSl4g2XTy
         Aao5mXYuRWX4F9H3Wj5G2qQB43dVYA0oNU78sMIWaATUTxTHcGLsGMlzGARGYjNMpY3K
         bIGhbzZTa9gcWpODuumpYKB0+iiXK48BEKDP8INbTCJvRlexHhkRQZuABwUxr8hEN5vN
         0hT5jmb812Q5NuSuTFebW6CoCBEV+bJ9nBgRXnJbVkEXch0wBnlksaSsOMf9pKyNFDLb
         wG4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770291165; x=1770895965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUFONjuQLtbcVub/kPg3eEuVXzFRYkS/YmMcr8CvBmw=;
        b=g1R8NPXJmqlbh0s6QNCVaexLZnsZreCXZAPFsB6BNxojxrfe9fBHAfchjFwIEzvGZt
         nYc0z4aAa29qE9fbGN+GaP+WSuo6Dn+xsSNbofoOYLGPzIpbTscCPZVvYWcwelVnYBdE
         ERlf9SUv3+M0tr49ppwJ5X73VjQEuCCFQxjLhHMbWCwYJJT/3nWEy7G5bR7836ORTDWW
         umizugVxCg4JrUAm1p5BsmymiuGj2VOvaKB/4Ds2xD5ByjANV7/GjTFIRGFi8fIUrTsL
         EoKLdYMlqGj1YwBC0BmAdL3TmFce5YBp2DIZyysu5JOpD0m378Ndbd1Tb4ieugCyoyC/
         5Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770291165; x=1770895965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HUFONjuQLtbcVub/kPg3eEuVXzFRYkS/YmMcr8CvBmw=;
        b=AiO/ZoZ0gMXS8D8FcVL977N/Bx7A7r3CVDYf2QEnr3t0jgwY0IrWKa+Mf2Nhwd46DS
         2h5Iozx813/MP9lIpt3A8D1qR+YQtf+jT69qYKx4YCKQ9FDItc/YtFmwywsKAFfbcRpf
         OCcQxvhoDLEH+nJ1kk/AxuBZBOHM9uQbOrSztR4xJw37XPab3ubOfeL1NdPCpGEyR2xI
         McXOoI/v2tmWPXUCynGBhqqenpB0+I3Ipwhwzn0je4/uX0wgG5KsuJ6jCakqWdy/kjAp
         M8r0r5UUMcPQAIGzFoCWMEHhYgGrqtdcovPODMNBvN1BBPeh/o1hoTF1sEPA6LF7pvvO
         xWgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU51/Cz/SnlGGPgU7BPoV4qMcj529frZ0EHl/DRsgWlbyM9mHmcvKDtYho4d1JIZ7wUr3rYQbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxolayUfnKmsHNyMlVI/TRQmiAQzununk+TE1VyMWaTK4yZ/tno
	kN6lQ2We+drPhoFMsTIvPrK1RK6h5tHSh/W2Lf8O0dG8giRif61B6b73aCdr0s7Ft8V2PgttIki
	+3ctkhCN1neT3rgoYaSkr6/VviWfHDwU=
X-Gm-Gg: AZuq6aLPZuQPuJwnHj9EvexvIf4SK5LruZM6oxDTG63WZa1XIHt3xLhzOjIIjHaIlg9
	xWFf/Td7aF2NtTV5biC+4pkaYJJ6cIbWxsA8i5PNmSAGIHBNVDngrac0WX0AF63qINbtTgd+aEM
	qP697qNJ9E/lL6gevRGOg2evq4kEMT+MTKVt1FsyK4ElX/kOHaXXsZyfv3GasvMN/m/5505RSlf
	NBVi0dqWQ4A/xvhvlKgFAYYh0HRK/qDZO8uc9Y6FXKJlFFtK35sbUahcWtGUvJaNy4ZrsdUWjeR
	yWha8kWLrZtQ9s2QEIR2c9HGMGmeZk1taw/yFxH7UpbLjScOuT432zVB2E/owjLAwBZtmzY=
X-Received: by 2002:a17:907:84b:b0:b88:448c:be01 with SMTP id
 a640c23a62f3a-b8e9f0a8c35mr390932366b.18.1770291164318; Thu, 05 Feb 2026
 03:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-inv-icm45600-fix-int1-drive-bit-v1-1-72a78cd07150@tdk.com>
In-Reply-To: <20260205-inv-icm45600-fix-int1-drive-bit-v1-1-72a78cd07150@tdk.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Feb 2026 13:32:08 +0200
X-Gm-Features: AZwV_QiXOqOOjplTg2gMyP4sKVgxsZvWFdsBXBYnOUNPtfQwvHW7PXHB16Yg_2M
Message-ID: <CAHp75VdmVP45+3r6HoC-Gf7FfXMJdmfTV739LLDAtdX_f_xu7Q@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_icm45600: fix INT1 drive bit inverted
To: jean-baptiste.maneyrol@tdk.com
Cc: Remi Buisson <remi.buisson@tdk.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214443-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0416EF1EA6
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 11:55=E2=80=AFAM Jean-Baptiste Maneyrol via B4 Relay
<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:
>
> Drive bit must be set for open-drain mode and be cleared for push-pull
> mode.

Any pointers to the datasheet? (to the particular section / table that
explains this bit)

...

Assuming it's correct, with added reference to the datasheet
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

