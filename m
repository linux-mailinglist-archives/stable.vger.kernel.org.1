Return-Path: <stable+bounces-200726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D8CB2FF9
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 14:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 330DB3050B80
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5C12F0670;
	Wed, 10 Dec 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="Acm/fkwG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E81F3BA4
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372726; cv=none; b=GAZYB6XEGS5OvnZjpFbKpAd5a7j+MyF4F6rDMnycwG2komc7J6RslgvDyy3CxqTioVrHLKvX5agdss+oTVTzdELq2tGd8q3RSmfhUKO4/oY9O7JGOuMZorWh0p07lnzG34ZxDZNWFgLSWR2Kmsl/n6hRQMNEnujPMWo23nQWC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372726; c=relaxed/simple;
	bh=OaZ2MRStedNYhARK5ORn3uHEPYJ68aLZv6sH2R2dr0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8MGD+oVy9q3uY44gjobM7pvXSKxAzhe2xew5nthS2gaDrCvdiLXf1S+zb6EM4DmiU5GIDbbx0ltdz1WlUJcy515v96inH0TI4wcaDXz4pzljZMNRcz8RFYBTCylGCjPMcc8pUxtzqpYIcEMepOFlu0vNUxEUz1BSUIhbukT238=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=Acm/fkwG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79d0a0537bso888808966b.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 05:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1765372723; x=1765977523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IUKRQZN8is04ZjTspSWXLsy53w+dt0YEDy823e8wJuw=;
        b=Acm/fkwGAxCYpa1bn/TBePDP5Kb9sZDOSwIf7zPyFguUxCSoc2bbiw1+L2nNzr6WXF
         0u6ea5+qeY5P6oxN+RF5j2Noty+mR1/CDMbANqW0bFe0k8baQZ4qz0mJ0oM6hxa1mBq/
         hnCRvOwwDuI8fjKLovEfO93y9Cw61y+NjqUXwD4NtwdeDSh0ML4ytAA4hd4cT4vLDxJU
         quocC7UiDbXei23KKWKmmq3UEAX23p4fLCvIdVLsEO9dyJWWfZUNHQX/TfwrBhpCqeiN
         3h6FHcZrY5pyHAwKBRScY3GOMVCo0EKFH5x3XI4bIhDmPlPdad4QwzPDkKOx7l37dGad
         T/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765372723; x=1765977523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUKRQZN8is04ZjTspSWXLsy53w+dt0YEDy823e8wJuw=;
        b=lg6l/kWB526QLtEgWRcvXX8KSimpJlm62Ak2tKu/KTM4LuwSk70hJCTR8v9N3ETCtx
         9BfQHA3AgNUv6pY2f9JZf8qI5JK94cKKLfWiXTzLD2VbMEqAAh341L2UyNtrTqUYDkVN
         boShcVovTbZ2ghzQMxoGewg083N1896lMT4AoTny4sjqDCDQrHwnAe8FjQR3GWcxwpfy
         sEEMMuKzF4IamH/d8FlJPwtPqHyViT/sbGlryPPdhoc74GeTI84IFxmGhgxX/COA0f0j
         /s0ak2WeaqIUpodP+RiVxfy85SfME8f1IH8gEOKY8+L7Qzikh7ErCCTcUJ12DtL//T6d
         OuGA==
X-Gm-Message-State: AOJu0YwZeYTTimMWLSumN3eE4u+Lt3QOtNW1EX4Baym67s4OLo9LMJ4O
	TH9woOJL+KBiWMqehgh/hTk+73RTCpNCGWFOWq7TrYrd/fFa5gHnqs2CwiWr7RqFhOFsQh9OcAd
	iA65+SzCLfAblq7m0pgROZALGGwEvejsG26gAoWzyuw==
X-Gm-Gg: ASbGncsIwcv1GvY5nr4aUk9hOqrpKlwSY209RUzijQDWWd5J4IVNbrN9a5MNyt9bItO
	B9Nl9Wj+L39HTcKbv2UWdSr5xBmweKN4KM4W2aTjsL8kpJmkqYLUotMLhJemWZhv45UInPskBLw
	v3rj7lxJntW+SytSGXDJ87M7h1tq1z/n8RZAGH5wZbNWmBrh0pALi4eidNYZ690mv4baW5pC93L
	lyBrFGJKOvx1sS2tljzWhDWdp6U2g39rB5U2Ufd619UsETzj27FBhla5SizcU/hAOad+oM=
X-Google-Smtp-Source: AGHT+IFQis+sgENnCf9q/e8gy/hdLlOHnnAxvt0D9dfQRrKQbvkyA5aeTcioxx2rqHLHnWKlNEiha2FUNAAjbbi84y4=
X-Received: by 2002:a17:907:868b:b0:b77:1a42:d5c0 with SMTP id
 a640c23a62f3a-b7ce844cb6amr254069666b.43.1765372723378; Wed, 10 Dec 2025
 05:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072944.363788552@linuxfoundation.org>
In-Reply-To: <20251210072944.363788552@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 10 Dec 2025 18:48:05 +0530
X-Gm-Features: AQt7F2oCV2mK6R8SnN-AbSkkF8a2RzvZ5DPZEpb9rsNRB5GyoM2Beu1eu4X_NHA
Message-ID: <CAG=yYw=14sxEdq7Vvkjr=8vr9NYiG5jPYXw5sXcqC_6dS95W8A@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/29] 6.18.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 compiled and booted  6.18.1-rc1+
Version: AMD A4-4000 APU with Radeon(tm) HD Graphics
NO typical dmesg regressions

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

