Return-Path: <stable+bounces-15498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B567838D93
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B715F1F247DE
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918C45D749;
	Tue, 23 Jan 2024 11:39:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F05DF00
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009977; cv=none; b=CQp3KXwdy67zJDcVbrj5mmgindnV09PhNJOSnbbKxYrKOWfcNPFnm71mCwkr/dO7XkKX7HzgFdXiwiugbFd5fg6UO2aqWGrLt5JEE1m8ODO0FJ7z62PvnovkcUXFduQdfWcIC4JhitqfwZf+NohHQbyWMwnRdy6qP44xp7wSb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009977; c=relaxed/simple;
	bh=+WGJO1ib0tpz/CsTjFUFgSIrmScGErLbxca++W88gh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IyY936S5vlA0rMS7J6/A9QPBGRvIo2Lx3wvWml7rVl7URzkYF7h/kglacHZ2d1i4j94uJrN5MHgKE3+pmWecbORVxdlDETnJGMyPFVmFoRd4TummC7mbFcvCNP5XWDuN9oQIMaGyBn5No52M5gqj63cIEUL6hvHcscm7dmpvN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbb4806f67so3522694b6e.3
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706009975; x=1706614775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCJVEcyz2cVssa2KNCiknmKs1XLhxXVUcHhUVxONUMg=;
        b=cXVynp/fHAdaH8v4LCqBs+JSjjCBMrtmOajjisEk5YzdoeVc94GGVszeQnVwZqmwdP
         qGEzvjn8V4mkHZhd+zyQ5dJV3O9gFVolKWg6R/B2L0BLR3vUePjI9OKUkA9M+kyMCTqC
         Af13uW6+fZFQvPhOQ7A3UAjcRLuC77WGChBRnos9mQwo6SmNJ4+9eDKBUfB3AaGxP7dz
         GNX26r4IhMumTHNMTs7UDCyM58iIEGKwOBd4yHL76MDWeUOdMNznDk83nusKH/Nr81Lk
         4byFOvxJR3PKIOPKXZ3UD12fi0m4oSdvqzaVZNt2ZggZ78Ei9k3iqX5b3CbmgmGZe6kO
         ltXg==
X-Gm-Message-State: AOJu0YzB7RSfKqilGRrrCV2nYHWNRRlJVEZvzsSfZz1yORtUbzebk3Ff
	K7dfRCERj8GtHmFQMJM9ar8RCjLmjbkgcz3TskwsHsQLET40fjxN
X-Google-Smtp-Source: AGHT+IE/UiUoRfFu+oZbez0ENm1s/yDFqK8vE9vwXgmlZhYmtBjvOFEuW//qFGrzpPUGA0hb7i9sYQ==
X-Received: by 2002:a05:6870:b429:b0:210:811a:3376 with SMTP id x41-20020a056870b42900b00210811a3376mr1327318oap.61.1706009975103;
        Tue, 23 Jan 2024 03:39:35 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r13-20020a63d90d000000b005ce033f3b54sm10139779pgg.27.2024.01.23.03.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:39:33 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.1.y 0/5] ksmbd: backport patches from 6.8-rc1
Date: Tue, 23 Jan 2024 20:38:49 +0900
Message-Id: <20240123113854.194887-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is backport patches from 6.8-rc1.

-- 
2.25.1


