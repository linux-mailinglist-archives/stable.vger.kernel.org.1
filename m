Return-Path: <stable+bounces-109601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9DA17C57
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 11:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D892188382E
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA07D1F0E32;
	Tue, 21 Jan 2025 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digitalmanufaktur-com.20230601.gappssmtp.com header.i=@digitalmanufaktur-com.20230601.gappssmtp.com header.b="oZ2/jqRS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38381B87C2
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737456937; cv=none; b=cZZjOUkoW4BPIaBF09dGmy7d5NND0LktKV93IB2upMcaMu4M2KomYpLxKls4nEp2qwsxDr1snEsYpm3x4JGextUNaTZzGX9Yul+P/oRQnzwoJqnPTpIpUV6/GHmytkEcXyHHwFRfSl6+VEYVgFWCTVYHqA6T+K+qydye69DZFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737456937; c=relaxed/simple;
	bh=yYLbv2H4PS2A8iSMuVaol0jbiJfxxhLrYtmEIS+BllY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SIv/61cs8qwH4oZRAvHaJnrYCoxGGNj1mcrqAvVbjJ0glVtzrB5nau9v3g1ce8bqtv60iBsOMYpSmVhW+F9wgGdo4G6DQrjkHAkOpESCd9iX8nSyZcPdvSZaT3inH8ymToIDnCy9k1hQjXnS40QG2bchm2+ODivoQhrIJGpHYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digitalmanufaktur.com; spf=pass smtp.mailfrom=digitalmanufaktur.com; dkim=pass (2048-bit key) header.d=digitalmanufaktur-com.20230601.gappssmtp.com header.i=@digitalmanufaktur-com.20230601.gappssmtp.com header.b=oZ2/jqRS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=digitalmanufaktur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalmanufaktur.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so8812543a12.3
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 02:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalmanufaktur-com.20230601.gappssmtp.com; s=20230601; t=1737456932; x=1738061732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYLbv2H4PS2A8iSMuVaol0jbiJfxxhLrYtmEIS+BllY=;
        b=oZ2/jqRS2Un7WOb/r+Hh4FvR4ENWTp6dKPbGKK430NnCge9JE+15cBQJAriN6IgKgW
         HptBZ/G7NHfzM8Ww+zzKwS9zCjwDKLHoIy7MfwwpkERfB/rcGKmVQW3vePEV+7+nWOAj
         37N2mdIVMcGbEZ62p+u2dtVPBuKRlVAMs7bnYHsPGCJHvWvyf81Wtczv5pDobsmSRMJJ
         DuOaP3rNMkyVao8g25nxOvrbr29DuidtZb0e5J9fcS8rOkjCS4QPjlchcqUOdR0GkNkL
         SewglDDQRglrh98zNDL1nTQsjeR+jC9UQNP5/pod1M+SfpWsb62Amkca2tFC8N3f0ijb
         /pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737456932; x=1738061732;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYLbv2H4PS2A8iSMuVaol0jbiJfxxhLrYtmEIS+BllY=;
        b=QL894FhiYZWnHCMzYKcPZW/AVCvqqq8KLvVwCxOgGKE8tkl+0H7RjMMy9pnR6wp6oG
         oesH2dG9dPNkLaAGOJbQNv/Gr2TMt0NsV6fko8PbEGdzqADt8HgXY0YtRJslsqnxWEbf
         GTPeT4nY3vcuazKSTDQfECPLH9+ZfSNrXlvD2GX9xalN848LVKIYg1WI72wX6TC7oLa+
         QQHmj3yPSvwfOU5fc1PeBGmCMZH33ZeZrPXdx3VowumHjhAmvFyiR5j8P2DzL1CoXGd4
         w7kbqgCcwmjB9qMJGZRE8le9lKd0PVcMvJrpykHwGf1UvPjk5mGkwqzVXUgSzkbk1q/n
         d6Wg==
X-Gm-Message-State: AOJu0Yzgqc3VvW567XCSAqfb58Omteg+LNL9rpNK7A2Ez9Hcj/X9ur8+
	o+jvggo9BvsOsmzaKqz9+D9slHMB2VUhpI0WXYp+dH2RXD5vAHKI6aJNn5Bu0imuTEZq5G+rZWm
	X0K0iy+zDgpc5zTPG3FXsx8G8nnJkH7vwhgjWZVrGgw+SOc8XTbU=
X-Gm-Gg: ASbGncusIdeOiU/NemtNIatrD7Rs/mLxiToaLpnWLWIe9/ZcnTVQrElyI3ubz0mRLrC
	zh7hdKwonPdcecbr6a/nmA0MT6/w6XAzQ5SX43w4zVGNTB+t/3a8=
X-Google-Smtp-Source: AGHT+IEUhCYkF3GiAfEYnkmD9EdDQTrM/bQfadBLCtfMRGyaC7dwuufR/UCaxD9s6ztPd4s61i9DSjRzwrbsikT4sHs=
X-Received: by 2002:a05:6402:2706:b0:5d4:2ef7:1c with SMTP id
 4fb4d7f45d1cf-5db7db078c2mr38457653a12.24.1737456932368; Tue, 21 Jan 2025
 02:55:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Kramme <kramme@digitalmanufaktur.com>
Date: Tue, 21 Jan 2025 11:55:21 +0100
X-Gm-Features: AbW1kvZREuWR7wePK90njNPREs_5Ri04znGTW0giqoc29Af3OaX9He4zb1v7PkE
Message-ID: <CAHcPAXTDE-X28xU2ngUASXQdgrQdOAffSh1qYbPgS98u3mSKOA@mail.gmail.com>
Subject: NULL pointer dereference in apparmor's profile_transition v6.12
To: stable@vger.kernel.org
Cc: john.johansen@canonical.com
Content-Type: text/plain; charset="UTF-8"

Hello,

with v6.12 we encountered a kernel BUG (panic on our systems) that is
caused by a NULL pointer dereference inside the apparmor's
profile_transition code. I've contacted John Johansen as the
maintainer for the apparmor system, and he pointed me to 17d0d04f3c99
as a fix for that issue. That commit has now landed in v6.13, would it
be possible to backport this to v6.12? Commit is

17d0d04f3c99 apparmor: allocate xmatch for nullpdb inside aa_alloc_null

Thanks,

Paul

