Return-Path: <stable+bounces-179423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65DB55F92
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522691C23065
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 08:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4A92E8B9E;
	Sat, 13 Sep 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTjGpJlp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C626B95B
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757753635; cv=none; b=lXYN/fkQfl7cYspOy+ysIYVT9L0NEcK6JVEXbIcyxqDGwzVOKerF6yOHpY+g18YBxdiQYjoTVnfWbR9/Kzp7LdvmvW4QjCAVuMwZU6QP381eNQ5Z4SfZGVEj0WVvFWiHbQfKjPYPUq4BNYy/shBibq5w0nY1+F7vLJAeE4mf7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757753635; c=relaxed/simple;
	bh=hjX/8U9e+Qrmt58XABWZDNFleTWJFxO/SMBT8NBKylk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkMLCxf6u+6+G7KKkCtURN5QNJjv/vXD9EM506dcUtBQFKmEKjBQIt6WEJXxrhIjcDMWcxs8Uqmo0sb5zRf2ZObhM/lHREdqbZbx+jUg7A33JR4M0mn7t2H3Zz1nNfTA3fF4jCvoEvNzpR6Xw4ctwW7LeJjgK+mTRQ6uU9j7GVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTjGpJlp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0787fc3008so384141766b.3
        for <stable@vger.kernel.org>; Sat, 13 Sep 2025 01:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757753632; x=1758358432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRBsxly/heSok1/GwCP1v2e7VTjywigrOJtGbwcrN40=;
        b=jTjGpJlpC0Py7to7GOkrrewUBu15LIyzJ68Cy+vfi/yEzxI/Tt6eQzog15YCgl5IvU
         cYpojcytMuxRruU3ZrjSr3eRVeyn0i/TpOOk4+RodboCpuk6HI7pENJ9ZOl6o5CnMCQ0
         WbMyjVv6fD/sFQsLkZ3hxkYb495Uj14AUBf8U/aWTBzlJTrCk7oXAlQ4EF2kjNTa1lxq
         OY4iYYUPgCNAhyk+TaujDxjXhzGvRayWdX0ZOvnAH2HiT+UXeFFSyVjBPVL/59+1eanq
         Dib2Os/Z9wJc3pF3iVT0qj4nBmfZxeuMIZlbdmgFM0Uak31WeiYAr3eOJAcD9YqhKKGH
         UYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757753632; x=1758358432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRBsxly/heSok1/GwCP1v2e7VTjywigrOJtGbwcrN40=;
        b=P6AMw2tqfFU7sFFhD+DT4k3XHauRnrDrUUcX51ZXrWr8aqhP+n96z8WQ79wXiXtvR/
         CPJRbUUcpm+K6emXa3LJUw6Tmodl3TVQI9QuLKdRa4e+L5+MK0yOQ6j4Bg89kNsexY8r
         1s9RprJNwo0kqfUkHTt2STJ3HN1Zzm0adVhg6mbkjMlfDq8IVG2QG49g099CJNbdHKGx
         adDFROQ6H9KvhlT2By0QVn5L6bh6V3cZkQ4DjWWixBTWPig+q+xxUaq5/FxvxtPUSkNA
         K52Yi7jkJz4Q5BxH6sJW+w1oXzxrs2sNmXNTsWQ25lrUHqfAxOmLqn+NilAH6wRywOB6
         RFhA==
X-Forwarded-Encrypted: i=1; AJvYcCWChaaV8LEE1KvnQH9BvZbWttYovMkVUHP1ziRAJMbXVwjNW66yX5+C/Ti7+w1e3vWJoKDG/pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNhHhsMZUWa+SLMVVZ9VYm/duy72ZQirrKr3LMqzhGZg8Zl9fC
	yrym4iY8FRxN122zWqNsA9IjQk5MD2ddb+xsT0HfbM0jHrRLulociBbu
X-Gm-Gg: ASbGncvWYFkdLSNf+XQE/7P3/YSFBx5h0zojNBBee78XWW034czUIwHvNkPk31Zbq22
	hPvwbmyOjoZTJ0w/QV0tJM7YJ+/YeLEQ7oeAWvZ24k6a5xATyrToFDh/V1D0LhyoN9oiBZFn3Bb
	N4mmeu5w+tKuvSDMG3E7hIjKqNTc+r036LuswYeSMseLTgRFySjD8gZHy7L9FN21pAHIsxSLE1+
	OAjUlY5cQ08jwuCq/EABEDmQDHWfb1zTox7ehdJlEfQx5VDW16nRSN0lVFtjsDqoIPF6q4e7PGz
	gMLzvRWF8W1cQjZ8YNm71arDd+QBF6mYCZlQaKDrcxtGYzkEhuUk/aT2vCU36gXTHFtmo4vU8J6
	HXvx/81VUteJduAUNXtjZuNLcfC0UnghrzBu/MuEIkAKxlnBWePAVTcoleld0y/TD6dY=
X-Google-Smtp-Source: AGHT+IGRNH90vlh6pNSpSkah5E3lqgD6Qwr2bzQ2h7i2Vu2i65lG54BlgGQar3DeQCKypUkZNJ4X9A==
X-Received: by 2002:a17:907:9805:b0:b04:5385:e80 with SMTP id a640c23a62f3a-b07c3a98830mr539708866b.64.1757753631816;
        Sat, 13 Sep 2025 01:53:51 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d09e5414sm218564466b.18.2025.09.13.01.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 01:53:50 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E9A76BE2DE0; Sat, 13 Sep 2025 10:53:49 +0200 (CEST)
Date: Sat, 13 Sep 2025 10:53:49 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Staffan Melin <staffan.melin@oscillator.se>
Cc: zhangheng <zhangheng@kylinos.cn>, Jiri Kosina <jkosina@suse.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev, stable@vger.kernel.org,
	1114557@bugs.debian.org
Subject: Re: [regression] 1a8953f4f774 ("HID: Add IGNORE quirk for
 SMARTLINKTECHNOLOGY") causes issue with ID 4c4a:4155 Jieli Technology USB
 Composite Device
Message-ID: <aMUxHZF-7p7--1qS@eldamar.lan>
References: <aL2gYJaXoB6p_oyM@eldamar.lan>
 <c8f3d402-e0ec-4767-b925-d7764aec3d93@kylinos.cn>
 <e81e8d68cb33c7de7b0e353791e21e53@oscillator.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81e8d68cb33c7de7b0e353791e21e53@oscillator.se>

Hi Staffan,

chiming in hopefully it is of help.

On Fri, Sep 12, 2025 at 09:57:04PM +0200, Staffan Melin wrote:
> Thank you,
> 
> I tried to apply this patch to 6.12.39, the first problematic kernel, as
> well as 6.12.41, the first bad I tried, and on both I got an error message:
> 
> Applying: HID: quirks: Add device descriptor for 4c4a:4155
> error: patch failed: drivers/hid/hid-quirks.c:1068
> error: drivers/hid/hid-quirks.c: patch does not apply
> Patch failed at 0001 HID: quirks: Add device descriptor for 4c4a:4155
> 
> To which kernel version should I apply the patch?

As the deveopment goes from mainline then down to stable series, the
fix needs to be developed first for mainline. So the patch is targeted
there.

But please find attached an updated patch which hopefully should work
which resolved the context changes.

But ideally you can provide a Tested-by on zhangheng's mainline patch
to get things rolling as needed.

Regards,
Salvatore

