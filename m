Return-Path: <stable+bounces-189155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E11C02BEE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 19:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CBD1A68A11
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E232F34AAE7;
	Thu, 23 Oct 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQXFx07g"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96834A793
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240894; cv=none; b=ZxWs/1TrOKGMj5jYUNXiv8qHZt5w6em+X30poZ+5RzD/v33yI9TcE2rp7qJ9K7+GW+1Sxgx7+PV0atjtWWLlvhctU43O1GxSf72RdaQYAqfVo7FezvosFc5EEvnRy3ub4NApj7Zl34FplZN25UVb7TzC2s2lLtn+e3mAhoZQHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240894; c=relaxed/simple;
	bh=VwKC0UFE/hSiQYJTMaM4Bls4thTgZXjxzl37/zt9MmM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ktXj8e0XgWXYQDHoTFkWFQ+inDwLGpvy4jh11cJ4s5s0pHthmAnV2JzI4w95jn3bpHkQPrr/8CKzBqtNzZYs6uYXR8fdLvzDkbSSl9A7nkBvK2c07JCKX0jkTdMqtutEk/FxdOZf5DWUquyxfbqBdjBauGxsyUfHwd1+oaaYRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQXFx07g; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-932e88546a8so521835241.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761240892; x=1761845692; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VwKC0UFE/hSiQYJTMaM4Bls4thTgZXjxzl37/zt9MmM=;
        b=TQXFx07gUi7M3w6qqj1K+xEnYHhOPT4rmQwksSSqaXB4KYA54MDQCPbGaRCxisYqMo
         zlWRRYjPXVNRP7oZZJQuiPg8m78oKkJCGDOiNGzXdkhjwVW+oYv6uDicoKHEnB19ycFY
         MPdMHph+Ex02A+e/uRg0QV/Hpe+BhZfMMfFNuuS6zaihynvyrGzVv2mn2m1ARSrCv3nB
         pTjC0Ysc0J6JRnAFw98Och7PpIj9DD3G/Ix7jeTTIeLVrSd0lc7joiWN055oJeZJY/s2
         a9qsB+TkCQy8pzIj3HpgVOoxu4XY5Ag+23kpH3i4722kTFebf3pKTK2upQioqVBHchS3
         LDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761240892; x=1761845692;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwKC0UFE/hSiQYJTMaM4Bls4thTgZXjxzl37/zt9MmM=;
        b=nE364V2eEtZ9PNv3ZPIDCG/Z1xg0QpwO9EfJmwdomJYvJQtIOIiQoaMKXrmj35t11l
         7162ZTZd08kvZtSyR7akY0HehZM4kxjQsk5SZ3kYaPkXPv4U7C7b1wGffraSAUePRlgS
         FUyj2yvTZQkWGffVDGWZghAsM+WFk/YBnxu0bRQkfFiOG0KTczPziI4s2OIZFani3b0C
         i7OGCZIp3wMI1wp5luwTM2OwEo13RThAIsPe6LqJr5AkqUEouF+XyEwj1K63cuEKEA31
         QRaqUj5aMdpfWAiJOCGOb1ba//6QWsWLLC8mZVB76R1wl6KZtBss3RVrNhXkT38TeliC
         vNSw==
X-Gm-Message-State: AOJu0YxCTgJ2a1EtdUVPXADPb4SJimU99ijHr7oDn5ks1Ylx+fleyEP5
	bP8Fp2C5ZKiK4sbLS8M+F1ldJUfO9fkn4QH7DeisNZjYqEB0XRe1UCvnZAQVVcHpuDGVHtD3sS+
	Rk68H/hMK8sq2aaANiWYMTzxza+bKxnE7aQ==
X-Gm-Gg: ASbGncv6UjIbSeznm8HjX/r1Ojk6J9lnt69iuzWfSzkQBK+UFJXd02Ibiv9lN7WoX71
	b6XC388ZmZAjSbb9QfMij2dhW4G9GxBc9M9zSTP882nJ2sBceq7S2/w1rI8qDFKICpYYgvwSGyS
	FacNWKP+uSQaIdEOr8LR2bj0za+T6+8AqDpE5MZY9IbIDWZ/8G7N5osqrXls5pk3D4ipMopjxXL
	v1PK1912w5Iwf2dXdTHUdv+96ZYCtwkoMDVhEcat12665TTXz57vnzTf9s4zqbkz90TZdpgWC8Z
	e/aqUUF5EQGqVMtI75E=
X-Google-Smtp-Source: AGHT+IHVFWpWJL7hBMbtcQlq1qWz/PgUQ7gjmgFhrbWS+lxQFwK4LbyaD7R169a60hu7dXt7vXlM65mlKh2O/u466wQ=
X-Received: by 2002:a67:f40b:0:b0:5b8:e08f:eb38 with SMTP id
 ada2fe7eead31-5db23848dcamr1913663137.14.1761240891865; Thu, 23 Oct 2025
 10:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Micah Robert <micah.mypackagingpro@gmail.com>
Date: Thu, 23 Oct 2025 10:34:40 -0700
X-Gm-Features: AWmQ_bkAf6KWTjjSpEadTicYTnmufXQh8Z_xsM5X6ZP7BmlnQKjWhO-Pt2QrCPk
Message-ID: <CAHb_yAEb6NYdOOzAjBEgCjv1ne6iQ_EBYv-RqN+WMqxdHL85dQ@mail.gmail.com>
Subject: Custom Packaging Boxes and Labels
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We provide custom packaging boxes and labels. We make boxes in
different materials and styles such as Vape Boxe, Cigarette Boxes,
Cartridge Boxes, Cardboard boxes, Rigid Boxes and Mailer boxes, etc.

Our benefits include quick turnaround time, free shipping and design
support. Just send over your box or label specifications and quantity
so I can give you an estimate on that.

Let me know if you have any questions. Thanks


Best Regards
Micah Robert
My Packaging Pro

