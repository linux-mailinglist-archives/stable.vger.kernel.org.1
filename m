Return-Path: <stable+bounces-65297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B3E945F25
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 16:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEF61F23EF3
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DADA1E4870;
	Fri,  2 Aug 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="hvvEoOcw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8161E3CC1
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607796; cv=none; b=QTgUlJAh2HcXqrMobQN1mIdEtB3DfCOQPtD16+gKDY+rAa/u/2idt3Bnub5h0t2RnRGnEZ1Jifp3Vfyz9EOMnW62+HZG9E1m/8jQVgNcaEYS20AWyS0Do9U0o09birStLjq8BKYcpU/0IaWUQhjrXMuiPVzl3IQeF6uVmHJkCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607796; c=relaxed/simple;
	bh=jra6L/B4CTlR2NFq72iJu0OwzQ7WlwjqarLHxFb+pDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLCe47mqIDnsJ7vSp2dCOdcSnhoKa60AI4FG8rOQxDCDadqSCiWWioNUgUibClxXAmak2tlJkNUNENVV/vxYW3vshyx85UInsCK4sk6Ucn7oo+CEfB3i+TjLsRz/s3utkOo+oSOJHzXfybGkjKBER0PW6DIEcRF9PwotLraUy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io; spf=pass smtp.mailfrom=foundries.io; dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b=hvvEoOcw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd70ba6a15so63824345ad.0
        for <stable@vger.kernel.org>; Fri, 02 Aug 2024 07:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1722607793; x=1723212593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onbQXwbvGRZtHxO8bwST8GBr/BQhg0G2IIchYZX1q78=;
        b=hvvEoOcwX/zdst73gFS59zfoB+WqikNASoQbHtrN+BZUbXurV8eiJNUWhCVa2nFvif
         cbDZ6uBXelwQEXEZOXmuQPceNZDnO52kbE7OeGnTVTreDZLaNyD/f0CRpSkvOmnVSifw
         lGFFzSdwAW1xSTJCtsbBkvk50gZs4B88CZxSO4iD8Qip1kfyk3zYMteTU9a4Ej+944rF
         ptQ5t2Nwki5F4glQo1p2/3Vs3YGneQO7YNJcDeO6ninUKdsRiSnqy4IXypk4TRh4U3LG
         gUMGxMuivNcEKMymQpIb0yWY+17P3qp7acEn9Bu96YfBkpP4yVd5IHlCKlMaR0X4ab8w
         NUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722607793; x=1723212593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onbQXwbvGRZtHxO8bwST8GBr/BQhg0G2IIchYZX1q78=;
        b=keGYSZxvJ5xuj5IY2BRiZA0dYcHMe3EEc1zUxFX6SlHl7AEHkAiJb8Nu/nZ7o4Mtfp
         V1vn6xvLv8kjXE1GUikkm8rDSVwJRLhstcHgAR2USfvDHbp2+TeRJ3wSoHJGePDmN+pD
         EnxFncaMZeAySllIyzluT5GvkDOMChimsW9UJkYIUFnKfqHpSfg0NBNHZURqUEfNl6zh
         k4a9GVNOw7ffzcDyy24Hbl/+X7NGq9utCVJNEKZo9GGTXEo0Eu4njX18zWGsUCs6WDyc
         YWJPE0H96gsSIzuyvapweR8kijrd4rST7E9tAraR9HQ6zWpgah5ikRHX6nUtyD7xGmeR
         TtcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXBDad3Abj5kR98Tlx85KmcCtCI7G5CME75YHLlO8gdQtQGYxSigF/oYqZAzAyyh44lOL3bWdSexVKPmrTQuO0HskOYr0H
X-Gm-Message-State: AOJu0YwHxh53pHHo2+WtC5raKDoNGm7jeYx9qF4fTvKh+BHOX8Wsq5fn
	xz9VYoKnwh2u3IiTqvNRh9sYd0gA+/CfJDol2eBC7ADcRvYCsNqdXGGp3PeGuJ8=
X-Google-Smtp-Source: AGHT+IEJePKCgDb4w8BqZv94T5BRKWH09KZwYwkz4+WJxDFtkiMmhdjqhfnHlzdRaLq/4m/TiEmvjQ==
X-Received: by 2002:a17:902:d505:b0:1ff:49a0:46b1 with SMTP id d9443c01a7336-1ff5722e7abmr49769725ad.6.1722607792834;
        Fri, 02 Aug 2024 07:09:52 -0700 (PDT)
Received: from lola.lan ([2804:14c:3beb:8e:e577:62c5:62db:a016])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f6093fsm17638875ad.114.2024.08.02.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 07:09:52 -0700 (PDT)
From: Daiane Angolini <daiane.angolini@foundries.io>
To: max.oss.09@gmail.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	max.krummenacher@toradex.com,
	stable@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	Daiane Angolini <daiane.angolini@foundries.io>
Subject: [PATCH] tty: vt: conmakehash: cope with abs_srctree no longer in env
Date: Fri,  2 Aug 2024 11:09:40 -0300
Message-Id: <20240802140940.68961-1-daiane.angolini@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725132056.9151-1-max.oss.09@gmail.com>
References: <20240725132056.9151-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> conmakehash uses getenv("abs_srctree") from the environment to strip
> the absolute path from the generated sources.
> However since commit e2bad142bb3d ("kbuild: unexport abs_srctree and
> abs_objtree") this environment variable no longer gets set.
> Instead use basename() to indicate the used file in a comment of the
> generated source file.
> 
> Fixes: 3bd85c6c97b2 ("tty: vt: conmakehash: Don't mention the full path of the input in output")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Tested-by: Daiane Angolini <daiane.angolini@foundries.io>


