Return-Path: <stable+bounces-20359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572058581FE
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 16:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5191C228AD
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2288130AEA;
	Fri, 16 Feb 2024 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J3l632Nv"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4312C809
	for <stable@vger.kernel.org>; Fri, 16 Feb 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099043; cv=none; b=VzFbV53vkUnoiOBPef/zQxOR2aiC0HxGGcBxIdtajDVxqlSyEGAGfcpMgwri90GAG9DvTsFURok6/jY+MVScJ3S71lYV5T1+g2KnpD3ihr2CY7NkZjW9obmSSaQHxLJbnT7Ufcf/t2N8PZm+9VbarsvGidAE8YO6WgaHSo8ZLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099043; c=relaxed/simple;
	bh=oPEozYAQxXEXWmAjeuTijibjfA2St4Qwb29zKE0hwu0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F0U6OdrRqkpVF9nTwrWajycykZ4KLMp7kyVPDNrVWlV08KQL1Md9XoDAJFcXm1Gj11xLEHAnsSlghTb+eh4CjVjb079xTEVUoTuv9BPmiYUIYzbec8EDyI+Rr0OTuW6/P3ZE1BTVodXUjtLnW5fzXkbJOJr56/QFPHXzwqLdtu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J3l632Nv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a293f2280c7so309596566b.1
        for <stable@vger.kernel.org>; Fri, 16 Feb 2024 07:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708099039; x=1708703839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMP7S8YySLUxNquuLa/TjhwgOHNakO1cueXwUFERhiQ=;
        b=J3l632Nv1rGZDCB5KhPHSYWzRaXpwZB1xL/AJ9j2KOb6D4uIgU4z6Nrso39GO4eIWY
         P3jmLSktBbxSndmBkN7H7rAlXS9QSCc/eoi3zVXo288wbyhOjBSJwvWOel++lUFwp8BR
         4I6CdBe4/n8lAvLqpf+fxAU4MprCsLjCqu4cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708099039; x=1708703839;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VMP7S8YySLUxNquuLa/TjhwgOHNakO1cueXwUFERhiQ=;
        b=kGYX2U4Td9R/Tx3AtM2Zgz7MDIDWk98ZGROBN4sCqM1QlxqDfm/LSomPMnKXdKDvF+
         k5F64Bt6beccHLFQ306ZSCFxrw2ab+UolfeBXFkChgc6Bj6J8AAKevavwsOg/6lkCEwS
         YjqQqoGAjnqemCH3UlahTU8k3mzIdLK3L9v1o62bHbVm+qUEDdyjk5OSc0uRXhuZN0D2
         PWDEAkU05XP7/p7AX4/tfyM5PuuA6GDXepCEgjR/A2I3z/TBLqURjxJ4/ijUH236gjox
         mgOAdPyV2rXpchxOuDQ7H2bjdoncIPWSPnOaX4MpR03pb1qkgA+SGsRlGOz7wOf3bWqV
         3FKw==
X-Gm-Message-State: AOJu0YwOPZ/qFKlcNIhcVyiARHEXVnPH9E6wXu/4le2HO1CEGeku7qxd
	NEXeJVTuL5he8hxBz6aIAN8i95aOlRUc6QoG63LFUOdbVVZjOZ4afgGME83Iukp9qbsGHDEaCF4
	8Q0QU0Q==
X-Google-Smtp-Source: AGHT+IGOhCmwjcNO7BzTnacVGVdFU+yF23bqWozl0mCGLQ2noe4KtRlrA6/4jAqbALw7o/MaKpZfSw==
X-Received: by 2002:a17:906:e209:b0:a3d:a650:e5c with SMTP id gf9-20020a170906e20900b00a3da6500e5cmr3265995ejb.29.1708099039317;
        Fri, 16 Feb 2024 07:57:19 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090608cc00b00a3d1cce7c6fsm71899eje.62.2024.02.16.07.57.18
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 07:57:18 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso1728282a12.3
        for <stable@vger.kernel.org>; Fri, 16 Feb 2024 07:57:18 -0800 (PST)
X-Received: by 2002:a05:6402:1843:b0:561:e966:3a28 with SMTP id
 v3-20020a056402184300b00561e9663a28mr4036324edy.12.1708099038394; Fri, 16 Feb
 2024 07:57:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 16 Feb 2024 07:57:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcbbNw-dJu_=9xT3KR-xRgPYG7yLeUwqLkCKoRamx5Ug@mail.gmail.com>
Message-ID: <CAHk-=wgcbbNw-dJu_=9xT3KR-xRgPYG7yLeUwqLkCKoRamx5Ug@mail.gmail.com>
Subject: Please put the gcc "asm goto" bug workaround into stable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

I didn't think to mark these for stable in the commits, but they
definitely should go into the stable queue, since it's a known
mis-compilation of the kvm nested guest code with gcc-11 otherwise.

The bug technically affects other gcc versions too, but apparently not
so that we'd actually notice.

It's two commits:

  4356e9f841f7 ("work around gcc bugs with 'asm goto' with outputs")
  68fb3ca0e408 ("update workarounds for gcc "asm goto" issue")

where the first one works around the problem, and the second one
("update") just ends up pinpointing exactly which gcc versions are
affected so that future gcc releases won't get the unnecessary
workaround.

Technically only the first one really needs to go into stable. The
second one is more of a judgement call - do you want to match
upstream, and do you care about the (very slight) code generation
improvement with updated gcc versions?

            Linus

