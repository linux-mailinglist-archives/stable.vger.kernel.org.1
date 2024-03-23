Return-Path: <stable+bounces-28645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B64B88772D
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 07:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B455A1F22A99
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 06:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F9C53BE;
	Sat, 23 Mar 2024 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="N+9QMxOp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A225398
	for <stable@vger.kernel.org>; Sat, 23 Mar 2024 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711174633; cv=none; b=DspA7pXD+FpE0wjYTLMlPtxLwIcfjMhFzjLZoU/7oPIhWIaBTH9t+GruLBojlic8KJ5kH+A8klNlEH3UzECVQaips+e/IC1B6g5kek1iNxa/9A0q/V6lt5eAyHINm2hLp6DuPODYj9trMDrLbTlb+WyUtQiCYJ7AvyU08YWiPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711174633; c=relaxed/simple;
	bh=dqG0Z288zz1kSYusNKw5auggaqGEU0D07aewlJFuyP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJyO1/vXL+oIvSDAlwxm++lKmndAJnSoAgE1NCqbXJ5Dfa8KBu3xAYJRZvPSkR71nG7tc7CEB5ZHJS16B9Isz+/CZDLVLSIfUAprz2Pl78Vu1kUCwf0CoUL/jt57RjjvDEg9r2ky0MQ2GreKCWk2p0eKBSL+id88YCZEFi1TdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=N+9QMxOp; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42a029c8e62so21325641cf.1
        for <stable@vger.kernel.org>; Fri, 22 Mar 2024 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711174631; x=1711779431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUD52ht+HR3l3eedQqUGqKmwp+yFV4q4zkif3Vs2Vr0=;
        b=N+9QMxOpE0VJj9HzfPOcRHSV6xmUV/bor65C35aNwmZxESfBFPV0AEBi++5mqP0UmB
         9fTFz2RyhrPeotg95inB9669MVDiP7Uc6RyBIDyRdACUUdDBDCS1IACWuDrQG6OJwg8K
         5zTDiIkh+RT90TNKdnUwcubnQ5aW5R9nDtkS3/iXNpDX84mZnXry75hFWr+2VTzZyL2f
         i69Y5MNkTETI5j6z1Fo2rRNsNIx6jS9CfW34mwC8N7BThAbNyp5KJ/r2zQmPSSPJVbux
         PY/T6xp2SuiVh9uccdivjOvDkLw9o4BZLewGj3sK1HFXsOw4autrDA9e7Kv8bcBVyVP1
         Dlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711174631; x=1711779431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUD52ht+HR3l3eedQqUGqKmwp+yFV4q4zkif3Vs2Vr0=;
        b=PhxPjYXvNKmUpbsK3zT3a0muCI7UWGptfNg+Q/B+5e3PV4Cew3riPHN75uOP6iMHjt
         rOTjwsyMZ4clJAgJmV7fmwJaSk2CPKVzm5Fvr5agbzEKxMEQZ7gU/+zr1/8gdK9XxVKN
         SFJctVuyw1QBkhM39Fktm19oyRArHGBFPQJZpuhCCb2itvA7RuMe8uf1X0Alkuv0meor
         1c0LTnOG/skg+JhzkYlZjjATghWq6ET88+qY4TkaN6WwV8HJBMJJ7yPsb/e4/kNKTTKR
         URRW7omO+3VHJr9FjCdyR5uk7xCCD6pCgoAoY1XfDcnaGBwyFJQ3lUDnbOOshK4E/tak
         pNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWVRXQPoig3ytbElZorX4ODuXm6Y3orpZp9WQ9yaQPeYBZsRO19ITBstXAF+t/ulhYj9aNzQ24luHlWyWSlKQZIJ2F/hWJ
X-Gm-Message-State: AOJu0YzBq1awWw+r6beus9V0Djl2/Y6HAhKYVgeUiHYpMlv4zKe8wioM
	Gpa9+J5d5c9rLKn5hVgyvqGlF2UKfliVWrsKIVZyp5k9bMlsdsYqSHTt/zTK9yw=
X-Google-Smtp-Source: AGHT+IHsW+rCkfYvisR1ygy31z8BZc9G7J8m+4nL2/pwwjaGvRY/EyVRR4S6gmRAATdetLzbqae2KA==
X-Received: by 2002:ac8:7c47:0:b0:431:458a:8ea5 with SMTP id o7-20020ac87c47000000b00431458a8ea5mr220141qtv.55.1711174631036;
        Fri, 22 Mar 2024 23:17:11 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id bb40-20020a05622a1b2800b00431435c34b1sm196691qtb.60.2024.03.22.23.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 23:17:10 -0700 (PDT)
Message-ID: <25ecf18b-7533-410a-9b1f-6c11343b8565@draconx.ca>
Date: Sat, 23 Mar 2024 02:17:08 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: Select I/O-memory framebuffer ops for SBus
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, stable@vger.kernel.org,
 Javier Martinez Canillas <javierm@redhat.com>, deller@gmx.de
References: <20240322083005.24269-1-tzimmermann@suse.de>
 <877chu1r8s.fsf@minerva.mail-host-address-is-not-set>
From: Nick Bowler <nbowler@draconx.ca>
In-Reply-To: <877chu1r8s.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-22 06:43, Javier Martinez Canillas wrote:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
> 
>> Framebuffer I/O on the Sparc Sbus requires read/write helpers for
>> I/O memory. Select FB_IOMEM_FOPS accordingly.
>>
>> Reported-by: Nick Bowler <nbowler@draconx.ca>

Applied on top of 6.8 and the build is successful.

Thanks,
  Nick

