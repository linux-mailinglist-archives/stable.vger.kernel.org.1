Return-Path: <stable+bounces-83052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1099532D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C891F26BDE
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CDB1E0084;
	Tue,  8 Oct 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2Xnl/fi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46B1DEFCF
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400726; cv=none; b=Adx0JWT6Gr7GIwH2SYSJHEd6uSs4zzDSj1adGAioYpWrr7bzbKrV4Jfc+qr7snKjxf5WvM2++Af+2JpLGBJnStFz2Ec3HPKvGZBCorEl/JEZ+bgB9DGAXH3HU/xDiQVaeMLNcO0/gOwVYU0HlQDhDxaqbEn+mabA/4hTdruIBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400726; c=relaxed/simple;
	bh=BpcwFEIzPlx3XXF1AFjmp/nEahhq0W3xXSSc3zpzhVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxV73GHdjURNyXB0rrGxb73fRhZPLkEPKD9abtnOldVqspMfTbyj81aFlGyh2vV4RvCOBzRxtOnr4ByInAAs2Z4SOckGy/oST4hzYax4MZ9DdsSHq3y8JdB/NN9ptFlsrGS6ELyuetd6oHZYbJCWYttsLCS9gs6GvByrExOzKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2Xnl/fi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cbe8ec7dbso244705e9.1
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728400723; x=1729005523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpcwFEIzPlx3XXF1AFjmp/nEahhq0W3xXSSc3zpzhVE=;
        b=e2Xnl/fiiRQHYHjKm5GS6yUEskYFMQQHo6TmZsZGnKCP++qyu4X4v3B5sp4PVhtwoI
         qIJ8kU2XHBiW6yTr3GsqmO/9N6/qrrtnSDu1Ws6BZ6TDNSsm7lN/+FS2F+Cn7ESAG0x3
         LGXCggwmlqgs4rL5xALKKkhiBzM3SsMzFj7lRTn6jWnXlkzh+lsvO7E4W/DNiNIKKQvk
         +KI1Ns2dJ5LpcBTCZLS5+N7uK8mWbS+MU/9Azb5GL5/mal6bQ2ZKuhccvgDCVhQpR1iA
         3Goea/6t+0rTUz1OOc6V2/ra6I7+GV2Q27CIMOaJO047C9+43lDJcW+c/SNcFV8QieKP
         6Q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400723; x=1729005523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpcwFEIzPlx3XXF1AFjmp/nEahhq0W3xXSSc3zpzhVE=;
        b=OHRGwcCcItqP2oMOhBN3EA7GE3x15MigHt9rZN67HVwutWTKmdq52llkX3xfQXQL8W
         Q0KazN650xNNiEozgBisYb8+aXhpdxVKUs7G72qxCEzUHD5x1ZoAITvUn/ntDIJVdK0x
         zJdtDjoSWO2hyeihp7tdq1iNSLTgB6TkCJjNjMcxPnnNSa30XKDMc8zERrb/vI2wx038
         TzakmGM0eN/KOouw867yamtRkCoiZSbvo6Pb1DCwklbxrAqOlEuEA+wbt16fTREt+VY/
         EVKjMre/H+jgzYXG/IVSZraqHAu/9sITQTYYNoDJrAW/3ldubeRxUkJOCUtHBvES6kU0
         Nf0g==
X-Forwarded-Encrypted: i=1; AJvYcCVJn4Fv0xj5Ihr/fyI7jH9YHW5ryJ0Mbn9ikMWL0BZqvFTtq+NRh8kVPI0rOXKdRAvSJLZoTm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVqcLhHzSj0B3Q/suiD6AxUPiRVDGrZYuzd0UwDkpXTdkfS2p
	sB/VCxjBBqrbPRU1ivzlj+FtV1YrUYMIf9r6zOjYMcki6F1XT6IaYVjojL2znn7ThbFqxmqMuw3
	YDjl6+/Em+qZ8MprYpHR2uM28yDCv/yHdQSY7
X-Google-Smtp-Source: AGHT+IFl2HJmQLQPihSYgmIEqLrXDgSBjiY3CjR9+Q8LC6wqa3oeEE7Y5k2ZSKlmXR02y/8JyOXbsOZ7d7x39Pyhndc=
X-Received: by 2002:a05:600c:1e1f:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-4303b672650mr4285565e9.1.1728400722198; Tue, 08 Oct 2024
 08:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241004165105eucas1p1f21dfe36e7b1f0384126534dcbbd36c4@eucas1p1.samsung.com>
 <20241002224416.42F20C4CEC2@smtp.kernel.org> <c96e6f1b-3abf-454a-8236-360a845b25e9@samsung.com>
In-Reply-To: <c96e6f1b-3abf-454a-8236-360a845b25e9@samsung.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Oct 2024 17:18:04 +0200
Message-ID: <CAG48ez14RUJWc+iABHeTu1FAUPqH9bRTYAi+KqT2A=XFYYqL-Q@mail.gmail.com>
Subject: Re: + mm-mremap-prevent-racing-change-of-old-pmd-type.patch added to
 mm-hotfixes-unstable branch
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, 
	willy@infradead.org, stable@vger.kernel.org, hughd@google.com, 
	david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri, Oct 4, 2024 at 6:51=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> This patch landed in today's linux-next as commit 46c1b3279220
> ("mm/mremap: prevent racing change of old pmd type"). In my tests I
> found that it introduces a lockdep warning about possible circular
> locking dependency on ARM64 machines. Reverting $subject together with
> commits a2fbe16f45a8 ("mm: mremap: move_ptes() use
> pte_offset_map_rw_nolock()") and 46c1b3279220 ("mm/mremap: prevent
> racing change of old pmd type") on top of next-20241004 fixes this proble=
m.

Thanks for the report; that patch has now been removed, and a
different approach
(https://lore.kernel.org/all/20241007-move_normal_pmd-vs-collapse-fix-2-v1-=
1-5ead9631f2ea@google.com/)
will probably be used instead.

