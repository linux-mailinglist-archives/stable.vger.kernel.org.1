Return-Path: <stable+bounces-9108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD1820A3E
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395341C21559
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BED17F4;
	Sun, 31 Dec 2023 07:19:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7D17C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5955a4a9b23so299326eaf.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007174; x=1704611974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L58jroX+sVodPsdzeHDru0t1Y2lDf+B3K8tsCAsVDZc=;
        b=P0cDuILnghI38QJojl0fQjAuEzDBC6eiZ/uofXQV7zNx8Dw0tFwDTAj60h8x+QE/iV
         2Za18gzbnhcrjQleMxQiasHBNbSNzUD664d1fOC3BNsuQq+D/Z2PLawW3/PYXLkQflm/
         6KItAyY/6xX2hrqUTdFCckaOclcN5HLRJNeKpvL9NsqjOoksHci6xoXpTf5aLFPji1Tn
         LuwAbaQ23dx1g5SCXEvIg9ocYyYL0uUuQ86RYQNI3ojblorxj2F8p63/MBJa6CsmFQQk
         3aecpXJT5TPJFHoNbqU1uaAF0mK7pHlG8KI9PpqovtTo2+jjr1BZW+G4DD/1BMuzfxWV
         qyHw==
X-Gm-Message-State: AOJu0Yy9HN+hmR8V6UXmUjNSuuA3K+OvvCZa3vZvj0ZReo/z0wIBgj6h
	XHmGf8P6sjeC0tn2aXgMfYTJPgKU8bs=
X-Google-Smtp-Source: AGHT+IG8QEX3G9s76njEGU+fTotCPbFKWosBs65Xalx5uyTcYLHGo0h5MenhYFKCeu6qA3al2Oa8Pg==
X-Received: by 2002:a05:6870:c113:b0:204:1d3e:954 with SMTP id f19-20020a056870c11300b002041d3e0954mr17894388oad.94.1704007174198;
        Sat, 30 Dec 2023 23:19:34 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id s16-20020a63f050000000b005b7dd356f75sm17425312pgj.32.2023.12.30.23.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:19:33 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.6.y 00/19] ksmbd backport patches for linux-6.6.y
Date: Sun, 31 Dec 2023 16:19:00 +0900
Message-Id: <20231231071919.32103-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset backport ksmbd patches between 6.6 and 6.7-rc5 kernel.
Bug fixes were not applied well due to clean-up and new feautre patches.
To facilitate backport, This patch-set included clean-up patches and
new feature patches of ksmbd for stable 6.6 kernel.

-- 
2.25.1


