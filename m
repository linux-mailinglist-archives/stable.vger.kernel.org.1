Return-Path: <stable+bounces-35467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3389441D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244DF1F27E66
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FADB4AEE0;
	Mon,  1 Apr 2024 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="soVMMZ/1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DA8F5C
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991807; cv=none; b=DbtgV3Q1gVjfHgCYzB7oyfic3wzUjHqyyfM2ZSnDWUsc/IF4VqbjwJxk6fDkg744OjARB9F6FPCkOEgvqP6P0Gl9tarYGKFIv0JMWNtnSbbUuEJ1Nmm/diA2X0UOt9Eeeq/TP4x1wrirY+ZFusbofFXoudXpys3RfqlPIs37Zvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991807; c=relaxed/simple;
	bh=nyE92QsmSijPAgW5fCXN9A/NNpgraYl0b7qLIoQqZGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvuC960sv8+WJtBuZ0vdihNE9PxfLHDGRpsHsn2ogT6FDCoXOG3rig2JHKLyifLfhNWFLkggYUJKBm3zEic/t5HhCEMWxIqaijYS7eZShMevr9ZhXbZ+0oif8QUQvqk8r+136prltaMIC6o1Yldyyo+HTlneTI/ix4uxZmK8cv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=soVMMZ/1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e21ddc1911so484565ad.0
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711991805; x=1712596605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fa5EnP8W2aS/t4kiCQUSns+zPxCGVmzWOLF7r3sV1I=;
        b=soVMMZ/1pdp4QrhtRD5jBLNatC6s1ARt9C2og4LbULl7H333Jh24MWxRG4BuFjPlH/
         mejNUVcz/BFqMCdKgd1n6W5aJMePuJp06YbxF7/P9NgJyphEGkBYAGnnOgYAeyuzHOhA
         dsX9m3Tc0CRmCxiMe664DgTPKw0fYoclknz+gxKwqpR+LnOI2xBk9YNBrxGfcU9HPlgH
         xlqP8hWsqLiffVdwb2E9qNe37x65mp3SGOp/gHO0jhIo6ztQ506Rkrh5x8uqdvDqimqb
         pFPKJzHjDBw5ZUmiRHgj3MeqGEs81kpua1YaT/1oYFBbxKTh7IQkpLtZIBqDqP34FTU0
         HhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711991805; x=1712596605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fa5EnP8W2aS/t4kiCQUSns+zPxCGVmzWOLF7r3sV1I=;
        b=Yl/zwunP67sB6t0DoGscQrqrzasBQG3Zd+lEo9XLGoeWAul+dpo6f6r6U1WeO8xerH
         fHHs8z2hDOfQ9eOhdIZw8HoYv8pWSbACBRZspJEzJ8HBKZVxeP1s+Eq0mqWLz3n5cP/9
         HjFw6Bw2l53jt4COuswQ4TCWJg+4UJjSyRCch6KkFnyKtlP3XPPvTx+/V6DRtsJs4SPZ
         ZlsZFyXbTINTP1/ZRZUlK/m8I77Sb3jc5pNtW9M9yw7awNQY+vMswMCfNaSoYZVUu0Jp
         oPTJ1JzJ4yS05ZMJDqp5UsGg1npkqO/R69zGlheZABTFhBgO8iafalZQUjCX+wTyJ/q8
         LPNg==
X-Gm-Message-State: AOJu0Yz2lCpbwUNXMEFkTCwrBT7a0YNO5cCCbXu5jJ6iZ4huJiHFXuTL
	HboqmlmWLTWzlbxfxxw43J4XvPr97TrBMC7a0aE8H84DOTGNfR8m/dFk2OJlow9h05ZRkjzgkD1
	l7Q8Rdq2AF3UnlvcNbiWSNtGSGTC5fBtG29/g
X-Google-Smtp-Source: AGHT+IE3REtGqUHfJ4mA1gZLLDUMjjmkJZI7+58PEHx6u5kucIfNx6BoHW88vb4OIl85YrjTFIpJvVtYZ4TCoio83eg=
X-Received: by 2002:a17:902:b193:b0:1e2:1955:1b1c with SMTP id
 s19-20020a170902b19300b001e219551b1cmr544750plr.27.1711991804957; Mon, 01 Apr
 2024 10:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152553.125349965@linuxfoundation.org> <20240401152601.112837269@linuxfoundation.org>
In-Reply-To: <20240401152601.112837269@linuxfoundation.org>
From: Peter Collingbourne <pcc@google.com>
Date: Mon, 1 Apr 2024 10:16:30 -0700
Message-ID: <CAMn1gO6XMjbn7o63JiHyLrf_z0AFW69LZ_RcxG=1DWw9KttWGg@mail.gmail.com>
Subject: Re: [PATCH 6.7 267/432] serial: 8250_dw: Do not reclock if already at
 correct rate
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 9:25=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.7-stable review patch.  If anyone has any objections, please let me kno=
w.

Hi Greg,

This patch is being reverted for now, so it shouldn't go into any
stable branches (I see that you sent similar messages for 6.6 and
6.1).

Peter

