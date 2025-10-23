Return-Path: <stable+bounces-189165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 914D9C03253
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 21:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32DB3AD18D
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47F34B433;
	Thu, 23 Oct 2025 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cJ7tAcIK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E634C98F
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761246706; cv=none; b=gAQAmlCjhGrwFmlQj3ptjbXMF02Fh2EIF7eqWtlsjR4hqubf4m3OxyNyqNWqfbUzrxpDCOs5W6oJ6dB5Rpa2J40y98QsyIWoTC03fSRiXzHGfHS2/hyByETjUYU/e7jrecsHncF7uxf+9QMRLdwSOK3wZlrqi6Cvr6zL8Q8901U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761246706; c=relaxed/simple;
	bh=pttWRU7/dgK2UjwSiWEkHrJdOEDz6wX/zKzFjPVx6ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYnrLVNGWbtkpv6G5hapsFZSjqEk3wjQJFtQwQUDoCHWUjYZxcmJW6eMqgbfDw5QTlmSiC8E/spEsPwVmWuKIGuMyqzSZrpGgki2WRT6M3bvfQROwmbVXPpL6xauZrRm9dRqxii+aaV/1mu9c6BUmwGkYwUWdZ6yO4s7nAwl2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=cJ7tAcIK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710683a644so10156925e9.0
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1761246703; x=1761851503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YC021s3hSX0b6kL+FC7sXtMbVcQNzXKMZzcCBREO6dA=;
        b=cJ7tAcIKU89hjZAl1DbRa4SNrr4SpaI95dgst2LjXJdaLHW3Hif8Dew0Soi+H8+46G
         8krliozT5kjd/QtNDLM4RJl3lwybmTo7YVcvO7+/wP0OZMnTklPw12FP1G62FSxvj4qf
         IFye18Bz/vXXiXcAteoYXC8L8K4p/mpZJbBN2vT8m9DhTGPmeSfcYGsbJ/AjcWAQuQGd
         0lQIWNOMH7P8K+IwYrJOHLYCaucZAffWGyGpp+6rPTCIBWUQdWCCzY/gsRjnvFkonyvz
         x7kvdwkABDPg6+a3I3he2V8+kuIU9QYsAEI0HNFeZlmy/KxQEJ2D19ChakuXDd8rhDd/
         qFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761246703; x=1761851503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YC021s3hSX0b6kL+FC7sXtMbVcQNzXKMZzcCBREO6dA=;
        b=HS6laOXB70T0io0vhm8uR4BXyWOVgcro5tdVFp4SxaFKBuVaV4FM9WfDKFjSXxDKCl
         jRzHCZkUfVh9jhHf1eXfrU93eXSD+DZVJV1vt8lssjomRS5Nwi/GAxMOOr93Nl/z2esa
         4WD9atRHcZZCS0h7LkqULp/peHZZrIZ/tXKNbXAjOWaiCdco/8AB7m8oY7Yuuq9GhseC
         Y0FUq4OvRf5NFfLZDEiBuNBuWoUFKdjpQzq/XLPDN1v7br8cOjQNQdG767J8hbef5vOi
         NqKNGe45dOkxvQolVP1lh/YYzNgCvO1EnvSy2d8u9r88HOMNHQ4p6FeEzhulrneuRdIf
         o3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVZek4JzcIwMG7FI953EmNCpA3IO0hyNQ3/RdRauyRe5/mPD/YywEUI7kk5tgfBa2BABWf83zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc5z0wUhGF3ZTGN3IeYir/yDdpQ3N2VvXRCtYwyqRV6zVbtNac
	QB5c2xmP4PcyhWDwFnvkG+yyCGoBqrpyZF6qP3MrBuvI5GolnNLMGPI=
X-Gm-Gg: ASbGncuMUnzNjtTbIZDiY4mwEJF6B2TRXtsC4rA62o/gR56UbvdUh9vAe6HIYk7XMR5
	GaekEMOS/rps/XsMiXfULZff/oIFnuIBQSNEol/O6gHQiznRlRgzy3AzFIpgKRTF/s5eS3apD/L
	owE0ijXZXjT/JqTHpBNobQ92bLzW6DAS0m2Mu3nXZ8I/I6seMO6xoa+IM1/Cs16poz99W9c4eUO
	V8fvPXJoASf8bR9cE27l+I04OfyTMrWiB32SxGDCjDdV3auk8Exfyz9BZ+xOXzy/7vablpXnX5n
	JGxohpe3osquLWLNDRMJlBe99wbT7XwdAKViWzBcTpf3mOLQVcRPl1oOOq3QhppdEQfSl8lcFo3
	dk3SZie5sLXGJLkBFEV1ZtOzQoVEBvZ+3gMdqwZU+ORS0U8X/hTCZ7tGVeoCf2ilbPgkoqsETeu
	qlHcM33ZDb1ukD0sv1RjFdYspwF5K2EzMq7/eJRub+T9RQ6853w3LSL70oSQwHpas=
X-Google-Smtp-Source: AGHT+IFNsNEq2TdqKr0cvqPqFFbm5Iwue3LIAxDBLdoZa+wyAY95ssAJ4sXZtAPUqqOIfIkrYHRO3Q==
X-Received: by 2002:a05:600c:c3:b0:46f:cdfe:cd39 with SMTP id 5b1f17b1804b1-475c6f69890mr34045225e9.16.1761246702297;
        Thu, 23 Oct 2025 12:11:42 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4069.dip0.t-ipconnect.de. [91.43.64.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf15b10sm60824215e9.11.2025.10.23.12.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 12:11:41 -0700 (PDT)
Message-ID: <270ce9a3-5067-4ef8-9205-414b5667cf3a@googlemail.com>
Date: Thu, 23 Oct 2025 21:11:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION][BISECTED] Screen goes blank with ASpeed AST2300 in
 6.18-rc2
To: Thomas Zimmermann <tzimmermann@suse.de>, regressions@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 jfalempe@redhat.com, airlied@redhat.com, dianders@chromium.org,
 nbowler@draconx.ca, Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20251014084743.18242-1-tzimmermann@suse.de>
 <a40caf8e-58ad-4f9c-af7f-54f6f69c29bb@googlemail.com>
 <43992c88-3a3a-4855-9f46-27a7e5fdec2e@suse.de>
 <798ba37a-41d0-4953-b8f5-8fe6c00f8dd3@googlemail.com>
 <bf827c5c-c4dd-46f1-962d-3a8e2a0a7fdf@suse.de>
 <5f8fba3b-2ee1-4a02-9b41-e6e1de1a507a@googlemail.com>
 <e2462c92-4049-486b-92d7-e78aaec4b05d@suse.de>
 <3ca10b2e-fb9c-4495-9219-5e8537314751@googlemail.com>
 <329a9f97-dd66-49c2-bc42-470566d01539@suse.de>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <329a9f97-dd66-49c2-bc42-470566d01539@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Thomas,

Am 23.10.2025 um 14:46 schrieb Thomas Zimmermann:
[...]
> I've been able to reproduce the problem with an AST2300 test system. The attached patch fixes the problem for me. Can 
> you please test and report on the results?

Great! - this patch on top of 6.18-rc2 fixes the issue for me, too. Thanks very much for your effort!

Tested-by: Peter Schneider <pschneider1968@googlemail.com>

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

