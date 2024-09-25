Return-Path: <stable+bounces-77343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DA9985C17
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BB41C24853
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B90188CD5;
	Wed, 25 Sep 2024 11:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EeBzfBTJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0037175D3A;
	Wed, 25 Sep 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265486; cv=none; b=aFZKsjrh32TU4+Nm4yG9E5h9q8661b4lfjOEUolyrVqRtY49hxwu71D0mqx84O1WBIPVQ0ZcKvgioy6xAPkrcwEqcw8/WnodyiVqAWXYX+q6F+oU+dw6WYdaJ6V5pqkKh1p5pmreiKYm+WpGU1EO2TGRku0Q0lt0By5dSKd/il4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265486; c=relaxed/simple;
	bh=MqTIcPv2wreLQE3sRuPmqeOCVAS2j8QpUl+LEEm4tcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHKg/a3jEOCUgsHv/NqwarwMLfVLPEg0xf/sq1AqUdu4pfp0+8dahmeyvxJLHjisc8J/rMDH4T8oVZZQfsxIdzJ0HAivmR+snruOeTalkXAHFH9kB2A8Y5fKGhA0NUAgTia4FbC/KdpufepONGZq6Vk53CIfUX4V+pW2wCtnl8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=EeBzfBTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D67C4CECD;
	Wed, 25 Sep 2024 11:58:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EeBzfBTJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727265483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqTIcPv2wreLQE3sRuPmqeOCVAS2j8QpUl+LEEm4tcg=;
	b=EeBzfBTJ+ITh6sX/NuexvuxAR5yN/i9p+ZrRu0+yHuhIE+twH/u/yju2SphvGwIDffUqB8
	tDtH7Xzvilzug0qY7/9f2/MRNAk/QGfMXeYPl84IAoJ9oM7wJM3uoXcLE4GPwfeNbK1DDn
	JcKn2v/PPjrwbs0ZmXF4G2gld6ns+fA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4ea3fbe4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Sep 2024 11:58:03 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-27ce4f37afeso2934774fac.0;
        Wed, 25 Sep 2024 04:58:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUs6/lDL5K6TCpSrd7pabLa9MSHH7g8jdWTMGrtpHp2zgzkjX0aBcxyNekXRNqYTLzrAfah9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4c2s03/QvoAzmyeOqftI9hBwhM1DS/qOFddyoyp2Xoy3oP517
	Mq+GrdPlUI3S+CVxe3pvvrp7lpY2RyI1Hxgh7wyF7eGDUqYPuphTY/IrICcXoLLvSU2YqrZav6O
	ZMwKrqftjWeV5ebVYjIvFaf/D2sc=
X-Google-Smtp-Source: AGHT+IGxIvGKqArXhhF632Oh/orpAmEfK2IA2kcdmHFIb+A7o8ZSTNFgTs6mycKZwfsvI7RzD05QedjIoJd06zCdqIE=
X-Received: by 2002:a05:6870:ac1f:b0:27b:5abb:7def with SMTP id
 586e51a60fabf-286e142bc36mr1766401fac.20.1727265481982; Wed, 25 Sep 2024
 04:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925113641.1297102-1-sashal@kernel.org> <20240925113641.1297102-229-sashal@kernel.org>
In-Reply-To: <20240925113641.1297102-229-sashal@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 25 Sep 2024 13:57:51 +0200
X-Gmail-Original-Message-ID: <CAHmME9rBzzi92f053MBi_xLTv52SqTGXFrreOdvZD0KgG3RkVA@mail.gmail.com>
Message-ID: <CAHmME9rBzzi92f053MBi_xLTv52SqTGXFrreOdvZD0KgG3RkVA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.11 229/244] random: vDSO: don't use 64-bit
 atomics on 32-bit architectures
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Thomas Gleixner <tglx@linutronix.de>, tytso@mit.edu, 
	luto@kernel.org, vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"

This is not stable material and I didn't mark it as such. Do not backport.

