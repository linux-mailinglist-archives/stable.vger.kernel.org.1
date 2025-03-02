Return-Path: <stable+bounces-120018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A9AA4B2D0
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 17:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E827A7620
	for <lists+stable@lfdr.de>; Sun,  2 Mar 2025 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BDB1E990E;
	Sun,  2 Mar 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCqQPWyX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014321E3761;
	Sun,  2 Mar 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931433; cv=none; b=VfGDEX2WgqUKo9zvjIrZva/aDQKC2G6YhnW60EgeGlokuX9Rk/h08vwo8QfYzB/O/kw7C2LQ4WW9yP7kCKL5XDNTvPbSl4GU2KIb1GDtZk7m47Mr50hTyvMFCw5ZidLr+k/8Bz3OsS0Tjq0z9RhVn/E5UP2FmG0NGvZ9fSz9Em4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931433; c=relaxed/simple;
	bh=PpoiA7zcL5siK6dUoXkSOW7sxsC4plRQ9I9AThPDGb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qP9o9E6bzInFTFtMLT4zwRttdFSeZ/RxJiHkHWLK6D7h6YzKKncCCRq+8mEP6XFVZ66XW28ZAf2aApOexs58L7O3I0mRdKlFkw3oc3hS8mqkxa2WWSvCoCIvdDI2R8jjmsDbbZx5pSACMquWv7T9bPO2UjKQ3sVOi3Vi+8AYhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCqQPWyX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4f88ea298so3878994a12.2;
        Sun, 02 Mar 2025 08:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740931430; x=1741536230; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KqMUvt/Ij4ONg3Ys/j5SSJwq5McLd1u+T3IXK69/iY0=;
        b=lCqQPWyXvkBFzlU0kMyOCT92GdRsREG7ud0SVVQBkf+re/1wDxgUYxYvx+xpGHTBrR
         fk4ms0Dlgmcd3uJDwbWGD7M6jdrGTEdH5oDj2PH9JqMTggzncpEF3VrgSNaUhKJ7sBjc
         oO9AigvBdJK+RwCJ0RgiG6L0GdE+u8ur+JX66or694TV/isqteN3+VYDt2UwQBIVDaE5
         TXwJcfUMFYP4977ApcL3d1xT588EompzGJUzSPA6KqL0WigXnNaviXCdbS2Yl65xD75q
         o345tJVlUCNpKpsRuSUpYsXcN26ymYxO5ozynhli+VgzFqTZGFGSCriC70d4Fm4vpGgw
         igVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740931430; x=1741536230;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqMUvt/Ij4ONg3Ys/j5SSJwq5McLd1u+T3IXK69/iY0=;
        b=Esq6LREs5UXrq8u6+qUjI0/ocDsXSSjloUEFeZ2xRkTIifMn8VaxoAcINT5GQW08CY
         vfJgu+EYtPkPzeYqDlxO45UQRRZU15R4rWQxNn0Iy7jVSSoID7q39iHnmuWLuGe5PTGe
         VkY8wE395bSDYTlwe3MrcJmDMob2lnVCgf73ababhH9ZUZtlkOlufyJd48278nDPMdgt
         OqCot4mcVes74juBMo9PeArXtWsP5y2fz7lx0UAbJnqhmNWaSIkGADCie7wYthaAwlAd
         vhrbdactTPcMyl58bqXPJrfMTa0QzADkbFqzFzx8TtqPqd28T3uVeKUHS2iMDeOiW3HG
         G4eA==
X-Forwarded-Encrypted: i=1; AJvYcCU9HFn+YPsPCT6/7P17gzkHxq2tgRB/4s3d7mXNdsCdbfYKGVXrqunOykFEgZCnE3LQH4L4zxfPQQw=@vger.kernel.org, AJvYcCUHRbcN3pmrX5+2F6PtVcn/m571LBOaCnsAtEd58NaEInlJwT3S+Wn4R3Jic7OnrIvP8gdBQdNR@vger.kernel.org, AJvYcCVMr97EnxbI4IG3idupUhCxNGBNJtNFwMj7Ai7I2PYDjpgzvkPbtPSKxJ0sz3l7xOvmFwACbUvzSTlP8Iyf@vger.kernel.org
X-Gm-Message-State: AOJu0YyvzsFGKyFH1Mf/whFnoSSOc0an7oMDY1T17UPPEM81ZinGas8t
	FLj2oBFnmWKIbFNI0P+BsSA8c9IgtRs16JWNoiA9B7gzKl+UA3ge
X-Gm-Gg: ASbGncuWwKlUssavFqghDHdNfpEZFrwjs4owXqrsvUaShYi1oNQbEEqh4niesmMHeyK
	XLMTEkj6TDuonIX5pgtgN3NBJXIZUgSELpUi5kOy8ykCTvHlk1xHdiA+CGLZteQfw+N1Haa2ewT
	wj7gfE3DJ3Oo9P3LYOcPxCAwhUh9RIzLlShCq5Ll8f4pcEoEVr0H6TJflNG82hC35kQl1HUoUfq
	pnJKJJxyuYyvpZaepWn+Aa5KbZ2g2ntvSkDMcpbRFxbCcH9n3E7KpIzIjXrA4x//z3hw7ebWPKE
	VU6/vOaumF7/tPBR+BH45RcPsVz0RbEiOQqmBxy749pytjulhNE1w9KJ2IRZlBsccePlxcja3Ad
	OyA==
X-Google-Smtp-Source: AGHT+IFWXl0EDKxgBsDCDLhNQV3+yBJQ0X9U1IHYqXyA4xxGqEq/sAuqyM6Oe7BG4J2BsNkWYT1QVg==
X-Received: by 2002:a05:6402:520f:b0:5e0:9254:c10e with SMTP id 4fb4d7f45d1cf-5e4d6ad85famr11127566a12.11.1740931429973;
        Sun, 02 Mar 2025 08:03:49 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb5927sm5564238a12.53.2025.03.02.08.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:03:49 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id A74BCBE2DE0; Sun, 02 Mar 2025 17:03:48 +0100 (CET)
Date: Sun, 2 Mar 2025 17:03:48 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Niklas Cassel <cassel@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Eric Degenetais <eric.4.debian@grabatoulnz.fr>
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
Message-ID: <Z8SBZMBjvVXA7OAK@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mario et al,

Eric Degenetais reported in Debian (cf. https://bugs.debian.org/1091696) for
his report, that after 7627a0edef54 ("ata: ahci: Drop low power policy  board
type") rebooting the system fails (but system boots fine if cold booted).

His report mentions that the SSD is not seen on warm reboots anymore.

Does this ring some bell which might be caused by the above bisected[1] commit?

#regzbot introduced: 7627a0edef54
#regzbot link: https://bugs.debian.org/1091696

What information to you could be helpful to identify the problem?

Regards,
Salvatore

 [1] https://bugs.debian.org/1091696#10

