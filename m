Return-Path: <stable+bounces-41529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811BE8B3F09
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 20:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F4AB25097
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 18:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1016D9DF;
	Fri, 26 Apr 2024 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8pyZg+d"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F616C86A
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155154; cv=none; b=BDJMDCwiEPwZR51TdeILur1pzcThljCEGREaV31FERuBrw063P7YpjOf1UwnTTVC6f7rJHELaD8DK0WwaXChK1gCrtMtTw4mGvluzdzp73YsdRr9Wo4fC3JKAgmTz5mJyvm0WQDSuRUvimxE10uieXO5/w25CUttbO4jqax7ggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155154; c=relaxed/simple;
	bh=Kh8GfUhbaj+0ZGaApcAFU07YuBvcumc3DwGYXHPKN60=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ozr4AKKqpBlr6Em3DPdG0ofPPmkaVHblO9e6nNS8CwMakb2lX8uwNF655kfX1c3CYc6Mhn8pYSqaVThs/5LFnaqBGq3mGFOy0mZsRIMNFsVT9dgoIS3d+v5lNiyDn1N63THv3bmYghyUJycsCTrTEeNluhANWK8bZwRnPsXM5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p8pyZg+d; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de5acdb3838so984251276.1
        for <stable@vger.kernel.org>; Fri, 26 Apr 2024 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714155152; x=1714759952; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kh8GfUhbaj+0ZGaApcAFU07YuBvcumc3DwGYXHPKN60=;
        b=p8pyZg+dumzw/Ox7pYdGZtrlGs8sc/JFPLUyibrcwqbxg35HTVyG8bkPrEuP+aszzH
         XRqUFXiX3r1nNRAX8BBlHAD+pSVM6GowSVtDR19GvsEQWWOYQgkR9XKTzOP751/f0fMU
         cn41E1F6mUwj/KOTturApUsnJBgogT9KD433Q+GS0xNi+ueTqNAESxkZ4RGS85ZBz32g
         asbKOlr9o0feSt5uEudA+vIdWMRw/qxOlQuWC/SHQ54ipQQlfEdQQZqJmIAu4A84AP8m
         vVTteWaH+DV6OzuN9riyALT9yrN4q2PNNOgUCXu1oYxW26WMLuj/YSP1h6epzJn1bEc5
         p/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714155152; x=1714759952;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kh8GfUhbaj+0ZGaApcAFU07YuBvcumc3DwGYXHPKN60=;
        b=DDXmA74Fc8TULny5+1CuUySMWsICNiOlLCAKwYWWr0G/YM99XZ1wGVZTUGEYIGIXDD
         u9OZvFVCVlE+XJaZkVH28DjiUZQWXH6MVxdXATsjGuDnYWjFJ5KG1vmMgVJoZ6zBZPKz
         08U4OXU7e2reiR2ASoW4PVsKOPMmcT2W7r5Q8usBO9rqv9HsRkNA8ctzh+uHIqGlSOGt
         X/Cm2SCCD3GiKMC8egsSy/kMtqTej9Paekv8VcuTKVPxvKgFp/TVD0OeqB4/Jm7vCfvj
         ZN3in5ghhrvaeTX3qZL3kMQERiXA64X7NmxV2TR3/vSnmr9HeuwBlMj8o+UcxPmQ/god
         6FMg==
X-Gm-Message-State: AOJu0YxvZWWb+rLekaT1HavzLkgRlRPgt8XaaRabq3wCCLjKOMzNhMb0
	9FE9ErAZ0tRUgmn/uXzNO28FWzUSg4iCWvPLurhGZsYSyY0r6jUMuiehns7NEC3vBgqnszGhy3z
	pMEnyvY/wOuaGV8nhQW3yklzoiKT63UVrbKTj0gYtdQGwW+XaeAg=
X-Google-Smtp-Source: AGHT+IFXeFyKFccsslHC3aQr9GUpnW43p9KnAMyf6pgG2lsr4XZ5PIWbL/R5XrRUxy44oQqPYVfiUwV9eRWJUCGXV7g=
X-Received: by 2002:a25:7911:0:b0:de5:4edc:5b65 with SMTP id
 u17-20020a257911000000b00de54edc5b65mr2942045ybc.33.1714155151887; Fri, 26
 Apr 2024 11:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Terry Tritton <terry.tritton@linaro.org>
Date: Fri, 26 Apr 2024 19:12:21 +0100
Message-ID: <CABeuJB3YcaYHK=qcRbrr-QuU1-sduG3v+Xzg9b3fdAPVDDfyaA@mail.gmail.com>
Subject: Backport request for [PATCH 0/3] selftests/seccomp seccomp_bpf test fixes
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please backport the following fixes for selftest/seccomp.
I forgot to send the original patches to the stable list!
They resolve some edge cases in the testing.

commit 8e3c9f9f3a0742cd12b682a1766674253b33fcf0
selftests/seccomp: user_notification_addfd check nextfd is available

commit: 471dbc547612adeaa769e48498ef591c6c95a57a
selftests/seccomp: Change the syscall used in KILL_THREAD test

commit: ecaaa55c9fa5e8058445a8b891070b12208cdb6d
selftests/seccomp: Handle EINVAL on unshare(CLONE_NEWPID)

Please backport to 6.6 onwards.

Thanks,
Terry.

