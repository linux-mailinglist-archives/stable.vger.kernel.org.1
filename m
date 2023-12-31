Return-Path: <stable+bounces-9034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC38209F4
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB1CB21702
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B2617C2;
	Sun, 31 Dec 2023 07:13:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED4320E
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2044ecf7035so3720611fac.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006822; x=1704611622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnj/ywlPPIdiClG11Kqftl1wcjq71b04LFhY2rp1X7M=;
        b=RyCovkj5mpbMnN8wWc0NXZVXEIwAD25XYBJvQz5F4xd4JR4MZ3gMVsjNqgBEYUBGzE
         rXZ99kTw8mbHAaKFCtjIJGIbC2mFFQEnrUA6B5lEr+R5DGIjQadYpEkzff8L2Svf6IiW
         SsarBwHSU+Q8hUJwgg6Qo1chyD+XzECzdhk4XSWjZ6O+FBd01DKcLZL2Di3qwmjpzKaT
         0+B5RNyJTcldds36LIiTzL8ltwKAYOfxPR6OSoQWpYIQ9lXhR0p6SESO8kwpfEuR9SXr
         RbSKfFPXe3uGrwynDOULbw2W3Kin6ZYY6EV3ZXmPQIot6D5AlG4GkTDnMH1w5JUYXgea
         f+jA==
X-Gm-Message-State: AOJu0Yw2gDC5RdcO7sqGcvSG3RTDdHzT+u+w0TT2UuglK5aDqdGQvJ4k
	roWmGJNqAJIhkZE8dy6RNCY=
X-Google-Smtp-Source: AGHT+IH14d6kpmqmYW/lT0c3wzbrCVsY2Kx2qvQpjgtHzQl6B8qWrq02jhSD/jswHr44WfYj7fxlpA==
X-Received: by 2002:a05:6871:b0f:b0:203:a080:2d55 with SMTP id fq15-20020a0568710b0f00b00203a0802d55mr17485129oab.107.1704006822584;
        Sat, 30 Dec 2023 23:13:42 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:13:41 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.1.y 00/73] ksmbd backport patches for linux-6.1.y
Date: Sun, 31 Dec 2023 16:12:19 +0900
Message-Id: <20231231071332.31724-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset backport ksmbd patches between 6.1 and 6.7-rc5 kernel.
Bug fixes and CVE patches were not applied well due to clean-up and new
feautre patches. To facilitate backport, This patch-set included
clean-up patches and new feature patches of ksmbd for stable 6.1
kernel.

-- 
2.25.1


