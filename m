Return-Path: <stable+bounces-86423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B420E99FD5B
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 02:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6692A283528
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 00:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A601C8D7;
	Wed, 16 Oct 2024 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b="yQ2WSonZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13324C6D
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039682; cv=none; b=P4pDjWcAVtP0O54JpdW756O09Kihy20f7TgfvHCPN6SE8JYrQOxJVHfRpLLErJufAMXUa7E+BBHy7/FDGQLtJrQ3D9yttlZrIs65lvUOLtunhY1BktXzqRcTeAWlbf7+6Hc1dZBl9rnY1pXmDD9AvETUyLeZyaM+PUBZLMN0oe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039682; c=relaxed/simple;
	bh=coKtNqO6vfpoYegYa0XEjPkHmyZ+gwYV2lAdsNugEPk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bWzvu+tSnI4kCnUZDDT0i+Fe4A04QPCqelCbEDM5CnhPy8IzCGSAJ6CAVsPqm9oGsb+iZkKq462az+a0wDaA0nkiqgi/xhDQc7qmbpp+d9ngjzy1NpX1IPohaOKjVP810z/kIJ2thqvR8I/h5or+XKGxQu5UBX9QLE+CO1dQgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu; spf=pass smtp.mailfrom=utexas.edu; dkim=pass (2048-bit key) header.d=utexas.edu header.i=@utexas.edu header.b=yQ2WSonZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utexas.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utexas.edu
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so293004a91.0
        for <stable@vger.kernel.org>; Tue, 15 Oct 2024 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas.edu; s=google; t=1729039679; x=1729644479; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ewKdjpc+5ZwBL2qTSzgeCjZHe9uwYymKdJd3b8Yjcr4=;
        b=yQ2WSonZxJjAVsvIGwtt9xwRXt6CzhmYgUYOQtIaK+GnxhLk2rI3Vysx7ISCIKMycn
         90K6myFc8nYhMPpsd7wV4N/vFjrvwJgaB4Gaa3RB3FgC7J42NmioVVdfQ2OD2FnRwwZl
         hQLoPDD2cDnZwhFF6/M3K2j6I0rH5NWbv1Nj9xBcgAT5Wqpo7g8Qr6W2EHzPBPsZfNDD
         yeb1t7Ue9Lxesi0a+a5Mcf8fDvHyQsEb4wIikm9vGqwj0uVpWTKOEaNmFcCnlny0edaw
         OeyCjXLxmkzChslUTjomDXDtsU3TcdXaRLzfbqefoPbWDMYHaeqoM9w1vkKKNPCHX2CW
         h/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729039679; x=1729644479;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewKdjpc+5ZwBL2qTSzgeCjZHe9uwYymKdJd3b8Yjcr4=;
        b=SPkeaDWjIY3C3RiFWOtMs2PhJmsYfQJxdk6HsyQghjs3NcsvLIbeyIiy6FbpwijfgO
         Ui2jdc5A2in1IAerWoxc1+B2tWz06dEv0ez3RDrH/7N6kdu6CHnbT4eXZcf4vKiSv92M
         aIO13jwvziTxNtHw2onD7pr7iJzffAb6tg1+1SBSBc/bTxbW9g0VB+LwYUASQzlhXLiI
         js0iWL+2YUYYHg5JnM+SMnUntp6mPnLPIialDgxU68PsgebmdOR5gkHuVyoXPaW6+QOF
         v0gmNNLlng067I9Ao1ir5QZlmDRx9PTnAkpGdx8mq9lMKcrYYU1PL3N4ChwhTLurS23e
         YUeA==
X-Gm-Message-State: AOJu0YxX0LFdJrlk+wGYprT4tQuSdRR/OKfWBQ4duQwzhiz3A3Ws2mWy
	xIBqGlhSjP+Y2GfdB9knxQ1lXzq+XvF3hn47ZsDlRG/UwZKFu+6kXw99aTt4iyQlR6XckpJ+ytL
	+LBhNgaHSxohIVtS69B8FyTJD2KXBSry3ZD2nH4gJ+boy4aZas/A=
X-Google-Smtp-Source: AGHT+IHC68V6BB7DAt1UmNYyzfxuCfraF22LPY3tmnvw5T5h1P9t3EtI0PboOPF9x1x0zuNKk5wPF1ozqHzJabHfdD0=
X-Received: by 2002:a17:90a:f00e:b0:2e2:85b8:14e with SMTP id
 98e67ed59e1d1-2e3aa1514b7mr3694923a91.15.1729039678887; Tue, 15 Oct 2024
 17:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dean Matthew Menezes <dean.menezes@utexas.edu>
Date: Tue, 15 Oct 2024 19:47:22 -0500
Message-ID: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
Subject: No sound on speakers X1 Carbon Gen 12
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I am not getting sound on the speakers on my Thinkpad X1 Carbon Gen 12
with kernel 6.11.2  The sound is working in kernel 6.8

Dean Menezes

