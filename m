Return-Path: <stable+bounces-210245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBD0D399FF
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 22:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2857330072BC
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 21:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9533033DD;
	Sun, 18 Jan 2026 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1FyXtrq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11412749ED
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768772039; cv=pass; b=jaKHlOAg0VeLtggWtYTicAG6nmHnnNA7b4on+U4MgwOjudpHb+2qRo8ueHraJb7Oteqy7V3JSB/AgnMb5Y2/O2N0CRVO85w/IqMcmwk+LCP8jpB3kW6ZHLkzH4UW7Iw7M2tX9jEw2zKsQNo/XRSWGBAunCMQ3qzwsrZw2aLkREY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768772039; c=relaxed/simple;
	bh=dR5FMFlo246DjiayIr8NlGLupK4szceHEikbN1Luc1Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZyC7oUjnoYNJid2dHBt+9qcHctFshUFIrL0zbSAY+mUubwfXBfQB785c1o0oSlV35Y8w3N6TJzkoDF167Hx0XWcFE4IBJz6G5NHyuTHzlKK42wl1j9uCloKvmPY8DG2w8fhPmC1465Qm2bbxhbWDHWEd6g8wMspkkyJ8c9wBOB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1FyXtrq; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8712507269so518372266b.3
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 13:33:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768772036; cv=none;
        d=google.com; s=arc-20240605;
        b=TyhaTFtviMBLoGhl3pWcVCBuIE3qz7N59wsvnEZtaPE501PhfDfgPvArw4E9B73MM6
         DSf99rtIqscpe5fHjb1O+0Ts6nRQujHVVzXNaZXkdtzhjzJ3DpfwIXzCOnp6NT9yAaAt
         k4DtG4eCrFIPAln5HRpCFctRk5wojIDypLxN0khwU7aT5R+mFrh0FM4Q3zRlZ5uSMqgK
         X4u7opyiiVyx2KqiU+Z32E/vkkEhrTZPgPVK0GZ/hlzoIZ4I/QAkpG/VnEfPlym/ONcY
         Vje5pmcnAdjdBjZ21lo/x2F5UClClX8ODfaVBK/cXhu0y0rEB5hF6KtlOvdFScWQwnn5
         UpAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dR5FMFlo246DjiayIr8NlGLupK4szceHEikbN1Luc1Q=;
        fh=mHmi4d1tr9bCuGf+b1Mca1QnNhphO8XUxiGZLdk5lRs=;
        b=Yq8rbu/vlsY3qMjBVyNKIX6otFyMEMgx+ZsD+QXWZ9K5/OOloRrrrPTWawqS6dq18S
         sRE1XSOe+j2G3TyOr4ia8zdhTlUKXG5OcFoIUNml4xq/kbhY4FO5XnO+xBY1CvXh4bEH
         F6dhE2C4T9u4yXd6cgPeKpBW1FjXzoR0oZT9VNLlY0l0CGjZybBzyop5lkqf6cl3qFVI
         vxMB+/vw8Lm0orGDCkFI4iWz7Xka5aa5ZT85Znff9VE1Ke+g3Zy1DX21boTqpRUzAlP3
         rs/oJlqe+iKiFqzCeYEqu0v1vgQkGncTl0h+X2bpdBSxvtIjyXnkpGV0TfG8rv+39ifr
         TnMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768772036; x=1769376836; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dR5FMFlo246DjiayIr8NlGLupK4szceHEikbN1Luc1Q=;
        b=b1FyXtrqchzPczA8kRMiBe4/iNSTdqRY+JBmtz06IB9Yk/nvoTFCXqwSoa2bmX356H
         PRpJ30tcsdLujyi3Z7tpfsHRakBsf1EcHlNQtZ6fKth2jD5U+GKavhv3RambwTaexvsJ
         suZ/LOmtNYDHXCNKr/Jrt6Qj/OwZhhfTRWJOth45cVA89isxgG9QUdrwWIDWteHKiLng
         IeDB27QRClA8zlVc+qq+cI4N+MXh5HBAy3iKq3FXnzgcFsKRMEGvuRWfJDWN0NkCZhcE
         CzKXgGSli2dXBR5bKHag0t6bxqFnRtxj+RRyWIpoVm2/LAYD39+fGOotsjiium+kYCZc
         8/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768772036; x=1769376836;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dR5FMFlo246DjiayIr8NlGLupK4szceHEikbN1Luc1Q=;
        b=FGw1L2VwRXPQveiCRERHMDrSD3yDuzgkiKTaez5PfxI4L8QNdEGoDNDB6/cMe72haj
         62EXyzcRQK1m9Ud53zT7sDkDDsJi0tAab7ehlBxhKaertvaSHYuNIm5ieTOJXuGvwIa6
         2Ghm8XjI+zE71/eCZDY1E6LO0BR/Il01nUOZVAobLDrcgiiOkXztldIqRgZrLEP57KMq
         ZCj3eU4nEsM38Gii3lKK3XxkJYDQBMhrwBYYRf4ROjvJK6PLy0oDyAkDy9xx702Gw6x5
         L2e+2P+x73QvfEmzVh5KqouRTCm+3dl3v6QhaZP62zt6Cw5fsKBh0T7UwKp+6qfAnYCu
         RYcA==
X-Forwarded-Encrypted: i=1; AJvYcCUQuTWIM2F0lJNfzu6ywjXtOuf1G7jJmVPTXSMeY49oE57Wxr9XFWM32FGkBgAKT6T0vKgJLrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxANhI9+JV90N5k9w2bakzqaXbGTvl3Qkm+fBx1ZcZKo1Msflsw
	rNulKWCQyCQFab/jFAhyF5aMF+QysxRSWELl9Shhhu5uj3VsPPnaw617hDvQTwjugabeh8q/H9n
	pR+fsQex2ly1s/tiVtKQLkQqJFnvUX+zZGg==
X-Gm-Gg: AY/fxX4fZi9vJJzyuC8vk2bIYPvpBsrAxWpG6nAY3Whf+W7FCxqqT3HrzgFa1v7eysR
	EGacCBGv2yrIYjMN4pfqncin+HsNMCaAUjeHgImbiMg4pMIJWa8/aExqDT/LzxbUfr8hlUwT3h+
	h/6QpR7VzCnvNxDLYMCV6jZLbbrtOr0TiHqbyLrQ+W5JvOugt/BVXufYTZseosOceZsAQCQanq0
	pi9KNmoNw4Y4Vr0mUSC+UX/4uU36ueDGMnW26+X6S381fdUiHeKXlE0xG9pfgtQ7cwhAyCa51R4
	lbdeejL5sNxx8sIs7DQT9RBJSGAxEfRF
X-Received: by 2002:a17:907:930a:b0:b87:2d79:61c with SMTP id
 a640c23a62f3a-b8792d36328mr832751066b.8.1768772036000; Sun, 18 Jan 2026
 13:33:56 -0800 (PST)
Received: from 860443694158 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 Jan 2026 13:33:55 -0800
Received: from 860443694158 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 Jan 2026 13:33:55 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: zynai.founder@gmail.com
Date: Sun, 18 Jan 2026 13:33:55 -0800
X-Gm-Features: AZwV_QitwGRIZkGn1QroCS8h4qw7XwJi6e3jAKQi37ba990QzWONC4TZTkg9-wY
Message-ID: <CAEnpc1b7fMJvpaub42Oge4B+h3wZo+HOAi=ombo27AwLhWwvkA@mail.gmail.com>
Subject: Is Your Dentist Office Losing Time to Manual Workflows?
To: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	patches@lists.linux.dev, info@morenofamilydentistry.com
Content-Type: text/plain; charset="UTF-8"

Hi Miralda Moreno Team,

As a dentist office, you likely struggle with repetitive
administrative tasks and manual lead handling. This can add up to
hours of wasted time each week. Our AI-powered automation at ZynAI can
help streamline these processes, freeing up more time for what
matters.

With our solutions, your team could save 5-10 hours per week on admin
work and focus on providing top-notch care. Would it be worth a quick
conversation to explore how?

Best,
The ZynAI Team

