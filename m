Return-Path: <stable+bounces-132212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E6A85672
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 10:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1A01756B4
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61428293B6D;
	Fri, 11 Apr 2025 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMhr8FOj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D970290BBB;
	Fri, 11 Apr 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744359912; cv=none; b=eu9mkcwrIfs0YWqdd00S3DLI5GBI6J9/cjV2R46HovlzWNG2fxNTElvFYavD35EBnEF5nJs6+FtjtitqpNK5P/qYd0EERxCE/GFXfBIK/m7SXLBnvINb48v5OdF0e2+jXNlKhxnsFW3uzraJlcZWbxp6+r8dyDh6QRkSZd4PSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744359912; c=relaxed/simple;
	bh=CavpjmKXQjmZtDHhC3IR+5g5o+wulEUd5EPF7mBYPFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DadiM5l6W+aFSUyZmDcwOVKqqk1TMX9Wp9eocxJEJMvJSW0OBDZlItAAQJt4pxrvaOhwk5KJLqmhP1HLLYRg13qgrhPVJlRN+WZ4cOSmxv0cWgaoJq8vBJEv42uPlD8wFdd/mUZ8PpzxrjklaOeRELZbTTQJNqYoxhwklX2MAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMhr8FOj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso11739135e9.1;
        Fri, 11 Apr 2025 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744359908; x=1744964708; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CavpjmKXQjmZtDHhC3IR+5g5o+wulEUd5EPF7mBYPFo=;
        b=PMhr8FOjJoy83aEgkrZwhBLVCh0yoejTR53z1lXoLd465DqAoAUrBIXJuGevIDDcVm
         OOjb3RkNnapXHELSG/VpKZgyL3YBVRlPW2TM2srodr5zxHdW1oxlPPrk37ZAk7OYw79M
         7pEys1+CqFFBwRv3jIVBtu73hWVUyz/tPr7lIvJhgsZqNev8w6SXfkl9iil+psoGMmq6
         tbt2qrgroNVZsadIn1bCdNRmlnr1nz0m5SMfJUMx3XTdKcQQLJs491a7fKBmCMU3H+vc
         JUP/MlRaG4lrmuI5ixPnVE845ZaZp7iEXzmqcTeCyKr9ug97FNBRrKQWzk5uSU/bE3S4
         WQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744359908; x=1744964708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CavpjmKXQjmZtDHhC3IR+5g5o+wulEUd5EPF7mBYPFo=;
        b=EveGIttKHoz/9ZhACxB3cpRSQTV+nE/A1TbvIHY0nvgYA4LhmGAME5fuxUDKFRErWo
         RsMWqWb1Gtj68lZN1Qidzg9GUnuT0s/Wx2niO2e126CPUilhluwv40J5Sy+SLlWH2q2Q
         LYfjn7wReVCPc1WnjhDh4pwMK3f6h0UYKX6PMm/BCYsdS+L204ZtMo4Nl/QyuMHA/fxz
         cPqxCi0hAsEeROk7k3iDHLtIjSV7EAe+T1D/2Ybh0brBXsL2GzdXizNG3Wmj0+lQbaaB
         eKHNhl3nN61lKlNCSv4cmRtjQi3+avToBNVwGifgSQflOPPGGzh4wSyf8aP1Tzzr57sa
         y5fg==
X-Forwarded-Encrypted: i=1; AJvYcCVoF2f/g89G4ZFOQy7R9PWfc+AmyjQ24G9yovWqey+PVYxVlqyadxivVDBnQ2UwJXdklEmZ+PJJ8ayP+18=@vger.kernel.org, AJvYcCWSvNfwm+qcGrJRgO1hXj8zaXJeS+56JwinHwSYdcbLTi95S0tsE3z3a4os+7ndedzg1d/eXxkr@vger.kernel.org, AJvYcCXLHfpq0VY3s+viJD4JhJqLwLILZEfCjYiQAkikqvtEEf0RAMPuoLsYIDAf342JbDl2W9X7zDHrVOIbMnqj@vger.kernel.org
X-Gm-Message-State: AOJu0YwgccTng27p+hnb/ONrAVmA7tkcBRJcIP7Q4BqWpA6Jd/F4p9YG
	0gAPKY4B/I7Sl9L3a5II3Oxbor9EnYjklp34XaVcn6iOXYcPpS2Ng71kkMDl
X-Gm-Gg: ASbGncuRymzp6GDz40hCQq9Brc8hS0QbWD5/NzgthX2BlSXp08QM4Qf6P6XcNTK+WTM
	X0fTPXTt9jNvkfF/Gn7iXlvwtMheQSjCuOmX4VBYjCFY7hlaSdG8/UgBxl7ezQGSgNAyJEIE4Q9
	Q9NOEe7frdxUHr/7LUyY18/P6qkmRjJohobWB1x4am8Is+inO5tvViocUW9hj9sa5vGbw3MGkRp
	HI2Z3znyGOF/qemQwHHMt5dkyxcXe1ECh9HOWj7g73SAiBgSXGb+ZCEzIzhg/VS0bX2gqeCaoy/
	eRhpVYvv9aLAvPeIa3VYiaqer1BjEqVbLRqUqa6tYyJRvYaK3jx62r0BeJGgI1WB3ev5zPIZTB/
	sPw==
X-Google-Smtp-Source: AGHT+IHFtJlY4GIg3ATZj4XulRODy9ZQg/KCy9yu2qXDH9d6bFXyyZafdslcVYLkZONjYARX+zSyEw==
X-Received: by 2002:a05:600c:4f45:b0:43c:eea9:f45d with SMTP id 5b1f17b1804b1-43f3a95a248mr10834225e9.18.1744359907518;
        Fri, 11 Apr 2025 01:25:07 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43f233c8224sm74776565e9.22.2025.04.11.01.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 01:25:07 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:25:05 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jared Finder <jared@finder.org>,
	Jann Horn <jannh@google.com>,
	Hanno =?iso-8859-1?Q?B=F6ck?= <hanno@hboeck.de>,
	Kees Cook <kees@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] tty: Require CAP_SYS_ADMIN for all usages of
 TIOCL_SELMOUSEREPORT
Message-ID: <20250411.6070ec138c6c@gnoack.org>
References: <20250411070144.3959-2-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250411070144.3959-2-gnoack3000@gmail.com>

Hello Greg, Jared and others!

On Fri, Apr 11, 2025 at 09:01:45AM +0200, Günther Noack wrote:
> This requirement was overeagerly loosened in commit 2f83e38a095f
> ("tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN"),
> ...

For context, the links to the previous mail thread, where this patch
was a bit too "hidden" in a sub-thread:

Original patch:
https://lore.kernel.org/all/20250223205449.7432-2-gnoack3000@gmail.com/

Brief additional summary for why I consider this safe:
https://lore.kernel.org/all/20250307.9339126c0c96@gnoack.org

Thank you!
–Günther

