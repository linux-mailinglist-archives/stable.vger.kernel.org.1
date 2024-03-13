Return-Path: <stable+bounces-28105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD187B490
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 23:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BFA1F22B23
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 22:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A759B56;
	Wed, 13 Mar 2024 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IhRzOSwJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953035D8E0
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370086; cv=none; b=JUjiiKgqh+V3cDclOPZth55k92C1yZF8/94+N4djxOBkXwx+QD+AneMf99TrEyJslCd58S2LhKlP957YfVfVmxM2ci4+8SnguTCL+MkG05WTxiaH8+MEPZ0RDgD/G7nXmdZZeXRkanPNkO1S9vTnIVsTqJjODXmIxOhsb0HS/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370086; c=relaxed/simple;
	bh=Qcv5mgZk55+R4lJ5qTIq+C/ubfmHU7AoFL5Ea8b+yZ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nrjSYTq6xUoDkrJ1NBb3JdS8cW3zxN9Oo4SgizpDchNSnCy7nmDKmYfXeZn4lFxyfVtqYdun2wDqKkW9mRyvi94cpoaawu7JFGeKUAgpqRyxZDtrFjPtdPUyvzwjP1KS/ww1zTkAaznrBR/gVADeiwX6M4+hEkPkEMA5pxa5L1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IhRzOSwJ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78831914027so17023485a.1
        for <stable@vger.kernel.org>; Wed, 13 Mar 2024 15:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710370083; x=1710974883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qcv5mgZk55+R4lJ5qTIq+C/ubfmHU7AoFL5Ea8b+yZ8=;
        b=IhRzOSwJVhZXkcm+nvYwb+XcQqpCqYXSWCXkGKWoHzYlEIG3UCgU836T1KdiOVbplc
         pRqz6Wq9uaQv23Ep/yiDBeeImhR9lL7VT4NQsEP/em4an9RFG96w6DCHBsBASOhgYfNZ
         X43YPugPCyKBfnfd7Nej+IPu0VVO3ErHueLvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710370083; x=1710974883;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qcv5mgZk55+R4lJ5qTIq+C/ubfmHU7AoFL5Ea8b+yZ8=;
        b=aACRijFnZhlgWBZv8g6nndDXALS7jSkHLS5Z/fCdvWgGxWKiQMdLBcGzZlJMZRkTVK
         dlu9ZeR+Pw38VAxqzMbV6mffvI6DK1v5mPT2N9mY9WehxZjIVFdmZW3gpBLLtO8wlHJE
         +GMcwArFRvyEzLyaF4JOguv4qh+CcrpuEyXZORsgNxaJIT154y8b9uSHJrwrGjZx25Gj
         ZQx8ZBS3DFlF/Q6vymMWnaCMt45wDYwkywg6AJ058+FvftCSmqLGgcuEGfJrtMaRrgIt
         53MACFrJihuoaPWoYwlVS8tP6PcSybP82V/sffPACVFESRve3rBbqfQsWrGO5DwIMAkq
         0Spw==
X-Gm-Message-State: AOJu0Yxj6unR2O11PT/L8DCHf084rpbkUac0+pa3zpuK9M1j5zEYUp1J
	1P9J1IO9Rb0H8UXoWWBIP+LoZECX9f4Nem0Y5yq1PFGGuAj8TSiC8XWf+VJlVGgWk5G2e6220Gs
	=
X-Google-Smtp-Source: AGHT+IH8Cc2/UkFCh50UBE65hEouhT0svDzZ5U5wuLDCwP9LaJuCfmX+Ug+T586vvnaQ1CJuDqlaWQ==
X-Received: by 2002:a05:620a:4483:b0:789:d018:9e1f with SMTP id x3-20020a05620a448300b00789d0189e1fmr170149qkp.35.1710370083386;
        Wed, 13 Mar 2024 15:48:03 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id g7-20020a05620a40c700b00787ce45ed49sm101223qko.67.2024.03.13.15.48.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:48:02 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43095dcbee6so103191cf.0
        for <stable@vger.kernel.org>; Wed, 13 Mar 2024 15:48:02 -0700 (PDT)
X-Received: by 2002:a05:622a:8119:b0:430:92ef:d9f0 with SMTP id
 jx25-20020a05622a811900b0043092efd9f0mr70473qtb.7.1710370082205; Wed, 13 Mar
 2024 15:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 13 Mar 2024 15:47:49 -0700
X-Gmail-Original-Message-ID: <CACGdZYKuwuC9yhvsZEx5HvsRt1yieyJpgojiFZssR7hQuTkaRA@mail.gmail.com>
Message-ID: <CACGdZYKuwuC9yhvsZEx5HvsRt1yieyJpgojiFZssR7hQuTkaRA@mail.gmail.com>
Subject: 2 md/raid fixes
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please take the following 2 commits from 6.5 to 6.1-LTS. They're
already present in 5.10, 5.15, but seemingly were missed from 6.1.
They apply cleanly and compile for me.

873f50ece41a ("md: fix data corruption for raid456 when reshape
restart while grow up")
010444623e7f ("md/raid10: prevent soft lockup while flush writes")

