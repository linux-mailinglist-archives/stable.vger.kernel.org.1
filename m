Return-Path: <stable+bounces-88256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29E9B21A3
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACCB1C20DA5
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A37E101;
	Mon, 28 Oct 2024 00:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV3OZtUf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C47BAEC
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730077179; cv=none; b=DdSXEIH0Uc12cnlFbq3tw11ts3vEI3mtI1umOwgIH0EkuMIqCDfnl47dVGr5mgYtScBaNwjWHYLhC8gBUwr8D3xhEWFFa5jfbjpOuZ19LJLTEDmfpLWuZH9oLAQhFpBZD0ffbfXRN6MV+qTnHuaZdZo5nzddQrIESZ/EtSbkr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730077179; c=relaxed/simple;
	bh=Hd5GLAXp3ye3/4TWLWX6baeNpv4+Vy8H+HoPL8mosOI=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=GsK2ZJqSQ2FhMB8n7yh4/KrAmvy4N/3fLa6Ap1ldKOxFGKz8N4eJoXV10cqvneKILafTVC0w8ksRbku402OY+UPs3FUxobQ/PocW1n8mttEi8579AE0L6QDaS6THsIKcoDgsa6Xu1kFqGo+X/9JufSC2dGaqyqOUlpHutDd0rDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV3OZtUf; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43169902057so37024955e9.0
        for <stable@vger.kernel.org>; Sun, 27 Oct 2024 17:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730077176; x=1730681976; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hd5GLAXp3ye3/4TWLWX6baeNpv4+Vy8H+HoPL8mosOI=;
        b=cV3OZtUftpy+rPMDkXB2zu1RCdHPBN6Zw4yZjZ/bvsGEX9tTp8EvRd1qwGtiCGUfNg
         thBiuemhI3bs7Ha5muN2cJJI4o9s5xNQnODdrsc9yxWTjdzrWVJl6Dta/AMPoaBCChNu
         f5ySwj+jcVKVG6ICyFeoJghNIz7hMOgcITHeCDy/DrCXZB9fbripI0bDa4Cg/Z7EEnve
         a8GtCSTBEeLL+VurZSWXaq4gJe6wQ29p20GX8s7ayaSU+OOpqMn/okyv75yugl/KFfts
         ST6KINg2DnORll7LK+vmCPzfQeq/7A+RX47adUQggmyJ+OZYn0i24ufjPXNs2FdriUsL
         j2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730077176; x=1730681976;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hd5GLAXp3ye3/4TWLWX6baeNpv4+Vy8H+HoPL8mosOI=;
        b=QRrDKrxEGVb7JTmRFMotTNyz129KWpEGasCuMuYuD616mLgd5NHcMlP/F1Ib+owfLr
         4ttt9T9fDomKqNdUOAUHJTcTNkIIGb8vY3SSX/lBuzL2dANESknCd4USdRtGaizKIl2w
         xLEhluKXF2pgyknkjIv8EgHScPch8KUQ3W+4T9lu7PdlMEOsRD8cOgEc8vsjE3SYPzfy
         TCszyahpOeQFD6kFdl8c7CZ/vKSFPgVjz2p4/DXV9NGqgpHZpt6RWcgQBmkAj/HF90Gn
         5Vsoc8PZVOPQeBKUjRvHtuhuQtZsjHV/jE3GtUZCBoppIZ0BoCjmT+ryCwKagGWV3Uov
         mSsg==
X-Gm-Message-State: AOJu0YwIUr/s4OHSfjeM4ep+tTECvevpj8kjBnoc5dU2Cuts3+JI/f4c
	hq5OCd5Q8C9r2WBMD6KRQe0g/1tFxsrfJCEMRuXpApV5vxStHLXDuijXhGzP
X-Google-Smtp-Source: AGHT+IF1svhSYRu54Z9Tjw6HPsB+9o/P/cCMDkWQhF2RqgTff/0JjaDlftuzaIzoY0+7i3cGfQF06w==
X-Received: by 2002:adf:fd44:0:b0:374:c4c2:fc23 with SMTP id ffacd0b85a97d-380611f7ee5mr4517448f8f.56.1730077175578;
        Sun, 27 Oct 2024 17:59:35 -0700 (PDT)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb629d2casm2713855a12.32.2024.10.27.17.59.33
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Oct 2024 17:59:34 -0700 (PDT)
From: Kelly Hall <rasheekcrowley278@gmail.com>
X-Google-Original-From: Kelly Hall <info@gmail.com>
Message-ID: <9a75ca08313df48456eee711b57d6ac18ccf33c32c0776e57ff477f8572cca0a@mx.google.com>
Reply-To: khallpb@outlook.com
To: stable@vger.kernel.org
Subject: Free Piano
Date: Sun, 27 Oct 2024 17:59:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello Dear,

I am giving away my late husband's Yamaha Piano to any instrument lover. Kindly let me know if you are interested or have someone who will be interested in the instrument.

Thank you,
K.Hall

