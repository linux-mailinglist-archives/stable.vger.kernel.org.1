Return-Path: <stable+bounces-8216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565EE81AC49
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 02:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893451C23512
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B5F15CC;
	Thu, 21 Dec 2023 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dM8SPboV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC04419
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50c222a022dso400641e87.1
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 17:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703122944; x=1703727744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQaeuehoPaO3pr13bWE/WXu451v/qATRA3gTcbFlLWc=;
        b=dM8SPboVYxCx22ZWHIV3tXCbezGMEC0Pm9cqzn+8FVnZ2i5iZQrB9GVP/vAbktQlid
         KU9eFNGYkx5zzAufV+jxW2a0TwQgyqNke0z+sB+g2lJj/yG5A971ATonE2P2on8DBqv/
         UeoFwZfyq8H1jGX1cfpc66U+wagYl/YVWWwzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122944; x=1703727744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQaeuehoPaO3pr13bWE/WXu451v/qATRA3gTcbFlLWc=;
        b=iiYA/9g4toYe9guYCXI76NiE+Ebyep+edbnguu/9Z/+2FAR/dOtHlMSrtGdURU78Ik
         aX/6BbXbJ/p4E0ViXr5iS/QfBFo9rO/O+TjY+CKr6WoYsI8EbL4RTaoeEnWSFWTW/SWv
         J4H80kIONApyC2S1b5FNTlck+1ozokTcwZsiqxRiC7KBtVhZXKIV/tITbUojV+PaQYAE
         dkC7/u7wZ4Fha2oFUNJChG7aZqQLhV8xqYcKmNsb9THRdnV7GLdqKhqDDe7DIa6fwZ8l
         Mw1fA0UW0fOdjxYXHqm+d2j/iCCi+mqLgRA6dBqsuRaaHsJJgXwyRzc9L2Va/1WwGBay
         eLAw==
X-Gm-Message-State: AOJu0YxkZ8EoWvoZ3mgkZTRSV8JjloLVWPkxAjYKOAh7OsRXnROEjwQw
	dKuXqIumhNOL9oTyiP03kXXcLzGb+7QZrxHbj9Y=
X-Google-Smtp-Source: AGHT+IFaDAgu2igAOlDYsAt+vbaaI8ZSAdTXzSImJHZ+MXEZzIO6gjX9op4sY9ppvYB+n9Pi6XB9Cg==
X-Received: by 2002:a2e:2e02:0:b0:2cc:764a:7d26 with SMTP id u2-20020a2e2e02000000b002cc764a7d26mr2653593lju.106.1703122944008;
        Wed, 20 Dec 2023 17:42:24 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm495655eda.44.2023.12.20.17.42.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 17:42:23 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33666fb9318so219663f8f.2
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 17:42:22 -0800 (PST)
X-Received: by 2002:a05:6000:1cd:b0:336:7ddc:79c8 with SMTP id
 t13-20020a05600001cd00b003367ddc79c8mr294876wrx.1.1703122942318; Wed, 20 Dec
 2023 17:42:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
In-Reply-To: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 20 Dec 2023 17:42:06 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOLPWfS2M9J7CXWSP=dWw=mVOA41Ti_RGd2kRGTfcrinw@mail.gmail.com>
Message-ID: <CA+ASDXOLPWfS2M9J7CXWSP=dWw=mVOA41Ti_RGd2kRGTfcrinw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: fix uninitialized firmware_stat
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:02=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
>
> Variable firmware_stat is possilbe to be used without initialization.
>
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202312192236.ZflaWYCw-lkp@intel.com/

Acked-by: Brian Norris <briannorris@chromium.org>

