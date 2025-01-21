Return-Path: <stable+bounces-109583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3435A176B6
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 05:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EC07A3DA2
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 04:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568DF1898F2;
	Tue, 21 Jan 2025 04:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkcfmTVp"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8442CAB
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 04:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737435200; cv=none; b=Yy9d3evsNNSB1UUNfM+mvBW7GFgLO0+BCqb3E8aJHwsDx8TTCmWif/6FaHcwTuVuYQwHKRnGtJT0TVNYgMYhnwBtYXH3ObOjQT+i5hn/jI9Bu8w3BP1/Jt86OJBUufvQNSH9HfjXmVzd4HI4gSNupQtcMfBAHcKf1IzBBrtxR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737435200; c=relaxed/simple;
	bh=X+O8DDbzBtjzpox+koeeDac6d6MNWDTtYL7qjF4qdV8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Q+UKRIWQqn9AN8owwlMdThuRcA8oZd3OivpDPyBxwBfnQzuFok+9XtdY290hZVyZctKOfT67V32CaRJ7lqHRZebemuR0XNGXJPC9cfbLoPRBb9qMwzND5yBoQPq+MsXaAYNh1BlN78bVQmDcmN04j/fMmRalWk+WV2RQHqQFvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkcfmTVp; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51cccafb073so1707983e0c.1
        for <stable@vger.kernel.org>; Mon, 20 Jan 2025 20:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737435196; x=1738039996; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X+O8DDbzBtjzpox+koeeDac6d6MNWDTtYL7qjF4qdV8=;
        b=IkcfmTVpEM/l1c7HvuHDnRm8pIXsGctINv07+HBJ6tCjica7P8St85OqBju+5DbLx4
         O0mlQsXj+hc/7Svc5YW9g+F4o6akDcLYRtDM9ui+8flXeFjhYBV/HrqTowLeD5r1s7Nq
         ylyi4GxIkYK4BeldG9yndtMKvG/GA1SEsY4uW83jM9iE2iBEVlN1cub8LJcWy+av0f11
         pftdkHL70O25C6Qrq+jCQpqw2K5kUjqXjr0pBUlNmc86ZJJPEILRXO5ZhIoAXFDGyBJR
         KgSP+UwaATK9bjRdPP/PtQJPWROi0s9Xxnxz9CXhcj8ol+dvP7BIBX1dUjm7N6qa4JMt
         SbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737435196; x=1738039996;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+O8DDbzBtjzpox+koeeDac6d6MNWDTtYL7qjF4qdV8=;
        b=QL1KNXCu+VWWDsvLsJY3Z5cjiSiYxytxY6OTVVjcaOGLXtcIkl6a5V6XULSAiS+HFx
         9ZeTGu1KDDc3LyjlLNo5QyZzgRibPPTbzLYnfYOXm3MIjqKpqSpdslWKIZPltNMEJz37
         BrCyseseJHJUEgbHfUd6026mwmzmhErMfVNbgrXkGuT+K+gAMrMwC/1gIgAwXSwFPuvO
         hrkOa8cDQmk80PRq4QiYBObPcgfPhxeuQwg9ZltXzfvOn7aPW8qOZu0DnrOoWXRbrvWw
         t4UPZK3MswquEm3CTVrHk2nebr1PeCubdZDj0OLi57x0UBCeeWjyDWP165ZGb1zR5A2a
         S/PQ==
X-Gm-Message-State: AOJu0YymBREqdXz9Fx4mO2/1hWpQ8FvORdxQSUW0atbmZLBLzOGwEmeT
	kfyay6PMKAH4RY06xbZqAj/Z1r2YtXD76C2yqCj1ZFLPTi/hFObpJZnjqh9TwGaI+J+zpyf0sP6
	ryzGAFS5+E9JC+Bnzo3tD4F8CsuF6aolneepwrQ==
X-Gm-Gg: ASbGnctYSu9+4270hbI98B4Kwt7368loFlD/xDzRbWSavGe4VsM9oYENApTp/Jz8/58
	G4vpxGyPvbcXyWN+SzDGPJSHTf5gQ7fgmCPLi10x2NpU8bCSRHA==
X-Google-Smtp-Source: AGHT+IF5e4RxDf/3lSSGVOyWX7VEZO9PZ2c89baHfSfBAz1QtzUHvvlyRehbsxBcJxAqae0gM00FTrBQjpGc05axmZw=
X-Received: by 2002:a05:6122:338b:b0:516:230b:eec with SMTP id
 71dfb90a1353d-51d5b265b25mr11982258e0c.5.1737435196447; Mon, 20 Jan 2025
 20:53:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Kaegi <simon.kaegi@gmail.com>
Date: Mon, 20 Jan 2025 23:53:05 -0500
X-Gm-Features: AbW1kvY52NMdhNnCuLwEWyTpy5IPpTIJwa4s6ajou_UZAt_vLAbRecztOcnY4hI
Message-ID: <CACW2H-7QEMKA+LUAzFJ+srmRCzSuLk2G7shWt0SGR9SfmxwOjA@mail.gmail.com>
Subject: [REGRESSION] vsocket timeout with kata containers agent 3.10.1 and
 kernel 6.6.70
To: stable@vger.kernel.org, regressions@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Martin KaFai Lau <kafai@fb.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"

#regzbot introduced v6.6.69..v6.6.70
#regzbot introduced: ad91a2dacbf8c26a446658cdd55e8324dfeff1e7

We hit this regression when updating our guest vm kernel from 6.6.69
to 6.6.70 -- bisecting, this problem was introduced in
ad91a2dacbf8c26a446658cdd55e8324dfeff1e7 -- net: restrict SO_REUSEPORT
to inet sockets

We're getting a timeout when trying to connect to the vsocket in the
guest VM when launching a kata containers 3.10.1 agent which
unsurprisingly ... uses a vsocket to communicate back to the host.

We updated this commit and added an additional sk_is_vsock check and
recompiled and this works correctly for us.
- if (valbool && !sk_is_inet(sk))
+ if (valbool && !(sk_is_inet(sk) || sk_is_vsock(sk)))

My understanding is limited here so I've added Stefano as he is likely
to better understand what makes sense here.

This commit was backported from v6.13 to v6.12.8..6.12.9.

-Simon

