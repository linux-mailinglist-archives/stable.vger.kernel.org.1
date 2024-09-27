Return-Path: <stable+bounces-77872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B0F987F42
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 09:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8FD281744
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7517D373;
	Fri, 27 Sep 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yYFwDvC/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7D165EED
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421605; cv=none; b=bjIHyxzBCmuoxCZx9L8lTLd+WQlShJz8A43q9/dmc2L8w8rYA11a5OA7JHtVGW5DNkWWJubS94KZI4ZURgKtNjkY7XeTpFuN+REAIL5gKQaaJwCw9scoa/lQZXZdDc1uNJLph0n6LEByIkbthnYVwxJB6CVN+qUEy+ImP7d67HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421605; c=relaxed/simple;
	bh=UUer5AsU0EapduGbbVyKKaf43fdmVgfcN66T6aF1Q4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z05n2kMPfK1SrT+1rVxMbpHm8Vgo2PwbroqL0UaT3+3Y3ZlUwT6PtWMxEDW1uIKoFLISFa9hVCCKb55VE+CWurxlQqa0izy0KPkVG6GgqaCfQob00liWEHEsNkvoO4alhxZROsK/CVw3ldzsBvH8wJsnfPgsitkUKgIba+Vj8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yYFwDvC/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ccd81de57so1195440f8f.0
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727421602; x=1728026402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUer5AsU0EapduGbbVyKKaf43fdmVgfcN66T6aF1Q4M=;
        b=yYFwDvC/zymG0ut07yu3u9MELIZW3rRFgusdg3uljrqmEFr6YT2AkXQWLUUv9LUvqn
         Neh0J07+pTWaehz7fYIvZ2A2yYxXCT7ZdAFvIM5Gp0gflcQnvUySQbeFCMJLr91ZaAxb
         Vhr14odb+2uYLGkIDZ852Saws+/CS053zogjoIjzq7AOVmvcVqey5irFJEtmHc6X1zx/
         kXbUrXUI+Yk9nMxoCqw1TEhPYSGx7dNhCc0gX5jAJ2RfREIg/T9BRoePQqJA7rrvFEJP
         tHeNzww7R13ucyPIgX3ksd2Zkfx9ljldAN52C+uFBIHtdWPPituirqGIt1QBNb/Gj6EJ
         mN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727421602; x=1728026402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUer5AsU0EapduGbbVyKKaf43fdmVgfcN66T6aF1Q4M=;
        b=WdDM+XMJIkbjpDj8OGHXZ8qzJ3x+C4rOJmOhmiXLK2rbozmvbhqF2tBEqnGUxqMpv2
         wqB8hcCpasFkr88QRWf3BoZQEGKsSvTV8EZYM2d9N7QKBKVBEHUP8W+/WlNLW24oRz5L
         R7+vbZEw+EUXSS0hYzZSpFC04PV1G22OjR/BL9bp/IB7W3QRwfLyaAQBTfL79v78ImS+
         xbNIO9Jq5xUSoFQZBq+HY8Az4K4+5L2yxhoU0OBnzh+htQOhpFcNT+zVBYbHW7zMvtz4
         sUAnkEEJEGpg7sc7DnAo+U/cd9DGId6+Jgg8Z4VvkTwBt1C3zIePzoESLBURTN5O3/eQ
         QfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU8V7dAwfYCFVKcl8ShUHp5mkPtXmUhfXMNv4R0Dcl157MTlToUtk7xkBlNkoJS0e/f0sg56M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5vbAyHAa1ZCnVQxmNBX99edm2egnj2rN+VU66FD/gD2yXaG7
	0SuCIOnVCvRtiHF5CRaYBkt9ijyW9+aGuL2GuBc92aV7hJPiSk/C8UydwqmNcws8tlvyV3w8LpC
	91N0sgPrvd4WAeYhwnAlbE/36m8yuruA/yB4M
X-Google-Smtp-Source: AGHT+IFDjmGSn5W7hvNBqPXKxR5dvdDqGDDzbiagFCPcdJ+stGo59h9JFQ1gTQgOukiRs4WwBDXmp/Tlduf4VHIEEDg=
X-Received: by 2002:a5d:4e07:0:b0:374:bb1a:eebb with SMTP id
 ffacd0b85a97d-37cd56dfb91mr1412551f8f.25.1727421602051; Fri, 27 Sep 2024
 00:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-9-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-9-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 09:19:50 +0200
Message-ID: <CAH5fLgg=yYNFzsM=Jj5ALtKgaza+rXord-yg08_nDM15T15w0Q@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] binder: add delivered_freeze to debugfs output
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:37=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> Add the pending proc->delivered_freeze work to the debugfs output. This
> information was omitted in the original implementation of the freeze
> notification and can be valuable for debugging issues.
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

