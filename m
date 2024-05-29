Return-Path: <stable+bounces-47618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6618D324E
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 10:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A66C1F217A5
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F40167DA5;
	Wed, 29 May 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdAQONCw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F517167D92
	for <stable@vger.kernel.org>; Wed, 29 May 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972617; cv=none; b=Q2gkwwEvBMGWhCyIIiSMuSJk+a1UHaHWw4yEmPcIsR5Eh6trrHD7/zFJvK5MZremIbl82P/LHqlJ22PRnPp7jQZcemMM684BtqBx5SRNJFNeKG32Y/vUMExr1S1tygCYdQvIXqCQNUv81/6YlAvuGUt6XnonWAo9wGTrME6Mv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972617; c=relaxed/simple;
	bh=Jw43DxEHHLaMBRyPzhIh13jU7OM/CNi04Od4MHVUAz0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dH48OpTz8h6Mqm+8vzAHstAoBtPT+5QO/ZW195ppKV5+I+dTwEhOvJipvmfaOwcTvpIr4oHB0V0ZIAkz/5Wn1DLmHcjjqd75M3rCKAuXTzg+PXe7jG/1pbZTrNkdsugop08vrx/wbfPOER88phc0O3EpteWkNl1qfJdtgcxSIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdAQONCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFF7C2BD10
	for <stable@vger.kernel.org>; Wed, 29 May 2024 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716972617;
	bh=Jw43DxEHHLaMBRyPzhIh13jU7OM/CNi04Od4MHVUAz0=;
	h=From:Date:Subject:To:From;
	b=OdAQONCwr+JJ017u+Ae0lrePDmH6qfks3csBwQ3f7QvEWwWGAg054LZyj3+GqFWl+
	 I3ygv/8P3XhR1F0RwPhBAbhD3buZkQ2170bEDD+7Vx8GYFicZ2hJkz9UKehJHIzXHJ
	 smlO0g27egDTtUF0tCJ5Mh4LBbKNpKppFGKOMWYw80xGh1fO3x0iQJDwH4Yrj7IGaq
	 bdgAqUq5wu1hL89GDDhSrgOZrJ4v/1xdE1CykyHW5Dax9skExi1N1OuWBaEp66LNe9
	 8HDMZpig03NNBOyGESL2loGkqOelcCx/i169ZDx/18hznS+ZWvRrGI7wNjUcYeS75Q
	 z1o4OS88cl5gQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ae38957e8so464674e87.1
        for <stable@vger.kernel.org>; Wed, 29 May 2024 01:50:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhLkZYtwlXEtvr31oEc6YLR249895kv6wp1YnCMLJcvL27VizA
	SpNcWIs8gySNF28JCxRL4pIB847sxZVM5YT6XxebBmZHkfWTe8Ohy6Aa+pp7qiMhYRso6xGVmIj
	k8VPgU8hUhJz4rUbcXjHKt38kFpY=
X-Google-Smtp-Source: AGHT+IGkpBvcik818lRbsabmDizwd0XhuejnzOKgg/XVoUjm4jv5p8J+/dOLBSFR70/Lf13Hoyj8ij8muLeLl60vc48=
X-Received: by 2002:a05:651c:8b:b0:2ea:7f84:e842 with SMTP id
 38308e7fff4ca-2ea7f84ef1dmr1896931fa.40.1716972615233; Wed, 29 May 2024
 01:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 29 May 2024 10:50:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>
Message-ID: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>
Subject: backport request
To: "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please consider commit

15aa8fb852f995dd
x86/efistub: Omit physical KASLR when memory reservations exist

for backporting to v6.1 and later.

Thanks,
Ard.

