Return-Path: <stable+bounces-15478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7088283865F
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 05:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DD6B231E5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 04:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6E1C3E;
	Tue, 23 Jan 2024 04:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mkp1FnRq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78E7E6
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705984853; cv=none; b=fZhxDhWEcoDVL1y7qpDZ1xwoS4us2F+r6onBMnm7tnJj5TPVoKFkhZNxZKCdyeRJbEVVswDqxm47ch6GrLjlQtIxWA8aS0eldWp6m/3AcXZTcYdXLNmJJmBkhLpRvRRjbrh0XldPJqAxi6Z50B2qSynkjUBPCqRHHYC+PHKETXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705984853; c=relaxed/simple;
	bh=YOd0Xz8HUfT5xlx1WP8hP+JKoFmjh5aoSI7j96oW8i4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CRTJR13cH61ymCDcdkRzz7qRHhjLR5ByBReAJAOU4yU4DDjmh4XqwXcfUoy7ZzK8tgsSEwutinMVCFYB9qsZEjzY2NyMdEaWPETzf9qpD5r7qQj3yr/d5QsqQon+iFCTgEFjdWO2LKIgqAh28riocvYZT3So4X34ZcEVGG2FFsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mkp1FnRq; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6860ff3951aso14673736d6.1
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705984851; x=1706589651; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mJL/+SwQwpiuMOYdxWq9BpZVB2GgCdaKykGe+EXHzSw=;
        b=Mkp1FnRqG4F/Z3zBb8VezNvVYe9HmnDVti/gZEBNlw+tiUlqYCwwB9Tub7QZJHf3Ag
         98ib3gVDue0dKa+fVo5Ep+UczCaVMq3P/ynmi7hwB9HQflWlImi1EMSU7hNi6g4IM7PY
         w3Qzi+7WkoceHXJ/T78u3ButNDoMaZW0Br12A/9SgSHQUNg/RJTC6mr5ME73C0oNGcJa
         7aGV3FZ78gsxP+cYbGEf/2faI1Z/yNT/GEPbM3ZccX0q/nwUDaIVi9DwtotykRZg8Ze4
         /Mp8fP04FeASH72uT2vcBiJvM61wp43Y6vEUm74hGR+c08hau22nFIXNXljBIEZdgdkm
         bUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705984851; x=1706589651;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJL/+SwQwpiuMOYdxWq9BpZVB2GgCdaKykGe+EXHzSw=;
        b=hJ7W3Brk0Vgssug43BljOCevLkD+3ogkZoPRmz+KPOys0MQ1DV+tsBgUpb9PEJJ4qO
         c1KTI+7wqZJ1Fa/37P91qfLMEic3m9RUGBSRQCxzYgxZIwwhYBBArI8nFIlFPCZAdB2f
         +oOLz5CfSZ7mPE77SmWy35BzPnwFx1nl4yuv/L/+Z/81LMAZP1UF8jJ/9LRyv9zGjkq1
         efPHpCSUlgdzyReAY+c8gFG1Tm2p04VRxL/nJ4GN+kw8P7a5i6KrYazUJFtdccYDt19S
         PqqPW/+x1x51V4mGfrnMHykaLXL43XRRSI1D1iA7vvOxcZ1Qy1b6Y46DHTvTKBWqfAdj
         DurQ==
X-Gm-Message-State: AOJu0Yw4uMKGfmibhGh7upILwKwOYcJm9NcyOX52aUgJC1FbybNiHPzA
	YjYLkxylQOBfMswznoGf50NvPzRR9UiVpon+hDpreqgku3nbi6jN3xaQL6I1
X-Google-Smtp-Source: AGHT+IEccH9VvezrwqXv7iLjDCw+wdz+tSaIyaTqAV2PO5Gsb/7wZJZDqCZB3+UapLVR3YEFRxkBzg==
X-Received: by 2002:a05:6214:c8b:b0:685:f795:dfc2 with SMTP id r11-20020a0562140c8b00b00685f795dfc2mr421040qvr.86.1705984851150;
        Mon, 22 Jan 2024 20:40:51 -0800 (PST)
Received: from squish.no-ip.biz ([181.214.166.113])
        by smtp.gmail.com with ESMTPSA id h4-20020a0cf8c4000000b0068189522cd3sm3048642qvo.67.2024.01.22.20.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 20:40:50 -0800 (PST)
Received: by squish.no-ip.biz (Postfix, from userid 1000)
	id 2F730AA0B8; Mon, 22 Jan 2024 23:40:49 -0500 (EST)
Date: Mon, 22 Jan 2024 23:40:49 -0500
From: Paul Thompson <set48035@gmail.com>
To: regressions@lists.linux.dev
Cc: stable@vger.kernel.org
Subject: [REGRESSION] 6.6.10+ and 6.7+ kernels lock up early in init.
Message-ID: <Za9DUZoJbV0PYGN2@squish.home.loc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hi;

	With my longstanding configuration, kernels upto 6.6.9 work fine.
Kernels 6.6.1[0123] and 6.7.[01] all lock up in early (open-rc) init,
before even the virtual filesystems are mounted.

	The last thing visible on the console is the nfsclient service
being started and:

Call to flock failed: Funtion not implemented. (twice)

	Then the machine is unresponsive, numlock doesnt toggle the keyboard led,
and the alt-sysrq chords appear to do nothing.

	The problem is solved by changing my 6.6.9 config option:

# CONFIG_FILE_LOCKING is not set
to
CONFIG_FILE_LOCKING=y

(This option is under File Systems > Enable POSIX file locking API)

	I do not recall why I unset that, but it was working for I think the
entire 6.6 series until 6.6.10. Anyway thought I would mention it in case
anyone else hits it.

Paul


