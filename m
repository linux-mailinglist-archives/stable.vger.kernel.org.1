Return-Path: <stable+bounces-100264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317789EA17B
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 22:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3C9282D60
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B319D092;
	Mon,  9 Dec 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iURqDpRm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76219ABD4
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781339; cv=none; b=cb2OBTT7Z3dGgh+EE3hUNKlOw0+GxPoMI2DBF803Ti1C9BCYtj0mJzXjortMXpxBCGnd446qIqkjuRrXvOScQ1LsumjdUzBsCdaAyX00KZRkkixpw3+FBOBZQvm5uDyafNaOAFMDuVVLq7lrszX5xXxZO9Viqz4Sow3QM2iHzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781339; c=relaxed/simple;
	bh=d96K8IHRmrSECrNk5TPPQeRYq94PX/axSR8tLwCGpwE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ioEYVjEN6/korxaxFKf9L6MODdf73JaAhjf2r3SNq06093qbZABK93SnkALeUSD+vSQvJtKymvZpdDkYI+kJeHZlFYczh9a/wr3b8IcLRZ9373t2D7HEEaTkJDBJasBLFBqKQJyZxd7PkxGEf+y0326oeE4ZIMrGkT+DjUn0mAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iURqDpRm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee94a2d8d0so724278a91.2
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 13:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733781337; x=1734386137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d96K8IHRmrSECrNk5TPPQeRYq94PX/axSR8tLwCGpwE=;
        b=iURqDpRm954XCTIFwH4aDQPYAXYhJ3EizaA/0pytrDudFVOKZEWMNzHJ4pm0mszumc
         G2+V8ZDBhIWWLpbOQ9KHuxAYZg2pff7KbfnfzI++maSkcSegZLpG4JDg8tOLMkNtOuUu
         RAY10g7ruSQfz4gaShP2WiYixRC/+L20rWtF3RpDz55vDH2/p5NRPD4VJiTus2/vgo/o
         ZGq5ch0/IlT6p8K3GD2A5Le4AVOfbn5x9RIOVsUaxhdHGLLzdHNsw1SRVaFaSyl7O7pN
         5Hh5pe0IP0KqSklPiIgYD0b4Kr0rztCE8ECHwxZKSY85rfZhs8fTLaTUHXWYplTnDtmi
         ZB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733781337; x=1734386137;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d96K8IHRmrSECrNk5TPPQeRYq94PX/axSR8tLwCGpwE=;
        b=KLe7RqFHMibCoEU6o+PED9xunOKRXx3cRorxlpoq7o3kRFuKcJAPQ4SffJNWpQJK7l
         i8pdyybmBK7uIKwCqpV3aOuCHGo/bgF+qXDemw+OVOm5kUCPq8Pq5/gTPjExEhAkldtK
         BlAvNxM+GK1nYuCRvn28RyZ6V3l7vhcjKHiyTFoWF99BCtKkXj1r7MJpg6wmBJsqWoJw
         2HiTNgimuxioOAy//Ikmprd6Ygqn5QFJKLa+umnMwqIMg/0xmzF6QfLEf8atkTzlAiQq
         36i7xOOsLmjj6D6fZ3KutulH7u8fsivdBB2Sb1FLh663njnwgqo9fSTEWiS2dhUbPhMJ
         E9Pg==
X-Gm-Message-State: AOJu0YzQMdtyHJiykFS7EZ4czKTaPxLtCY13Na7NH4nP32rwiv/tSQO4
	5r4YiDrcKEZG3j1QKMYeKbJ6yWzaWskJAtNKurxtboDuNkaZ0gQEUxHfmLfj1NIG3mLtpS7HOC1
	CjWUjtuI5uJu2lpWmltTly+Pi7GQ=
X-Gm-Gg: ASbGncv95F+YOHk+Npr9+UtUSaJRhFM0H9d22vmcM08uqy8jjaifJ8BTdgOvvhT6sSx
	ekRp0LNnS0zheshWb5q5heWXKcOtVCy2kriM=
X-Google-Smtp-Source: AGHT+IGpy/vrc3SBc3yrzqwCMXFRUFHqeaZ/CxCso/jky1O9uRspFwfRHD4CDHmYPm8tAVrGT/T5ezxsz+He+P95jvo=
X-Received: by 2002:a17:90b:38cd:b0:2ea:c2d3:a079 with SMTP id
 98e67ed59e1d1-2ef69949ac6mr8357419a91.3.1733781337238; Mon, 09 Dec 2024
 13:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Dec 2024 22:55:23 +0100
Message-ID: <CANiq72k9A-adJy8uzog_NdrrfLh6+EgHY0kqPcA5Y45Hod+OkQ@mail.gmail.com>
Subject: Apply 60fc1e675013 to 6.12.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider applying commit 60fc1e675013 ("rust: allow
`clippy::needless_lifetimes`") to 6.12.y.

It is meant to avoid Clippy warnings with Rust 1.83.0 (released two
weeks ago), since 6.12 LTS is the first stable kernel that supports a
minimum Rust version, thus users may use newer compilers. Older LTSs
do not need it, for that reason.

It applies cleanly.

Thanks!

Cheers,
Miguel

