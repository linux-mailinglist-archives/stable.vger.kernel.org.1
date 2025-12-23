Return-Path: <stable+bounces-203266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D3CD81CC
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 06:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C90FA3016DE9
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 05:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AE62F2910;
	Tue, 23 Dec 2025 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTZEHlUN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF502DA76C
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766466339; cv=none; b=LrF42niIFuFzJpvbLngRRzW6HNfGAT3p36B7YBpfQfxr/oiLyeMfs/M/LnGf8XppJ79TzaEbDkf9O4OJVg1MfNQqkYgZ24HpMUJWPWVav+Vh6FPNMQSHWnOeEiXuS56mJ73W3C54IrtkhCY+YVAjSwCbCppt20c7OYdse/xfWrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766466339; c=relaxed/simple;
	bh=RieUY6Qi1xGapDDlOUiKSqVN3iI9rePab92e7LB55hw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=d8aE0N531SJXJk+G52hHaSVFYyAlPPbNNbvRZX9kBe6CNgmN0iKdBikgdqe0mt+WeODNHIcGrFIQ4jdehk+L2s1X9Ir1qwTYJ0JnM+GRGDvv0e8HqNuFLK1jFmqe5QYKID8XNC/NNaRqzbbRpSgjAwgorqXfJmhgE6SWe0MPrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTZEHlUN; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6446c2bbfe3so3715205d50.1
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 21:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766466337; x=1767071137; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RieUY6Qi1xGapDDlOUiKSqVN3iI9rePab92e7LB55hw=;
        b=gTZEHlUNwbPh/aNUxluHdzw7M95IOpDxkm1aVz3fKn1IPQps3WattCVoTUnY8F6+v1
         5w5FSzAtjX0uiruTGZ58KO/Jv1ErxZh3MAhQHNVqtMp6oMxCckF874C+V+vvjeb5ozb5
         zrZM0JT0DosLUUrMYF8WMXed0aQpJTOkIJRBJi9SGDl9J5EhzeMcRqLbP4PADrQuvEMv
         ek2N5tRzU9GIvAwSSPQp5V4vAsix/cZDwRL+EufXIVocevAxSmOBS+KMp4esOZVMRNFa
         WTgE/5Plr6ithwZg2eaPzI920ndYmKhiQqdrxSa/ZrB3K2aPdtXLZQioziIV1AEHz00R
         nnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766466337; x=1767071137;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RieUY6Qi1xGapDDlOUiKSqVN3iI9rePab92e7LB55hw=;
        b=txccyVJmepmb5KEvJ9KlaUr7h0PBVtO40pre6BxSvkeEwnTngHt4Y/Ldo6xFRbqPni
         P3yfi4DVdOgwyxB5KvRwgvBiMtpHCODy9V+553tMLeduA96PB8Pmp6LXtB6yQMWblL7I
         4AsJ79MgQq+atZLlO9vQOlHx5OUxHj1/riEnh859Q/W5qL1z0TJikKbXfv14wL7wBar6
         SjAlIu9tqzHSmg0ZBu+zHHB+alqEDdd6N6aHKBQ6R+PNF8FpP/hzcHJCLsKs80qM04v2
         KmQSqM5j3hnWKm/WU6j8i+0+PNa2ZZE6o3egmtJguoLtbiE5CgB/Bd1SKHbxvRkxrWFW
         u9Dg==
X-Gm-Message-State: AOJu0Yxp6WxddJJ8NwB74Y4WHARrWAGTJxI6/Eu2bhEP2KceQ91m+ZsF
	3uifVMvklXM/Py9ENKyls+QTSGxhUuFY8woNH082tgi0tsga/rr1zb4OY7WWo9Lr77uqGjWiXCp
	Pl6EYcOebMcz1KMqji/mug8WQ3JzjgJGCOvCM1g==
X-Gm-Gg: AY/fxX6jIpVHrlCh+lYqlwnhDR2sia0An7OB7VrW1b70yx0UxwfWfXtepWdg75W3aEI
	fjx0RI/ZXlCwRMWJT0/X0Vd+FMpbTQzcWYUEK17jvY2yA6mE1LD6h7g1ssQN4MBxMkUhZbX7VyP
	zdqoU2IZ18P2N5PFw/D0KmBxWnVSU7mHvfEnk2qCbzg09psuLrGcPyX/o8asbDsJEjpekY0mPRP
	AB1MdsHWdlmLM5m2FxhwWuqh94xP2RSb4j4MyvVvaCxZ3oYZGC1B3cndt1iyiQsQHfCyHE=
X-Google-Smtp-Source: AGHT+IGrDGuBoWwf4coyABhX/fP34Ls3x8DDjl+huGe0vI71VKxouBfSE81Dullt/xZyPtNgFHUPXkVv0EggEHRhKss=
X-Received: by 2002:a05:690e:1482:b0:63f:c019:23ee with SMTP id
 956f58d0204a3-6466a8415f4mr9857941d50.21.1766466336875; Mon, 22 Dec 2025
 21:05:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JP Dehollain <jpdehollain@gmail.com>
Date: Tue, 23 Dec 2025 16:05:24 +1100
X-Gm-Features: AQt7F2pr3D6lj6oIC0DzBUveK2F3vFlURKnj_1X9-tKVkEIb9HgLPceOvHDbc6A
Message-ID: <CAH1aAjJkf0iDxNPwPqXBUN2Bj7+KaRXCFxUOYx9yrrt2DCeE_g@mail.gmail.com>
Subject: Request to add mainline merged patch to stable kernels
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I recently used the patch misc: rtsx_pci: Add separate CD/WP pin
polarity reversal support with commit ID 807221d, to fix a bug causing
the cardreader driver to always load sd cards in read-only mode.
On the suggestion of the driver maintainer, I am requesting that this
patch be applied to all stable kernel versions, as it is currently
only applied to >=6.18.
Thanks,
JP

