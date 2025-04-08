Return-Path: <stable+bounces-128818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2E9A7F402
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 07:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565BA1712F6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 05:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7F9223308;
	Tue,  8 Apr 2025 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgtXyY3r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716815A8;
	Tue,  8 Apr 2025 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744088931; cv=none; b=TcG9Svsq1NpnExPZ/peVTY4iz1AAT3MEedHvsAuJ1RJU4rCgX0N5D1kqQbLCT6ZvxWyR8MagyneGP5VO6GEM6kVDuHQhWnSDeVkYpnPQi9bq1FbNukM+ia8GwjtmcaaRHPxURx7aDbDr5HFsGBB6zz8gq+ffhYezfB+PiFiBmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744088931; c=relaxed/simple;
	bh=dCFVXM4MfrbSjUno3IMYIAuWzWR5SEzGsM9gbJlGky8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=L9gBZ202P3Iu+UdIDD885/BwGzJAwb9UgefZJWksHcMTDVTV2O9c44wkLgbI1cy29cGY4dvmsf1xJtPWbg/iJ4BbrXr2oOj4Os1ZxiKuxsnHMwtCJ7h9bYshaWNuyqZvFlMIexYGw77Iq+hY9LHeuaIQFxs1atUP+vyuaUiQ6as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgtXyY3r; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7369ce5d323so4016653b3a.1;
        Mon, 07 Apr 2025 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744088930; x=1744693730; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msd/d1ehfzc3JsJDzVJrH86yQ9NABRze3WH3qpDSmYY=;
        b=CgtXyY3raixh2clH8bli8QJpy/JslcaqX5dZATjlcFIxNfJcAilj4O/3qV19OZXuP6
         3BWpRjhvc1s5iRHINnLjcvbwPN/Vr4EwDg1RCAigrGVlSZYkRWEH8KFrWt2ymOnJAyGj
         J+/7MFN/UZYvkR5iw/KUDghfE2IYYNFtM6G4HcFPFGNeWKmBqy5eLmmZ1vFTKovus/3N
         Ns+HaNXTgRCux0/8fBW1gvRgrSiZnSBTxrpk82lqjTzuUuodWCOA0Ss09k3Tvbvub08p
         RuJKKzn+2Tj7a/NfiUIZdjJGuzoObmr5YG1HGZJczBCM/jA+L0vogna4OQ2irTWAT92w
         r0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744088930; x=1744693730;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=msd/d1ehfzc3JsJDzVJrH86yQ9NABRze3WH3qpDSmYY=;
        b=sPXl0Cd5yZRKqvjMzI2xqN4t32jQekMxkGLtowROT33kvALsZEOSPWdHF1eoTOyYro
         Rc9bwS9hWk1Ogl1hqb6YnMPnpMtnsZ70FPL5f4iCf+V0uF7DWkgl9tBDYJkQULiZEGa5
         N67lUyEyjGAedWF/6NugwsneEaWm7AxXeGOnfOPiT6JSijM85PvujWP1wwA7jeleDx9O
         IVR1EFw5LV/YpfHTAqHYVk7ePnAGm4BJOL406wnL9qMihm8Bn5CJPTYQNtaJ3e0dz0Zg
         Wdfmqlq4Ez2AAp+RZV/VHCfLS0TEnY+wItucbgZtMbgm8565TIaSy7N3ugYXSG7AQU5I
         izYg==
X-Forwarded-Encrypted: i=1; AJvYcCU7hefeHhx72U4DPdfKLK3Ri8y2fPojsgCtLjX90ADq1BfPwB9aBZG5ibyMsM4YTYNHkcN4syUA@vger.kernel.org, AJvYcCUGwbDF76yf6f3/vgfs8eLvY2qSft0Cm4OjFzY88nuNVZgBXywmlxvuzhmw1q+IpR/XrkWrfBqPf2OR8kI=@vger.kernel.org, AJvYcCUM6gjif6+zEJOq5+A+yrOLd4rP4EYi1GKrRZeG6j0wlyzTKy/qCfNpawfNQsPrmgivtH7XqrM8FY9kwypvz6H2IsOS/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYgug/a42dicfJCaWW1utSaH/P1bLb6Xnemviw1TuLN9uORYrq
	P3CYlZ3CF2ResqCXetJtkk9GdlE39CDhTMW8P0vJ2A3XKjzatPZN
X-Gm-Gg: ASbGncui/S4isNXnuJB2qpQM2f4qv03dF1SQ+VgmnyuNt+w/jIz67sXiQ8uOEXOnG32
	Nwsmz0ff/hMml8eIgBJ3wbSftQQFQBjLRA5sDO6Q5nhby8xPZguXVE0G4iQ9re3rWTdefvhB1+Z
	Pc+krZIJkx4ISh/aXMA5ENgOFJBHqv89p7F2a61x/isqeJOxnvTd4jeSLstJWVngkChpirjV8RP
	jtoHm1cDuqlNqt5xPkFotfHaLD4jGG0XLxyE/9S4a2WTmhb2eJh+RWSOsOflGETps2nv+h+0347
	F8Pw4ZmgQOYZdyTxyGKLPy14qwcr5CCGzG0pEg==
X-Google-Smtp-Source: AGHT+IFMc8CTv5CM3QidabaC1+gT5QWZSr42z0RwSRQhSmgrztIdQxQEbgnOQHx7t1YCG0VrCQGQGA==
X-Received: by 2002:a05:6a00:1411:b0:732:5164:3cc with SMTP id d2e1a72fcca58-739e711fcf5mr19489473b3a.19.1744088929480;
        Mon, 07 Apr 2025 22:08:49 -0700 (PDT)
Received: from localhost ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d1b87sm9871932b3a.16.2025.04.07.22.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 22:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Apr 2025 02:08:45 -0300
Message-Id: <D90ZXBE1FIMF.2DV3D7QERNFMR@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Wentao Liang" <vulab@iscas.ac.cn>, <hmh@hmh.eng.br>,
 <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>
Cc: <ibm-acpi-devel@lists.sourceforge.net>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3] platform/x86: thinkpad-acpi: Add error check for
 tpacpi_check_quirks
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250408013950.2634-1-vulab@iscas.ac.cn>
In-Reply-To: <20250408013950.2634-1-vulab@iscas.ac.cn>

Hi Wentao,

On Mon Apr 7, 2025 at 10:39 PM -03, Wentao Liang wrote:
> In tpacpi_battery_init(), the return value of tpacpi_check_quirks() needs
> to be checked. The battery should not be hooked if there is no matched
> battery information in quirk table.

Why is this the case? What problem is this fixing?

It seems only a few devices are listed in battery_quirk_table, and the
comment above it suggests it is just a fixup:

	/*
	 * Individual addressing is broken on models that expose the
	 * primary battery as BAT1.
	 */

Furthermore, I looked at uses of this quirk in the code and it's absence
doesn't seem critical.

>
> Add an error check and return -ENODEV immediately if the device fail
> the check.

I bring this up because it has the potential to cause a regression on a
lot of devices.

--=20
 ~ Kurt

