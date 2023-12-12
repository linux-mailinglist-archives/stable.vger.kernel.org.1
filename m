Return-Path: <stable+bounces-6461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA2480F18B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 16:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A061F212C0
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1355C76DD1;
	Tue, 12 Dec 2023 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrMJbX0n"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E99EDB
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 07:54:39 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-334af3b3ddfso5406325f8f.3
        for <stable@vger.kernel.org>; Tue, 12 Dec 2023 07:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702396477; x=1703001277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X7YyC8Xl01NdnNvrr2I60Nfbd3bOJLaUs4NrIGIAPbQ=;
        b=JrMJbX0nRKK6PQjV6SbzFdOqmH78dxA3oxQTQmVeNTi/rAWtKNfPDXtN+MohtiuFBl
         0hnVXZwNJXQ4X4GFpd9tdW0aHabrS5blhdjGVsoXRoMpL9Vul3JGiTg2vN4PHGyFZwtp
         JaTb1u3O/p/f9fvfOLEvTT2DfeuX/qQ5uNU7MtwEHEdGSitcfWEeTlvj9J86wmvv0Pz3
         2/u92dzGo0rkpZ96htjy3qE87ukBuvUmPD+I1SqHbrCI4LEmn0gkeDrvgfWsQI8xuPB6
         qsgUnnN0nGdFeVLiJPT6aIVOdJJmavVA5TeoIeLhfJVR9+y3AJg2mQ2RdT0mUKgAPSkX
         DPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702396477; x=1703001277;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7YyC8Xl01NdnNvrr2I60Nfbd3bOJLaUs4NrIGIAPbQ=;
        b=rPa2LgE1jC5kQ/r9UcUaq6VrBKIMrEnQb7QAqkdyYICvfy++nD9J4e1eP3aZCEbqQP
         HMwZp7S1126QNfCW/ko6isL4kiFDE7x6nhNyLbUGa+rsJIghrTw9Cywn2rTusGBDAW6T
         QRusZ037Ws3s8r4+tFnyFEuNAbmlAsCH+zRBsCoEI28LMHBUquWDoeefFzqN8QDH/ZjX
         Lf8VM8K895WJt0PyIP9cbJ3sd1Ha08DSUxkvNXEXknbU656dkOZhv4vHQll7C0nVCZvU
         s5OHN6usOo0mSMMd/QEetSO+tS++B55w4MtvHmlXijcYKIi6DAdLxNYXteEFSPGLpuT/
         GIEQ==
X-Gm-Message-State: AOJu0YyJ6aOgYCof+UeQL8YEBU0eJQiyzWd2sulc3yv3dV3Hdl7tePO3
	7xumSDo+O9MXhMp+6BL4CPVIplbyXfkXUrQ3cEhpUICcZ4c=
X-Google-Smtp-Source: AGHT+IGEDUBffHNxghHY05vqJA1lVmh6Hubk7T0I7pMrASn1fsLZ+NBquw0gMB99kkJnCcqufHE5gytXL733lALQ888=
X-Received: by 2002:a5d:53c7:0:b0:334:b192:7e4 with SMTP id
 a7-20020a5d53c7000000b00334b19207e4mr3230892wrw.74.1702396477413; Tue, 12 Dec
 2023 07:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Arnab Bose <hirak99@gmail.com>
Date: Tue, 12 Dec 2023 21:24:26 +0530
Message-ID: <CAFdQku6FY_VXajL9GRH-OdUsqeAAY++_x3GAj=kZJ-b=dvvMKw@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: fix deadlock in nl80211_set_cqm_rssi (6.6.x)
To: leo@leolam.fr
Cc: gregkh@linuxfoundation.org, johannes.berg@intel.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tested-by: Arnab Bose <hirak99@gmail.com>

I have tested the patch and confirm that it fixes the regression.

