Return-Path: <stable+bounces-105111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E06F9F5E30
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 06:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013B47A256D
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 05:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E8155389;
	Wed, 18 Dec 2024 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="JFYp7mbH"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535B149C6A
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498366; cv=none; b=LZEGPTJPwqFoWjtgETFBqt2Jn1GUy9wIL98NwfdlnjVkIPVzd/yC0egwPJkJ52h08wUiG/XLBaxTsgsqIQKnsGeJ7l3l8SVaTgcvNcZq3OmgC1DLTZ3R4nZp7cyrVSvr3Bhd6NURNOUlNFjmKAlZIPzxsekRZTTYmPafdw656Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498366; c=relaxed/simple;
	bh=oTPuzqyItJv41NNiZ4ukdmIpmWpNMavGAl2ub/uht+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X91fL5QxQaDijFbDFiOQRF2dgnw44mdTJQuqs9wiaEfjuJkT5mrOfuXQqEJqckEESZs4Bl+4GcMUd4/5mdRcXdj+7t0xNdLAvHKrfPTJGO6Mf9EzqWexh/25IqqyIUON99WiqclHKQAujCBiliVQJ3Gs+ANOH5yHnms3QbsFfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=JFYp7mbH; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eba7784112so2371529b6e.2
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 21:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1734498363; x=1735103163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTPuzqyItJv41NNiZ4ukdmIpmWpNMavGAl2ub/uht+M=;
        b=JFYp7mbHZ2aP1DdPPeqd+9JetvvzVmjY2mrABcTyskYz+yX3jWLHWRraUOPUgImlB2
         TOV6QyTD467/HvmCQ3BlYi+i9Vc+ND+B7lXXf0K72m1q8Uf3QlKYpHSYCeRvEIJukQs8
         FNQQB7UliQRz3LeUZDjoahkeLW8KV9t/Ef4Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734498363; x=1735103163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTPuzqyItJv41NNiZ4ukdmIpmWpNMavGAl2ub/uht+M=;
        b=PvQyWTuu+8D/MLZ4nW+ELoLGTfMHWlRXsOnfP2rwKNkdgmdQY2nyfCWCdduL+IRl/M
         M7bZNrENQNJTQSo82vpiqjfPPjph3MtiETIukJ7yL0ZjMQTWNUC311Pv6sM/JJ9/SGj4
         ej2AHBtgfwyRwncR0p4KiMMYyDskmn3snvc963vUqbCxBHcFV0GX1/lIWdyAalj/UAto
         rz31o2rfUWH2kAdJE/TjHAQ62IEVKXXZ5j2OaXZZTqkOVAtxm8MUcBrkEq1bg2Z8JQbK
         IUJSNk9b+dx772KfW9hYrX5Y9VBk44bqVdV7iAL4+uQd4bOU1yvk7+9I78OynlD2DfT0
         NLkQ==
X-Gm-Message-State: AOJu0YzDIKAwt3VnqmxjjyFXnOsQF0t1G1V9tJyEoLTklG59KpepP1OL
	OvmbGJfuXnBVT8Sk1SYjD5P3Dg7PDkZMyWLDiLJqPO72SlytWkuL/VMHnSpXTD0dTkARfUm8rXl
	9D+Y7tVQjnxouwQWg1ppjxT2BCqZNYd4y0Dg4sDPlzwWXMKQgdtY=
X-Gm-Gg: ASbGncs7SYKOdlhiodDIGsddoB+MXEB106SzZ3BLSHwy9sA5P1HYPKIJr5yuZW3wdkh
	iPpDPq2Cb9A1R9N9XBg2S3tCQpoSvhCawPLEOAQ==
X-Google-Smtp-Source: AGHT+IFYSVcfe0gQcHXiMp1HzweGg5mWu3JZnVKDkld+qZa3RGAzkjQA6n8sBykLa9C+BYnanU1nNlNFoC5YX34o6c8=
X-Received: by 2002:a05:6808:1a21:b0:3e6:14a6:4288 with SMTP id
 5614622812f47-3eccc0b8e3dmr1064710b6e.11.1734498363385; Tue, 17 Dec 2024
 21:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH+zgeEVr3g23gtcbHtQnUpC5R2uDZ3T56wzx3g9cNnvOZ-+HA@mail.gmail.com>
 <2024121203-blinking-unblock-b85a@gregkh>
In-Reply-To: <2024121203-blinking-unblock-b85a@gregkh>
From: Hardik Gohil <hgohil@mvista.com>
Date: Wed, 18 Dec 2024 10:35:51 +0530
Message-ID: <CAH+zgeE8Afr6EQTR3iYNnY9ESPcQWEW0nsGE4cAQsj-X_Jn2WQ@mail.gmail.com>
Subject: Re: request to backport this patch to v6.6 stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 2:07=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> It does not apply cleanly at all, so obviously you didn't even test that
> this worked :(
>
> {sigh}

The dependency patch for this fix is
fb6e30a72539ce28c1323aef4190d35aac106f6f (net: ethtool: pass a pointer
to parameters to get/set_rxfh ethtool ops)

