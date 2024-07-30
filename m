Return-Path: <stable+bounces-62637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADAB940873
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 08:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346021F217E0
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 06:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63A1684A5;
	Tue, 30 Jul 2024 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXbDvMxW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11E161914
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321379; cv=none; b=JNYgxWrUOFgpoqcFbi/BaowrcbNKcq0NqtgUzHDFlIiPcrIiC7A9j5jsrB7hOLDvGa2gjomPbnTDaYq86NA1ZflhW8AbsbEnebpDyBpR+X89iWdz+jKPX15Y13cM8zPjwI4PkB7TpPJOk/AWspL0bdXpj7laNWoSZxCqoIPs3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321379; c=relaxed/simple;
	bh=uOvq+MhB4+zSd/Vt0H1pnDvcLKpcwozIOQ5FrDJDE2c=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=n4CdA+7kw7I+LgAcXF067AAx3swVFiRR4f8JZgStctN0Lr6IbbX6uMm8k+Sasw7Tz7A9pWtLOX5+NwzxhMi0mZCUm51UdbR3zE0CAME32Va1nvJQd+5A8hg32aQDh2B+pLmPLm9/9la6XeriDNiKmzWdt9CsX35LhVtuO0SqQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXbDvMxW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52fd0904243so342676e87.3
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 23:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722321375; x=1722926175; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uOvq+MhB4+zSd/Vt0H1pnDvcLKpcwozIOQ5FrDJDE2c=;
        b=QXbDvMxWDHT3gEm5lHQFdP1pMIuHMRPtUkUcHVNdNBvwkiLYnw9/O7GlTmsxe2KZkQ
         j7DD9qJxCw2JpFe6Qd/gvqoKA+NAYXDVL0NtGbYkqYGh5ozQYeq00ZuUi8z3GKCAiykk
         Ry/MNrCoCAeAIgLeCSVGoaPGnX8Y4lRqyM7EjMdLpfNFppfzjkJ/AD3MW6/EZEAG3gjl
         EcdGvlufO6Y3zt28df5z/KsbmlPMVHkI2wvSmsQsaRUZSdHUnCjwSliKTDB8VgAJ+ZYE
         7mSDYoGiBkyQ8koT46fsBEAQolTod/4+qc0E9d4daDbZiCaJH1MUK8/NG/dmv/X9NI8j
         GUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722321375; x=1722926175;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOvq+MhB4+zSd/Vt0H1pnDvcLKpcwozIOQ5FrDJDE2c=;
        b=sfg5od7/OBpdwlml2hdEFJwxF3/ocX/C68Bb/9KYj69Kauuq9MHaw1uG4FffzoxdQx
         QWlyBP0Dwbv//VK2uRk8SGblDmjbBcCFBqVWV8eMe/5qvsXJ1uccbcsidH30ypqs8KZ8
         DX3/YaTvE2abruHsZugSWTwDF7w7qaReacG3IBaocO4UYSgwRgwED9/jyc7Ile2PA+Rk
         iE7M5JxV/2Pjl+dJN7TktV9g22N6PQ7/f5l96ZTP8gzSvaVvhMPlqe9LqiO3SCrvBkk1
         fIUPnknHsTVxoolzx+muBiRwJ1agX9Q5SLPSjbZvOuJSTtOVtNUIFjMzToxb+rBdITIk
         8PNQ==
X-Gm-Message-State: AOJu0YxYlEEYVtIONasV6sJpjY8OcWnqWc3C5Eqi6PO95t1UQpn+kHWe
	NcmZ6JejogXQuPOo6jRlI4W2nEeduXqBXh13O8hjXVioIpVFrXVNq64iJw==
X-Google-Smtp-Source: AGHT+IERc/0AhYw8B51f0neHAGMVg0/QFRLB5ysa1HufiHGSVf4FK3kPLj8Z5f8lgvj3kCT8b6t8RQ==
X-Received: by 2002:a05:6512:110e:b0:52f:c22f:32a4 with SMTP id 2adb3069b0e04-52fd52d2d57mr5909703e87.6.1722321375191;
        Mon, 29 Jul 2024 23:36:15 -0700 (PDT)
Received: from axet-laptop.lan ([2001:470:28:187::a67])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c19e8asm1758227e87.201.2024.07.29.23.36.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:36:14 -0700 (PDT)
Message-ID: <8cd6293f66f9399a859330a348c79fa3dacb0202.camel@gmail.com>
Subject: asus_wmi: Unknown key code 0xcf
From: Alexey Kuznetsov <kuznetsov.alexey@gmail.com>
To: stable@vger.kernel.org
Date: Tue, 30 Jul 2024 09:36:13 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello!

My Asus Laptop (ASUS VivoBook PRO 15 OLED M3500QA-L1072) reporting this
wmi code everytime I connect power cable.

I got no key code on power disconnect.

[11238.502716] asus_wmi: Unknown key code 0xcf

