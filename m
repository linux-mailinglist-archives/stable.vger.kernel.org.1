Return-Path: <stable+bounces-119657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FFAA45D06
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 12:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3DB81895618
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A5B2153FD;
	Wed, 26 Feb 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2xnckHw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6A321504E;
	Wed, 26 Feb 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569243; cv=none; b=qgBpeiWBxxm62g3UVxn0Yn7/sEtHeIShY06aJYdc07On1wR6sQKjffOmnco4bEy30BaXi5UmVDBuPTUpj5s0DWG/fmak+yQTrm4Kcr0hl04SV3AJQPZyvT8IxI+wtcaUeYj9yctz2uwR+Nd5jGvYyC6/80RLhQBrQ/zsCbcTzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569243; c=relaxed/simple;
	bh=qwvqSfT1lFNy/9NdzeDks+gFqld8ltqBx1YYsUg/OBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fCCdyOBTDC4TEVy4+dVIvY8GgNxYeabK6wiZEnTlGCFZO50BXbVwL07fo17sRyzSmft2x5M1RWfgLiJtmm/vYUkLBOqurYpUMonAGnlDqTsLh62td37Po7Lb0UH6pxOjzl4wCyRVQig9IVNdwhW8SxyiDGV1SDpNbeS1K4q+eNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2xnckHw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso41360225e9.0;
        Wed, 26 Feb 2025 03:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740569240; x=1741174040; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qwvqSfT1lFNy/9NdzeDks+gFqld8ltqBx1YYsUg/OBk=;
        b=M2xnckHwhNrPbvZITddWFRF7oU0i3F1oJN8vdtrXkMNTn4dDn2a59hi45fuSuwuqZM
         dv4W/xZ0jd04ulOOdBLmPOU2rYXIT2xxNuIgISpYSPIWMEq9Y2m9M34vr/JBNUSaUIcn
         47iH7zI6/8aF8MVvGcO8Bzinh9WKISNN72Z/JAx+GYyMonZ8rQJsj+m1OG5RgEdNXPQS
         hum+oGlVC/iVd6eww9rtqwO9eJCHmGyWTtehYbW9rTNVq3L0QbTN9/DdQfR/tlMoXzY1
         VK7zfyXjX6PCU3M7Cxmeg02+XpEECF6L8pY067BGbX/cq4+2YEgxeJ8fgnlfYjPL9RRo
         pP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569240; x=1741174040;
        h=content-disposition:mime-version:reply-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwvqSfT1lFNy/9NdzeDks+gFqld8ltqBx1YYsUg/OBk=;
        b=rKS3rD0rFWbowrKM2geIzh1SaIFAIr6QjvRl2zLa4676gtrcbh4ZwN+J2Yg8TIlY1p
         pVMWrQiiIDzBaA+5Ymtgvzx8RGlTDxVkG0IdybMqbUNiWlivWmaGplA/55edAI7BruLW
         vK5/E1WCrPTd1a+AxvILQ0dEh5cHlULKrHCIW8bOFvuxwrBJKOgKwV/j/VlUR3QHVdMj
         y6fHHRPPisbo+ABCOnBWqVQ25RreVL6vhpt1eaAYtcDck4idBIa273evp6o7j59JNTgy
         Jq8JTjE2gEytR7i5qiBg+XX7qiY5WQjih7SI5Nge6G0JSc+v6pTmLSxGKBDdBVnn29Mf
         /DVA==
X-Forwarded-Encrypted: i=1; AJvYcCUDIwhAzarEj6ACj5i/fEgINUG7weQNfPq9zgGqjHoxlJmQC+1e/N991896hHyQ01JwoUo7CqGH@vger.kernel.org, AJvYcCVNIUtdG1kXJTpGs3wxadEadMRW8YorV+N/EpTwotr7ebaNIqoKVXdIiHxRx1GQZ0sE5GYX6Wji@vger.kernel.org, AJvYcCXGuXzqYhLrpov9WsEMrAPQXMndGw4KJ/MFySFT3GLW/lu8MNx0ohULp9TE0+Os21Z2zMYad7MdvgVEe1Y=@vger.kernel.org, AJvYcCXXqHEpojIhGWZuc6+SevBccMvv+5MyqPg/e6ZGcOI7UKixnQKKcDGkwMDGk98zij0sKisEV1r5AF+d@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsFiUzrG4XPImFe2jjru3u+29GejI3zKb9s1m7Ktq0+SjnIME
	hGkOKLXu2Ck0W8rAHUpvzwpZoDc9xSBJZxi2cR6ZUo7+fDtK5YmN
X-Gm-Gg: ASbGnctZBKeT/ALDal1YJD3clW4a4ZhGknb9OtCjFWsHxg7C7fGjxSLhW+vOJQyjb2X
	Jx9596D+IyZtMNsflR8GmsWNZMYYDtm6Sq1DjPIo8gEJFDmzNMpkTksbOE56SUhiiQ3G8hyxoj5
	O7rz17RzTP2Uuxs3RZe9vjYXEDZNCcw0qvA49/ie42Knaf6rKRGmx/SxDj4QJeqRX0acGrqK5SJ
	gjD2A+oFS4vnU3WAEQTfstSWTdaTZ1OzU5b8wWHf/b692+VgSJbayyvU9+hmE2X+xC4QYoif9tD
	uufXECSSnwJAXbaKHCmxCHwRqKen
X-Google-Smtp-Source: AGHT+IFKfUEsVvfSXYEsCwQADOJ2i91RasJteBc0xV5dUODflc4/l4UG2nuGlo6Fve6SSYO1wjpXEA==
X-Received: by 2002:adf:f511:0:b0:38f:2766:758d with SMTP id ffacd0b85a97d-390cc631000mr4428234f8f.37.1740569239771;
        Wed, 26 Feb 2025 03:27:19 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:4b1:eb67:8b45:9659])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390d6a32299sm1701605f8f.55.2025.02.26.03.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:27:19 -0800 (PST)
Date: Wed, 26 Feb 2025 11:27:12 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart()
Message-ID: <Z776kB1bbI48k9Cx@qasdev.system>
Reply-To: cf0d2929-d854-48ce-97eb-69747f0833f2@lunn.ch
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,

Just following up on my patch from Feb 18 regarding the uninitialised access fix in mii_nway_restart(). Any further feedback would be appreciated.

Thanks,
Qasim


