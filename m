Return-Path: <stable+bounces-40352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3198ABE53
	for <lists+stable@lfdr.de>; Sun, 21 Apr 2024 03:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DEFB209FF
	for <lists+stable@lfdr.de>; Sun, 21 Apr 2024 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEC81870;
	Sun, 21 Apr 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwB++PyO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89138C
	for <stable@vger.kernel.org>; Sun, 21 Apr 2024 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713663660; cv=none; b=rtxAr5oCiu/b+zlLRQ4aHhJ0Q/m+/Jmwn0Ag5l2JEiMhmW/CsxjoL1DXMr+JieaHgJvoHzAbs/HGqSbk5FMkteu6PB1NrNafLCv4iTRg7hRyBv/IFcOTrZ3PQ1DDU9TWEa293C8xHlYtsewr/8CkUoWqdkmjz4n/knPcplCILgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713663660; c=relaxed/simple;
	bh=T5uWf7twLwo8Ntri9YXeOxms/gs4iKPrFheaNSzPWLU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gk/NcS5rrqwjufR2ipRrMO2q7S6ofiY9XFXksOX2oAlnfOt6BFmH7VFe/WfVPo5mABWnn30OJ6tpwQaQgg5NpyYfA/9p6UiVunsYrWzOiRqBBD72drWzZcRgMmx7tfDU+jPxIracPHV6NnBbtmm3HlOsqm717F1qnDRb93ekk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwB++PyO; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6ea1f98f3b9so1522391a34.1
        for <stable@vger.kernel.org>; Sat, 20 Apr 2024 18:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713663658; x=1714268458; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPPphxs1xThnbHTYw7OsnuXPgQeuz23xKFRMYDxQjME=;
        b=MwB++PyOJ63v4WKZ9BOvXfVP9BGrs9RFqUlaDK0AXGFt743xuaeQ5RcMp+V527HTrk
         ydl8b61lKFpnL24MaBppvXzxSVwCbSJ6mTHI57tfmRvjO7WyvuNcl1O6V9ME2yleYgp2
         RXE+j5DulIAoAQTXjM6e1R0Lp+5TvHnWx7Cy4bHkaGV9NUSvVElyFvp2rNymhkiBZI9R
         qFpdCfUUYl2MioBWpHH8hYGsAKfEsJw1s6Sy7m7siK8TRrldG2OQX1/YvAN5332AkfKA
         3yd+Uum69zE1vcq28PukveKUpBtM5HOLe1+wH6rxGl5AmsFRJ+IBpOBTEdNrhy4nVhqC
         c+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713663658; x=1714268458;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LPPphxs1xThnbHTYw7OsnuXPgQeuz23xKFRMYDxQjME=;
        b=ABy1XQippCskBcbK7mqYivH/LbNnqLnm4Z3pa+n13WAZWea9Wxs6/swCQKJg/TRQUh
         zi350ukUIUU1XNMl/itn8oO7kGdzafIAlPnSzGMhMp6l/0koLV7kAQaxZn01jt/CpeKq
         t2OCf2YCHc/5LOiMOLS/Vb6VCDRn8kA8WgYKF/Pnmxwjyu3LcNxPDKQXWK3vZpqMmU2+
         FrVrpyI1NzX/IWtfAvXP1hI/j2soXUUDEbtFCIcRNc6tynNfBKpoZEvfWb6Nib2Yd+R0
         YABvVmNXQ9mn/Yax3VBtZdM24D58hCCtja3U23Rg3SCUwB/E24edfDjmzCa6tIUQS12t
         F2Sg==
X-Gm-Message-State: AOJu0YxRRRQ3FT1SZfDA8zM2lZ+E9AiS9TTHJ54CHCwaukBP4ytnzPnt
	oemyaQItY3F6K8Scyqj0dXGIcyxQOlMN92prWaPEb9j4SCBaBqBz5g83VsmE
X-Google-Smtp-Source: AGHT+IHauy86yS7qmVrgfv18VMcIBONU/OCzfuSqvEwa6HOZDBh72LSPGDvaKoEWGwc6fodUdm6d+g==
X-Received: by 2002:a05:6830:1208:b0:6eb:8435:60 with SMTP id r8-20020a056830120800b006eb84350060mr7770082otp.24.1713663658136;
        Sat, 20 Apr 2024 18:40:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:70:f702:9c77:c230:a0ba:a1a1? ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
        by smtp.gmail.com with ESMTPSA id t23-20020a9d7f97000000b006ea1326606csm1227327otp.14.2024.04.20.18.40.57
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 18:40:57 -0700 (PDT)
Message-ID: <50fbb97f-41a6-435c-8900-450a8947d9b7@gmail.com>
Date: Sat, 20 Apr 2024 20:40:57 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Mario Limonciello <superm1@gmail.com>
Subject: Extend Framework 13 quirk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The Framework 13 quirk for s2idle got extended to cover another BIOS 
version very recently.

Can you please backport this to 6.6.y and later as well?

f609e7b1b49e ("platform/x86/amd/pmc: Extend Framework 13 quirk to more 
BIOSes")

Thanks,


