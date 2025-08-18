Return-Path: <stable+bounces-170052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609F5B2A13C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E45171738
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6AB2E22B3;
	Mon, 18 Aug 2025 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJID5qZp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE730F521
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518596; cv=none; b=BgVczes4xDvQMQv7RGy4/B4/Bod89XYa0AFCmodDO+tNBPHS6qp1nO5fBeqwxk/FVIvcLepjXIoTCNWNFeof/vh0RqHXi13WkLiAuO0DEWOnwkyTvMa6gpQm8BAept0YrFMBINExRlD/Q3byy1Lgyjr5OOMotSCqFMeCGkcN0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518596; c=relaxed/simple;
	bh=MaYubBCQWAasqPoZ4eaRm9SHFdkSTSmzvdSy+5/YQH8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rYTN3vRGoaOm9fIV+VOPjdT2QedEQVA+vsMg7h0pYbB5r6kzpdqYEnr7ZRLnVcEWsmyUgPxUJT+kD/sEhwGPuMkqLUQ1c3nJubEH08hl0ex3uuRDyaVIj9uhu9Jy+U96PnGdgSwseLgXGGudM2bn72FZlhCteilKz58H/SxsfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJID5qZp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso30462505e9.1
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755518593; x=1756123393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MaYubBCQWAasqPoZ4eaRm9SHFdkSTSmzvdSy+5/YQH8=;
        b=SJID5qZpwGnoXaRDPj74QhYgT+GVn46T+0eydws90JOtsBRchqaoAHc0dF4DnmS5I+
         3cdPAK25+21teoHj6hsWVS1nK5mi7JqeAovWqCksvlfUnhxAkd36rDu3HgkJpolIjM1+
         MbrFWjHy/bxgwtowq1lbcCWrc/yvS5rvN6szmcvaYghLlaslGlN+dzyqI3ppQHorlXeq
         W/2izuTez49tSvmgNADfnA144rzC77k8CPzjD1dfEekZuEnzxn4U4TA81aMReXwa9NTz
         SuC7wLiumPP5dA5fAj8TK4Dga1++L+ldmaABcedHTcshwaSIPOPktRCUzzYZ7nhRkZ0S
         37vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518593; x=1756123393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaYubBCQWAasqPoZ4eaRm9SHFdkSTSmzvdSy+5/YQH8=;
        b=D+3XXrQPWeTHl33KPboK4+B4MOjclc+fTdz9oP7Z2DF7c/0mohlFVjDfaaBe3FNVFo
         pwJXgw6GWqZc9XHlBLlcSwdGUvlMKS1B6ez5xRKHZhbQxQdxSh5kSKRbtUfZE5dero+A
         gNrkuFvGKLxfdSYAcc06ic3GNEYw5qINCLosvvh88upHhagUZB4Z97aAJeaPVAzD2FC2
         Py/LPDsL89qXj7bWQcKsyyAFhu5fwE03WBuHvPxoM6NzN4wbwS5GbYw1GkQ4FalEXqIk
         m4DxuF+rw+e9AuDWx1VeIzDh7HhIWmUqY3+83eCzTVi24ZPtZchHIA4+fbiwYpmt7PU0
         Ubag==
X-Gm-Message-State: AOJu0YyJLCSQyQXlH5c7mKXvn7sVzwiRsfPa+nGV6C/PhWK3SO0XjTJo
	9jRzpXkx0Hy8I8Ycpgj56bK6f2Wot7IED7tBQSEI/9WBUrLRrvre7eBynVIqgoaE11jUpeq9dGE
	uydtYvfOLik2BPktlFMiiY9P78dU519TMozX1jGDelifV
X-Gm-Gg: ASbGncuivVcwQhpJMBKyV7zBu4OXCELEpDsnTYCikkcIU6I9hVr9s73LbVBw+j/yzZB
	hE8p8HphA3qK/FJRD1seldpkjusVBvvIyh1iUhYHtKtrBnPxgSfGQ3ad3wrJSPeeuvuKAREp6Uf
	2X+PIEUdi9gnLUy5zSTS7UpTO+yHOMC7hmIiXGHKjY1DRC8LlNAl2aWPoLPHmSMJhVXVbC1aZ9T
	zai4NhA
X-Google-Smtp-Source: AGHT+IGYdWvI+uTxadLH2zeve19zPjNVFGol6N6HNqJSEG9k0vrbJWrMjWvGouPVZgo5uS9k9jzvf0LtOtoJhDJFCJo=
X-Received: by 2002:a05:600c:1914:b0:458:bc3f:6a77 with SMTP id
 5b1f17b1804b1-45a273becf0mr67451675e9.2.1755518592212; Mon, 18 Aug 2025
 05:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5Za15YWs5a2Q?= <miaogongzi0227@gmail.com>
Date: Mon, 18 Aug 2025 20:03:00 +0800
X-Gm-Features: Ac12FXz9THHGrPuKRAARYC_e0dKHuCmvZKAlgezYau7bZxiA0mLaNZgOd4kku_I
Message-ID: <CACBcRw+Fu1B+fXEFvhfsZFtPqa5G=AYSW0K3L2RBWh8YfkgUhg@mail.gmail.com>
Subject: [REGRESSION] IPv6 RA default router advertisement fails after kernel
 6.12.42 updates
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

While testing Linux kernel 6.12.42 on OpenWrt, we observed a
regression in IPv6 Router Advertisement (RA) handling for the default
router.

Affected commits

The following commits appear related and may have introduced the issue:

ipv6: fix possible infinite loop in fib6_info_uses_dev()=EF=BC=9A
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.12.42&id=3Ddb65739d406c72776fbdbbc334be827ef05880d2

ipv6: prevent infinite loop in rt6_nlmsg_size()=EF=BC=9A
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.12.42&id=3Dcd8d8bbd9ced4cc5d06d858f67d4aa87745e8f38

ipv6: annotate data-races around rt->fib6_nsiblings=EF=BC=9A
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.12.42&id=3D0c58f74f8aa991c2a63bb58ff743e1ff3d584b62

Problem description=EF=BC=9A

In Linux kernel 6.12.42, IPv6 FIB multipath and concurrent access
handling was made stricter (READ_ONCE / WRITE_ONCE + RCU retry).

The RA =E2=80=9CAutomatic=E2=80=9D mode relies on checking whether a local =
default route exists.

With the stricter FIB handling, this check can fail in multipath scenarios.

As a result, RA does not advertise a default route, and IPv6 clients
on LAN fail to receive the default gateway.

Steps to reproduce

Run OpenWrt with kernel 6.12.42 on a router with br-lan bridge.

Configure IPv6 RA in Automatic default router mode.

Observe that no default route is advertised to clients (though
prefixes may still be delivered).

Expected behavior

Router Advertisement should continue to advertise the default route as
in kernel 6.12.41 and earlier.

Client IPv6 connectivity should not break.

Actual behavior

RA fails to advertise a default route in Automatic mode.

Clients do not install a default IPv6 route =E2=86=92 connectivity fails.

Temporary workaround

Change RA default router mode from Automatic =E2=86=92 Always / Use availab=
le
prefixes in OpenWrt.

This bypasses the dependency on local default route check and restores
correct RA behavior.

Additional notes

This appears to be an unintended side effect of the stricter FIB
handling changes introduced in 6.12.42. Please advise if this has
already been reported or if I should prepare a minimal reproducer
outside OpenWrt.

Thanks,
[GitHub: mgz0227]

