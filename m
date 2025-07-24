Return-Path: <stable+bounces-164695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3183B11278
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 22:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CF717B4AEE
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47062857E9;
	Thu, 24 Jul 2025 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HmnkNuvY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59974274FE8;
	Thu, 24 Jul 2025 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389664; cv=none; b=ivHpBOATMdKe2DFVR9ZKIGxIVEShh775KCkzQ8m7/3cju4P7Op8Lyv48nxqp0pwMePnFu+NwpQhE+Gx4fVV2MPspfwscIMEHlNmxgVTdipXKtKHlkcx6v2ZEG2L5zbhDuXzUcEg+E9luCHCiCRq77X0AOKV8eTnguaB1D+FzagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389664; c=relaxed/simple;
	bh=OkdhwaUZTEkA/8Ob6sZu3DY16d88qrhLi65k+2v2Mck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mH7Oavb1yGtGcd2pobcYP3RutHrJyJxTfbe6eo/eHZGRiKF0uaHsh4zF7mhGsSwTMeZqk88NiFCgEWsE73cWURJTF8u91NbZEFg6NR49aB5XjrrnqEn5n4uosbeOx7gTDynX3t38Hc/XTZbqjdTHQtGO+b8FAfMGFh3AcPFmnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HmnkNuvY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23602481460so15132835ad.0;
        Thu, 24 Jul 2025 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753389662; x=1753994462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOCw+zwSoBjK9tkB7mm9A7h5IvTW/rXVDxScNi1zD9A=;
        b=HmnkNuvY80fGvnx2E96LNKsJINHmmLMtQ27u38YX62YwzL626N7ARAzFY//xjZLVRp
         cAJ2IFa7hjixSwRKDdb17gFIYxsX2UUf99epSH+Px025UQfs4VEgdEllSYcJcBWyu9ac
         fzUwoYnWXuiigdHtmrbHjIZ+3GGxdIU8XOt8V4ZKsIhFiMe2QSil3wFhQJqB1abYmjvp
         65gbhaLnhIGS7mcBycOmyBHP+XfNiL9q1/x+cYRxtqdr6SEIR4j19OqkSExY+yeZ8jzr
         mJ9pzPnFfLxoOcO0PcFIO3lVoR4i6qatzWrQEEtWUYdb9GreBSMNXAlcIwVAeNk2gEwj
         W5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753389662; x=1753994462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOCw+zwSoBjK9tkB7mm9A7h5IvTW/rXVDxScNi1zD9A=;
        b=EXhfWc2TtpoEp4rmNvK9Yagf6P2xJOw6BzzVw6j36BhQqu9m2r7dfXSNzBABRmIbXl
         DEe0PjDwTvq30DHbe/PjI2oTygB3EML3bZjN8wcBGKQLmwrm9OJGI/bG+1gZnB763PZB
         d7U1C9u8TGRsvGwuX2bvgoC997EcpRO8cr3enoXp1WZFw6nYTGtOJ8KhNdD8NmOJIoia
         EqLaZafq4fwIdyUu+jw1SDo/X4AL5ll1ObcdYRLLjgJI3uS39EDC5cLwklDReSaerOZ6
         tvpuuApPJkJ3xCBNkZgb8PEA23sxYHeH0zZ0GYmPGcbK0imizcSFUGTCDmwrjIv+9oxv
         HL2g==
X-Forwarded-Encrypted: i=1; AJvYcCUmFk4xcbYiFGUtGIYasmR2c5xK0ouMhLawUSh8pG3P6l8VOqf+DCRCtdHsMBXGS7DH6pxWWsEv@vger.kernel.org, AJvYcCVD0iuA88K3NHs2Cpaw0gH8/yhqyApM8ik848KmMI9owZvVVmVlkYaVuZsofbXW0V0mOL1LHMZdyAm6@vger.kernel.org, AJvYcCWh4usSYUGIDWm4RD8ONQRAPXxmSlu9GmrlEl30yrmzH/pFUMySka7ZCNVt5ST+sTdK0Wd/sSDuIAvHn7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBpW0Lf3W24s73F9eNBJXXKtLgeH+J1n2dPiWqMtBkpoeBOmI
	RjDW8l4N6TS3Nu3CyMJVmWMnqU3WenjC6anAX7TcwFDakoOsifpOnBjz4ZiAU9TA1jjLTuR2Q/7
	uP/rGhKpThTJM/WSlvh9jLWdNxdsJuX4=
X-Gm-Gg: ASbGncsGRjNFwVYl03dVUcammFCp+C7mk3c2jg5lXGEonrowl2PI8iAlanZSkg8ti5p
	uqKFs3nKzirnOrtes4JjhSTUqE0e+SV/09uJXznJiT6PyH2NbvimiZDauVhP+yTWVtHkmEnjZYV
	L0JozaZWqRoWX2IQoSdaGlkl3P6lOSynBjTtv18tdIeL5DkVjEucVSNKH512e75hyR8DKMN/2O1
	AM3ZJHz6silMUbXznzRQ8bCXv0nR3OduqHXIxBZ
X-Google-Smtp-Source: AGHT+IFdFsKgc8c9LIsxfd5vS1nUB3qzLmvj3zqtBITbHXVC4ohk11b8ZDXHVYhRfFBl3SO/aA5SL4YzLpsmblcQJaM=
X-Received: by 2002:a17:903:2f0e:b0:235:f3b0:ae81 with SMTP id
 d9443c01a7336-23f982045b2mr113630275ad.27.1753389662549; Thu, 24 Jul 2025
 13:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724091910.21092-1-johan@kernel.org> <20250724091910.21092-3-johan@kernel.org>
In-Reply-To: <20250724091910.21092-3-johan@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 24 Jul 2025 22:40:51 +0200
X-Gm-Features: Ac12FXyKvSF6Sl1tAfpFd9vrz8AMVtFNJwy9SmqhXWKxVaxcWhy0St6W2IcNat8
Message-ID: <CAFBinCC4SKra51msT8DCRzyBCjZ5V-Dk5g7tEtovF+ttG1QU0g@mail.gmail.com>
Subject: Re: [PATCH 2/5] usb: dwc3: meson-g12a: fix device leaks at unbind
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Bin Liu <b-liu@ti.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:19=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> Make sure to drop the references taken to the child devices by
> of_find_device_by_node() during probe on driver unbind.
>
> Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
> Cc: stable@vger.kernel.org      # 5.2
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thank you for finding and fixing this!

