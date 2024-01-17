Return-Path: <stable+bounces-11861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A647830ADC
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 17:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5581C243B1
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 16:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA542232D;
	Wed, 17 Jan 2024 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLav/nDT"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963981F176
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508200; cv=none; b=MMSGuD814mY2HopiXZqCz8uHIdMNQlUeBwBYn86o9zQ0/gp6mh4VVxKb6T+4yb0L+gZ3+Eqg9oVSbxDYbVgi75czO+/QLufYWmYIYwJ2lpxp6aKKBM+G4FUCaqOnSptq0p0TFGgRO889r/ac+ybgDDvVwfGGrvpEf+XTfXSsH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508200; c=relaxed/simple;
	bh=1ISyXaKvcBGkQehMclaDaLFtTFdr7RXzHLBwz1zhEEI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hB6+hcXITrm4Y7lacexMqLtVmgEy6LCSja5JJODiNYCGqZIsaxeD0Kxipl34O3INSUbmiPZnH7Uly+f+x1TNDKgeUdtIl1BDNK7f9bn26abNo92X8p1X48DCBHQE8h56BvENcX8ncFfeN4wC72huXlM7P1wymRWltInLdAjhmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLav/nDT; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-204f50f305cso7436106fac.3
        for <stable@vger.kernel.org>; Wed, 17 Jan 2024 08:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705508198; x=1706112998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ISyXaKvcBGkQehMclaDaLFtTFdr7RXzHLBwz1zhEEI=;
        b=QLav/nDTn7MbBzIbsPAdSg8ClkOGpYAOcmHXzYQAQVv799sOMf7lkqRcWGtyWeTJWQ
         hrC719aCUlMadM9UGYG5AAwjU/eIDU9J0/0Ria7WUfVj2Ofg6/Y7xQToZU5qyr+FFMuY
         q8bDbPbbeUcAIMPtchUPtXUy7FAz6/F1Z91aHgTyxzEnQDZtM9ePNakpLo0dB6vZg8HM
         UPf0P7SwoHfw9dSSsZEYyth4fvVRMzx+BHuOTOotQcBRiNkZhGwPBFBTEibW3niDsR7L
         Kjk1GtlVsl6+eq7pzGhnK6zUj72dIyHfyGa0TMGWeVC5klBhyVXVAw+taf13yKSGKcan
         9QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508198; x=1706112998;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ISyXaKvcBGkQehMclaDaLFtTFdr7RXzHLBwz1zhEEI=;
        b=bKNg9QWav9lxat3kQTQVgcqkB6FB5qQJc4j89Jh0y/8p8vXUDq83he9xM82BUV6w8i
         X/FCQxS39kJaiEa/8TEuAtbIDX5mT2wNTmuct2BClWzkXU1gejYo27lOrDW0xOI6zy8X
         5qaDrDc10hBTypzglf9QXU9mSAo1XIzPWh9FreDmASH+3OXiTeMjkTaB99G01Sro/NC6
         oY/cMBHpj1w79YPNE62LoeIJ4mFnIn9oPOn1FKeQKWrL9BVwmtOop13c00e3zWlENFDT
         Upca5eGCSDPjUJvv+/YDsM1g8d8NKCLnNIE9ar8Kl6gRpBe1AisskiHLCYRzJKaELnb9
         jgjQ==
X-Gm-Message-State: AOJu0Yy5sdSiWYiLusmf1TesZWyx33voEtTU0+4d1VdCToGWxyNgGrsO
	8J45Fy0pCFKxLW8FT4dPwwsQJrTjmyavbFwmPVQ=
X-Google-Smtp-Source: AGHT+IEA2xX2NMiJNqU7ct9iRYivoYBfrNw3di0A15BaQBn27DsYNSpDTbNAXXNuIB3BrOb6VBmEOV5R46pmB4zxZQU=
X-Received: by 2002:a05:6870:6188:b0:203:ec56:f0a2 with SMTP id
 a8-20020a056870618800b00203ec56f0a2mr11814299oah.44.1705508198594; Wed, 17
 Jan 2024 08:16:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jan 2024 11:16:27 -0500
Message-ID: <CADnq5_PCqgDS=2Gh3QScfhutgY4wf4hoS15fW5Ox-nziXWGnBg@mail.gmail.com>
Subject: drm/amd/display: Pass pwrseq inst for backlight and ABM
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	stable@vger.kernel.org
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please cherry pick upstream commit b17ef04bf3a4 ("drm/amd/display:
Pass pwrseq inst for backlight and ABM") to stable kernel 6.6.x and
newer.

This fixes broken backlight adjustment on some AMD platforms with eDP panels.

Thanks,

Alex

