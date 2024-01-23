Return-Path: <stable+bounces-15510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DC838DAC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DA028A786
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC0A5A114;
	Tue, 23 Jan 2024 11:42:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9FC4BAA8
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010162; cv=none; b=azqffPXDfj8PzNmJZQyB1zVjDAojgBGou3otNF8hpLrw9C4TpQyew5xvi+BealAeTaJ7GsWXDcuzCl9YkqwuPlT6plU4Ce+dNAKkdxIi66Ath0aH1xcHTwz4J1oTe5WN5CL9WF1bAOmQuRA5z5jQDN1ZDELSAVVSAu98zwEKZQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010162; c=relaxed/simple;
	bh=+WGJO1ib0tpz/CsTjFUFgSIrmScGErLbxca++W88gh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sz4pZIe7QRehpphmE26iwz9nZ+1ojUyScqwhcTyBURYYEaamBrqiUQPu5xAYz1EqLFO2Uzwm5o2drWK8HV49ImQtOBBDty5Wro1N0yPoIm/cpVIHrG/eFlrYTS7mF5+V8G2rvtv39iXCK05i9KP1dCtp3JSjky9TwHdYsct/xEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb9d54575cso2933785b6e.2
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:42:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010160; x=1706614960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCJVEcyz2cVssa2KNCiknmKs1XLhxXVUcHhUVxONUMg=;
        b=OJeS/Qe1CCx8fAHiKAfqUWdlHmwlVDG6copmInZQxSsgwi6wrZoSsxiYTXVGivEEKh
         DeohUylguowEVJCaQMceUHFXmimWl+pVR16DzA1nRwl7A7p3pDmCl9chkP7w/qXajEXD
         xd3phPmGmv+T2qOUXB1yEr1LzmLYrtJeBdciV9H1EFSWhtSRE1ozim5sfm+oct/6vSEN
         7AYL1Cf/6MxmXNBMNgAGqI8kLinyd1GrDDgfqjKLJ/7oUJU9JK/hTi7j2QzlOA+c0EQh
         DkppI07ZBPpYS/3r2EdxTqDAOffxzeB7nr5GOFH9fYfi1K5iQ3KFwlvq0PkHqblIyp1+
         zlUw==
X-Gm-Message-State: AOJu0YyDS8Y+iZ0y4FrevEeOqAI3B4IO/szUUwy7Kib4UrVKwz7WKPOK
	6E+NJSsJc+qZiQQcB4G0nvaCkVR0nbbMMdBVavYUVuayrvsctMyr
X-Google-Smtp-Source: AGHT+IH9Wyp8Y1ndtyX90Lhu0YB1NPumP8A2HTLjLrolQk2Umma9JXCiNxIi7MFECufqcsjTuYdOmA==
X-Received: by 2002:a05:6808:1244:b0:3bd:252e:3339 with SMTP id o4-20020a056808124400b003bd252e3339mr6978956oiv.63.1706010160112;
        Tue, 23 Jan 2024 03:42:40 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id c20-20020aa781d4000000b006d9a6a9992dsm11405182pfn.123.2024.01.23.03.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:42:39 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 6.7.y 0/5] ksmbd: backport patches from 6.8-rc1
Date: Tue, 23 Jan 2024 20:42:23 +0900
Message-Id: <20240123114228.205260-1-linkinjeon@kernel.org>
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


