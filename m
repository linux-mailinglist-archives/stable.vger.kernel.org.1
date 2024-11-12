Return-Path: <stable+bounces-92814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FECF9C5D78
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB19C1F21977
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B4B206944;
	Tue, 12 Nov 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUr53ITm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217120651E;
	Tue, 12 Nov 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429492; cv=none; b=PEq2+rH/pdGEUHtK9meAyP1e+akZ7RdBLuGOBokO/TaHUvv+iDAIGnipRdyb9nlN09jr1qAtqTm8bmtdtmUK6M/gk1g05kqOV9w++iUx7NSGKnbRzdBWBnw3OD0Wdq32qGy5CW2Mjse5OhB8k6zLJvt49cuqJxIyJTJjOwoSK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429492; c=relaxed/simple;
	bh=KUhNk2z9MDkRfzqWZ5qmFgqq+TTg1/DVZofrq9PuuqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuBjgWPiQ7P0ZlzWYdMwF61wRjbe+vao952E7npqcpHHSlAjGJzC/ilj+LaIDeF5FGEw+LwkCeHY8jRdQW6gboBAmXeifqgiPaFclJg1EbKWjyZUXMiD+9dopA//Zdcb/YmNOdX8iLSXcsQWFwNrz3/n28ZbzDdrrBozBvcuaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUr53ITm; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a9ed49edd41so1015271166b.0;
        Tue, 12 Nov 2024 08:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731429489; x=1732034289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KUhNk2z9MDkRfzqWZ5qmFgqq+TTg1/DVZofrq9PuuqU=;
        b=dUr53ITmK5MTR6KMKoD21/ogM4j3Ict1J/5BLsPN3SqP4crKh+J5zC34dg/MZprDA2
         KRo8lDQSUcV1lTJppfWHLKd2mBKakokXgek1sPxOfrluup6rSAOfK5jiHCGQWdc56sN8
         gFK1hw6rubpVgRoHcCfM2xXEdE+UZgKvHpdz2wOyZCj3yX1S7ohLVrxkDNFOaHY3nFKi
         9JF2aGTEu60WOsGirUvc2W08hyRVyCUlQZZ1w2X7KeCcC1IGSLO1C4xjFptg6SleiSYw
         sV3UF6pfwVskV2Rjq8VbyAo2jcSHij83W7e1sYuHgCBGzAlaPyOMgRJQOV3+fXL9XKe5
         kFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731429489; x=1732034289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUhNk2z9MDkRfzqWZ5qmFgqq+TTg1/DVZofrq9PuuqU=;
        b=IBMYLisR9zNjUB+4vM/GWK6uxJhS3RClco8FnuprTGtNdByVwg1VrnaKBJs1ohTUku
         X8LT+m0eNQaCYdsb+L0x6p/TDu/nvDj1w1dVeMu9VJfroxa1UpxSaPxEjKice5pRIM1Y
         JgZxgZGsr3KWLJTbwFrSOgHkS6/FimmvwJBPE5FIg9Kf3WngKBmFVk8e3EuSheC5Twea
         98c5rHgCSEHEMFFYVJgVkOn2UAyO8tD3DdekBYGTO8PX/DwSL3oNjcaVGnBvJjWzc5jl
         LxH3RDO0uxnL/AWI8GklOHEvinkb/hcSun9x++eNzVhqDxSSt/XCJn6HERpUL3aVspAo
         Fx7w==
X-Forwarded-Encrypted: i=1; AJvYcCXGZ+BD6kJ+kDaCkmUuKp0FVHlsS+E4hBMAAIKU2xMiGFgzRzozNgQfkiSXERK08swja/HNJvGg@vger.kernel.org, AJvYcCXXPyPzx+746Axtk/WU3Wpi5C4DvBSxoGMcwJyU1SbEDk8Mp4hCJG48OQOyHbUgumle5HLyKItfNRyOcW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyooMWPTBD2PQGmuh//eGIlCNxHGkHssx6F/DxPX/DCMRvWi6HO
	whZOBC/8cUSsu3sdNo+LWURZAV/jWz7NQhUdNhdD6m7ZGM9wrBY9+aa3QAfnQUqAjpzJfPVEL48
	WGppigtDuCfiVHWGhxN5lHydKwt8=
X-Google-Smtp-Source: AGHT+IGbNgg3vPZwBtH2bYSkjboNf0KX35TdzEpbztlVIlIcHPgEXMYbOAhhZurjqxNtiFg2VefOBdmGUge2VCCob8s=
X-Received: by 2002:a17:907:3f97:b0:a99:d3f4:ff3b with SMTP id
 a640c23a62f3a-a9eeff4101emr1489398266b.27.1731429488749; Tue, 12 Nov 2024
 08:38:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018081636.1379390-1-chenqiuji666@gmail.com> <BL1PR12MB53333B4078E3C1C1AEC49AD99D582@BL1PR12MB5333.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB53333B4078E3C1C1AEC49AD99D582@BL1PR12MB5333.namprd12.prod.outlook.com>
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Wed, 13 Nov 2024 00:37:57 +0800
Message-ID: <CANgpojV8U4UenoKc8kT8LGUnWmyu5yYMo_2fzY4C9R+EdMj_jg@mail.gmail.com>
Subject: Re: [PATCH] cdx: Fix atomicity violation in cdx_bus_match() and cdx_probe()
To: "Agarwal, Nikhil" <nikhil.agarwal@amd.com>
Cc: "Gupta, Nipun" <Nipun.Gupta@amd.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"baijiaju1990@gmail.com" <baijiaju1990@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

We have addressed the concurrency issue in the match driver interface
at a higher level, as detailed in the
[https://lore.kernel.org/all/20241112163041.40083-1-chenqiuji666@gmail.com/].
Due to the widespread nature of the issue, it is more appropriate to
resolve it by adding a lock at the higher level.

Therefore, in v2, we have removed the changes to the cdx_bus_match()
function, as the higher-level fix conflicts with those changes.

Kindly refrain from merging the v1 of this patch. Thank you.

Regards,
Qiu-ji Chen

