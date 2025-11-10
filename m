Return-Path: <stable+bounces-192916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B40C45571
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 09:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460323B33C9
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474782E8B83;
	Mon, 10 Nov 2025 08:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFR3FZ/x"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91A230BF8
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762738; cv=none; b=hhAQx+XPMOw+2sfhqnqLi5FW+/wEDxl4q1JAEuHKFaBf+w6SakEdCAHB9pdAwYJgTYxdQenLSXQ67F9XWABNQcJhNKEDU+tgaK994ddLSie/1S0N7GcdZ/U85xDOh+Nm8+hK8/aNfk80svPDfK5Xh1MkF6FwjFBanSGbXq1Dgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762738; c=relaxed/simple;
	bh=LUwREsvCB54P+nF2qMZzK2Xq5d8lmHU9Yu4Uy90Zjvo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bIhzBrVJ8A0IRmaw/TUlVi+snZz6COmguELJUT2UOLBGDya+QOVI7Lxx0QIg0qZAHT38Mp5cli+3g+ll4VlrMlSocBryZBA+aQvx1TJnO6TSI+PEJVVFL5mxD0PEGUomdTgKNrwvkfYq1QsDRIfoQsFC8XdUe7DYsJYjVegahRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hFR3FZ/x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47773cd29a4so7180645e9.2
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 00:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762762733; x=1763367533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ow0jXvjkh77pOXWIP6I5DYsF4xpz6igLz3RhPzX2Hc=;
        b=hFR3FZ/xshkoNyuZt5jSfQ+VXYtbnH85AAMhNYL1vNq0ObRVZo3kqTd9pRB5ePgm/T
         FK/fRHmQjsHC4g9/MseoRElf+XkPC0tJOTg8N/Stpjo8x5mUBUbqeCClPC+EbHH/6d8Q
         SQL3RrYP+E0fGsZ9lWIamvwlL44kAdsxwcnpUdp/5jA07ytfRiCP5wS0vkoPV1hnmtSI
         0Yx0waezk41ae0tqyTFN2nVywJslB8Ub5aJe21eISo5PoIqkd4T5OZ4nAVu6j3/DxHU6
         Uqc8YpasHmX/uagAe4/oeprsq9vTZrCH8l8L4/syh0rxsCPEs6vULAysGDLK6y9YRHHC
         /gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762762733; x=1763367533;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Ow0jXvjkh77pOXWIP6I5DYsF4xpz6igLz3RhPzX2Hc=;
        b=YD3CrVjwg+MNzvcfZDHVkNRKPivFyebuKiFaI4Wq5k9eGIeCX/oVpn2eb3lcwADIyr
         cmq3bkjI9KMkggKMpLbkWV1tdC2k9Q6sw14xWGMc0+4cNpxtx0zUGNUXesPB6Sj/t5D0
         NesFqmEYizWksGU1k3CZ/fy5l8//DEQbmIeoqi3yAvV9xrTUljqmUgc6Nnp7cnVCA4uL
         g7JuubFrShGeM4wqSbZzoWOgjLI+cBSX0tXEo942XPw5oxmq5r+1eDqNlwn/8dFZbmJu
         PoSTm6NdoxL4N88fASE+H3YfLFZ8Ly0Z+mIZ/hqmOoNNAP/1gNAA1nm9r6WsdnggKCzf
         RT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdyZ4wF7lYjRrFCkLv3xaCE9DU192tymI0eQ2uU2zPsrIlTaHYTwnlwGmjnKeEBxA6KFMnomw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPO7BvAmOe0oen0qPr7rjapr6SGtEALkwT6pOFsWLiIRpZUa7
	KsITib3Zsa8L6UsOhkD9nYQTiZ+VxIADWnbp+XT8Zh6ER5iKBSaiSPq4Mwgcr4ijKY4=
X-Gm-Gg: ASbGncsG7QjWxnxqS4EczMJTbjH+7luMrGB+o/ml5LostIxvx/Q8MaF21AUbJlQAeEC
	Z8+1DEhCHNMOW3NmfzgOXkfdQpvay0prUFZg9HnhoyTkOjownS1ptsekJ9WZ8mpTDCKxw/ACp1G
	mH+9XASwk2bG+V3snjYzYKU64tBOzppbtGV5q8QkGROljiz1D26oHCn72yKrTjNnJ4VAeGoM/4e
	u56jKDkokzRj3kfsu6L01iRj0BwSK1g9PSRUlKhtrTJBHWOrDaVkIkGl0QOrhBDlgJCeCsaQ13G
	MbAKMJZMRJ6s9rsy3/9S8BbdZk6h9y1MUkMXh63JvnzgtrNkjUa6Dm7XjZMfcNYa/tgwwEmvdqo
	YsNpqd+TUdVhBN2M38XhH7Rp83TL4lxqXSU7MXVvR3L7AcwdMMZvm82wPCCDbWMGnbl4tjiXu+o
	lm6Oh/luTACNIyF2S95xT5
X-Google-Smtp-Source: AGHT+IFNAJ6Bn4FpyZtFF1NnxwYE2SjgYr7mpYVD4++XybQIbWpInXbD7iemC8JYoesp/8+j6x9DXg==
X-Received: by 2002:a05:600c:4fc7:b0:477:6d96:b3dd with SMTP id 5b1f17b1804b1-47773236f6cmr51381675e9.1.1762762733314;
        Mon, 10 Nov 2025 00:18:53 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bd08834sm192070105e9.15.2025.11.10.00.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 00:18:53 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>, 
 Yue Wang <yue.wang@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Andrew Murray <amurray@thegoodpenguin.co.uk>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, stable+noautosel@kernel.org, 
 stable@vger.kernel.org, Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
Subject: Re: (subset) [PATCH RESEND 0/3] PCI: meson: Fix the parsing of DBI
 region
Message-Id: <176276273239.834148.1225755186046227156.b4-ty@linaro.org>
Date: Mon, 10 Nov 2025 09:18:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Sat, 01 Nov 2025 09:59:39 +0530, Manivannan Sadhasivam wrote:
> This compile tested only series aims to fix the DBI parsing issue repored in
> [1]. The issue stems from the fact that the DT and binding described 'dbi'
> region as 'elbi' from the start.
> 
> Now, both binding and DTs are fixed and the driver is reworked to work with both
> old and new DTs.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.19/arm64-dt)

[2/3] arm64: dts: amlogic: Fix the register name of the 'DBI' region
      https://git.kernel.org/amlogic/c/8b983ae355aab50942c72096beba30254c5078bd

These changes has been applied on the intermediate git tree [1].

The v6.19/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


