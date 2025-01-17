Return-Path: <stable+bounces-109350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FCBA14E19
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 12:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0A61676BA
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 11:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916671FC7F0;
	Fri, 17 Jan 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogzXapfc"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB58A1F941A
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111691; cv=none; b=gXpSsZZHbyFOp+xe0WSBE4Ettn63kbvDwcQHR5pwvT7nl4UWZ9yNQ1NWMeLlw70IMmZEFeg8TeXcBm7/yKSx7d6It/21fC31iJ5GcPXlfrYmWh/trwbw59RIhMUTmAtFJzTWDSHBAZYjF28VMMI5kpAp6jiahQ2BUiphoN0mmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111691; c=relaxed/simple;
	bh=EHlUvjyfBpcQRy9CTmzwkImVHbb03jpmzzIX7+9vAgk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Whq8NWbBJex23p8lJFXroxpAdTT0GzMW6TE+8G6eYMePrw1+5hyRpjUbHM4+1pb8uAozE+GwbSpPSaVIg0CpZswO4x7KZ2AG2KaMtxaqkWH1duh2kqrMjVhZnECB8Wwim82B3CyR5zCXfnck4dnW3P1RLO7lrfxvy/hygkxl69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ogzXapfc; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e5787c3fcf8so3563314276.1
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 03:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737111688; x=1737716488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q8bu8Qc5PTElBy9ZnD9cLpUHEyM5ZFLwUTLMakrPf9c=;
        b=ogzXapfccKE5C4Q63n/9VQJYzwmlzOwWfRSlvN+o7igIQoVUpTS8MNsnuqU/NKmyZ7
         JnNMR9DqomudP2c1L1i9HnqOFbPp98Ptj+ohN9Bs2onfprpIHOXLy6wdGPGwz3gVTaUf
         MEDh3d/HTVRKCFJJo0f9yF/AW2sCQX5N05xOSNkRHuTqxroSeQiwtkG7/XSnO8hlo85G
         pDTi2W13MJgWZPSHt7Z+ytOOXhBTHjgnes4W+r59r27n7Zvke5KcQ+kHL6PKSF13AVkk
         x4vkL544HcuPGSYASiKm8JDTXc1FHAdG+wldmttBwgmbjGlhjAGv6g1HVUQdDwCQwYhJ
         n8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737111688; x=1737716488;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8bu8Qc5PTElBy9ZnD9cLpUHEyM5ZFLwUTLMakrPf9c=;
        b=gSJeY0w/u8n0dRPKsad8bBVISrj443aoR68b8sdyYY8gfkO2cvzJnahMP+KQMh2pgH
         RIduJa50SoDuwylI0bqTh6Mj5k3Uq6DRRus2Z+Wj0Q4Y0FCYEw6PIibmEmPg2uWFVO2Y
         gcDnFmb3D0gO0f4z3Bvc+87vqraEyB8qUixKfd7mILHa1kyaYr10j4qcBcw1QZ1hrPDe
         oDmgVomFjpSq+YaO9sdWYPyQ23Lwwdsgst+BWO+B7c0/Cn3qYk2cj3OTNCgycnKWxyeO
         oz1Q/4AR/Z9VRPEa7xwnu6x3DCZxYDMJgj2VTiEEo1DLAklwIBFMd6YSloYaiIcqq8pe
         7j/g==
X-Gm-Message-State: AOJu0YwsRdIMsrgU0dvqu9H54HKDdrGkdeXS8KopwH9eY1z1BZcuOjMf
	vLGBJuq/Of2fXLUCLhHvoCeKU2i0tX2O3I7L+9f0cbWFaAfH1CIq9kRyYfEOaIZzC9Ojm1Kjabb
	+4OdEYlQl1bDolz6UIwnN5AQB1mS3Ykyk6ob8lN7JFAk3uXxO7iE=
X-Gm-Gg: ASbGncsnNIh+58NWFK3xC1Pbl3l1BoewsyjsQfB3I776c7PUV31ivqrEwvvA7+dxzQW
	6Vlo/itmKBm2s29Qnlgc1o70aU9U1FuplphW5
X-Google-Smtp-Source: AGHT+IFakzgCgk21aw10lE64UpK4ukN6IJmWmU0+58/iRsf6IQu7oOl/D0C/udws3jtcC01zLGuWhi9Pu6ts/fKa1AA=
X-Received: by 2002:a05:690c:7084:b0:6ef:7f34:fe1f with SMTP id
 00721157ae682-6f6eb677dbfmr14680477b3.13.1737111688513; Fri, 17 Jan 2025
 03:01:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Terry Tritton <terry.tritton@linaro.org>
Date: Fri, 17 Jan 2025 11:01:17 +0000
X-Gm-Features: AbW1kvaJkFfAgjNr1dvbx7qgYtU_augH6JLXqRsJCDKX5s6FvMLcnUbtOUgS6yo
Message-ID: <CABeuJB2PdWVaP_8EUe34CJwoVRLuU8tMi6kVkWok5EAxwpiEHw@mail.gmail.com>
Subject: [REGRESSION] Cuttlefish boot issue on lts branches
To: stable <stable@vger.kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Daniel Verkamp <dverkamp@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi all,
We've seen a regression on several lts branches(at least 5.10,5.15,6.1) causing
boot issues on cuttlefish/crossvm android emulation on arm64.

The offending patch is:
    PCI: Use preserve_config in place of pci_flags

It looks like this patch was added to stable by AUTOSEL but without the other
3 patches in the series:
    https://lore.kernel.org/all/20240508174138.3630283-1-vidyas@nvidia.com/

Applying the missing patches resolves the issue but they do not apply cleanly.

Can we revert this patch on the lts branches?

