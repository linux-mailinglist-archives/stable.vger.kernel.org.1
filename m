Return-Path: <stable+bounces-7629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9541B817554
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 499101F24F57
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96673A1D5;
	Mon, 18 Dec 2023 15:35:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A651E3A1D4
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b436f6cb9so2338686a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913713; x=1703518513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iS23NdFYt++juEpBQaUY1PiPMPS1oSwdnng6yl8NxfI=;
        b=T9Ww2jL2OgGQSxgrbwj7BvxR+ADivs8StWRUsYMoeHhFGokvNKKLCTsMiKkHZWC+/W
         x0FH+HFqH/+nyLPSKnqMomppZ7FkOlad5QiaVli3l+aYTlu/PwKLSe2buYUYDO/sYH6s
         0AFeKW2Ly/bobgsstNlgarS0BgyPQvlAPiZDs5asUjHG2xIh/OxvmriJawTGZkoG8JCT
         YIHDZdClrkKWhR0d7fuAeBGYCY/vKgxDO/efhMMZZ9e6PYbJnLj1Evh7/sOaWcRyX4kf
         r3WRqOg17BRuiSA6y9uwz5Lfcoh0J+QhgiyLCXVhNBPfkP7Avs2kXga3xf207+Oyu3dE
         YThw==
X-Gm-Message-State: AOJu0Yybho+CTI9QE4EWeVpiQ54fOdJmIGfa/2a0FVymC3BUXAGVGOYk
	bO8+q/rFXG+ZVTz4/Xx6rn0=
X-Google-Smtp-Source: AGHT+IEoNkMBc7FxxC1EkCtFDeIIso48my80et7tOT7ihXBSGa+3DTJvz/pJkXd1d2F6aIQpVCKD0Q==
X-Received: by 2002:a17:90b:1d02:b0:28b:3bb9:ddf6 with SMTP id on2-20020a17090b1d0200b0028b3bb9ddf6mr2318117pjb.88.1702913712419;
        Mon, 18 Dec 2023 07:35:12 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:11 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15.y 000/154] ksmbd backport patches for 5.15.y
Date: Tue, 19 Dec 2023 00:32:20 +0900
Message-Id: <20231218153454.8090-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset backport ksmbd patches between 5.16 and 6.7-rc5 kernel.
Bug fixes and CVE patches were not applied well due to clean-up and new
feautre patches. To facilitate backport, This patch-set included
clean-up patches and new feature patches of ksmbd for stable 5.15
kernel.

-- 
2.25.1


