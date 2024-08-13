Return-Path: <stable+bounces-67527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58226950B73
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 19:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3581F23D2D
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC5F1A2562;
	Tue, 13 Aug 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hTkiLZHz"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53A1A08D1
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570146; cv=none; b=Dxj9sli/u0iawCsiaS/AAnNaEgHnZrihcQi9AlMyX1YMAQONRa3yit9kUkcRy2sLnDJq9DYFYcOK2OiCkNAXkCxpKT9ob5TSmMe+s12pDduYrpLqC41Xrt15HvfycIO7Afgj8z4aOCJ4ueenh9+896aJz1OMXbSJBwNPK4lc1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570146; c=relaxed/simple;
	bh=Ej+GIAFDY3dY5obu8h1MJ+YQlppurY/RE+HmFZP3aEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqzCuBQhlIvIUuxIROVLo1YuXE27gRLJ221TeiFRIpkPxoVaaVbziyorG7TDYBGVrvUywFjCrEdN36/Z1rokhCmIApKcWDUEwh+3PY/QEtv2jmrHUkBhMgLcV3FFmK6cZFVh1EZ4BY1jWcfySIOhV08vk7JXPXUKUTkwnPGC8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hTkiLZHz; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e0885b4f1d5so5489689276.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723570144; x=1724174944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej+GIAFDY3dY5obu8h1MJ+YQlppurY/RE+HmFZP3aEE=;
        b=hTkiLZHzpDBYvmUYdNVjCv11mrYeVaUCNoWy5sbwxWHiB5qYVoXNuipktK0E+goQNL
         AqhXmAgq768YuwtKQuIEUj7FTxQgguoDD9bhpmt7FJ/+0RedqXCa1aEn7NS8Rh1lB08b
         6IVb+wTm6ProOqCDUPSXGgF49VDu8qZF+O0+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570144; x=1724174944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ej+GIAFDY3dY5obu8h1MJ+YQlppurY/RE+HmFZP3aEE=;
        b=HIzT5P1hVOzmeuuXsJOiiWCwBi/70BAc/6hUQtFWMnOIHktpCPRzw9pW6NPy6reUYN
         5YP+y4aTlRApr1sHwQ14h1Zhnw1WOn0S0X8LaEaFIuJJGqUAnlrUMkDIgN9fKtgztxE9
         uwNoBirUPHVZKqV7BBOHbcAo/BM+focxIyROZ9cOSpL0+a8lT+l6MifuUeD3+cKVvP79
         YbhMv9Q2a65viKHBOJ6KiELEkhPIIB+dFOBVmGx508NcTf1YDFdv1G4vwmls8aaHPzCI
         UAZl5xsLDqW+wYu2WBVT/1P4fnbPxNc7c1bu6KG2P3Yaia7btKy3lSKfeMBimOJHMdly
         XwOA==
X-Forwarded-Encrypted: i=1; AJvYcCVz7dyVpyt+QN+1O6d6fhB/ffQbf03xjTlq6ymXwcR7PxVCU6VFf1MoBp30oVvM3xxmN+0d/Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFxNvhfy98Wl4AnNwf0Y0R+XbGQtV8QR2TdMlc4kWzYgs4SJL2
	Z3D0jgmm6fbdihTf8DztBk0F0kIEPwvsDrmyRywgsoGIviAKTzZUZaXH3aOfhHW2p2W+3fm1Qb0
	ppdrBYcPagDb+oii55sWeqm6lLovlqWWlF2GQ
X-Google-Smtp-Source: AGHT+IHtrAKscoNgDYs1RSalf0ZqMoV624z1vbcAIXUiHI4BaHdw7buCdg+GUUA8SXKs8Lwbxf0UH82SeLhVTjvI8fU=
X-Received: by 2002:a05:6902:13cd:b0:e0d:19bf:329a with SMTP id
 3f1490d57ef6-e1155b84263mr286036276.41.1723570144264; Tue, 13 Aug 2024
 10:29:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801175548.17185-1-zack.rusin@broadcom.com>
In-Reply-To: <20240801175548.17185-1-zack.rusin@broadcom.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Tue, 13 Aug 2024 12:28:55 -0500
Message-ID: <CAO6MGtg7MJ8fujgkA5vEk5gU9vdxV3pzO9X2jrraqHcAnOJOZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vmwgfx: Prevent unmapping active read buffers
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, martin.krastev@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove `busy_places` now that it's unused. There's also probably a
better place to put `map_count` in the struct layout to avoid false
sharing with `cpu_writers`. I'd repack the whole struct if we're going
to be adding and removing fields.

