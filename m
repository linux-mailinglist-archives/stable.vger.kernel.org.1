Return-Path: <stable+bounces-71665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C93E966A13
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D801F2362D
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2BA1BE24B;
	Fri, 30 Aug 2024 19:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XekhFN/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35281BE228
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725047433; cv=none; b=nz94thIGhc7+jD8TLiEIzNW1EPYhqy8XNIxBzcb347cz9D2LKGmla75b5v6t88Thc9NuD2a9wiM1fhBGsoRLqh98zTK0eQA2XLC1HP2VKTmj9Ja3emgErpTCz32fyc1Lkkwaod3tFuN5YTLLPVsto1sU9+xgRCrqWv9V3ZfhFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725047433; c=relaxed/simple;
	bh=yXNmqAtLWS5NlIPRIhOiDrjJJPBlvX+h51JTFVleZsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGWtL6cQVJsVO4RDnvmHe6YCBdZX90+V28e9RhZ24gfqfidgKpnFAvk9sljCRo+7spcatGOUztQU4bEiow9royoyglCMwHNWjxyqgB537ehbPYQY6wLeyXeuBvd911g318fYwC0+RFm9O2/DHC3EVJGyBVN/bA5sYc/z+kwzJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XekhFN/e; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71456acebe8so1776265b3a.3
        for <stable@vger.kernel.org>; Fri, 30 Aug 2024 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725047431; x=1725652231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6QlsYvzYMyoJ1Ksug9tyv8g6XTQnvNg8jtnf6sK7fQ=;
        b=XekhFN/eDLLhULgj+9yt+QR+Z8hd5PxKNrD99xDYp/sxEGJSYOG3IQlu3T0pogDAWs
         /xQDJJeggNAdXJ1XA+rv9d7JtE6SIiob89+FJ2LGDNwmtuu/kQys5sPtub6TPiFPS5Lh
         N8q5V7fZZQ/aCUnmpwRi7umO7NARDQaDHKXaoh5DP8ycTuy5IPhEz2VFbCOyF4umuO+8
         Gvemy0goURud/zXa9fWQ6ly/rEYt4OZWFd5fOb0LCL1ekwVv7A8YRd5uwGj2wv+VqbNc
         +AaoppnfB531dAEpzMSeLTfSXHXyvr9eCpTJt8lnHONJPSEC1lqH+GInCAVnofjVoCpt
         W0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725047431; x=1725652231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6QlsYvzYMyoJ1Ksug9tyv8g6XTQnvNg8jtnf6sK7fQ=;
        b=xO7TQRdxXzGsMYhrcCqz1NDjvXYQt0bgK8pEGnJrV2lQ3ric1JjBtYTMp0wJnUy/Ux
         xNDonEjUsrAIEulWRr+NRLC9sn5aa65EGY6C8KhwJZdGI+Ce9ktEE4/tOtl7Ig0QND8M
         vQ+9IZMwaWDb3tlha6NP6P4e4+9/KiQ5mDl8SGVS2H09r1aOUDEcHflFw9aFYrtd/oys
         bKqfoXCbmN14HAN3fFbN8GAnuF+hdW45ffzNq+i0vJmoka4VIb9jeGnczdaVHijDTEfV
         o+UVAkkx51QNTmrsrZvConWMoBXcXvuLgE53BRg3SjS3CiBpRSlpz4c+8tKI/ySILSbm
         o5cg==
X-Forwarded-Encrypted: i=1; AJvYcCXBxr1nbqk8RcUTURVcsirJ1vKCDMv5J3/pNlTVX8hdAhMi5p8TEN5MFu+r6UwyzL62xNJpXjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMlqX/Woy+5UKmma37gkV2T5OPXhvCY62aFpsr5yNzhP6VVFr
	XrqLIB6EL7Jw+vyVwEjqp9/E/tUCISr19TT3nU6c1Oi4mDkSJlDWtsOM14KtrFQ=
X-Google-Smtp-Source: AGHT+IEcm7YmlJtxqZsF4YzOMKYXwtY0ArLtbfsQjCm0ebmHvrq6+/sfSJC7izruBGlFJ/auiUixHg==
X-Received: by 2002:a05:6a20:9c9b:b0:1cd:f065:4eec with SMTP id adf61e73a8af0-1cdf06555a8mr2551415637.41.1725047431173;
        Fri, 30 Aug 2024 12:50:31 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e7423c2sm3296998a12.17.2024.08.30.12.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 12:50:30 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: s-vadapalli@ti.com
Cc: bhelgaas@google.com,
	j-keerthy@ti.com,
	kishon@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	srk@ti.com,
	stable@vger.kernel.org,
	u-kumar1@ti.com,
	vigneshr@ti.com
Subject: Re: [PATCH 0/2] Fixes for the PCI dra7xx driver
Date: Fri, 30 Aug 2024 12:50:30 -0700
Message-ID: <20240830195030.3586919-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827122422.985547-1-s-vadapalli@ti.com>
References: <20240827122422.985547-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series is based on commit
> 3e9bff3bbe13 Merge tag 'vfs-6.11-rc6.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
> of Mainline Linux.
> 
> The first patch fixes conversion to "devm_request_threaded_irq()" where
> the IRQF_ONESHOT flag should have been added since the handler is NULL.
> 
> The second patch fixes the error handling when IRQ request fails in the
> probe function. The existing error handling doesn't cleanup the changes
> performed prior to the IRQ request invocation.

I tested this patch on v6.11-rc5 using a am57xx-beagle-x15 with a SATA
drive connected to the eSATA port, and confirm that this allows
booting again.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin

