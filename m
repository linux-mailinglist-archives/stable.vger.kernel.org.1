Return-Path: <stable+bounces-112066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41791A268A4
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB047A2086
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 00:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A801D530;
	Tue,  4 Feb 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="i2qvos6X"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772610E4
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629296; cv=none; b=AD+GZEPQsxhPeZ5IOXH6/i6Wnvkf6QkmgiWlQl/bSYW0xVCLLilb/kNI0fBBBcwwZdtTTRmLKGpderER0bFmt3gqY+WCoFGzN1OjiOFTrFC8DpDynHw8vrEPWMNReVVNZxdKigcXpbkfOBD6l/pIWYTIVgkkTYpQnwSIOLR+6Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629296; c=relaxed/simple;
	bh=KregMQnIuzXswt5Nae5GAvCTaDyGbn7lPPG0zELqBMc=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=fKnWCNIormHQEaVJxnlzoXUq1+5stGwv7eE7dLJvNtccVERI+WS0IbXdIQa1ijYdqhhfVctQ/7+kwa+oTrg3eVW/F188rqLJIrweOAiUVhtMlvmx1tdk3L6HQJl/1i93gYTfszheynFfubKLczUsiZNtMK7AVeuLxYzNbBdh5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=i2qvos6X; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6f4bc408e49so28073357b3.1
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 16:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1738629294; x=1739234094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ALYL1piPWYR5chqzctGajE3dqdS3nVFmVV3lLrQKz0Q=;
        b=i2qvos6XBVzaL/58ikaDChRBwAg4SMtIWVQJ/DkFAaofzMtoVrNrVDZjVlO4GDocx7
         WqsoRzkZupe9qQta7LO9APxO+ySRT+j4YBpY09HCXuVP4DoFUsaEbkw3e+R2o1joNega
         QMhN3AQ+Jh8SahsPA98dtbaymGmizFIL4NAxRP1clBmdynAsFG+DixfeHH5gVPe7M2FB
         /9F+LD5OiQLZLhdIs0/8Z5yCelZSk/mKcI6ejs5y4jjQe06mRshHsUxODvD14hr3qj2u
         zRTQiC8tKl46RtZuY49kA5sSRDihZn5zL70atZEhL9GWd/yKrwLHW0ckbQBE1t3eKygh
         51fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738629294; x=1739234094;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALYL1piPWYR5chqzctGajE3dqdS3nVFmVV3lLrQKz0Q=;
        b=FmR2LAexox/AuUbvf+9Bv2t/JT7lLub33cJc4AXhjeOwmgRBupl/1YpRjm1luGufUK
         30osBkVBp54/1bCcyvZi3OznC+Hr3qeZpUIBmjedBRrX85Oa6E1X3OeAKJ7mAEmAWgp4
         10cCBVOJKqh5Qx78MS+zSixUW1XV/32XPukiH8XoDq9VaQWJIuEm3ZuVnuPwMwy+yGlO
         xDTAf41hqZA1z9vaWoW95anFQRQGi/8m/0lF49S856zWrtSn3EbzjAMDf4UT5Wf2iUH6
         6GpJdwQociPDpd7dKuywjg/xiZ0EgCZ3tc0vlOW62/RpM+rV1vhrzN1rNW++tU7jNoPh
         Davg==
X-Gm-Message-State: AOJu0YzGIfKSZ1mL0+Ill20KOWXdlVXHPOaPVeW0nGk7k8y1K/ejMoZE
	uEYjPi+gDR513cTCO5PSpSFzDBQmPhq1ROL5s4XmdjZTRwCdeu8dbI9ra+xHRWpmReivelWtHfQ
	9ZQPr7NFV1rn03vNxAfsllAsTQEKYCepNVvyz6kH3bcNd0rOX/HobdXIX
X-Gm-Gg: ASbGncsZPs/5p5obSs9Um30KccBvWbd6+TlrgMY5QjwJCDothmiZxSaU6BlJ8EZf5lo
	383cXfZsF4Pwk3HmrwDkyo0GUIh9AfkwyP3N5eG2BBEgnk4qzpxzYx5dtCzvrJeklM2PgAHGb5I
	hyFSJHUEtgcpH8Kq4NRiEyXAmULfFWzA==
X-Google-Smtp-Source: AGHT+IEXQJjUncK0LEBhqNwdV9jgeeD9k7sVHvyAXy6+5Y8tk8lfcW4PkFQXaqwK03Zu4DlDm8Y1WzQGucnCnsSQW40=
X-Received: by 2002:a05:690c:89:b0:6ef:a53e:8e5c with SMTP id
 00721157ae682-6f7a831f071mr164063697b3.8.1738629294194; Mon, 03 Feb 2025
 16:34:54 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:34:53 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:34:53 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Mon, 3 Feb 2025 16:34:53 -0800
X-Gm-Features: AWEUYZkjjmaCsyroe3Xk6NEyQ_gWnh4Heq7mg9dHvnTdcxawSedz07j-Kt0GGFI
Message-ID: <CACo-S-2UhmehXF0AEA1rco9AckS7nDpOSRwZrAK4ba-b1Tj9-A@mail.gmail.com>
Subject: stable-rc/linux-5.10.y: new build regression: passing 'const struct
 net *' to parameter of type 'struc...
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.10.y:

 passing 'const struct net *' to parameter of type 'struct net *'
discards qualifiers
[-Werror,-Wincompatible-pointer-types-discards-qualifiers] in
net/ipv4/udp.o (net/ipv4/udp.c) [logspec:kbuild,kbuild.compiler.error]

- Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:841ec27ef8554e3fda7cfd5babc4831387ac9e8e
- Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=maestro:841ec27ef8554e3fda7cfd5babc4831387ac9e8e


Log excerpt:
net/ipv4/udp.c:447:29: error: passing 'const struct net *' to
parameter of type 'struct net *' discards qualifiers
[-Werror,-Wincompatible-pointer-types-discards-qualifiers]
  447 |                 score = compute_score(sk, net,
      |                                           ^~~
net/ipv4/udp.c:359:55: note: passing argument to parameter 'net' here
  359 | static int compute_score(struct sock *sk, struct net *net,
      |                                                       ^
1 error generated.



# Builds where the incident occurred:

## i386_defconfig+allmodconfig(clang-17):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a11a6a661a7bc87489b7d5

## x86_64_defconfig+allmodconfig(clang-17):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a11a3d661a7bc87489b7ae

## defconfig+allmodconfig(clang-17):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a11a31661a7bc87489b78d

## x86_64_defconfig(clang-17):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a11a39661a7bc87489b7a3

## defconfig+allmodconfig(clang-17):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a11a35661a7bc87489b798


#kernelci issue maestro:841ec27ef8554e3fda7cfd5babc4831387ac9e8e


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

