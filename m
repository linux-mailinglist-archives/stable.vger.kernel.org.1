Return-Path: <stable+bounces-42888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5CC8B8DD5
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDA91C2138C
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CBE12FB3E;
	Wed,  1 May 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cR9r/erO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914612FB36
	for <stable@vger.kernel.org>; Wed,  1 May 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580010; cv=none; b=dgqj8riVrCYKZROhIH+XCK4gFFtoyu+mmX5hHrvAo5BlZMiw2z5/IHVb4PqV03/zDjYmNfIFSOZK5uWepWJ0G8IcnSXZgGyEWdvgmSo5Hgw1YBxtVhE4W8Q3gCjM+k2xD0vBIU6Rz1c/zVr84jj5c2+oLxYo+5yVkPcErL8rEMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580010; c=relaxed/simple;
	bh=xoGKNlPY12RS3Pov7PPcYrzVGwkA0flz3O349h/XE6w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DktOvDjD4zmNjYY6P6KoPYAPwDWWDSlvYYY3UbUsfqTiv8oSCooIpDBJ3eqcV06ktGatBlUgwYghdH8Z8N1xxE0xjsg9OOppqFENHdPPY/CRAstYvbSViXgdwUwOMZkmhXRJZkcCDX+RefaHG21AswtECB9BFvaiqyTimvsLGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cR9r/erO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b387e2e355so30616a91.3
        for <stable@vger.kernel.org>; Wed, 01 May 2024 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1714580008; x=1715184808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xoGKNlPY12RS3Pov7PPcYrzVGwkA0flz3O349h/XE6w=;
        b=cR9r/erOp5LNKDa3mgrs3LRKViev2IZPBRfgwhL43LoPmyAwTlnizsG/RMqjLEvUK4
         p4N2itT5ZAoXB5X+nsfS9v/kusDiBPcunTH+zDun6o9Kn1YWzg0ZaIFwd5TSKcI8XQTT
         Lk8LluIoOGyQ1nNHxzGzI5QRK90Q7N9yFGR53ykGAlKFfNf1CFdbzNlfXow9caTPi4d8
         bqHJx1gRdGU6tb8yrtRqn7kKAJwyApM9FpZoA+4TkZv86uW6YYp5mNL7LoCEBh3ZFaDu
         UZamsnAzvMcM4BySAwtwk+GAlZAAE0H0utbbi+zOxVo0H0ZVYZAOTDuJjk0u/FKLthyg
         VZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580008; x=1715184808;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoGKNlPY12RS3Pov7PPcYrzVGwkA0flz3O349h/XE6w=;
        b=GyPF1IOw7Z1C9h3CmsRn57RSlIE9P5+MDDdLKkJPb7lRxTNSyxFzbBea7ojA1X2AR9
         MdxxpnWoHiPiVjaF0jXuAQa31m2KKmLOatdhrQHjfftQbuEEwJ0LQ7zGWu0wy7TQriMD
         ytQUuhCE/YZ1mbkVQbBrU9gN8ulB9OfL8f75+ulQovygeHLN12Q6MazLhd0064nMAkT2
         k4tXo/Pj31r+AiLknzjld5KgknGjaIS2ipBij3A9t6dTtFpkFZFrezuW6RUSGagR9cII
         ZcCZWWFnnzuqTPvmCoLXg6y/AMarxurJAoBXX995tqO36MUbGRycWDaG6HtVPgUtOcTr
         bM3w==
X-Gm-Message-State: AOJu0YyKUldJGTn79ya4XvnfSBX34sOlrwO5OAPVa8QN8SmYjOb879Mi
	DHz4KjLxA9lB1igINLXIoky8Q+F3aI7r+Jmn2L7pi4VOb+IFrqeCxvw7Zy84IxkycTlH9PG6Zd7
	qqEFSWAtRHTsZHJGG9dR51/ThxvNVtR/T8cXo8vUdMiqrZEOjXL8=
X-Google-Smtp-Source: AGHT+IH81ujBB4jl5sEtOkGI6qHsqlonGXMcVj0QzSFV9UGhOSsjOrxOVoylz1K3RbxwWJIt9QZFs3RSJbGR0gBqp4c=
X-Received: by 2002:a17:90a:8a12:b0:2a5:7188:9590 with SMTP id
 w18-20020a17090a8a1200b002a571889590mr3298329pjn.22.1714580008201; Wed, 01
 May 2024 09:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 1 May 2024 17:13:17 +0100
Message-ID: <CALrw=nG=+tWmUGgBe5Tyip+PJiMPR_7FWG=e1Ws6OP8mDhqPZw@mail.gmail.com>
Subject: Request to backport "bpf: Add missing BPF_LINK_TYPE invocations" to
 6.6 kernel
To: stable@vger.kernel.org, jolsa@kernel.org
Cc: kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

We recently saw a KASAN report on a 6.6.27 kernel similar to [1] and
noticed that commit 117211aa739a ("bpf: Add missing BPF_LINK_TYPE
invocations") was never backported to the 6.6 stable tree. Is there a
reason? Can it be backported?

[1]: https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/

Ignat

